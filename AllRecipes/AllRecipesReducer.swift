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
            let result = await repository.fetchRecipes()
            switch result {
            case let .failure(error):
                await send(.didFailToFetchRecipes(error))
            case let .success(response):
                await send(.didFetchRecipes(response.recipes))
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
