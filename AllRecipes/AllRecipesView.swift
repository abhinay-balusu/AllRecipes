// 

import ComposableArchitecture
import Kingfisher
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
                case let .data(recipes):
                    recipesContent(viewStore, recipes: recipes)
                case .error:
                    errorContent(viewStore)
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

    private func recipesContent(_ viewStore: ViewStoreOf<AllRecipesReducer>, recipes: [Recipe]) -> some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                    ForEach(recipes) { recipe in
                        ZStack(alignment: .leading) {
                            KFImage(recipe.photoUrlSmall)
                                .cancelOnDisappear(true)
                                .resizable()
                                .cornerRadius(12)
                                .shadow(radius: 5)
                                .opacity(0.5)
                            VStack(alignment: .leading) {
                                Spacer()
                                Text(recipe.name)
                                    .font(.headline)
                                Text(recipe.cuisine)
                                    .font(.subheadline)
                            }
                            .padding()
                        }
                    }
                }
            }
            .padding()
            .navigationTitle("Recipes")
        }
    }

    private func errorContent(_ viewStore: ViewStoreOf<AllRecipesReducer>) -> some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack {
                    Spacer()
                    Text("Unable to load Recipes")
                    Text("Please pull down to refresh")
                    Spacer()
                }
                .frame(minWidth: proxy.size.width, minHeight: proxy.size.height)
                .navigationTitle("Recipes")
            }
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
