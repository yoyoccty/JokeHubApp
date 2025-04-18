import SwiftUI
import SwiftData

struct JokeDetailView: View {
    let joke: Joke
    @Environment(\.modelContext) var context
    @Query var favorites: [FavoriteJoke]
    @State private var isFavorite: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            Text(joke.setup)
                .font(.title2)
            Text(joke.punchline)
                .font(.title3)

            Button(action: toggleFavorite) {
                Label(isFavorite ? "Unfavorite" : "Add to Favorites", systemImage: isFavorite ? "star.fill" : "star")
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .scaleEffect(isFavorite ? 1.1 : 1.0)
            .animation(.spring(), value: isFavorite)

            HStack(spacing: 20) {
                Button {
                    UIPasteboard.general.string = "\(joke.setup)\n\n\(joke.punchline)"
                } label: {
                    Label("Copy Joke", systemImage: "doc.on.doc")
                        .font(.caption)
                }

                ShareLink(
                    item: "\(joke.setup)\n\n\(joke.punchline)",
                    subject: Text("Here's a joke for you!"),
                    message: Text("Enjoy this one:"),
                    label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                            .font(.caption)
                    }
                )
            }
        }
        .padding()
        .navigationTitle("Joke Detail")
        .onAppear {
            isFavorite = favorites.contains { $0.id == joke.id }
        }
    }

    func toggleFavorite() {
        if isFavorite {
            if let existing = favorites.first(where: { $0.id == joke.id }) {
                context.delete(existing)
            }
        } else {
            let favorite = FavoriteJoke(id: joke.id, setup: joke.setup, punchline: joke.punchline, type: joke.type)
            context.insert(favorite)
        }
        try? context.save()
        isFavorite.toggle()
    }
}
