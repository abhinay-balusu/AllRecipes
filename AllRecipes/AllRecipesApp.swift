// 

import ComposableArchitecture
import SwiftUI

@main
struct AllRecipesApp: App {
    var body: some Scene {
        WindowGroup {
            AllRecipesView(store: Store(
                initialState: AllRecipesReducer.State(),
                reducer: { AllRecipesReducer() },
                withDependencies: { dependencyValues in
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                    dependencyValues.allRecipesRepository = .live(jsonDecoder: jsonDecoder)
                }
            ))
        }
    }
}
