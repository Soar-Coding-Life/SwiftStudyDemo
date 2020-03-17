//
//  SCLGlobal.swift
//  SwiftStudy
//
//  Created by mac on 2020/1/15.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import MJRefresh
import RxCocoa
import RxSwift
import RxAlamofire
import RxDataSources
import Moya
import IQKeyboardManagerSwift
import Kingfisher

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let statusBarHeight : CGFloat = {
    if #available(iOS 13.0, *){
        let scene : UIWindowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
        return (scene.statusBarManager?.statusBarFrame.size.height)!
    }else{
        return UIApplication.shared.statusBarFrame.size.height
    }
}()

let navigationBarHeight = 44.0 + statusBarHeight
var bottomHeight:CGFloat {
    if isIphoneX {
        return 34.0
    }
    return 0.0
}


var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}


var isIphoneX: Bool {
    if #available (iOS 11.0, *) {
        var window = UIApplication.shared.keyWindow!
        if #available(iOS 13.0, *) {
            if (UIApplication.shared.supportsMultipleScenes) {
                let scene : UIWindowScene = UIApplication.shared.connectedScenes.first as! UIWindowScene
                window = scene.windows.first!
            }
        }
        let bottomSafeInset = window.safeAreaInsets.bottom
        if(bottomSafeInset == 34.0 || bottomSafeInset == 21.0){
            return true
        }
        return false
    }
    return false
}



var isIpad : Bool  {
    let deviceType = UIDevice.current.model
    if deviceType == "iPhone" {
        return false
    } else if deviceType == "iPod touch" {
        return false
    }else if deviceType == "iPad" {
        return true
    }else{
        return false
    }
}


//MARK: print
func sclLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}


///MRAK:- 应用默认颜色
extension UIColor {
    class var background: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }
    
    class var theme: UIColor {
        return UIColor(r: 29, g: 221, b: 43)
    }
}

///MARK:- 字符串常量定义
extension String {
    static let searchHistoryKey = "searchHistoryKey"
    static let sexTypeKey = "sexTypeKey"
}


extension UICollectionView {
    func reloadData(animation: Bool = true) {
        if animation {
            reloadData()
        } else {
            UIView .performWithoutAnimation {
                reloadData()
            }
        }
    }
}

func openURL(scheme: String) {
    if let url = URL(string: scheme) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:],
                                      completionHandler: {
                                        (success)in
                                        print("Open \(scheme): \(success)")
            })
        }else{
            let success = UIApplication.shared.openURL(url)
            print("Open \(scheme): \(success)")
        }
    }
}

