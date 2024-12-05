# Social Feed App

This repository contains the source code for the **Social Feed App**, a Flutter-based mobile application that uses Clean Architecture principles and modern development practices.

---

## Architecture Overview

The application follows the principles of Clean Architecture, ensuring separation of concerns and modular design. The architecture layers are structured as follows:

1. **UI**: The user interface interacts with the State Management layer.
2. **State Management**: Handles app state using **BLoC (Cubit)**.
3. **UseCase**: Encapsulates business logic for a specific feature or flow.
4. **Repository**: Acts as an abstraction layer between UseCase and DataSource.
5. **DataSource**: Interfaces with external APIs, local storage, or other data providers.

---

## Key Tools and Technologies

- **Firebase**: Used for user authentication.
- **Hive**: Caches the user's profile for offline access.
- **SharedPrefs**: Stores the user's image locally for quick retrieval.
- **JSON Server**: Mock host used for serving feed data during development.
- **dio**: HTTP client for network communication.
- **Logger**: Logs application events for debugging and monitoring.
- **getIt**: Implements dependency injection to manage state and dependencies.
- **cachedNetworkImage**: Caches images for efficient resource usage.
