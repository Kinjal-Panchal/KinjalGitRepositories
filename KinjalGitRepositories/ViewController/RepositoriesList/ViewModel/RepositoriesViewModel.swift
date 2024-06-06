//
//  RepositoriesViewModel.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import Foundation
import CoreData

class RepositoriesViewModel {
    
    //MARK: Variables
    private(set) var repositories: [Repository] = []
    private var currentPage = 1
    private let pageSize = 10 // Number of repositories to fetch per page
    var isLoading = false
    var onUpdate: (() -> Void)?
    var onLoadingStateChange: ((Bool) -> Void)?
    private var isloadMore = true
    
    init() {
        fetchRepositories()
    }
    
    //MARK: get Repositories
    func fetchRepositories() {
        guard !isLoading && isloadMore else { return }
        isLoading = true
        onLoadingStateChange?(true)
        
        if !Connectivity.isConnectedToInternet() {
            print("No internet connection, loading data from Core Data")
            self.repositories = CoreDataManager.shared.fetchAllRepositories()
            self.isLoading = false
            self.onLoadingStateChange?(false)
            self.onUpdate?()
            return
        }
        
        print("Fetching page \(currentPage)")
        
        NetworkManager.shared.fetchRepositories(page: currentPage, pageSize: pageSize) { result in
            self.isLoading = false
            self.onLoadingStateChange?(false)
            switch result {
            case .success(let repoModels):
                print("Fetched \(repoModels.count) repositories")
                if repoModels.isEmpty {
                    self.isloadMore = false
                } else {
                    CoreDataManager.shared.saveRepositories(repoModels: repoModels)
                    let newRepositories = CoreDataManager.shared.fetchRepositories(page: self.currentPage, pageSize: self.pageSize)
                    self.repositories.append(contentsOf: newRepositories)
                    self.currentPage += 1
                }
                self.onUpdate?()
            case .failure(let error):
                print("Error fetching repositories: \(error)")
            }
        }
    }
    
    func refreshRepositories() {
        currentPage = 1
        isloadMore = true
        fetchRepositories()
    }
}

extension RepositoriesViewModel {
    
    //MARK: ==== Add Bookmark to saved locally
    func addBookmark(to repository: Repository) {
        repository.isBookmarked = true
        CoreDataManager.shared.saveContext()
    }

    //MARK: ==== remove Bookmark to removed locally
    func removeBookmark(from repository: Repository) {
        repository.isBookmarked = false
        CoreDataManager.shared.saveContext()
    }
}
