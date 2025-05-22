# AR Museum Guide

A cross-platform mobile application that enhances museum experiences using augmented reality (AR). Built with Flutter, Unity, Vuforia, and Firebase.

## Project Structure
- `mobile_app/`: Flutter mobile app for visitors
- `curator_dashboard/`: Flutter web dashboard for curators
- `backend/`: Node.js API with Firebase Firestore
- `unity_ar/`: Unity project for AR functionality

## Setup Instructions
1. **Install Dependencies**:
   - Flutter: `flutter pub get` in `mobile_app/` and `curator_dashboard/`
   - Node.js: `npm install` in `backend/`
   - Unity: Import Vuforia SDK and configure image targets

2. **Firebase Setup**:
   - Create a Firebase project and enable Firestore
   - Add credentials to `backend/` and `mobile_app/lib/firebase_options.dart`

3. **Run Locally**:
   - Mobile App: `flutter run` in `mobile_app/`
   - Dashboard: `flutter run -d chrome` in `curator_dashboard/`
   - Backend: `node index.js` in `backend/`

4. **Unity AR**:
   - Build Unity project and integrate with Flutter using `flutter_unity_widget`

5. **Deploy**:
   - Mobile App: Deploy to Play Store/App Store
   - Dashboard: Host on Firebase Hosting
   - Backend: Deploy to Google Cloud Platform