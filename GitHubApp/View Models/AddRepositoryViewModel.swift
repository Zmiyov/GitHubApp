//
//  AddRepositoryViewModel.swift
//  GitHubApp
//
//  Created by Vladimir Pisarenko on 06.04.2023.
//

import Foundation
import GitHubAPI

final class AddRepositoryViewModel: ObservableObject {
    
    var name: String = ""
    var description: String = ""
    var visibility: RepositoryVisibility = .public
    @Published var errors: [ErrorViewModel] = []
    
    func saveRepository(completion: @escaping () -> Void) {
         
        Network.shared.apollo.perform(mutation: CreateRepositoryMutation(name: name, description: .some(description), visibility: GraphQLEnum(visibility), clientMutationId: .some(UUID().uuidString))) { result in
            switch result {
                
            case .success(let graphQLResult):
                if let errors = graphQLResult.errors {
                    DispatchQueue.main.async {
                        self.errors = errors.map {
                            ErrorViewModel(message: $0.message)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errors = [ErrorViewModel(message: error.localizedDescription)]
                }
            }
        }
    }
}
