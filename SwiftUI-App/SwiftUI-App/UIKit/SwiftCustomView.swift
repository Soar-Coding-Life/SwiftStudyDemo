//
//  SwiftCustomView.swift
//  SwiftUI-App
//
//  Created by 王贵彬(lu.com) on 2022/1/12.
//

import Foundation
import UIKit

class MyView: UIView {
    lazy var imageView:UIImageView = {
        let img = UIImageView(frame: .zero)
        img.image = UIImage(systemName: "book.fill")
        img.contentMode = .scaleAspectFit
        img.tintColor = .random
        return img
    }()

    
    lazy var textLabel:UILabel = {
        let lab = UILabel(frame: .zero)
        lab.font = UIFont.systemFont(ofSize: 15.0)
        lab.textAlignment = .center
        lab.textColor = .random
        return lab
    }()
    
    
    func setupUI() {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        self.backgroundColor = .random
        self.addSubview(self.imageView)
        self.addSubview(self.textLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        self.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth : CGFloat = self.wgb_width!
        let screenHeight : CGFloat = self.wgb_height!

        self.imageView.wgb_addAlignConstraintToSuperview(.top, 0)
        self.imageView.wgb_addAlignConstraintToSuperview(.left, screenWidth/4.0)
        self.imageView.wgb_addAlignConstraintToSuperview(.right, -screenWidth/4.0)
        self.imageView.wgb_heightConstraint(screenHeight/2.0)

        self.textLabel.wgb_addAlignConstraintToSuperview(.bottom, 0)
            .wgb_addAlignConstraintToSuperview(.left, 0)
            .wgb_addAlignConstraintToSuperview(.right, 0)
            .wgb_heightConstraint(screenHeight/2.0)
    }
    
    
    override func layoutSubviews(){
        super.layoutSubviews()
        self.imageView.frame = CGRect(x: frame.width/4.0, y: 0, width: frame.width/2.0, height: frame.height/2.0)
        self.textLabel.wgb_y = frame.height/2.0
        self.textLabel.wgb_x = 0
        self.textLabel.wgb_size  = CGSize(width: frame.width, height: frame.height/2.0)
    }

}
