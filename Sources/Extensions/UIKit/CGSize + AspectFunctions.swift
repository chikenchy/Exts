// port of http://stackoverflow.com/a/17948778/3071224
import UIKit
import Foundation

public extension CGSize {
    
    static func aspectFit(aspectRatio : CGSize, boundingSize: CGSize) -> CGSize {
        var size = CGSize.zero
        
        let mW = boundingSize.width / aspectRatio.width;
        let mH = boundingSize.height / aspectRatio.height;
        
        if mH < mW  {
            size.width = boundingSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if mW < mH  {
            size.height = boundingSize.width / aspectRatio.width * aspectRatio.height;
        }
        
        return size
    }
    
    static func aspectFill(aspectRatio :CGSize, minimumSize: CGSize) -> CGSize {
        var size = CGSize.zero
        
        let mW = minimumSize.width / aspectRatio.width;
        let mH = minimumSize.height / aspectRatio.height;
        
        if mH > mW {
            size.width = minimumSize.height / aspectRatio.height * aspectRatio.width;
        }
        else if mW > mH {
            size.height = minimumSize.width / aspectRatio.width * aspectRatio.height;
        }
        
        return size
    }
    
}
