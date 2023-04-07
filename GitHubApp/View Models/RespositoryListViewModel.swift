//
//  RespositoryListViewModel.swift
//  GitHubApp
//
//  Created by Vladimir Pisarenko on 06.04.2023.
//

import Foundation
import Apollo
import GitHubAPI

enum RepositoriesDisplay {
    case latest
    case top
}

final class RepositoryListViewModel: ObservableObject {
    
    @Published var repositories: [RepositoryViewModel] = []
    @Published var repositoriesDisplay: RepositoriesDisplay = .latest
    
    func getTopRepositoriesForUser(username: String) {
        Network.shared.apollo.fetch(query: GetTopRepositoriesForUserQuery(username: username)) { result in
            switch result {
                
            case .success(let graphQLResult):
                guard let data = graphQLResult.data,
                      let user = data.user,
                      let nodes = user.repositories.nodes
                else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.repositories = nodes.compactMap { $0 }.map(RepositoryViewModel.init)
                }
                
            case .failure(let error):
                print(error )
            }
        }
    }
    
    func getLatestRepositoriesForUser(username: String) {
        
        Network.shared.apollo.fetch(query: GetReposetoriesByUserNameQuery(username: username), cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
                
            case .success(let graphQLResult):
                guard let data = graphQLResult.data,
                      let user = data.user,
                      let nodes = user.repositories.nodes
                else {
                    return
                }
                
                DispatchQueue.main.async {
                    self.repositories = nodes.compactMap { $0 }.map(RepositoryViewModel.init)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

struct RepositoryViewModel {
    
    let node: RepositoryNode
    
    var hasRating: Bool {
        node.stargazerCount > 0
    }
    
    var id: String {
        node.id
    }
    
    var name: String {
        node.name
    }
    
    var description: String {
        node.description ?? ""
    }
    
    var starCount: Int {
        node.stargazerCount
    }
}
