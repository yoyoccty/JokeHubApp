import SwiftUI

struct JokeListView: View {
    @StateObject var viewModel = JokeViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.filteredJokes) { joke in
                NavigationLink(destination: JokeDetailView(joke: joke)) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(joke.setup).font(.headline)
                        Text(joke.punchline).font(.subheadline).foregroundColor(.secondary)
                    }
                    .padding(.vertical, 6)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
                }
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Jokes")
            .toolbar {
                Button {
                    Task { await viewModel.fetchJokes() }
                } label: {
                    Label("Refresh", systemImage: "arrow.clockwise")
                }
            }
            .refreshable {
                await viewModel.fetchJokes()
            }
            .onAppear {
                Task { await viewModel.fetchJokes() }
            }
        }
    }
}
