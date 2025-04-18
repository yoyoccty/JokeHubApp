import SwiftUI
import SwiftData

@MainActor
struct FavoritesView: View {
    @Environment(\.modelContext) private var context
    @Query var favorites: [FavoriteJoke]
    @State private var searchText = ""
    @State private var sortOrder: String = "A-Z"

    var filteredFavorites: [FavoriteJoke] {
        let filtered = searchText.isEmpty ? favorites : favorites.filter {
            $0.setup.localizedCaseInsensitiveContains(searchText) ||
            $0.punchline.localizedCaseInsensitiveContains(searchText)
        }

        return filtered.sorted {
            sortOrder == "A-Z" ? $0.setup < $1.setup : $0.setup > $1.setup
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Sort", selection: $sortOrder) {
                    Text("A–Z").tag("A-Z")
                    Text("Z–A").tag("Z-A")
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                List {
                    ForEach(filteredFavorites) { joke in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(joke.setup).font(.headline)
                            Text(joke.punchline).font(.subheadline).foregroundColor(.secondary)
                            Text("Type: \(joke.type)").font(.caption).foregroundColor(.gray)

                            Button(role: .destructive) {
                                delete(joke: joke)
                            } label: {
                                Label("Remove from Favorites", systemImage: "trash")
                                    .font(.caption)
                            }
                            .padding(.top, 6)
                        }
                        .padding(.vertical, 6)
                    }
                }
                .searchable(text: $searchText)
                .navigationTitle("Favorites")
            }
        }
    }

    func delete(joke: FavoriteJoke) {
        context.delete(joke)
        try? context.save()
    }
}
