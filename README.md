# Code Royal
> A mobile programming battle RPG where practising Dart questions feels like fighting monsters.

**Live demo:** https://YOURUSERNAME.github.io/YOUR-REPO/
**Demo video:** `docs/demo.mp4`
**Course:** Applications Development and Emerging Technologies (6ADET)
**Author:** Ange Potato

---

## Screenshots

| Main Menu | Battle | Result |
| --- | --- | --- |
| ![Main Menu](<img width="428" height="912" alt="image" src="https://github.com/user-attachments/assets/51cfa81e-4657-420b-81de-17847d78ca0f" />
) | ![Battle](<img width="422" height="915" alt="image" src="https://github.com/user-attachments/assets/4a4f74aa-489e-458f-b7f6-efb8ffb35929" />
) | ![Result](<img width="417" height="912" alt="image" src="https://github.com/user-attachments/assets/14263550-801b-4daa-9495-e5a857366233" />
) |

| Profile |
| --- | --- |
| ![Profile](<img width="425" height="911" alt="image" src="https://github.com/user-attachments/assets/6c0498f2-3fb5-48b9-8405-cdfb977b59d9" />
) |

## What it does

- Battle randomly-named enemies, each with its own animated GIF sprite
- Answer Dart programming questions by **typing the answer**, not picking a letter
- Damage scales with difficulty: easy = 10 HP, medium = 15 HP, hard = 20 HP
- Win or lose based on HP, then see a result summary with XP, level and score
- Progress (level, XP, score, battles won) persists across sessions

## Built with

| | |
| --- | --- |
| Framework | Flutter (Dart), Material 3 |
| State | `StatefulWidget` + `setState`, lifted to `CodeRoyalApp` |
| Storage | `shared_preferences` |
| AI (optional) | `google_generative_ai` for Gemini-generated questions |
| Font | Silkscreen (SIL OFL) |

## Running it yourself

Offline Mode:
> flutter pub get
> flutter run

Online Mode:
> flutter pub get
> flutter run --dart-define-from-file=dart_defines.json

```bash
flutter pub get
flutter run -d web-server --web-port 8080
