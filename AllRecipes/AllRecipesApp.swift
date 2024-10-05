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
                    dependencyValues.allRecipesRepository = .live
                }
            ))
        }
    }
}
