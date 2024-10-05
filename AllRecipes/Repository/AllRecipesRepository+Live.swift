// 

import Foundation

extension AllRecipesRepository {

    static func live(networkManager: NetworkManagerInterface) -> AllRecipesRepository {
        AllRecipesRepository(
            fetchRecipes: { () async throws(AllRecipesError) -> RecipesResponse in
                try await networkManager.request(from: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"))
            }
        )
    }
}
