//
//  UIColor+WGBExtension.swift
//  SwiftDemo
//
//  Created by 王贵彬(lu.com) on 2022/1/5.
//

import Foundation
import UIKit

//使用 RGB[255,255,255]
struct RGB {
    static subscript (r:UInt32,g:UInt32,b:UInt32) -> UIColor {
        return UIColor(r, g, b)
    }
}

//使用 RGBA[100,100,100,0.8]
struct RGBA {
    static subscript (r:UInt32,g:UInt32,b:UInt32,a:CGFloat) -> UIColor {
        return UIColor(r, g, b, a)
    }
}

extension UIColor {
    /// UIColor(r,g,b) 或者 UIColor(r,g,b,a)
    /// - Parameters:
    ///   - r: red
    ///   - g: green
    ///   - b: blue
    ///   - a: alpha
    convenience init(_ r:UInt32 ,_ g:UInt32 ,_ b:UInt32 ,_ a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    
    /// UIColor.random
    class var random: UIColor {
        return UIColor(arc4random_uniform(256),
                       arc4random_uniform(256),
                       arc4random_uniform(256))
    }
    
    /// let img:UIImage = UIColor.red.image()
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// UIColor.colorFromHex("#1d3eff")
    class func colorFromHex(_ hexString: String) -> UIColor {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 { return UIColor.black }
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }
        
        if cString.count != 6 { return UIColor.black }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt64 = 0x0
        var g: UInt64 = 0x0
        var b: UInt64 = 0x0
        
        Scanner(string: rString).scanHexInt64(&r)
        Scanner(string: gString).scanHexInt64(&g)
        Scanner(string: bString).scanHexInt64(&b)
        
        return UIColor(UInt32(r),UInt32(g), UInt32(b))
    }
}



