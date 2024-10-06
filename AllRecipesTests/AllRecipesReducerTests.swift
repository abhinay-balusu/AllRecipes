// 

import Foundation
import ComposableArchitecture
@testable import AllRecipes
import Testing

class AllRecipesReducerTests {

    @Suite("Lifecycle")
    struct LifecycleTests {

        @Test
        func whenViewDidAppearFetchRecipesCalled_returnedWithSuccess() async throws {
            let store = await TestStore(
                initialState: AllRecipesReducer.State(),
                reducer: { AllRecipesReducer() },
                withDependencies: {
                    $0.allRecipesRepository = AllRecipesRepository.mock
                }
            )

            await store.send(.viewDidAppear)

            await store.receive(\.didFetchRecipes) {
                $0.viewState = .data([
                    .init(
                        cuisine: "American",
                        name: "Banana Pancakes",
                        photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
                        photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
                        sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
                        uuid: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                        youtubeUrl: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
                    )
                ])
            }
        }

        @Test
        func whenViewDidAppearFetchRecipesCalled_returnedWithEmptyResponse() async throws {
            let store = await TestStore(
                initialState: AllRecipesReducer.State(),
                reducer: { AllRecipesReducer() },
                withDependencies: {
                    $0.allRecipesRepository = AllRecipesRepository.empty
                }
            )

            await store.send(.viewDidAppear)

            await store.receive(\.didFetchRecipes) {
                $0.viewState = .empty
            }
        }

        @Test
        func whenViewDidAppearFetchRecipesCalled_returnedWithFailure() async throws {
            let store = await TestStore(
                initialState: AllRecipesReducer.State(),
                reducer: { AllRecipesReducer() },
                withDependencies: {
                    $0.allRecipesRepository = AllRecipesRepository.failingWithError(.internalError)
                }
            )

            await store.send(.viewDidAppear)

            await store.receive(\.didFailToFetchRecipes) {
                $0.viewState = .error
            }
        }

        @Test
        func whenViewDidAppearAgainFetchRecipesNotCalled_noActionRecieved() async throws {
            let store = await TestStore(
                initialState: AllRecipesReducer.State(viewState: .data([
                    .init(
                        cuisine: "American",
                        name: "Banana Pancakes",
                        photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
                        photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
                        sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
                        uuid: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                        youtubeUrl: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
                    )
                ])),
                reducer: { AllRecipesReducer() },
                withDependencies: {
                    $0.allRecipesRepository = AllRecipesRepository.failingWithError(.internalError)
                }
            )

            await store.send(.viewDidAppear)
        }
    }

    @Suite("Actions")
    struct ActionTests {

        @Test
        func whenPullToRefreshFetchRecipesCalled_returnedWithSuccess() async throws {
            let store = await TestStore(
                initialState: AllRecipesReducer.State(viewState: .error),
                reducer: { AllRecipesReducer() },
                withDependencies: {
                    $0.allRecipesRepository = AllRecipesRepository.mock
                }
            )

            await store.send(.pullToRefresh) {
                $0.viewState = .loading
            }

            await store.receive(\.didFetchRecipes) {
                $0.viewState = .data([
                    .init(
                        cuisine: "American",
                        name: "Banana Pancakes",
                        photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
                        photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
                        sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
                        uuid: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                        youtubeUrl: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
                    )
                ])
            }
        }
    
        @Test
        func whenPullToRefreshFetchRecipesCalled_returnedWithEmptyResponse() async throws {
            let store = await TestStore(
                initialState: AllRecipesReducer.State(viewState: .error),
                reducer: { AllRecipesReducer() },
                withDependencies: {
                    $0.allRecipesRepository = AllRecipesRepository.empty
                }
            )

            await store.send(.pullToRefresh) {
                $0.viewState = .loading
            }

            await store.receive(\.didFetchRecipes) {
                $0.viewState = .empty
            }
        }

        @Test
        func whenPullToRefreshFetchRecipesCalled_returnedWithFailure() async throws {
            let store = await TestStore(
                initialState: AllRecipesReducer.State(viewState: .empty),
                reducer: { AllRecipesReducer() },
                withDependencies: {
                    $0.allRecipesRepository = AllRecipesRepository.failingWithError(.badServerResponse)
                }
            )

            await store.send(.pullToRefresh) {
                $0.viewState = .loading
            }

            await store.receive(\.didFailToFetchRecipes) {
                $0.viewState = .error
            }
        }

        @Test
        func whenPullToRefreshWithOneAlreadyinProgressFetchRecipesNotCalled_returnedWithNoAction() async throws {
            let store = await TestStore(
                initialState: AllRecipesReducer.State(viewState: .loading),
                reducer: { AllRecipesReducer() },
                withDependencies: {
                    $0.allRecipesRepository = AllRecipesRepository.failingWithError(.badServerResponse)
                }
            )

            await store.send(.pullToRefresh)
        }
    }

    @Suite("Network")
    struct NetworkTests {

        @Test func whenRequestFromUrl_returnedWithSuccess() async throws {
            let recipesResponse = RecipesResponse(recipes: [
                .init(
                    cuisine: "American",
                    name: "Banana Pancakes",
                    photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/large.jpg"),
                    photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"),
                    sourceUrl: URL(string: "https://www.bbcgoodfood.com/recipes/banana-pancakes"),
                    uuid: "f8b20884-1e54-4e72-a417-dabbc8d91f12",
                    youtubeUrl: URL(string: "https://www.youtube.com/watch?v=kSKtb2Sv-_U")
                )
            ])
            let mock = MockNetworkManager()
            mock.didRequestFromUrlStub = {
                recipesResponse
            }

            let actualResponse = try await AllRecipesRepository.live(networkManager: mock).fetchRecipes()

            #expect(mock.didRequestFromUrlCallCount == 1)
            #expect(mock.didRequestFromUrlSpy == URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"))
            #expect(actualResponse == recipesResponse)
        }
    }
}
