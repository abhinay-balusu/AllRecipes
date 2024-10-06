// 

import Foundation
@testable import AllRecipes
import Testing

struct NetworkManagerTests {

    let sut = NetworkManager()

    @Test
    func whenRequestData_handleSuccessResponse() async throws {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")

        let response: RecipesResponse = try await sut.request(from: url)

        #expect(!response.recipes.isEmpty)
        #expect(response.recipes.first(where: { $0.uuid == "f8b20884-1e54-4e72-a417-dabbc8d91f12" }) == .init(
            cuisine: "American",
            name: "Banana Pancakes",
            photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
            photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
            sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
            uuid: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
            youtubeUrl: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
        ))
    }

    @Test
    func whenRequestData_handleMalformedResponse() async throws {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")

        do {
            let _: RecipesResponse = try await sut.request(from: url)
        } catch {
            guard case .decodingError = error else {
                Issue.record("Unexpected error")
                return
            }
        }
    }

    @Test
    func whenRequestData_handleEmptyResponse() async throws {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")

        let response: RecipesResponse = try await sut.request(from: url)

        #expect(response.recipes.isEmpty)
    }
}
