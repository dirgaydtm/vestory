# Architecture Documentation

This document outlines the architectural patterns and directory structure used in the Vestory Flutter project.

## Pattern

This project follows a Feature-Driven Architecture pattern. The codebase is divided into modular features, promoting separation of concerns, scalability, and maintainability.

## Tech

| Category             | Technology / Package                                                                         | Description                                  |
| :------------------- | :------------------------------------------------------------------------------------------- | :------------------------------------------- |
| **Framework**        | Flutter                                                                                      | Primary UI framework                         |
| **State Management** | Riverpod (`flutter_riverpod`)                                                                | State management and dependency injection    |
| **Routing**          | GoRouter (`go_router`)                                                                       | Declarative routing                          |
| **Networking**       | Dio (`dio`)                                                                                  | Standard HTTP requests                       |
| **Local Storage**    | SQLite & Drift (`drift`, `sqlite3_flutter_libs`)                                             | Offline-first relational local database      |
| **Environment**      | Dotenv (`flutter_dotenv`)                                                                    | Environment variables configuration          |
| **UI Components**    | SVG (`flutter_svg`), Shimmer (`shimmer`), Animations (`flutter_animate`), Chart (`fl_chart`) | Various UI components and data visualization |
| **Code Quality**     | Lefthook                                                                                     | Git hooks (pre-commit, commit-msg, pre-push) |


## Structure

```bash
lib/
├── main.dart                          # Application entry point: await bootstrap(); runApp(App());
├── bootstrap.dart                     # Initialization: dotenv, database, error handlers
│
├── app/
│   ├── app.dart                       # Root widget: MaterialApp.router()
│   └── config/
│       └── router.dart                # GoRouter configuration
│
├── core/                              # Shared application core logic and utilities
│   ├── theme/                         # Styling, colors, and typography
│   │   ├── app_colors.dart
│   │   ├── app_text_styles.dart
│   │   └── app_theme.dart
│   ├── network/                       # API clients and interceptors
│   │   └── dio_client.dart
│   ├── database/                      # Offline-first SQLite database (Drift)
│   │   ├── app_database.dart
│   │   └── daos/
│   ├── constants/                     # Global constants and keys
│   │   ├── app_constants.dart
│   │   └── db_constants.dart
│   ├── providers/                     # Global Riverpod providers
│   │   └── core_providers.dart
│   ├── errors/                        # Error handling and failure models
│   │   └── failures.dart
│   └── utils/                         # Extension methods and helper functions
│       └── extensions.dart
│
├── features/                          # Feature modules
│   ├── auth/                          # Example feature: Authentication
│   │   ├── data/
│   │   │   ├── models/                # Data Transfer Objects (DTOs)
│   │   │   ├── services/              # Remote/Local data sources
│   │   │   └── repositories/          # Repository implementations
│   │   └── presentation/
│   │       ├── providers/             # Feature-specific state management
│   │       ├── pages/                 # UI Screens
│   │       └── widgets/               # Feature-specific UI components
│   ├── onboarding/
│   ├── home/
│   └── feature-x/                     # Template for new features
│       ├── data/
│       │   ├── models/
│       │   │   └── feature_x_model.dart
│       │   ├── services/
│       │   │   └── feature_x_remote_datasource.dart
│       │   └── repositories/
│       │       └── feature_x_repository.dart
│       └── presentation/
│           ├── providers/
│           │   └── feature_x_provider.dart
│           ├── pages/
│           │   └── feature_x_page.dart
│           └── widgets/
│
└── shared/                            # Reusable components across multiple features
    ├── models/                        # Shared data models
    └── widgets/                       # Shared UI components

assets/                                # Static resources
├── images/
└── fonts/
```
