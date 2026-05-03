# TechPulse

TechPulse is a complete Flutter project structure focused exclusively on the **Data Layer** and **Core Setup** following **Clean Architecture** principles.

## 1. What the project is

TechPulse is designed to discover trending technologies by parsing data from GitHub, Dev.to, and OpenAI, while utilizing Firebase for data persistence. This codebase establishes the foundational models, remote datasources, repositories, and dependency structures required for an enterprise-level mobile application. It contains no presentation logic or UI elements (except for a minimal `main.dart` entry point).

## 2. Project Architecture (Clean Architecture)

This project strictly adheres to Clean Architecture for the Data and Core layers:

- **Core Layer (`lib/core/`)**: Contains app-wide constants (like API URLs) and common logic such as custom exceptions and failures. This layer is independent of any external packages or frameworks.
- **Data Layer (`lib/data/`)**: Responsible for data retrieval and manipulation. It's subdivided into:
  - **Models**: Plain Dart objects that map to external JSON/Firestore structures. Includes `fromJson` and `toMap` methods.
  - **Datasources**: Direct handlers for external APIs or databases. They use `http` for REST calls, `cloud_firestore` for Firebase, and handle all mapping/parsing raw data.
  - **Repositories**: Implementing business logic boundaries. They coordinate one or more datasources, map raw exceptions into unified `Failure` classes, and ensure separation of concerns.

## 3. Folder Structure Explained

```text
lib/
├── core/
│    ├── constants/
│    │     └── api_constants.dart       # Holds all endpoint URLs for GitHub, Dev.to, and OpenAI
│    └── errors/
│          └── failures.dart            # Custom exception wrapper classes (ServerFailure, NetworkFailure, etc.)
│
├── data/
│    ├── datasources/
│    │     ├── devto_remote_datasource.dart   # Fetches top and Flutter articles from Dev.to API
│    │     ├── firebase_datasource.dart       # Handles CRUD operations on Firestore collections
│    │     ├── github_remote_datasource.dart  # Fetches trending and Flutter repositories from GitHub API
│    │     └── openai_datasource.dart         # Calls OpenAI's API to predict next trends using GPT
│    │
│    ├── models/
│    │     ├── favorite_model.dart            # Model for saved repositories in Firestore
│    │     ├── language_stat_model.dart       # Model for language tracking history in Firestore
│    │     ├── prediction_model.dart          # Model mapping OpenAI JSON predictions
│    │     └── trending_repo_model.dart       # Model for GitHub repository response
│    │
│    └── repositories/
│          ├── ai_repository_impl.dart        # Coordinates AI data logic (OpenAI)
│          ├── favorites_repository_impl.dart # Coordinates Firestore Favorites logic
│          └── github_repository_impl.dart    # Coordinates both GitHub and Dev.to logic
│
└── main.dart                                 # App entry point with initialization steps
```

## 4. How Each Datasource Works

- **`GithubRemoteDatasource`**: Uses the `http` package to call the GitHub Search API. Supports optional Bearer authentication via a `.env` token and decodes the JSON list of repositories into `TrendingRepoModel` lists.
- **`DevToRemoteDatasource`**: Queries the unauthenticated Dev.to API for trending tech or specific "Flutter" tags, mapping the responses directly into custom Dart Maps/models.
- **`OpenAiDatasource`**: Communicates with the OpenAI Chat Completions API. It passes a strict system prompt to ensure GPT returns only a JSON object. This response string is parsed directly into a `PredictionModel`.
- **`FirebaseDatasource`**: Uses `cloud_firestore` to directly read/write documents. It maps to three core collections: `favorites`, `predictions`, and `language_history`.

## 5. How to Configure `.env`

1. Duplicate the `.env.example` file and rename it to `.env`.
2. Add your secret keys inside the new `.env` file:
   ```env
   GITHUB_TOKEN=your_github_personal_access_token_here
   OPENAI_API_KEY=your_openai_api_key_here
   ```
3. Never commit `.env` to version control (ensure it is added to `.gitignore`).

## 6. How to Run the Project

1. Run `flutter pub get` to install all necessary dependencies (http, provider, firebase_core, flutter_dotenv, etc.).
2. Ensure you have followed the standard Firebase setup for your target platforms (Android/iOS) using `flutterfire configure`.
3. Uncomment the `Firebase.initializeApp()` line in `lib/main.dart` once Firebase is configured.
4. Run `flutter run` on your target device or simulator.

## 7. API Descriptions

- **GitHub API**: 
  - `GET /search/repositories?q=stars:>500&sort=stars&order=desc&per_page=20` (Trending Repos)
  - `GET /search/repositories?q=language:flutter&sort=stars&order=desc` (Flutter Repos)
- **Dev.to API**:
  - `GET /api/articles?top=7` (Top general articles)
  - `GET /api/articles?tag=flutter&per_page=10` (Top Flutter articles)
- **OpenAI API**:
  - `POST /v1/chat/completions` (GPT-4o-mini completion targeting JSON output)

## 8. Firebase Setup

The application logic targets **Cloud Firestore**. Make sure the following collections exist or allow creation via security rules:
- `favorites`: Stores favorite GitHub repositories per user.
- `predictions`: Stores generated OpenAI predictions.
- `language_history`: Stores language popularity stats over time.

You must set up a Firebase project and run `flutterfire configure` to generate `firebase_options.dart` for this application to connect.

## 9. Error Handling Strategy

- All remote calls are wrapped in `try/catch` blocks inside the datasources.
- Timeouts are strictly enforced on HTTP calls (`.timeout()`).
- Datasources throw generic Dart `Exception`s which are caught by the Repositories.
- Repositories map these exceptions into strictly typed `Failure` objects (e.g., `ServerFailure`, `NetworkFailure`). These custom objects keep domain boundary logic clean and make it easier for a future Presentation layer to display clear UI warnings to the user.