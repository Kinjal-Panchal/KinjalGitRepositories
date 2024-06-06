//
//  UtilityClass.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

enum navigationTitlePosition: String {
    case middle
    case left
}


class UtilityClass : NSObject
{
    class func setTitleInNavigationBar(strTitle : String, navigationItem : UINavigationItem, position : navigationTitlePosition = .left, navigationController : UINavigationController)

    {
        
        let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = UIColor.hexStringToUIColor(hex: "2A5A2A")
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.prefersLargeTitles = false
        navigationController.navigationBar.barTintColor = UIColor.yellow
        navigationController.navigationBar.tintColor = UIColor.black
        
        let longTitleLabel = UILabel()
        longTitleLabel.text = strTitle
        longTitleLabel.textColor = UIColor.hexStringToUIColor(hex: "161616")
        longTitleLabel.font = UIFont.systemFont(ofSize: 20)
        longTitleLabel.sizeToFit()
        if(position == .left)
        {
            let leftItem = UIBarButtonItem(customView: longTitleLabel)
            navigationItem.leftBarButtonItem = leftItem
        }
        else
        {
            longTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            longTitleLabel.textAlignment = .center
            navigationItem.titleView = longTitleLabel
        }
        
    }
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class LoaderClass: NSObject {
    static var act_indicator = ActivityIndicatorViewController()
    // MARK: -- Inicator --
    static func showActivityIndicator() {
        let size = CGSize(width: 30, height: 30)
        
        act_indicator.startAnimating(size, message: "", type: NVActivityIndicatorType(rawValue:2)!)
    }
    static func hideActivityIndicator() {
        act_indicator.stopAnimating()
    }
}

