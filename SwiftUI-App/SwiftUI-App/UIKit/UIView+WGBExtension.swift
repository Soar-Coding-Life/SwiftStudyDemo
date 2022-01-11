//
//  UIView+WGBExtension.swift
//  SwiftDemo
//
//  Created by 王贵彬(lu.com) on 2022/1/4.
//

import Foundation
import UIKit

extension UIView {
    @inlinable  public  var wgb_x :CGFloat? {
        set {
            self.frame.origin.x = newValue!
        }
        get {
            return self.frame.origin.x
        }
    }
    
    @inlinable  public  var wgb_y :CGFloat? {
        set {
            self.frame.origin.y = newValue!
        }
        get {
            return self.frame.origin.y
        }
    }
    
    @inlinable  public  var wgb_width :CGFloat? {
        set {
            self.frame.size.width = newValue!
        }
        get {
            return self.frame.size.width
        }
    }
    
    @inlinable  public  var wgb_height :CGFloat? {
        set {
            self.frame.size.height = newValue!
        }
        get {
            return self.frame.size.height
        }
    }
    
    @inlinable  public  var wgb_centerX :CGFloat? {
        set {
            self.center = CGPoint(x: newValue!, y: self.center.y)
        }
        get {
            return self.center.x
        }
    }
    
    @inlinable  public  var wgb_centerY :CGFloat? {
        set {
            self.center = CGPoint(x: self.center.x, y: newValue!)
        }
        get {
            return self.center.y
        }
    }
    
    @inlinable  public  var wgb_size :CGSize? {
        set {
            self.frame.size = newValue!
        }
        get {
            return self.frame.size
        }
    }
    
    @inlinable  public  var wgb_origin :CGPoint? {
        set {
            self.frame.origin = newValue!
        }
        get {
            return self.frame.origin
        }
    }
    
    /// 添加填满父视图的约束
    public func wgb_fillAlignedConstrains() {
        wgb_addAlignConstraintToSuperview(.top,0)
        wgb_addAlignConstraintToSuperview(.leading,0)
        wgb_addAlignConstraintToSuperview(.trailing,0)
        wgb_addAlignConstraintToSuperview(.bottom,0)
    }
    /// 填充并设置间距
    public func wgb_fillAlignedConstrainsInsets(_ edges: UIEdgeInsets) {
        wgb_addAlignConstraintToSuperview(.top,edges.top)
        wgb_addAlignConstraintToSuperview(.leading,edges.left)
        wgb_addAlignConstraintToSuperview(.trailing,edges.right)
        wgb_addAlignConstraintToSuperview(.bottom,edges.bottom)
    }
    /// centerY
    @discardableResult
    public func wgb_centerYConstraint(_ constant:CGFloat) -> Self {
        return wgb_centerYConstraint(constant,nil)
    }
    /// centerX
    @discardableResult
    public func wgb_centerXConstraint(_ constant:CGFloat) -> Self  {
        return wgb_centerXConstraint(constant,nil)
    }
    /// height
    @discardableResult
    public func wgb_heightConstraint(_ constant:CGFloat) -> Self  {
        return wgb_addConstraintToView(.height, .equal, nil, .notAnAttribute, 1.0, constant)
    }
    /// width
    @discardableResult
    public func wgb_widthConstraint(_ constant:CGFloat) -> Self {
        return wgb_addConstraintToView(.width, .equal, nil, .notAnAttribute, 1.0, constant)
    }
    
    /// top
    @discardableResult
    public func wgb_topConstraint(_ constant:CGFloat) -> Self {
        return wgb_topConstraint(constant,nil)
    }
    /// leading
    @discardableResult
    public func wgb_leftConstraint(_ constant:CGFloat) -> Self {
        return wgb_leftConstraint(constant,nil)
    }
    /// bottom
    @discardableResult
    public func wgb_bottomConstraint(_ constant:CGFloat) -> Self {
        return wgb_bottomConstraint(constant,nil)
    }
    /// right
    @discardableResult
    public func wgb_rightConstraint(_ constant:CGFloat) -> Self {
        return wgb_rightConstraint(constant,nil)
    }
    
