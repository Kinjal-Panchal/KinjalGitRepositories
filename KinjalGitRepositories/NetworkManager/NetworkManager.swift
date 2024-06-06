//
//  NetworkManager.swift
//  KinjalGitRepositories
//
//  Created by Kinjal panchal on 06/06/24.
//

import Foundation
import SwiftyJSON
import Alamofire

//MARK: NetWorkManager
class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchRepositories(page: Int, pageSize: Int, completion: @escaping (Result<[RepositoryModel], Error>) -> Void) {
        let url = "https://api.github.com/orgs/square/repos?page=\(page)&per_page=\(pageSize)"
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                var repositories: [RepositoryModel] = []
                for repoJSON in json.arrayValue {
                    let repo = RepositoryModel(
                        id: repoJSON["id"].int64Value,
                        name: repoJSON["name"].stringValue,
                        stargazersCount: repoJSON["stargazers_count"].intValue
                    )
                    repositories.append(repo)
                }
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

