//
//  RepositoryDetailsViewModel.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import Foundation

class RepositoryDetailsViewModel {

    private(set) var repository: Repository!
    
      func addBookmark(to repository: Repository) {
            repository.isBookmarked = true
             CoreDataManager.shared.saveContext()
       }
        
        func removeBookmark(from repository: Repository) {
            repository.isBookmarked = false
            CoreDataManager.shared.saveContext()
        }
    
}
