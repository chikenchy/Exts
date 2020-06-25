//
//  String + demical.swift
//  ShoppingCalculator
//
//  Created by 신희욱 on 2020/06/25.
//  Copyright © 2020 AXI. All rights reserved.
//

import Foundation

extension Double {
    
    func fractional() -> Double {
        let int = Int(self)
        let result = self - Double(int)
        print(result)
        return result
    }
}
