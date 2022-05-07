import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

final class CalculatorSumFooterView: UITableViewHeaderFooterView {
    private let sumLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 25)
        $0.textColor = .systemBackground
    }
    private let saveButton = UIButton().then {
        var configuration = UIButton.Configuration.borderless()
        configuration.baseBackgroundColor = .label
        configuration.title = NSLocalizedString("Save", comment: "")
        configuration.baseForegroundColor = .systemBackground
        $0.configuration = configuration
    }
    var currencyCode: String?
    var sumRelay = BehaviorRelay<Decimal>(value: 0)
    var isButtonEnabled = BehaviorRelay<Bool>(value: false)
    var isDirty = BehaviorRelay<Bool>(value: false)
    var saveRelay =  PublishRelay<Void>()
    var bag = DisposeBag()
    
    private func footerAttrString(sum: Decimal) -> NSAttributedString? {
        let str = NumberFormatter().then {
            $0.usesGroupingSeparator = true
            $0.numberStyle = .currency
            $0.locale = Locale.current
            $0.currencyCode = currencyCode
            $0.maximumSignificantDigits = 100
        }.string(from: NSDecimalNumber(decimal: sum))!
        
        let array = sum.description.split(separator: ".")
        if array.count == 2 {
            let result = NSMutableAttributedString(string: str)
            let range = (str as NSString).range(of: ".\(array[1])")
            result.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.lightGray, range: range)
            result.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 22), range: range)
            return result
        } else {
            return NSAttributedString(
                string: str,
                attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.systemBackground
                ]
            )
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        sharedInit()
    }
    
    private func sharedInit() {
        contentView.backgroundColor = .label
        contentView.addSubview(sumLabel)
        contentView.addSubview(saveButton)
        
        sumLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        sumRelay
            .bind(with: self) { `self`, sum in
                self.sumLabel.attributedText = self.footerAttrString(sum: sum)
            }
            .disposed(by: bag)
        
        saveButton.rx.tap
            .bind(to: saveRelay)
            .disposed(by: bag)
        
        let sharedIsDirty = isDirty.share()
        sharedIsDirty
            .bind(to: saveButton.rx.isEnabled)
            .disposed(by: bag)
        
        // 버튼의 화면갱신이 이상하게 보이므로 강제 갱신
        sharedIsDirty
            .bind(with: self) { `self`, _ in
                self.contentView.superview?.layoutIfNeeded()
            }
            .disposed(by: bag)
    }
}
