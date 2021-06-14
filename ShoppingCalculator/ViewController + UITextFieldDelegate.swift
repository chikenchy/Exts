import UIKit

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case priceLbl:
            selectType = .price
            textField.resignFirstResponder()
        case countLbl:
            selectType = .count
            textField.resignFirstResponder()
        case nameLbl:
            selectType = .name
        default: break
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case priceLbl:
            selectType = .price
            nameLbl.resignFirstResponder()
            return false
        case countLbl:
            selectType = .count
            nameLbl.resignFirstResponder()
            return false
        case nameLbl:
            return true
        default: return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameLbl {
            selectType = nil
            textField.resignFirstResponder()
        }
        return true
    }
}
