// 

import ComposableArchitecture
import SwiftUI

struct AllRecipesView: View {

    private let store: StoreOf<AllRecipesReducer>

    init(store: StoreOf<AllRecipesReducer>) {
        self.store = store
    }

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    let store = Store(
        initialState: AllRecipesReducer.State(),
        reducer: { AllRecipesReducer() }
    )

    return AllRecipesView(store: store)
}
