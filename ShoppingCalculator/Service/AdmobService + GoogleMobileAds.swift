import Foundation
import GoogleMobileAds

extension AdmobService: GADBannerViewDelegate {
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.isHidden = false
    }
    
    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        bannerView.isHidden = true
    }
    
    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {}
    
    func bannerViewDidRecordClick(_ bannerView: GADBannerView) {}
    
    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {}
    
    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {}
    
    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {}
    
}

extension AdmobService: GADFullScreenContentDelegate {
    
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) {}
    
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) {}
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {}
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {}
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {}
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print(error.localizedDescription)
    }
}



