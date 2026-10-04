# Code Royal

> A mobile programming battle RPG where practising Dart questions feels like fighting monsters.

**Live demo:** https://YOURUSERNAME.github.io/YOUR-REPO/
**Demo video:** docs/demo.mp4
**Course:** Applications Development and Emerging Technologies (6ADET), Holy Angel University
**Author:** Ange Potato

---

## Screenshots

| Main Menu | Battle | Result |
| --- | --- | --- |
| <img src="https://github.com/user-attachments/assets/51cfa81e-4657-420b-81de-17847d78ca0f" width="250" alt="Main Menu"> | <img src="https://github.com/user-attachments/assets/4a4f74aa-489e-458f-b7f6-efb8ffb35929" width="250" alt="Battle"> | <img src="https://github.com/user-attachments/assets/14263550-801b-4daa-9495-e5a857366233" width="250" alt="Result"> |

| Profile |
| --- |
| <img src="https://github.com/user-attachments/assets/6c0498f2-3fb5-48b9-8405-cdfb977b59d9" width="250" alt="Profile"> |

## What it does

- Battle randomly named enemies, each with its own animated GIF sprite.
- Answer Dart programming questions by typing the answer, rather than picking from multiple-choice options.
- Deal damage based on question difficulty:
  - Easy: 10 HP
  - Medium: 15 HP
  - Hard: 20 HP
- Win or lose battles based on HP.
- View a result summary showing XP, level, and score.
- Persist player progress across sessions, including level, XP, score, and battles won.

## Built with

| Technology | Usage |
| --- | --- |
| Framework | Flutter (Dart), Material 3 |
| State management | `StatefulWidget` + `setState`, with state lifted to `CodeRoyalApp` |
| Storage | `shared_preferences` |
| AI (optional) | `google_generative_ai` for Gemini-generated questions |
| Font | Silkscreen (SIL OFL) |

## Running it yourself

## Offline Mode
flutter pub get
flutter run

### Online Mode

cp dart_defines.example.json dart_defines.json
(edit dart_defines.json and paste your GEMINI_API_KEY)
flutter pub get
flutter run --dart-define-from-file=dart_defines.json

## Presentation
Credit: USED Claude
Video: https://drive.google.com/file/d/1QVjF58zbqqhj-ANDkVl7k--1BvHdZ0X-/view?usp=sharing
Slides:
Square Image: 

## AI USAGE
https://github.com/Ange-Potato/code_royal/blob/e346256f4daf925fc354eaeb9d2994a89083a43c/AI-USAGE.md
