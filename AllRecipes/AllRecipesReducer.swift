// 

import ComposableArchitecture

@Reducer
struct AllRecipesReducer {

    struct State: Equatable {

        enum ViewState<Action: Equatable>: Equatable {
            case loading
            case data
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
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            return .none
        }
    }
}
