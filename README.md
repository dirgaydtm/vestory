# Vestory Flutter Project

### Prerequisites

*   Flutter SDK (^3.14.0-147.0.dev or compatible)
*   Dart SDK
*   Lefthook (for Git hooks)

### Installation

1.  Clone the repository:
    ```bash
    git clone <repository_url>
    ```

2.  Install dependencies:
    ```bash
    flutter pub get
    ```

3.  Configure environment variables:
    Copy `.env.example` to `.env` and fill in the required values.
    ```bash
    cp .env.example .env
    ```

4.  Run code generation (for Drift database and other generated files):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

5.  Run the application:
    ```bash
    flutter run
    ```

## Development Detail

Please refer to the [`ARCHITECTURE.md`](ARCHITECTURE.md) file for detailed information regarding the project structure and architectural patterns in this repository.
