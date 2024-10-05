// 

struct AllRecipesRepository {

    var fetchRecipes: () async throws(AllRecipesError) -> RecipesResponse
}
