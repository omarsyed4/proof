# Proof

A habit accountability app for a small group of friends, built with Flutter.

This repository starts with a retrospective import of the existing Checkpoint 4 UI. The small commits organize that completed work for review; they are not the original development timeline. Commit dates reflect this import.

## Current scope

Ten static screens: Sign in, Today, Goals, Add a goal, Camera check-in, Post check-in, Feed, Friends, This week, and Reminders. Navigation and text input work. Firebase is planned; authentication, actual camera capture, posting, notifications, and deletion are not connected.

- Username/password sign-in only.
- Check-in photos are intended to be taken in-app, with no gallery picker.
- Accepted friends and per-goal sharing control visibility.
- Written comments appear before generic reactions.
- Weekly progress uses dots and dashed outlines, with no streak or failure state.

## Run

Uses Flutter 3.29.3, Dart 3.7.2, and JDK 17. Android and iOS scaffolds are included.

```sh
flutter pub get
flutter run
```

The Android project has no native C/C++ assets, so its empty CMake step is disabled.

## Code

- `lib/main.dart`: theme and routes.
- `lib/screens/proof_screens.dart`: ten screen layouts and shared page frame.
- `lib/widgets/proof_style.dart`: shared controls and styling.
- `lib/widgets/demo_data.dart`: the eight ERD entity shapes and demo records.

## Branches

`main` contains the integrated UI. `setup/flutter` holds the foundation, each `ui/<screen>` branch holds one page, and `docs/workflow` holds repository guidance. Page branches are merged without squashing so their small commits remain visible. See [the workflow guide](docs/GIT_WORKFLOW.md).

The screenshot PDF, LaTeX source, and submission zip are kept outside this code repository. The Webcourses code submission remains a separate zip containing only the Dart files under `lib/`.
