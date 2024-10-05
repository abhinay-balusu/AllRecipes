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
                guard case .data = state.viewState else {
                    return fetchRecipes()
                }
                return .none
            case .pullToRefresh:
                guard !state.viewState.isLoading else {
                    return .none
                }
                state.viewState = .loading
                return fetchRecipes()
            case let .didFetchRecipes(recipes):
                let sortedRecipes = recipes.sorted { $0.name < $1.name }
                state.viewState = .data(sortedRecipes)
                return .none
            case .didFailToFetchRecipes:
                state.viewState = .error
                return .none
            }
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
