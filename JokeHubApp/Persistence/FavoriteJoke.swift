import Foundation
import SwiftData

@Model
class FavoriteJoke: Identifiable {
    var id: Int
    var setup: String
    var punchline: String
    var type: String

    init(id: Int, setup: String, punchline: String, type: String) {
        self.id = id
        self.setup = setup
        self.punchline = punchline
        self.type = type
    }
}
