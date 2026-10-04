# AI usage

This project was built with AI assistance. This file is the record of it.

## 1. How I used AI

### 2026-09-20 — Project setup and theme

- **Tool:** Claude
- **What I asked for:** Help setting up `theme.dart` from my Design System v2 PDF, plus a `MainMenuScreen` with `HeaderTitle`, `PrimaryButton`, `InfoCard` and `HpBar`.
- **What it gave back:** A complete `theme.dart` with `ColorScheme.dark`, a `TextTheme`, an `AppSpacing` class, and each widget in its own file.
- **What I kept, what I changed, and why:** Kept the structure and the palette. Fixed the `onPrimary` hex — the PDF's OCR had mangled it — and deleted a couple of widgets I did not need yet so the first commit stayed small.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/025d82bc712a4d1f5c5f7571bb5b65e608a2d36c
  - Related commits the same day: `Main Menu Starting`, `added HeaderTitle widget`, `Primary Button`, `updated button`, `Added More Widgets and Updated the Menu`

### 2026-09-21 — Silkscreen font

- **Tool:** Claude
- **What I asked for:** How to add Silkscreen as a global font.
- **What it gave back:** A `fonts:` block for `pubspec.yaml` and a `fontFamily: 'Silkscreen'` line for `appTheme`.
- **What I kept, what I changed, and why:** Kept it. I downloaded the TTF myself and dropped it into `fonts/`; the AI did not fetch the file. Fixed the asset path and the weight declaration so Flutter could actually find it.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/508ebfc966c07ed013f494da5e9eeba161a771d0
  - Related commits: `adding Silkscreen font`, `applying Silkscreen font`

### 2026-09-22 — Player Progress and Profile screen

- **Tool:** Claude
- **What I asked for:** A `PlayerProgress` model and a Profile screen matching my mockup, with colored stat cards (yellow levels, green XP, red battles won).
- **What it gave back:** `PlayerProgress`, a `ProfileStatCard` widget, and a `ProfileScreen` composing three of them.
- **What I kept, what I changed, and why:** Kept the layout. Changed the yellow from the AI's guess to `#F2C14E` to match my mockup more closely, and set the default player level to 0 so a new account starts empty.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/9197adc9880621f5eae4e293908e85a09983f7cf
  - Related commits: `Player Progress data added`, `Fixed Fonts, Added Profile Screen, Updated Menu Screens, and Re Added other stuff that was removed.`

### 2026-09-26 to 2026-09-28 — Enemy assets and static Battle Screen

- **Tool:** Claude
- **What I asked for:** Enemy sprite loading and a static Battle Screen layout matching my mockup: exit pill, enemy GIF, dual HP bars, question card, battle log.
- **What it gave back:** `Enemy` model, `enemy_bank.dart` with a random picker, `BattleScreen`, `BattleHpBar`, `BattleLog`, and `QuestionCard`.
- **What I kept, what I changed, and why:** Kept all of it. Changed the enemy asset path from `.png` to `.gif` because I use animated sprites, and added an `errorBuilder` fallback icon so the screen still renders if a sprite is missing.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/f165320cc87fd279ec461ddadee4412edc5c1ba4
  - Related commits: `Added Enemy pictures, setting up the enemy datas`, `Adding enemy sprites`, `Adding the battle screen, but not interactive yet`

### 2026-09-30 — Stateful battle logic

- **Tool:** Claude
- **What I asked for:** Making the battle react to typed answers, drop HP, update the log, and end the battle with a Result screen.
- **What it gave back:** A `StatefulWidget` version of `BattleScreen` with `_handleAttack`, `_endBattle`, and a retry callback, plus a small `onRetry` addition to `ResultScreen`.
- **What I kept, what I changed, and why:** Kept the logic. Simplified the retry flow — the first version used a proxy widget I did not want, so I refactored it to pass an `onRetry` callback straight into `ResultScreen`. Also converted `_PillButton` in `ResultScreen` into a shared `PillButton` widget that the Battle screen reuses.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/f8f97188560e54d347375288566be6c8d6f51efe

### 2026-10-01 — Persistence with shared_preferences

- **Tool:** Claude
- **What I asked for:** Save and load `PlayerProgress` so the profile and XP survive a restart.
- **What it gave back:** A `PlayerRepository` class and a lifted state in `CodeRoyalApp` so both the Battle and Profile screens read the same object.
- **What I kept, what I changed, and why:** Kept the whole thing. Added `gainBattleRewards` to `PlayerProgress` myself because I wanted the XP-rolls-into-level logic to live in the model, not the battle screen. Updated `BattleScreen` and `MainMenuScreen` to accept the shared progress and a `onProgressUpdated` callback.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/6a316337a4949526780ff6e69d0dcfbfa42f0759
  - Related commits: `Updated the Player stats`, `lift PlayerProgress state to app root, wire persistence`

