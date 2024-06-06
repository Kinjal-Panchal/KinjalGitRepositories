//
//  RepositoriesViewController.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var RepositoriesTableview: UITableView!
    
    //MARK: Variables
    private let viewModel = RepositoriesViewModel()
    var repositories: [Repository] = []
    let refreshControl = UIRefreshControl()
    
    //MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupPullToRefresh()
        bindViewModel()
        LoaderClass.showActivityIndicator()
        viewModel.fetchRepositories()
        
    }
    
    //MARK: Tableview and NavigationBar setup
    private func setupTableView(){
       RepositoriesTableview.delegate = self
        RepositoriesTableview.dataSource = self
        let nib = UINib(nibName: tableviewCellName.RepositoriesTableviewCell.rawValue, bundle: nil)
        RepositoriesTableview.register(nib, forCellReuseIdentifier: tableviewCellName.RepositoriesTableviewCell.rawValue)
       UtilityClass.setTitleInNavigationBar(strTitle: "Repositories List",navigationItem: self.navigationItem,position: .middle, navigationController: self.navigationController ?? UINavigationController())
   }
    
    //MARK: setup pull to refresh
    private func setupPullToRefresh() {
        refreshControl.addTarget(self, action:
                                    #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .red
        RepositoriesTableview.addSubview(refreshControl)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
            viewModel.refreshRepositories()
       }
    
    //MARK: Binding view model
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.RepositoriesTableview.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
        viewModel.onLoadingStateChange = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    print("Loader Show")
                    LoaderClass.showActivityIndicator()
                } else {
                    LoaderClass.hideActivityIndicator()
                }
            }
        }
    }
}
    
//MARK: Tableview DataSource and Delegate
extension RepositoriesViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableviewCellName.RepositoriesTableviewCell.rawValue, for: indexPath) as! RepositoriesTableViewCell
        let repository = viewModel.repositories[indexPath.row]
        cell.lblRepoName.text = repository.name
        cell.lblCount.text = "Count: \(repository.stargazersCount)"
        cell.btnBookmark.isSelected = repository.isBookmarked
        cell.bookmarkedClick = {
            if repository.isBookmarked {
                self.viewModel.removeBookmark(from: repository)
                
            } else {
                self.viewModel.addBookmark(to: repository)
                
            }
            DispatchQueue.main.async {
                self.RepositoriesTableview.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 100
     }
      
      func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let position = scrollView.contentOffset.y
          if position > (RepositoriesTableview.contentSize.height - 100 - scrollView.frame.size.height) {
              viewModel.fetchRepositories()
          }
      }
    
}

