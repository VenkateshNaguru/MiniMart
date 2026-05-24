# MiniMart 🛒

An iOS e-commerce demo app showcasing modern Swift development practices.

## Architecture
MVVM-C + Clean Architecture
- **Coordinators** handle navigation
- **UseCases** isolate business logic  
- **Repository pattern** abstracts data layer
- **DI Container** manages dependencies

## Tech Stack
| Technology | Usage |
|-----------|-------|
| SwiftUI | All UI screens |
| SwiftData | Cart persistence |
| Combine | Search debounce pipeline |
| async/await | Networking layer |
| @Observable | State management |

## Features
- 🏠 Product listing with async image loading
- 🔍 Search with 300ms Combine debounce + Task cancellation
- 🛒 Cart with SwiftData persistence
- 📱 MVVM-C navigation architecture

## Requirements
- iOS 17+
- Xcode 26+
- Swift 5.9+

## API
Uses [Platzi Fake Store API](https://fakeapi.platzi.com)
