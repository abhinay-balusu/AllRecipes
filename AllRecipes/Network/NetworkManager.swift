// 

import Foundation

enum AllRecipesError: Error, Equatable {
    case internalError
    case remoteError(String)
    case badServerResponse
    case decodingError(String)
    case incorrectUrl
}

extension AllRecipesError: Sendable { }

protocol NetworkManagerInterface: Sendable {

    func request<T: Decodable>(from url: URL?) async throws(AllRecipesError) -> T
}

final class NetworkManager {

    @MainActor static let shared = NetworkManager()

    private let session: URLSession
    private let jsonDecoder: JSONDecoder

    init(session: URLSession = .shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
}

extension NetworkManager: NetworkManagerInterface {

    func request<T>(from url: URL?) async throws(AllRecipesError) -> T where T : Decodable {
        guard let url else {
            throw AllRecipesError.incorrectUrl
        }

        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw AllRecipesError.badServerResponse
            }
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            if error is DecodingError {
                throw AllRecipesError.decodingError(error.localizedDescription)
            } else {
                throw AllRecipesError.remoteError(error.localizedDescription)
            }
        }
    }
}
