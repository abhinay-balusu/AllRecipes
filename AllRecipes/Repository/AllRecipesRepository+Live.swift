// 

extension AllRecipesRepository {

    static var live: AllRecipesRepository {
        AllRecipesRepository(
            fetchRecipes: {
                .success(.init(recipes: []))
            }
        )
    }
}
