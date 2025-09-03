📘 Flutter HTML Viewer with Comments (Full-Stack Project)

This project is a full-stack Flutter + Node.js + PostgreSQL application.
It lets you:

Render HTML pages inside a Flutter app.

Store and manage comments per page in PostgreSQL.

Manage backend APIs with Express.js.

Automate testing/builds with a GitHub Actions CI/CD pipeline.

🔹 Backend (Node.js + Express + PostgreSQL)

Built with Express.js.

PostgreSQL used as the database (hosted on Render).

Database schema:

pages → stores page slug, title, HTML content.

comments → stores comments tied to a page.

APIs:

GET /pages → List all pages.

GET /pages/:slug → Get specific page (HTML content).

POST /pages → Create a new page.

GET /comments/:slug → Fetch comments for a page.

POST /comments → Add a comment to a page.

DELETE /comments/:id → Delete a comment.

Example .env
PORT=5000
DATABASE_URL=postgresql://<username>:<password>@<host>/<db_name>
NODE_ENV=production

🔹 Frontend (Flutter)

Built with Flutter.

State management using Bloc Pattern (flutter_bloc).

UI Features:

Dashboard: Displays all HTML pages in card format (ListView + Card).

Page Detail: Renders HTML using flutter_widget_from_html.

Comments: List comments under each page, with ability to add new ones.

Dependencies:

http

flutter_bloc

equatable

flutter_widget_from_html

Folder Structure (Frontend)
lib/
  blocs/         # BLoC files (PagesBloc, CommentsBloc)
  models/        # PageModel, CommentModel
  repository/    # API calls to backend
  screens/       # Dashboard + PageDetail screens
  main.dart

🔹 CI/CD (GitHub Actions)

A GitHub Actions workflow is configured to:

Run on push and pull_request events.

Install Flutter dependencies.

Run analyzer + tests.

(Optional) Build release APK when merging into main.

Example Workflow (.github/workflows/flutter.yml)
name: Flutter CI/CD

on:
  push:
    branches: ["*"]
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: stable

      - name: Install dependencies
        run: flutter pub get

      - name: Analyze
        run: flutter analyze

      - name: Run tests
        run: flutter test

      # Build release APK on main
      - name: Build APK
        if: github.ref == 'refs/heads/main'
        run: flutter build apk --release

🚀 How to Run
Backend
cd backend
npm install
npm run start

Frontend
cd flutter_app
flutter pub get
flutter run

🔹 Future Improvements

Add authentication (users login before posting comments).

Upload & serve real HTML content instead of dummy text.

Deploy Flutter web build and connect to backend directly.