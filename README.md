# Healthy Habits

An interactive story app that teaches children healthy habits through choice-based adventures — built for iPad.

---

## What it does

- Kids pick a habit (sleep, hydration, movement, screen time, hygiene, healthy eating) and play through a short story as a character
- At key moments, they choose between two illustrated options — one healthy, one not
- Every choice comes with feedback, audio narration, and a collected tip they keep at the end
- Fully bilingual — kids (or parents) can switch between English and Spanish at any time

---

## Why it works

- **Story-driven** — habits are taught through consequences in a narrative, not lectures
- **AI-generated illustrations** — every scene has a unique image generated for that habit and moment, making it feel alive
- **Short sessions** — each story takes ~3 minutes, designed for attention spans
- **Replayable** — options are shuffled on every play, so kids don't just memorise answers

---

## Technical overview

**Stack:** Flutter (iOS/iPad only) · Dart

**AI & content**
- Images generated via OpenRouter (Gemini 2.5 Flash) on first play, then permanently cached to disk — zero repeat API calls
- TTS narration via `flutter_tts` with iOS audio session configured for reliable playback

**Architecture**
- `StoryEngineProvider` — state machine managing 7 phases (intro → loading → narrating → asking → responding → transitioning → ending)
- `ImageGenerationProvider` — 3-tier cache: in-memory → SharedPreferences manifest → file system (`Documents/habits/{habitId}/`)
- `AudioProvider` — wraps `flutter_tts` with iOS `AVAudioSession` playback category
- `GoRouter` for navigation, `Provider` for state, `flutter_animate` for animations

**To run**
```bash
# Copy your .env file with OPENROUTER_API_KEY
cp .env.example .env

flutter pub get
cd ios && pod install && cd ..
flutter run -d "iPad Air"
```
