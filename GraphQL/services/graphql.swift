//
//  graphql.swift
//  GraphQL
//
//  Created by Darrell Richards on 11/8/20.
//

import Foundation
import Apollo

class GraphqlService {
    static let shared = GraphqlService()
    private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:3000")!)
    
    func clearCache() {
        apollo.clearCache()
    }
}
