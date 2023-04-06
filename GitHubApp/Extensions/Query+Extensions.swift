//
//  Query+Extensions.swift
//  GitHubApp
//
//  Created by Vladimir Pisarenko on 06.04.2023.
//

import Foundation
import Apollo
import GitHubAPI

extension GetReposetoriesByUserNameQuery.Data.User.Repositories.Node: RepositoryNode { }
extension GetTopRepositoriesForUserQuery.Data.User.Repositories.Node: RepositoryNode { }
