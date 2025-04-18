import Foundation

@MainActor
class JokeViewModel: ObservableObject {
    @Published var jokes: [Joke] = []
    @Published var searchText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    var filteredJokes: [Joke] {
        if searchText.isEmpty {
            return jokes
        } else {
            return jokes.filter { $0.setup.lowercased().contains(searchText.lowercased()) } //test
        }
    }

    func fetchJokes() async {
        isLoading = true
        defer { isLoading = false }
        do {
            let url = URL(string: "https://official-joke-api.appspot.com/jokes/ten")!
            let (data, _) = try await URLSession.shared.data(from: url)
            jokes = try JSONDecoder().decode([Joke].self, from: data)
        } catch {
            errorMessage = "Unable to fetch jokes. Please check your connection."
        }
    }
}
