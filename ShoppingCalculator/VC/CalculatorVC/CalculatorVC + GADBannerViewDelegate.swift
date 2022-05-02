import Foundation
import GoogleMobileAds

extension CalculatorVC: GADBannerViewDelegate {
    
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
