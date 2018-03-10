//
//  CommonFunctions.swift
//  Pappaya
//
//  Created by Thirumal on 28/11/16.
//  Copyright © 2016 Think42labs. All rights reserved.
//

import Foundation
import UIKit

struct CommonFunctions
{
    static let shared = CommonFunctions()
    // MARK: - UIView custom functions
    
    /**
     Set border color and border width for any UIView class
     
     - Parameter view : UIView - UIView for which border color and border width to be set.
     - Parameter borderColor : UIColor - Color of border
     - Parameter borderWidth : CGFloat - Border width (EX : 1.0 , 2.0)
     */
    
    func setBorderColorForView(_ view : UIView , borderColor : UIColor , borderWidth : CGFloat)
    {
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.masksToBounds = true
    }
    
    /**
     Set cornerRadius for any UIView class
     
     - Parameter view : UIView - UIView for which cornerRadius to be set.
     - Parameter cornerRadius : CGFloat - cornerRadius (EX : 1.0 , 2.0)
     */
    
    func setCornerRadiusForView(_ view : UIView , cornerRadius : CGFloat)
    {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }
    
    /**
     Set Shadow effect for any UIView class
     
     - Parameter view : UIView - UIView for which cornerRadius to be set.
     - Parameter cornerRadius : CGFloat - cornerRadius (EX : 1.0 , 2.0)
     */
    
    func setShadowForView(_ view : UIView , cornerRadius : CGFloat , shadowOpacity : Float)
    {
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = shadowOpacity
                
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        
        view.layer.rasterizationScale = UIScreen.main.scale
    }
    
    // MARK: - Color functions
    
    /**
     Get the color for given hexa Int
     
     - Parameter netHex : Int - Hexa decimal value (Ex: 0xFFFFFF)
     - Returns UIColor
     
     */
    
    func getUIColorForHexaCode(_ netHex:Int) -> UIColor
    {
        return UIColor(red: CGFloat((netHex >> 16) & 0xff) / 255.0, green: CGFloat((netHex >> 8) & 0xff) / 255.0, blue: CGFloat(netHex & 0xff) / 255.0, alpha: 1.0)
    }
    
    /**
     Get the color for given RGB value
     
     - Parameter red : CGFloat - Value for red code
     - Parameter green : CGFloat - Value for green code
     - Parameter blue : CGFloat - Value for blue code
     - Returns UIColor
     */
    
    func getUIColorForRGB(_ red : CGFloat , green : CGFloat , blue : CGFloat) -> UIColor
    {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    // MARK: - General function
    
    /**
     Get the instance of the appDelegate for application
     
     - Returns AppDelegate instance of the application
     */
    
    func getAppDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    /**
     Get the main screen bounds of the window
     
     - Returns : CGRect
     */
    
    func getMainScreenFrame() -> CGRect
    {
        return UIScreen.main.bounds
    }
    
    /**
     Set Status bar backGround color
     
     - Parameter color: UIColor - Status bar color
     */
    
    func setStatusBarBackgroundColor(_ color: UIColor) {
        
        guard  let statusBar = (UIApplication.shared.value(forKey: "statusBar") as? UIView) else {
            return
        }
        statusBar.backgroundColor = color
    }
    
    //MARK:- User defaults
    
    func saveDetailsToUserDefault(detailDict : [String : Any])
    {
        UserDefaults.standard.setValuesForKeys(detailDict)
        UserDefaults.standard.synchronize()
    }
    
    func getStringForKeyFromUserDefaults(key : String) -> String
    {
        if let value = UserDefaults.standard.string(forKey: key)
        {
            return value
        }
        return ""
    }
    
    /// Get the bool value for the given key from UserDefaults
    ///
    /// - Parameter key: key for which data should be return
    /// - Returns: Bool value for the key
    func getBoolValueForKey(key : String) -> Bool
    {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    /// It clears all value from UserDefaults.
    
    func clearUserdefault()
    {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()
    }
    
    //MARK:- View controller
    
    /// Returns the UIViewController from the given story board name and viewcontroller identifier.
    ///
    /// - Parameters:
    ///   - SBIdentifier: Story board identifier
    ///   - VCIdentifier: view controller identifier
    /// - Returns: UIViewController from story board
    func getViewControllerWithIdentifier(SBIdentifier : String, VCIdentifier : String) -> UIViewController
    {
        return UIStoryboard(name: SBIdentifier, bundle: nil).instantiateViewController(withIdentifier: VCIdentifier)
    }
    
    func getTrimmedString(text : String?) -> String
    {
        if text != nil
        {
            return text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        return ""
    }
    
    func getUserImage() -> UIImage
    {
        if let userImageData = UserDefaults.standard.object(forKey: Constants.UserDefaultsKey.UserImage) as? Data
        {
            if let image = UIImage(data: userImageData)
            {
                return image
            }
        }
        return UIImage(named: "icon-avatar")!
    }
    
    func checkNullAndNil(text : String?) -> String
    {
        if let textString = text
        {
            return textString
        }
        return ""
    }
    
    func convertServerDateStringToDate(dateString : String) -> Date
    {
        return self.convertStringToDate(dateString: dateString, format: Constants.DateFormat.server)
    }
    
    func convertStringToDate(dateString : String, format : String) -> Date
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.init(secondsFromGMT: 0)
        return dateFormatter.date(from: dateString)!
    }
    
    func convertDateToString(date : Date, dateFormat : String)-> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    func convertStringToString(dateString : String, format : String, toFormat : String) -> String
    {
        let date = self.convertStringToDate(dateString: dateString, format: format)
        return self.convertDateToString(date: date, dateFormat: toFormat)
    }
    
    func intervalBetweenDate(fromDate : Date, toDate : Date) -> Int
    {
        let calender = Calendar.current
        return calender.dateComponents([Calendar.Component.day], from: fromDate, to: toDate).day!
    }
    
    func addDateToDate(addDate : Date, interval : Int) -> Date
    {
        let calender = Calendar.current
        return calender.date(byAdding: Calendar.Component.day, value: interval, to: addDate)!
    }
    
    func getUserType() -> String
    {
        return self.getStringForKeyFromUserDefaults(key: Constants.UserDefaultsKey.UserType).uppercased()
    }
    
    func convertListToModel(attachmentList : [[String : Any]]) -> [AttachmentModel]
    {
        var modelList : [AttachmentModel] = []
        for detail in attachmentList
        {
            modelList.append(AttachmentModel(dict: detail))
        }
        return modelList
    }
}








