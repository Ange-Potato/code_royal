# Code Royal

*A mobile programming battle RPG where practising Dart questions feels like fighting monsters.*

**Demo video:** [Watch the demo →](https://drive.google.com/file/d/1QVjF58zbqqhj-ANDkVl7k--1BvHdZ0X-/view?usp=sharing)

**Presentation slides:** [View the slides →](https://drive.google.com/file/d/15Y2Xn7z9Vhr_Vi0WxzGwAF5sjrJIYdt6/view?usp=sharing)

**Square image:** [View the square image →](https://drive.google.com/file/d/19OG2wgVK4L0N6t_xIgLwbrs_K7LLAVye/view?usp=sharing)

**Course:** Applications Development and Emerging Technologies

**Author:** [Ange-Potato](https://github.com/Ange-Potato)

---

## Screenshots

<img src="https://drive.google.com/uc?export=view&id=19OG2wgVK4L0N6t_xIgLwbrs_K7LLAVye" width="300" alt="Code Royal square image">

Captured from the current Flutter web build at a 390 × 844 phone viewport.

### The four screens

| Main Menu | Battle |
| --- | --- |
| <img src="https://github.com/user-attachments/assets/51cfa81e-4657-420b-81de-17847d78ca0f" width="280" alt="Main Menu"> | <img src="https://github.com/user-attachments/assets/4a4f74aa-489e-458f-b7f6-efb8ffb35929" width="280" alt="Battle"> |

| Result | Profile |
| --- | --- |
| <img src="https://github.com/user-attachments/assets/14263550-801b-4daa-9495-e5a857366233" width="280" alt="Result"> | <img src="https://github.com/user-attachments/assets/6c0498f2-3fb5-48b9-8405-cdfb977b59d9" width="280" alt="Profile"> |

## What it does

- **Battles randomly named enemies.** Every battle picks a random enemy from
  a bank in `lib/data/enemy_bank.dart`, each with its own animated GIF sprite.
- **Types the answer, not picks it.** Questions are answered by typing the
  correct value, not choosing A/B/C/D. Typing forces recall, not recognition.
- **Scales damage with question difficulty.** Correct answers drop enemy HP;
  wrong answers drop player HP. Easy = 10, Medium = 15, Hard = 20.
- **Ramps question difficulty with player level.** Level 0–9 sees easy
  questions; 10–19 adds medium; 20+ adds hard. Harder questions mean bigger
  swings for both sides.
- **Persists player progress.** Level, XP, total score, and battles won are
  saved to the device with `shared_preferences` and loaded on next launch.
- **Optional AI question generation.** If a `GEMINI_API_KEY` is provided at
  build time, `GeminiService` asks Gemini for a fresh question each round.
  If the key is missing or the request fails, the app silently falls back to
  the local bank.

## Built with

| | |
| --- | --- |
| Framework | Flutter (Dart), Material 3 |
| State | `StatefulWidget` + `setState`, with `PlayerProgress` lifted to `CodeRoyalApp` |
| Storage | `shared_preferences` |
| AI (optional) | `google_generative_ai` — Gemini-generated questions, falls back offline |
| Font | Silkscreen (SIL Open Font License) |


## Running it yourself

The app works offline using the built-in question bank. To let Gemini write
fresh questions instead:

1. Get an API key at https://aistudio.google.com/app/apikey
2. Restrict it in Google Cloud Console:
- API restrictions → Generative Language API only
- Set a quota cap (100 requests/day is plenty for a demo)
3. Copy the example and paste your key:
```bash
cp dart_defines.example.json dart_defines.json
# edit dart_defines.json and paste your GEMINI_API_KEY
```
4. Run with the flag:
```bash
flutter run --dart-define-from-file=dart_defines.json
```
If the key is missing or the API call fails, the app falls back to the local
bank automatically and logs > Offline question (no AI). in the battle log.
dart_defines.json is gitignored — never commit it.

## Project structure

```text
Project structure
text
lib/
├── main.dart                         # app entry, loads PlayerProgress, hosts MaterialApp
├── theme.dart                        # ColorScheme, TextTheme, AppSpacing, AppColors
├── models/
│   ├── player_progress.dart          # level, xp, score, battles won, gainBattleRewards()
│   ├── enemy.dart                    # name, sprite path, max HP
│   └── question.dart                 # prompt, code, correctAnswer, difficulty
├── data/
│   ├── enemy_bank.dart               # enemy list + randomEnemy()
│   ├── question_bank.dart            # fallback question list + randomQuestion()
│   ├── gemini_service.dart           # optional Gemini question generation
│   └── player_repository.dart        # shared_preferences load/save
├── screens/
│   ├── main_menu_screen.dart         # title, Battle / Profile / Quit, Player Summary card
│   ├── battle_screen.dart            # stateful battle loop, HP, log, attack resolution
│   ├── result_screen.dart            # victory or defeat summary, retry, home
│   └── profile_screen.dart           # Levels, Experience, Battle Won stat cards
└── widgets/
    ├── header_title.dart
    ├── primary_button.dart           # full-width menu button
    ├── pill_button.dart              # compact secondary button (Exit, Retry, Home)
    ├── info_card.dart
    ├── hp_bar.dart
    ├── battle_hp_bar.dart
    ├── battle_log.dart
    ├── profile_stat_card.dart
    └── question_card.dart
```

## Privacy and secrets

The current build is local-first. Every player's level, XP, score, and
battles-won count lives on their own device via shared_preferences and is
never sent to a server. There is no user account, no backend, and no data
collection.

The optional Gemini integration reads its API key from
String.fromEnvironment('GEMINI_API_KEY'), never from source. The key is
passed at build time via --dart-define-from-file and the file is gitignored.
The example file dart_defines.example.json ships with a placeholder. The
key is restricted to the Generative Language API in Google Cloud Console
and quota-capped, which is the mitigation that protects it once a web build
exposes it in the browser.

All sample data — question bank, enemy names, default player name — is
invented. No classmate names, emails, or real user data appear anywhere in the
repository.

## Known issues and next steps

1. Live demo falls back to the offline bank. The deployed build does not
ship with a Gemini key, so it uses the local question bank. Running locally
with --dart-define-from-file=dart_defines.json enables AI questions.

2. Question bank is small (10 items). Fine for a demo; not a curriculum.
More questions can be added to lib/data/question_bank.dart in seconds.

3. No sound effects yet. audioplayers is the next stretch goal listed in
the proposal.

4. No per-question timer. Hard questions are risky because of the damage
they deal, but there is no clock pressure yet.

5. Only one enemy sprite is bundled per enemy. More variety is planned.

6. No difficulty override on the Profile screen. Difficulty currently
ramps automatically with player level.

Next: a working audioplayers integration, better Gemini prompts for
unambiguous answers, a per-question timer, a larger question bank, and a
difficulty setting on the Profile screen.

## Project documentation

| Document | |
| --- | --- |
| [Proposal](assets/docs/01-proposal.pdf) | the problem, users, scope, and storage decision |
| [Mockup and wireframes](assets/docs/02-mockup.pdf) | what each screen looks like |
| [Design system](assets/docs/03-design-system.pdf) | palette, type, spacing, components |
| [Security and privacy](assets/docs/security-and-privacy.md) | repository security state |


## AI use

https://img.shields.io/badge/built%20with-AI%20assistance-0b5fff

Assistant used: Claude. A large part of the scaffolding was AI-assisted —
widget structure, the theme, and the initial battle loop. I wrote or adjusted
the game rules (difficulty-scaled damage, XP roll-over, free-text answer
matching), the persistence layer wiring, and the API key handling. Full
account in AI-USAGE.md.

## Licence

All Rights Reserved. See [LICENSE](LICENSE). This repository is publicly
visible for coursework review only and does not grant any license to use,
copy, or redistribute.
