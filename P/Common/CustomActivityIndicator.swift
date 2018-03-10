//
//  CustomActivityIndicator.swift
//  MIT
//
//  Created by Thirumal on 23/02/17.
//  Copyright © 2017 Benz. All rights reserved.
//

import UIKit

class CustomActivityIndicator: NSObject
{
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    public class var shared: CustomActivityIndicator
    {
        struct Static
        {
            static let instance: CustomActivityIndicator = CustomActivityIndicator()
        }
        return Static.instance
    }
    
    public func showProgressView()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = appDelegate.window!
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.backgroundColor = UIColor(hex: 0x111111, alpha: 0.5)
        
        progressView.frame =  CGRect(x: 0, y: 0, width: 150, height: 50)
        progressView.center = view.center
        progressView.backgroundColor = UIColor.white
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 5
        progressView.layer.borderColor = UIColor.lightGray.cgColor
        progressView.layer.borderWidth = 5
        
        activityIndicator.frame = CGRect(x: 10, y: 5, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.color = UIColor.black
        
        let loadingLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 100, height: 50))
        loadingLabel.textAlignment = NSTextAlignment.left
        loadingLabel.textColor = UIColor.black
        loadingLabel.text = "Loading..."
        progressView.addSubview(loadingLabel)
        
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    public func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}

extension UIColor
{
    convenience init(hex: UInt32, alpha: CGFloat)
    {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
