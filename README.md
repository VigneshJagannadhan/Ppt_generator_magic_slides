# Indian App Guy PPT Generator

## How to run
- `git clone https://github.com/VigneshJagannadhan/Ppt_generator_magic_slides`
- `cd indian_app_guy`
- Create a .env with your own - SUPABASE_URL and ANON_KEY
- `flutter pub get`
- `flutter run`
- Launch the app, open Settings, and add your MagicSlides `accessId`

You can install the APK from Here : https://drive.google.com/file/d/1gWBIVzj8sRnmJcXQ4rcRyqCFfepv0f3x/view?usp=sharing

## Database used
- Supabase for authentication
- flutter_secure_storage for tokens
- shared_preferences for other local data

## Architecture
- Flutter app using Clean architecture with feature-first foldering (`lib/features/*`)
- Core services wired via a simple DI layer in `lib/core/DI`
- Presentation generation flows rely on remote MagicSlides APIs

## Known issues
- PPT API credits: MagicSlides returns `200` with `success: true` and text `"presentation generated successfully"` even when credits are exhausted (extra field says credits spent). Because errors are inferred from HTTP status/message, this scenario currently bypasses our handlers and the UI shows success while no PPT is created.

- Access IDs for PPT generation were not provided by the team, so users must add their own locally from the settings screen before generating slides.
