//
//  RepositoryNode.swift
//  GitHubApp
//
//  Created by Vladimir Pisarenko on 06.04.2023.
//

import Foundation
import Apollo

protocol RepositoryNode {
    var id: String { get }
    var name: String { get }
    var description: String? { get }
    var stargazerCount: Int { get }
}
