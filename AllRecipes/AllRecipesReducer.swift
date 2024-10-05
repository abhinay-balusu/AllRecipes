// 

import ComposableArchitecture

@Reducer
struct AllRecipesReducer {

    @Dependency(\.allRecipesRepository) private var repository

    struct State: Equatable {

        enum ViewState<Action: Equatable>: Equatable {
            case loading
            case data([Recipe])
            case error

            public var isLoading: Bool {
                self == .loading
            }
        }

        var viewState: ViewState<Action> = .loading
    }

    enum Action: Equatable {
        case viewDidAppear
        case pullToRefresh
        case didFetchRecipes([Recipe])
        case didFailToFetchRecipes(AllRecipesError)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .viewDidAppear:
                return fetchRecipes()
            case .pullToRefresh:
                return fetchRecipes()
            case let .didFetchRecipes(recipes):
                state.viewState = .data(recipes)
            case .didFailToFetchRecipes:
                state.viewState = .error
            }
            return .none
        }
    }
}

fileprivate extension AllRecipesReducer {

    func fetchRecipes() -> Effect<Action> {
        .run { send in
            do throws(AllRecipesError) {
                let response: RecipesResponse = try await repository.fetchRecipes()
                return await send(.didFetchRecipes(response.recipes))
            } catch {
                return await send(.didFailToFetchRecipes(error))
            }
        }
        .cancellable(
            id: Cancellable.fetchRecipes,
            cancelInFlight: true
        )
    }

    enum Cancellable: Hashable {
        case fetchRecipes
    }
}
