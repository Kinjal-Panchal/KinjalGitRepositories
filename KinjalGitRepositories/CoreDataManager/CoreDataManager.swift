//
//  CoreDataManager.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import Foundation
import CoreData
import UIKit

//MARK: Coredata Manager class
class CoreDataManager {
    
    //MARK: Variables
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "KinjalGitRepositories")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data stack: \(error)")
            }
        }
    }
    
    //MARK: Save data to local databse
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: Get all repositories list with pagination
    func fetchRepositories(page: Int, pageSize: Int) -> [Repository] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Repository> = Repository.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        fetchRequest.fetchOffset = (page - 1) * pageSize
        fetchRequest.fetchLimit = pageSize
        
        do {
            let repositories = try context.fetch(fetchRequest)
            return repositories
        } catch {
            print("Failed to fetch repositories: \(error)")
            return []
        }
    }
    
    //MARK: Get repositories
    func fetchAllRepositories() -> [Repository] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Repository> = Repository.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            let repositories =  try context.fetch(fetchRequest)
            return repositories
        } catch {
            print("Failed to fetch repositories: \(error)")
            return []
        }
    }
    
    //MARK: Save all repositories to database
    func saveRepositories(repoModels: [RepositoryModel]) {
        let context = persistentContainer.viewContext
        for repoModel in repoModels {
            let fetchRequest: NSFetchRequest<Repository> = Repository.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", repoModel.id)
            
            do {
                let existingRepositories = try context.fetch(fetchRequest)
                if existingRepositories.isEmpty {
                    let repository = Repository(context: context)
                    repository.id = repoModel.id
                    repository.name = repoModel.name
                    repository.stargazersCount = Int32(repoModel.stargazersCount)
                    repository.isBookmarked = false
                } else {
                    let repository = existingRepositories.first!
                    repository.name = repoModel.name
                    repository.stargazersCount = Int32(repoModel.stargazersCount)
                }
            } catch {
                print("Failed to fetch or save repository: \(error)")
            }
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
}
