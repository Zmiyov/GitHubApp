//
//  Apollo.swift
//  GitHubApp
//
//  Created by Vladimir Pisarenko on 06.04.2023.
//

import Foundation
import Apollo
import GitHubAPI

final class Network {
    
    static let shared = Network()
    private init() { }
    
    private(set) lazy var apollo: ApolloClient = {
        let url = URL(string: "https://api.github.com/graphql")!
        let configuration = URLSessionConfiguration.default
        
        let store = ApolloStore()
        configuration.httpAdditionalHeaders = ["authorization": "Bearer \(Constants.APIKeys.GitHubAccessToken)"]
        
        let sessionClient = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        let provider = DefaultInterceptorProvider(client: sessionClient,store: store)
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: requestChainTransport, store: store)
    }()
}
