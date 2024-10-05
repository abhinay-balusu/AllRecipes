// 

import Dependencies

struct AllRecipesRepositoryDependencyKey: DependencyKey {

    // This is the value used by default
    static var liveValue: AllRecipesRepository = AllRecipesRepository(
        fetchRecipes: {
            assertionFailure("Must implement fetchRecipes")
            return .failure(.internalError)
        }
    )
}

extension DependencyValues {

    var allRecipesRepository: AllRecipesRepository {
        get { self[AllRecipesRepositoryDependencyKey.self] }
        set { self[AllRecipesRepositoryDependencyKey.self] = newValue }
    }
}
