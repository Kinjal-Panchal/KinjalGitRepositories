//
//  Constant.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import Foundation
import UIKit
import Alamofire

enum AppStoryboard: String{
    case Repositories = "Repositories"
}

enum tableviewCellName: String {
    case RepositoriesTableviewCell = "RepositoriesTableViewCell"
}

extension UIViewController {
    
    class func instantiate<T: UIViewController>(appStoryboard: AppStoryboard) -> T {
        
        let storyboard = UIStoryboard(name: appStoryboard.rawValue, bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
