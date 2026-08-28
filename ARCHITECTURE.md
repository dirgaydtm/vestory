# Architecture Documentation

This document outlines the architectural patterns and directory structure used in the Vestory Flutter project.

## Pattern

This project follows a Feature-Driven Architecture pattern. The codebase is divided into modular features, promoting separation of concerns, scalability, and maintainability.

## Tech

| Category             | Technology / Package                             | Description                                  |
| :------------------- | :----------------------------------------------- | :------------------------------------------- |
| **Framework**        | Flutter                                          | Primary UI framework                         |
| **State Management** | Riverpod (`flutter_riverpod`)                    | State management and dependency injection    |
| **Routing**          | GoRouter (`go_router`)                           | Declarative routing                          |
| **Local Storage**    | SQLite & Drift (`drift`, `sqlite3_flutter_libs`) | Offline-first relational local database      |
| **UI Components**    | Chart (`fl_chart`)                               | Data visualization                           |
| **Code Quality**     | Lefthook                                         | Git hooks (pre-commit, commit-msg, pre-push) |


## Structure

```text
lib/
├── main.dart                          # Application entry point: await bootstrap(); runApp(App());
├── bootstrap.dart                     # Initialization: Drift database, Env setup, SharedPreferences
│
├── app/                               # Core Application Setup
│   ├── app.dart                       # Root widget: MaterialApp.router()
│   └── config/
│       └── router.dart                # GoRouter configuration & route definitions
│
├── core/                              # Shared Application Core Logic
│   ├── constants/                     # Global constants (e.g., app_constants.dart)
│   ├── database/                      # Offline-first SQLite database (Drift)
│   │   ├── connection/                # Platform-specific database connections
│   │   ├── daos/                      # Data Access Objects (Queries)
│   │   ├── tables/                    # Table Schema Definitions
│   ├── providers/                     # Global Riverpod providers
│   ├── theme/                         # Styling, colors, and typography
│   └── utils/                         # Helper functions and formatters
│
├── features/                          # Feature Modules (Feature-First)
│   ├── home/                          # Home Dashboard
│   ├── mission/                       # Gamified Missions System
│   ├── notification/                  # App Notifications and History
│   ├── onboarding/                    # Welcome & Introduction Screens
│   ├── portfolio/                     # Investment Portfolio Tracking
│   ├── search/                        # Market Search & Debouncing
│   ├── settings/                      # Preferences and Toggles
│   └── stock/                         # Stock Market Data & Chart Views
│
├── shared/                            # Reusable Things Across Features
│   ├── data/                          # Shared Repositories & Models
│   │   ├── constants/
│   │   ├── models/
│   │   ├── repositories/
│   │   └── services/
│   └── presentation/                  # Shared UI Elements
│       ├── layouts/
│       ├── providers/
│       └── widgets/
│
assets/                                # Static Resources
├── images/
│   ├── core/
│   ├── mission/
│   ├── notification/
│   ├── onboarding/
│   ├── search/
│   └── stocks/
├── fonts/                             # Custom fonts
└── data/                              # Static JSON data for simulation
```