### 2026-10-02 — Damage scales with difficulty

- **Tool:** Claude
- **What I asked for:** Damage should not be a fixed number — it should scale with how hard the question is.
- **What it gave back:** A `_damageFor(int difficulty)` helper with a switch on difficulty.
- **What I kept, what I changed, and why:** Kept the shape. Set the numbers myself to easy = 10, medium = 15, hard = 20, matching the difficulty pacing I wanted for the game.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/399b2aba3bac149931aa3338d11418a0d66d9d17

### 2026-10-03 to 2026-10-04 — Gemini API integration

- **Tool:** Claude
- **What I asked for:** AI-generated questions, scaled by difficulty, with free-text answers (no multiple choice) and a fallback to the offline bank.
- **What it gave back:** A `GeminiService` class, a rewritten `Question` model with no `choices` field, and an async `_loadQuestion` in the battle screen with a loading card.
- **What I kept, what I changed, and why:** Kept it, but changed the API key handling — the AI's first draft suggested a key as a constructor argument in code. I moved it to `--dart-define` so nothing is ever in `lib/`, and wrote the `dart_defines.example.json` / `.gitignore` setup myself.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/046001d78760a57f9a52197bdc82cc9a4a085f01
  - Related commits: `Question model uses free-text answers, update bank`, `Updated Logs, gemini can be now used`

## 2. Where the AI got it wrong

### Case 1 — API key in source

- **What it gave me:** A `GeminiService(apiKey: "AIza...")` example, with the key as a literal string in the file.
- **What was wrong with it:** The repository is public. A hardcoded key would be visible in `lib/` and in history the moment I committed. Even a single commit is enough — deleting the line later does not undo it.
- **What I did instead:** Moved the key to `String.fromEnvironment('GEMINI_API_KEY')` and documented `--dart-define-from-file=dart_defines.json` in the README. Added `dart_defines.json` to `.gitignore` and committed `dart_defines.example.json` as the placeholder.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/0e9e9c751aae32e5b6504ce6b24cd1444105bec8

### Case 2 — Wrong Gemini model name

- **What it gave me:** `model: 'gemini-2.0-flash'` in the `GenerativeModel` constructor.
- **What was wrong with it:** On my SDK it threw a model-not-found error, and because the catch block in `_loadQuestion` swallows errors silently, the app just fell back to the offline bank. I thought the key was broken for about an hour.
- **What I did instead:** Added `debugPrint('Gemini failed: $e')` to the catch block so the real error surfaces, confirmed it was a model name issue, and swapped to a model that works on my SDK.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/0e9e9c751aae32e5b6504ce6b24cd1444105bec8

### Case 3 — Free-text answer check too strict

- **What it gave me:** A simple `userAnswer == question.correctAnswer` comparison for the new free-text answers.
- **What was wrong with it:** Case differences ("String" vs "string") and numeric differences ("5" vs "5.0") both failed. That is bad for a text-answer game where the player types rather than picks.
- **What I did instead:** Wrote `_answersMatch` myself: trim, lowercase, direct compare, and if both sides parse as numbers, compare them numerically. Placed it in `_BattleScreenState` so I can tune it as I test.
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/0e9e9c751aae32e5b6504ce6b24cd1444105bec8

## 3. Who wrote what

### Written by me

- **File:** `lib/models/player_progress.dart`
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/9197adc9880621f5eae4e293908e85a09983f7cf
- **What it does and why it is built this way:** Holds the player's `level`, `xp`, `totalScore` and `battlesWon`. The `gainBattleRewards` method handles XP roll-over into levels with a `while` loop, so a single battle can raise more than one level if the XP gain is large. I wrote the level-up loop and the `clamp(0.0, 1.0)` guards on `levelProgress` and `xpProgress` because those are the edge cases that broke things when I first tested a fresh save: the progress bars were showing fractions greater than 1 and the bars were overflowing their containers.

### The AI-written part I understand best

- **File:** `lib/screens/battle_screen.dart`
- **Commit:** https://github.com/Ange-Potato/code_royal/commit/eb3a90d2aa387820de50ac3eb181230b04e789f9
- **What it does and why we kept it:** The `_loadQuestion` method sets `_loadingQuestion = true`, awaits the Gemini call, and on any error falls back to `randomQuestion()` from the local bank. The `if (!mounted) return;` guard after the await is the part I did not understand until I read it carefully: if the player taps Exit while the question is still loading, the widget is already disposed by the time the `await` returns, and calling `setState` on a dead widget crashes the app. The guard prevents that. We kept the async + fallback pattern because it lets the game keep moving even if the API is slow or offline, which matters for a demo.
