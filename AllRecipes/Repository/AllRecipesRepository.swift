// 

struct AllRecipesRepository {

    var fetchRecipes: () async -> Result<RecipesResponse, AllRecipesError>
}

enum AllRecipesError: Error {
    case internalError
    case remoteError
}
