# Indian App Guy PPT Generator

## How to run
- `git clone https://github.com/VigneshJagannadhan/Ppt_generator_magic_slides`
- `cd indian_app_guy`
- `flutter pub get`
- `flutter run`
- Launch the app, open Settings, and add your MagicSlides `accessId`

## Database used
- Supabase for authentication
- Local persistent storage only (`shared_preferences` for lightweight state)

## Architecture
- Flutter app using clean architecture with feature-first foldering (`lib/features/*`)
- Core services wired via a simple DI layer in `lib/core/DI`
- Presentation generation flows rely on remote MagicSlides APIs

## Known issues
- PPT API credits: MagicSlides returns `200` with `success: true` and text `"presentation generated successfully"` even when credits are exhausted (extra field says credits spent). Because errors are inferred from HTTP status/message, this scenario currently bypasses our handlers and the UI shows success while no PPT is created.

- Access IDs for PPT generation were not provided by the team, so users must add their own locally from the settings screen before generating slides.
