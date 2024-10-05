// 

struct AllRecipesRepository {

    var fetchRecipes: () async -> Result<RecipesResponse, AllRecipesError>
}

enum AllRecipesError: Error, Equatable {
    case internalError
    case remoteError(String)
    case badServerResponse
    case decodingError(String)
    case incorrectUrl
}
