//
//  TestUiKitViewController.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/11.
//

import Foundation
import UIKit
import SwiftUI

class TestUiKitViewController: UIViewController {
    lazy var view0 : UIView = {
         let view = UIView(frame: CGRect.zero)
         view.backgroundColor = RGB[255,0,0]
         return view
     }()
    
    lazy var view1 : UIView = {
         let view = UIView(frame: CGRect.zero)
         view.backgroundColor = RGBA[255,100,100,1]
         return view
     }()

    lazy var view2 : UIView = {
        let view = UIView(frame: CGRect.zero)
         view.backgroundColor = UIColor(100,255,10,0.6)
         return view
     }()

    lazy var view3 : UIView = {
         let view = UIView(frame: CGRect.zero)
         view.backgroundColor = UIColor.random
         return view
     }()

    lazy var view4 : UIView = {
         let view = UIView(frame: CGRect.zero)
         view.backgroundColor = UIColor.colorFromHex("#1e2f3d")
         return view
     }()
    
    lazy var scrollView : UIScrollView = {
         let view = UIScrollView(frame: CGRect.zero)
        view.backgroundColor = .random
        view.contentInsetAdjustmentBehavior = .automatic
         return view
     }()
    
    
    lazy var button : UIButton = {
        let view = UIButton(type: .custom)
        view.backgroundColor = .black
        view.layer.cornerRadius = 10.0
        view.setTitleColor(.white, for: .normal)
        view.setTitle("调用SwiftUI的页面", for: .normal)
        view.addTarget(self, action: #selector(callSwiftUIPage), for: .touchUpInside)
         return view
     }()

    
    @objc func callSwiftUIPage() {
        //替换当前页面为SwiftUI `ListDataView`页面
        let listVC = UIHostingController(rootView: ListDataView())
        listVC.view.frame = CGRect(x: 0, y: 0, width: self.scrollView.contentSize.width, height: self.scrollView.contentSize.height)
        self.addChild(listVC)
        listVC.didMove(toParent: self)
        self.scrollView.addSubview(listVC.view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.frame = self.view.bounds;
        self.scrollView.contentSize = CGSize(width: self.view.wgb_width!, height: 2000)
        self.view.addSubview(self.button)
        self.button.wgb_size = CGSize(width: 200, height: 30);
        self.button.wgb_centerX = UIScreen.main.bounds.size.width/2.0;
        self.button.wgb_centerY = UIScreen.main.bounds.size.height/2.0;
        
        UINavigationBar.appearance().prefersLargeTitles = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
                
        [self.view0,
         self.view1,
         self.view2,
         self.view3,
         self.view4].forEach({
            self.scrollView.addSubview($0)
        })
        
        self.view0.wgb_x = 20;
        self.view0.wgb_y = 20;
        self.view0.wgb_width = 300;
        self.view0.wgb_height = 100;
        
        self.view1.wgb_x = self.view0.wgb_x;
        self.view1.wgb_y = self.view0.frame.maxY + 10;
        self.view1.wgb_width = 50;
        self.view1.wgb_height = 200;
        
        self.view2.wgb_x = self.view1.frame.maxX + 10;
        self.view2.wgb_y = self.view1.wgb_y;
        self.view2.wgb_width = 240;
        self.view2.wgb_height = 200;

        self.view3.wgb_x = self.view1.wgb_x;
        self.view3.wgb_y = self.view2.frame.maxY + 10;
        self.view3.wgb_width = 300;
        self.view3.wgb_height = 300;
        
        self.view4.wgb_x = self.view1.wgb_x;
        self.view4.wgb_y = self.view3.frame.maxY + 10;
        self.view4.wgb_width = self.view.wgb_width! - 60;
        self.view4.wgb_height = 600;


//        self.view0.wgb_topConstraint(20)
//            .wgb_leftConstraint(20)
//            .wgb_heightConstraint(100)
//            .wgb_widthConstraint(300)
//
//        self.view1.wgb_addConstraintToView(.top, .equal, self.view0, .bottom, 1.0, 10)
//            .wgb_leftConstraint(0,self.view0)
//            .wgb_heightConstraint(200)
//            .wgb_widthConstraint(50)
//
//        self.view2.wgb_addConstraintToView(.leading, .equal, self.view1, .trailing, 1.0, 10)
//            .wgb_widthConstraint(240)
//            .wgb_heightConstraint(200)
//            .wgb_topConstraint(0, self.view1)
//
//        self.view3.wgb_addConstraintToView(.top, .equal, self.view2, .bottom, 1.0, 10)
//            .wgb_addConstraintToView(.left, .equal, self.view1, .left, 1.0, 0)
//            .wgb_widthConstraint(300)
//            .wgb_heightConstraint(300)
//
//        self.view4.wgb_addConstraintToView(.top, .equal, self.view3, .bottom, 1.0, 10)
//            .wgb_addConstraintToView(.left, .equal, self.view3, .left, 1.0, 0)
//            .wgb_addConstraintToView(.right, .equal, self.view3, .right, 1.0, 0)
//            .wgb_addConstraintToView(.bottom, .equal, self.scrollView, .bottom, 1.0, -10)

        
    }
    
    
}
