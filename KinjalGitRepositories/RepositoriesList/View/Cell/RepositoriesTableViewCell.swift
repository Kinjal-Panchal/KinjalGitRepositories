//
//  RepositoriesTableViewCell.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell {

    //MARK: Outlets
    @IBOutlet weak var lblRepoName: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnBookmark: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    //MARK: Variables
    var bookmarkedClick : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellSetup()
    }
    
    //MARK: CellSetup
    func cellSetup(){
        mainView.layer.borderWidth = 1
        mainView.layer.borderColor = UIColor.hexStringToUIColor(hex: "999999").cgColor
        mainView.backgroundColor = UIColor.hexStringToUIColor(hex: "2A5A2A")
        mainView.layer.cornerRadius = 8
        mainView.clipsToBounds = true
        lblCount.textColor = UIColor.hexStringToUIColor(hex: "161616")
        lblRepoName.textColor = UIColor.hexStringToUIColor(hex: "161616")
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
    
    //MARK: BookMark Button Action
    @IBAction func btnActionBookMark(_ sender: UIButton) {
        if let clicked = bookmarkedClick {
            clicked()
        }
    }
    
}
