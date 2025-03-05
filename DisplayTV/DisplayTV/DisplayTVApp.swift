import SwiftUI

@main
struct DisplayTVApp: App {
    var body: some Scene {
        WindowGroup {
            SeriesListView(viewModel: SeriesListViewModel())
        }
    }
}
