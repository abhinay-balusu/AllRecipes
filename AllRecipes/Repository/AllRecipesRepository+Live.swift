// 

import Foundation

extension AllRecipesRepository {

    static func live(jsonDecoder: JSONDecoder) -> AllRecipesRepository {
        AllRecipesRepository(
            fetchRecipes: {
                guard let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json") else {
                    return .failure(AllRecipesError.incorrectUrl)
                }

                do {
                    let (data, response) = try await URLSession.shared.data(from: url)
                    guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                        return .failure(AllRecipesError.badServerResponse)
                    }
                    do {
                        let response = try jsonDecoder.decode(RecipesResponse.self, from: data)
                        return .success(response)
                    } catch {
                        return .failure(AllRecipesError.decodingError(error.localizedDescription))
                    }
                } catch {
                    return .failure(AllRecipesError.remoteError(error.localizedDescription))
                }
            }
        )
    }
}
