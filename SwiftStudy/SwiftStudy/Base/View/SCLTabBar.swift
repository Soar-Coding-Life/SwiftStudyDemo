//
//  SCLTabBar.swift
//  SwiftStudy
//
//  Created by mac on 2020/1/9.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol SCLTabBarProtocol: NSObjectProtocol {
    func clickHPTabBarCenterButtonWithTabBar(_ tabBar : SCLTabBar)
}

class SCLTabBar: UITabBar {
    weak var sclDelegate: SCLTabBarProtocol?
    var sclHandler: (()->())?
   lazy var publishButton : UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named:"add"), for: .normal)
    button.addTarget(self, action: #selector(buttonclickAction(button:)), for: UIControl.Event.touchUpInside)
    return button
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.publishButton)
//        self.backgroundColor = UIColor.black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let width : CGFloat = UIScreen.main.bounds.size.width
        let btnY: CGFloat = 0.0
        let btnW: CGFloat = width/5.0
        var btnX: CGFloat = 0.0
        var btnH: CGFloat = 49.0

        self.publishButton.frame = CGRect(x: 0, y: 0, width: btnW, height: btnH)
        self.publishButton.center = CGPoint(x: width*0.5, y: btnH*0.5)
        var index : NSInteger = 0
        for button in self.subviews {
            if (!(button.isKind(of: UIControl.self)) || (button == self.publishButton)) {
                continue;
            }
            
            btnX = btnW * CGFloat((index > 1 ? index+1 : index))
            btnH = button.frame.size.height
            button.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
            index += 1
        }
    }
    
    @objc func buttonclickAction(button:UIButton)->Void{
        self.sclDelegate?.clickHPTabBarCenterButtonWithTabBar(self)
        self.sclHandler?()
    }
}