    /// lessThanOrEqual height
    @discardableResult
    public func wgb_lessThanOrEqualHeightConstraint(_ constant:CGFloat) -> Self {
        return wgb_addConstraintToView(.height, .lessThanOrEqual, nil, .notAnAttribute, 1.0, constant)
    }
    ///greaterThanOrEqual height
    @discardableResult
    public func wgb_greaterThanOrEqualHeighthConstraint(_ constant:CGFloat) -> Self  {
       return wgb_addConstraintToView(.height, .greaterThanOrEqual, nil, .notAnAttribute, 1.0, constant)
    }
    
    /// lessThanOrEqual width
    @discardableResult
    public func wgb_lessThanOrEqualWidthConstraint(_ constant:CGFloat) -> Self  {
       return wgb_addConstraintToView(.width, .lessThanOrEqual, nil, .notAnAttribute, 1.0, constant)
    }
    /// greaterThanOrEqual width
    @discardableResult
    public func wgb_greaterThanOrEqualWidthConstraint(_ constant:CGFloat) -> Self {
       return wgb_addConstraintToView(.width, .greaterThanOrEqual, nil, .notAnAttribute, 1.0, constant)
    }
            
    /// 添加相对于父视图的约束
    /// - Parameters:
    ///   - attribute: 属性
    ///   - constant: 约束数值
    @discardableResult
    public func wgb_addAlignConstraintToSuperview(_ attribute: NSLayoutConstraint.Attribute,_ constant:CGFloat) -> Self {
       return wgb_addConstraintToView(attribute, .equal, superview, attribute, 1.0, constant)
    }
    
    //MARK: - 重载 `centerY` `centerX` `top` `bottom` `left` `right`
    /// centerY
    @discardableResult
    public func wgb_centerYConstraint(_ constant:CGFloat,_ target:UIView?) -> Self {
        return wgb_addSingleAttributeConstraintToView(.centerY, target ?? superview, constant)
        }
    /// centerX
    @discardableResult
    public func wgb_centerXConstraint(_ constant:CGFloat,_ target:UIView?) -> Self  {
        return wgb_addSingleAttributeConstraintToView(.centerX, target ?? superview, constant)
    }
    
    /// top
    @discardableResult
    public func wgb_topConstraint(_ constant:CGFloat,_ target:UIView?) -> Self  {
        return wgb_addSingleAttributeConstraintToView(.top, target ?? superview, constant)
    }
    /// bottom
    @discardableResult
    public func wgb_bottomConstraint(_ constant:CGFloat,_ target:UIView?) -> Self {
        return wgb_addSingleAttributeConstraintToView(.bottom, target ?? superview, constant)
    }
    /// left
    @discardableResult
    public func wgb_leftConstraint(_ constant:CGFloat,_ target:UIView?) -> Self  {
        return wgb_addSingleAttributeConstraintToView(.leading, target ?? superview, constant)
    }
    /// right
    @discardableResult
    public func wgb_rightConstraint(_ constant:CGFloat,_ target:UIView?) -> Self {
        return wgb_addSingleAttributeConstraintToView(.trailing, target ?? superview, constant)
    }

    
    /// 添加相对于某视图的同一属性的约束
    /// attribute  属性
    /// constant 约束数值
    /// multiplier 倍数
    /// target 参考视图
    @discardableResult
    public func wgb_addSingleAttributeConstraintToView(_ attribute: NSLayoutConstraint.Attribute,_ target:UIView?,_ constant:CGFloat) -> Self  {
       return wgb_addConstraintToView(attribute, .equal, target, attribute,1.0, constant)
    }
    
    @discardableResult
    public func wgb_addConstraintToView(_ attribute: NSLayoutConstraint.Attribute,
                                        _ relatedBy: NSLayoutConstraint.Relation,
                                        _ target:UIView?,
                                        _ targetAttribute:NSLayoutConstraint.Attribute,
                                        _ multiplier:CGFloat,
                                        _ constant:CGFloat) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: relatedBy,
                toItem: target,
                attribute: targetAttribute,
                multiplier: multiplier,
                constant: constant
            )
        )
        return self
    }

}
