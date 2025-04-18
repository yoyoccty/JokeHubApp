import Foundation

struct Joke: Identifiable, Codable, Hashable {
    var id: Int { return jokeID }
    let type: String
    let setup: String
    let punchline: String
    let jokeID: Int

    enum CodingKeys: String, CodingKey {
        case type, setup, punchline
        case jokeID = "id"
    }
}
