// 

import Foundation
@testable import AllRecipes

class MockNetworkManager: NetworkManagerInterface {

    private(set) var didRequestFromUrlCallCount = 0
    private(set) var didRequestFromUrlSpy: URL?

    var didRequestFromUrlStub: (() throws(AllRecipesError) -> Decodable)?

    func request<T: Decodable>(from url: URL?) async throws(AllRecipesError) -> T {
        didRequestFromUrlCallCount += 1
        didRequestFromUrlSpy = url
        return try didRequestFromUrlStub?() as! T
    }
}
