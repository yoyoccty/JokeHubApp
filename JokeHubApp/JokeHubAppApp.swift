import SwiftUI
import SwiftData

@main
struct JokeHubAppApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                JokeListView()
                    .tabItem {
                        Label("Browse", systemImage: "face.smiling")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
            }
        }
        .modelContainer(for: FavoriteJoke.self)
    }
}
