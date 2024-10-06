// 

struct AllRecipesRepository {

    var fetchRecipes: @Sendable () async throws(AllRecipesError) -> RecipesResponse
}
