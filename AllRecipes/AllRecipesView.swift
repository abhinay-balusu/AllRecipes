// 

import ComposableArchitecture
import SwiftUI

struct AllRecipesView: View {

    private let store: StoreOf<AllRecipesReducer>

    init(store: StoreOf<AllRecipesReducer>) {
        self.store = store
    }

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationView {
                switch viewStore.viewState {
                case .loading:
                    ProgressView()
                        .navigationTitle("Recipes")
                case .data:
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
                case .error:
                    EmptyView()
                        .navigationTitle("Recipes")
                }
            }
        }
        .onAppear {
            store.send(.viewDidAppear)
        }
        .refreshable {
            store.send(.pullToRefresh)
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
