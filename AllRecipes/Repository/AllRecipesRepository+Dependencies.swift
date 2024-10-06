// 

import Dependencies

struct AllRecipesRepositoryDependencyKey: DependencyKey {

    // This is the value used by default
    static let liveValue: AllRecipesRepository = AllRecipesRepository(
        fetchRecipes: { () async throws(AllRecipesError) -> RecipesResponse in
            assertionFailure("Must implement fetchRecipes")
            throw .internalError
        }
    )
}

extension DependencyValues {

    var allRecipesRepository: AllRecipesRepository {
        get { self[AllRecipesRepositoryDependencyKey.self] }
        set { self[AllRecipesRepositoryDependencyKey.self] = newValue }
    }
}
