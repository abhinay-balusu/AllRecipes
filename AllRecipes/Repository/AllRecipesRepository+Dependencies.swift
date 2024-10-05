// 

import Dependencies

struct AllRecipesRepositoryDependencyKey: DependencyKey {

    static var liveValue: AllRecipesRepository = .failingWithInternalError
}

extension DependencyValues {

    var allRecipesRepository: AllRecipesRepository {
        get { self[AllRecipesRepositoryDependencyKey.self] }
        set { self[AllRecipesRepositoryDependencyKey.self] = newValue }
    }
}
