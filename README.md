# 📺 TV Series App

## 📌 Overview
TV Series App is an iOS application that allows users to browse, search, and save their favorite TV series using the **TVMaze API**. Users can view series details, explore episodes, and manage their favorite series in an intuitive interface.

## 🚀 Features
- **List TV Series**: Fetch and display a paginated list of TV series from the API.
- **Search Series**: Search for TV series by name.
- **Series Details**: View information about a selected series, including schedule, genres, and summary.
- **Episode List**: Browse episodes by season with an improved UI using horizontal scrolling.
- **Favorites Management**:
  - Add a series to favorites.
  - Remove a series from favorites.
  - View favorited series in alphabetical order.
- **Offline Persistence**: Favorites are stored locally using `UserDefaults`.

## 🛠️ Technologies Used
- **SwiftUI** for the user interface.
- **MVVM Architecture** for better code organization.
- **URLSession** for network requests.
- **AsyncImage** for handling remote images.
- **UserDefaults** for storing favorite series.
- **XCTest** for unit testing.

## 📦 Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/ritacvn/DisplayTV.git
   ```
2. Open the Xcode project:
   ```sh
   cd DisplayTV
   open DisplayTV.xcodeproj
   ```
3. Run the app on a simulator or a physical device.

## ✅ Running Tests

To run the unit tests, follow these steps:

1. Open Xcode and select the DisplayTV scheme.

2. Press Cmd + U to run all unit tests.

3. Alternatively, open the Tests folder and manually run specific test cases.

4. Check the Test Navigator (Cmd + 5) to view the test results.
