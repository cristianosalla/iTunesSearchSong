# iTunesSearchSong

A SwiftUI music search and player app built with modern iOS patterns. Search the iTunes catalog, browse albums, and preview songs.

## Features

- **Song Search** — Real-time debounced search powered by the iTunes Search API
- **Album Browser** — View full album track listings with artwork
- **Music Player** — Stream 30 second previews with playback controls (play/pause, next, previous, repeat)
- **Queue Management** — Browse and navigate the current play queue
- **iPad Support** — Adaptive layout with `NavigationSplitView` and responsive sizing via `GeometryReader`

## Architecture

The project follows **MVVM** with protocol-based dependency injection for testability.

```
iTunesSearchSong/
├── Components/          # Reusable UI (TrackArtworkView, TrackInfoView, EqualizerBars)
├── Extensions/          # Protocols & type extensions (ArtworkScalable, Color, Double)
├── Features/
│   ├── Home/            # Search screen (HomeView + HomeViewModel)
│   ├── Album/           # Album detail (AlbumView + AlbumViewModel)
│   ├── Player/          # Playback (PlayerView, PlayerSplitView, QueueListView)
│   └── Splash/          # Launch screen
├── Models/              # Data models (Track, Album)
├── Navigation/          # Router with NavigationPath
├── Resources/           # Constants, strings, assets
└── Services/
    ├── Network/         # Generic network client (ClientAPI)
    ├── Protocols/       # Service interfaces (SearchSongProtocol, FetchAlbumProtocol)
    └── iTunes/          # iTunes API implementation & endpoint builder
```

### Key Patterns

- **`@Observable`** (iOS 17+) for reactive state management across ViewModels and Router
- **Protocol-oriented networking** — `ClientAPIProtocol`, `SearchSongProtocol`, and `FetchAlbumProtocol` enable full mock injection in tests
- **Centralized design system** — `AppConstants` for layout values, `AppStrings` for localized text, `AppImage`/`AppSymbol` for assets
- **Discriminated union decoding** — `iTunesResult` enum with custom `Decodable` to handle mixed API responses (albums + tracks)

## Requirements

- iOS 26.1
- Xcode 26.2
- No third-party dependencies

## Getting Started

1. Clone the repository
2. Open `iTunesSearchSong.xcodeproj` in Xcode
3. Build and run on a simulator or device (iOS 17+)

## Testing

The project includes unit tests covering ViewModels, API decoding, and endpoint construction.

```bash
# Run tests via Xcode
Cmd + U
```

Test structure:

- **ViewModelTests** — `HomeViewModelTests`, `AlbumViewModelTests`, `PlayerViewModelTests`
- **APITests** — `iTunesAPITests` with mock JSON responses
- **Mocks** — `MockAPI`, `MockClientJsonRequest`, `MockClientObjectResponse`

## Screenshots

### 1. Splash Screen
<img width="2360" height="1640" alt="Simulator Screenshot - iPad Air 11-inch (M3) - 2026-04-15 at 23 07 23" src="https://github.com/user-attachments/assets/8b285ba8-168a-4a82-aa7b-3cb9c19f66ab" />

### 2. Songs Screen (Home)

<img width="2360" height="1640" alt="Simulator Screenshot - iPad Air 11-inch (M3) - 2026-04-15 at 23 06 48" src="https://github.com/user-attachments/assets/9c117ef0-fc38-4989-834c-8abefcf96581" />

### 3. Song Details (Player)

<img width="2360" height="1640" alt="Simulator Screenshot - iPad Air 11-inch (M3) - 2026-04-15 at 23 07 00" src="https://github.com/user-attachments/assets/f122ce22-c89b-40ea-af96-7e1aec230f65" />

### 4. Album Screen

<img width="2360" height="1640" alt="Simulator Screenshot - iPad Air 11-inch (M3) - 2026-04-15 at 23 07 05" src="https://github.com/user-attachments/assets/38022f6e-71d1-4a94-a79f-e630db7dd414" />
