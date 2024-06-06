//
//  RepositoryDetailsViewController.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    
    //MARK: Variables
    private let viewModel = RepositoryDetailsViewModel()
    var repository: Repository!
    var updatestatus: ((Repository) ->())?
    
    //MARK: Outlets
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnBookMark: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: SetupViews
    func setupViews(){
        btnBookMark.layer.cornerRadius = 8
        UtilityClass.setTitleInNavigationBar(strTitle: "Repository detail",navigationItem: self.navigationItem,position: .middle, navigationController: self.navigationController ?? UINavigationController())
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"iconBackArrow"), style: .plain, target: self, action: #selector(goBack))
        lblName.text = repository.name
        lblCount.text = "Stars: \(repository.stargazersCount)"
        updateBookmarkButtonTitle()
    }
    
    //MARK: Back button Action
    @objc func goBack()
      {
          self.navigationController?.popViewController(animated: true)
      }
    
    //MARK: BookMark button Action
    @IBAction func btnActionbookMark(_ sender: UIButton) {
        if repository.isBookmarked {
            viewModel.removeBookmark(from: repository)
        } else {
            viewModel.addBookmark(to: repository)
        }
        updateBookmarkButtonTitle()
        if let statusUpdate = updatestatus{
            statusUpdate(repository)
        }
    }
    
    private func updateBookmarkButtonTitle() {
        
        btnBookMark.backgroundColor = repository.isBookmarked ? UIColor.gray : UIColor.hexStringToUIColor(hex: "2A5A2A")
        btnBookMark.setTitle(repository.isBookmarked ? "Remove Bookmark" : "Add to Bookmarks", for: .normal)
        btnBookMark.setTitleColor(repository.isBookmarked ? .white : UIColor.hexStringToUIColor(hex: "161616") , for: .normal)
    }
}
