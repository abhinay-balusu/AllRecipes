// 

import Foundation

#if DEBUG
extension AllRecipesRepository {

    static var mock: AllRecipesRepository {
        AllRecipesRepository(
            fetchRecipes: { () async throws(AllRecipesError) -> RecipesResponse in
                return .init(recipes: [
                    .init(
                        cuisine: "American",
                        name: "Banana Pancakes",
                        photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
                        photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
                        sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
                        uuid: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                        youtubeUrl: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
                    )
                ])
            }
        )
    }

    static var empty: AllRecipesRepository {
        AllRecipesRepository(
            fetchRecipes: { () async throws(AllRecipesError) -> RecipesResponse in
                return .init(recipes: [])
            }
        )
    }

    static func failingWithError(_ error: AllRecipesError) -> AllRecipesRepository {
        AllRecipesRepository(
            fetchRecipes: { () async throws(AllRecipesError) -> RecipesResponse in
                throw error
            }
        )
    }
}
#endif
