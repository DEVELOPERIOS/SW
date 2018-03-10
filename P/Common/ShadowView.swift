//
//  ShadowView.swift
//  PappayaEd
//
//  Created by thirumal on 6/29/17.
//  Copyright © 2017 Think42Labs. All rights reserved.
//

import UIKit

@IBDesignable class ShadowView: UIView {
    
    @IBInspectable var cornerRadius : CGFloat = 5.0
    @IBInspectable var shadowRadius : CGFloat = 2.0
    var shadowOpacity : Float = 0.7
        {
        didSet
        {
            if shadowOpacity < 0.0
            {
                shadowOpacity = 0.0
            }
            else if shadowOpacity > 1.0
            {
                shadowOpacity = 1.0
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        applyShadow()
    }
    
    func applyShadow()
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = UIColor.black.cgColor
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true

        self.layer.rasterizationScale = UIScreen.main.scale
    }
    override var bounds: CGRect {
        didSet {
            applyShadow()
        }
    }
    
//    private func setupShadow() {
//        self.layer.cornerRadius = 8
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowRadius = 3
//        self.layer.shadowOpacity = 0.3
//        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .AllCorners, cornerRadii: CGSize(width: 8, height: 8)).CGPath
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.mainScreen().scale
//    }

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        #if TARGET_INTERFACE_BUILDER
            applyShadow()
        #endif
    }
}


extension UIView {
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var layerCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
