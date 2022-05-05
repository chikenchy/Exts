import Foundation
import GoogleMobileAds
import Extensions

let admobServiceSingleton = AdmobService()

final class AdmobService: NSObject {
    private var interstitial: GADInterstitialAd?
    
    
    func setup() {
#if DEBUG
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["00008030-0016690A3423802E"]
#endif
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    func loadInterstitial(completion: ((Result<GADInterstitialAd, Error>) -> Void)?) {
        GADInterstitialAd.load(
            withAdUnitID:"ca-app-pub-9095645775931715/6207589589",
            request: GADRequest()
        ) { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                completion?(.failure(error))
                return
            }
            
            let ad = ad!
            
            ad.fullScreenContentDelegate = self
            interstitial = ad
            
            completion?(.success(ad))
        }
    }
    
    func loadInterstitialIfNeeded(completion: ((Result<GADInterstitialAd, Error>) -> Void)?) {
        if let ad = interstitial {
            if let topVC = UIViewController.topMostViewController() {
                do {
                    try ad.canPresent(fromRootViewController: topVC)
                } catch {
                    // 이미 본 광고 에러일 경우만 다시 로드를 시도한다.
                    if GADPresentationErrorCode(rawValue: (error as NSError).code) == GADPresentationErrorCode.codeAdAlreadyUsed {
                        self.loadInterstitial { result in
                            completion?(result)
                        }
                    } else {
                        completion?(.failure(error))
                    }
                    return
                }
            }
            
            completion?(.success(ad))
        } else {
            self.loadInterstitial { result in
                completion?(result)
            }
        }
    }
    
    func showInterstitial(completion: ((Result<GADInterstitialAd, Error>) -> Void)?) {
        guard let ad = interstitial else { return }
        guard let topVC = UIViewController.topMostViewController() else { return }
        
        do {
            try ad.canPresent(fromRootViewController: topVC)
        } catch {
            completion?(.failure(error))
        }
        
        interstitial?.present(fromRootViewController: topVC)
        completion?(.success(ad))
    }
}
