# Security checklist

Project: Code Royal
Repository is public: Yes
Backend: None — all data is stored on the device with `shared_preferences`.
AI provider: Google Gemini, called from the client using a `--dart-define` key.

## Secrets and credentials

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 1 | No API key, token or password is hardcoded in `lib/`, including in comments and commented-out code | Yes | `grep -rn "AIza" lib/` returns nothing. The Gemini key is read with `String.fromEnvironment('GEMINI_API_KEY')` in `lib/data/gemini_service.dart`; no literal value anywhere. |
| 2 | Anything private is in a gitignored config or passed with `--dart-define`, with an example file committed | Yes | `dart_defines.json` is gitignored; `dart_defines.example.json` ships with `"GEMINI_API_KEY": "PASTE_YOUR_KEY_HERE"`. README documents `flutter run --dart-define-from-file=dart_defines.json`. |
| 3 | No keystore, `key.properties` or signing credential is in the repository | Yes | `.gitignore` excludes `android/key.properties`, `*.jks`, `*.keystore`. `git status` shows none of these tracked. |
| 4 | Git history is clean: I searched `git log -p` for password, secret, api key and token | Yes | Ran `git log -p \| grep -i -E "password\|secret\|api[_-]?key\|token"` — no live values returned, only documentation references to the key name. |
| 5 | Any credential that was ever committed has been rotated | N/A | No credential has ever been committed. Nothing to rotate. |

## GitHub Actions

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 6 | No secret value is written literally in any workflow YAML file | N/A | No workflow files exist in `.github/workflows/`. |
| 7 | Secrets are stored in repository Actions secrets and read with `${{ secrets.NAME }}` | N/A | No workflows, no Actions secrets used. |
| 8 | No workflow step echoes, dumps or debug-prints a secret, and I opened a recent run's log to confirm | N/A | No workflow runs. |
| 9 | If I build a signed APK: the keystore is a base64 secret decoded to a file at build time, never printed | N/A | No signed APK built; project runs on web and emulator only. |
| 10 | Uploaded build artifacts contain no key file, keystore or generated config | N/A | No artifacts uploaded; no workflows. |
| 11 | Third-party actions are pinned to a commit SHA, not a moveable tag | N/A | No workflows. |
| 12 | Secret scanning and push protection are enabled on the repository | Yes | Enabled in GitHub → Settings → Code security. Push protection blocked a test commit containing a fake `AIza...` string during setup. |

## Backend and security rules

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 13 | Firestore and Storage rules are not left open to anyone; they require an authenticated user | N/A | No Firebase. Code Royal has no backend. |
| 14 | Rules restrict a user to their own documents where that makes sense | N/A | No backend. All player state lives in `shared_preferences` on the device. |
| 15 | If Supabase: Row Level Security is on for every table | N/A | No Supabase. |
| 16 | Firebase and Google API keys are restricted in the Google Cloud console to the APIs and app they are for | Yes | The Gemini API key is restricted to the **Generative Language API** only, with a daily quota cap. Since the key ships inside the client build, the restriction and quota are what limit exposure. |
| 17 | I opened the app signed out and confirmed I could not read or write data I should not | N/A | No authentication, no shared backend. The app cannot read data belonging to anyone else because it stores everything locally. |
| 18 | Seed and sample data is invented, not real people's data | Yes | The fallback question bank in `lib/data/question_bank.dart` uses generic Dart/programming questions. Enemy names are invented. Default player name is `"Player"`. |

## Input and app surface

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 19 | Input is validated before it is written, not only styled as valid in the UI | Yes | `_handleAttack` in `battle_screen.dart` rejects empty input before scoring. `_answersMatch` compares the trimmed lowercased value against the correct answer (with a numeric fallback). Nothing is written to storage from user input except through `PlayerProgress.gainBattleRewards`, which only adds integers. |
| 20 | Nothing secret is recoverable from the built app, since a shipped binary can be unpacked | No | The Gemini API key ships inside the client build as a `--dart-define` constant. It is technically recoverable from the compiled binary. Mitigated by API restriction and quota cap, not by hiding the key. Documented in README's "Privacy and secrets" section. |

## Repository and privacy

| # | Check | Yes / No / N/A | Evidence |
| --- | --- | --- | --- |
| 21 | No student number, personal email, phone number or home address in the repository or in commit messages | Yes | `git log --pretty=full` shows only the GitHub username as author. No student number, no personal email in commits. |
| 22 | No classmate's personal data in the repository | Yes | All sample content is invented. No names, IDs or images of any other person. |
| 23 | Dependencies come from pub.dev, and `build/` and `.dart_tool/` are gitignored | Yes | All packages come from `pub.dev` (`shared_preferences`, `google_generative_ai`, `device_preview`). `.gitignore` excludes `build/` and `.dart_tool/`. |
| 24 | Images, fonts and other assets are mine, licensed, or credited | Yes | Silkscreen font is under the SIL Open Font License (Google Fonts). Enemy GIFs are `[FILL: original / generated / sourced from X under Y licence]`. Credit in README's "Credits" section. |
| 25 | Repository visibility is deliberate, and I checked it after my last push | Yes | The repository is public on purpose; it is graded from the live link in the README. Verified after the last push on `[FILL: date]`. |

## Anything I found and fixed

The checklist caught one thing I had not thought through: the Gemini API key is
compiled into the client build, so it is recoverable from a shipped binary even
though it is not in the repository. I could not hide it a browser app has to
send the key to call the API. I restricted the key in the Google Cloud
Console to the Generative Language API only and set a daily quota cap. The
README's "Privacy and secrets" section says this plainly. Everything else on
the list was already clean: no hardcoded secrets, no backend, no personal data,
and both secret scanning and push protection are on.
