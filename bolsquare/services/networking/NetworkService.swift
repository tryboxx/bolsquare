//
//  NetworkService.swift
//  BolSquare
//
//  Created by Christopher Kolodziej on 23/07/2025.
//

import UIKit

protocol NetworkService: AnyObject, AutoMockable {
    func fetchRepositories() async throws -> [Repository]
}

final class NetworkServiceImpl: NetworkService {

    /// Minimal example, for simple purpose only
    func fetchRepositories() async throws -> [Repository] {
        guard let url = Constants.repositories else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.requestFailed
        }

        do {
            return try JSONDecoder().decode([Repository].self, from: data)
        } catch {
            throw APIError.decodingFailed
        }
    }
}

private enum Constants {
    static let repositories = URL(string: "https://api.github.com/orgs/square/repos")
}
