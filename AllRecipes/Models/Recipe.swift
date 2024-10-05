// 

import Foundation

struct Recipe: Decodable, Equatable, Identifiable {

    let cuisine: String
    let name: String
    let photoUrlLarge: URL?
    let photoUrlSmall: URL?
    let sourceUrl: URL?
    let uuid: String
    let youtubeUrl: URL?

    var id: String {
        uuid
    }
}
