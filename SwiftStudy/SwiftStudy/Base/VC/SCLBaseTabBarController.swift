//
//  SCLBaseTabBarController.swift
//  SwiftStudy
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class SCLBaseTabBarController: UITabBarController {
    var sclTabBar:SCLTabBar = SCLTabBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildVCs()
        self.sclTabBar.sclDelegate = self;
        self.sclTabBar.frame = self.tabBar.frame
        self.sclTabBar.isTranslucent = false
        self.setValue(self.sclTabBar, forKey: "tabBar")
        
        //设置tabBar的字体颜色
        UITabBar.appearance().tintColor = RGB(148,151,159)
        let normalAttributesDic = [
            NSAttributedString.Key.foregroundColor : RGB(148,151,159),
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)
        ]
        let selectAttributesDic = [
            NSAttributedString.Key.foregroundColor : RGB(217,153,29),
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)
        ]
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributesDic, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectAttributesDic, for: .selected)
        
    }
    
    func setupChildVCs(){
        addChildVC(SCLHomeViewController(), title: "首页", normalImageName: "tabbar_home_nor", selectImageName: "tabbar_home_sel")
        addChildVC(SCLNewsViewController(), title: "新的", normalImageName: "tabbar_bot_nor", selectImageName: "tabbar_bot_sel")
        addChildVC(SCLFindViewController(), title: "发现", normalImageName: "tabbar_yue_nor", selectImageName: "tabbar_yue_sel")
        addChildVC(SCLMyViewController(), title: "我的", normalImageName: "tabbar_me_nor", selectImageName: "tabbar_me_sel")
    }
    
    func addChildVC(_ vc : UIViewController, title : String,normalImageName:String,selectImageName:String){
        vc.tabBarItem.title = title;
        vc.tabBarItem.image = UIImage(named: normalImageName)
        vc.tabBarItem.selectedImage = UIImage(named: selectImageName)
        let navVC : SCLBaseNavigationViewController = SCLBaseNavigationViewController(rootViewController: vc)
        vc.navigationItem.title = title
        self.addChild(navVC)
    }
}

extension SCLBaseTabBarController : SCLTabBarProtocol {
    func clickHPTabBarCenterButtonWithTabBar(_ tabBar: SCLTabBar) {
        let alertVC : UIAlertController = UIAlertController(title: "提示", message: "你点击了中间的那个item", preferredStyle: .alert)
        let cancelAction : UIAlertAction = UIAlertAction(title: "取消", style: .cancel){
            (action:UIAlertAction) in
            print("\(action.title!)")
        }
        
        let confirmAction : UIAlertAction = UIAlertAction(title: "确定", style:.default){
            (action:UIAlertAction) in
            print("\(action.title!)")
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(confirmAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
}

extension SCLBaseTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}
