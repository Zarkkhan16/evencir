# Evencir — Flutter Test Task

My submission for the Evencir Flutter interview test. This is a fitness and wellness app built from the provided Figma design — dark theme, bottom navigation, and a few screens that tie together a daily health dashboard.

**Repo:** https://github.com/Zarkkhan16/evencir-task

---

## Project Overview

Evencir is a mobile wellness app where users can check their daily stats, log water intake, view upcoming workouts, track mood, and browse their training calendar. The UI follows the Figma mockup closely. Data is handled locally with mock sources — no backend or API calls for this task.

The app uses BLoC (Cubit) for state management and a feature-based folder structure so each screen owns its own logic.

---

## Dependencies Used & Why

| Package | Why |
|---------|-----|
| `flutter_bloc` | State management — each screen has its own Cubit |
| `go_router` | Navigation and bottom tab routing |
| `get_it` | Dependency injection — wiring up repos, use cases, and cubits |
| `equatable` | Comparing states and models without boilerplate |
| `intl` | Formatting dates and numbers on the dashboard |
| `table_calendar` | Calendar widget for training plan and home screen |
| `cupertino_icons` | Standard icon set (comes with Flutter) |

**Dev dependencies:** `bloc_test` and `mocktail` for unit tests.

---

## Project Structure

```
lib/
├── main.dart              # Entry point
├── app/                   # App setup — theme, router, DI
├── core/                  # Shared stuff used across features
│   ├── theme/             # Colors, spacing, dark theme
│   ├── widgets/           # Reusable UI (buttons, cards, nav bar)
│   └── utils/             # Helper functions (calendar logic, etc.)
└── features/              # One folder per screen/feature
    ├── home/
    ├── training_plan/
    ├── mood/
    ├── calendar/
    ├── profile/
    └── shell/             # Bottom nav wrapper

Each feature is split like this:

    data/         → models, local data sources, repository impl
    domain/       → entities, repository contracts, use cases
    presentation/ → cubits (state logic), pages (screens), widgets
```

In short:
- **models** live under `data/models/` and `domain/entities/`
- **views** are the `presentation/pages/` and `presentation/widgets/`
- **controllers** are the Cubits in `presentation/cubit/`
- **utils** and shared widgets sit in `core/`

---

## App Features

- Home dashboard with daily metrics, workout cards, and hydration tracker
- Tap-to-log water intake with visual progress
- Month calendar bottom sheet from the home screen
- Training plan screen with scheduled workouts and calendar view
- Mood screen with a circular mood picker
- Full calendar page with marked workout dates
- Profile screen with user info
- Bottom navigation across Home, Plan, Mood, and Profile
- Dark theme matching the Figma design

---

## App Screenshots

[View Screenshots](https://drive.google.com/file/d/1FmbHWuKWZmfYbi981RD4YQy5CcA9y5JE/view?usp=sharing)

---

## App Demo Video

[Watch Demo Video](https://drive.google.com/file/d/1FmbHWuKWZmfYbi981RD4YQy5CcA9y5JE/view?usp=sharing)

---

## APK Download

[Download APK](https://drive.google.com/file/d/11VnEdO3oambHwVHp3TlRDs167NxgvkUt/view?usp=sharing)

Install on any Android device and allow installs from unknown sources if prompted.

---

## How to Run the Project

```bash
git clone https://github.com/Zarkkhan16/evencir-task.git
cd evencir-task
flutter pub get
flutter run
```

Make sure Flutter is installed and a device/emulator is connected before running.

---

Built with Flutter for the Evencir interview test task.
