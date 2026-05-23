# InstaDoctor
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/ayanegm/InstaDoctor)

InstaDoctor is a comprehensive doctor appointment booking application built with Flutter and Firebase. It provides a seamless experience for both patients seeking medical consultations and doctors managing their schedules. The app features distinct user interfaces and functionalities tailored to each role.

## Features

### For Patients
- **Authentication:** Secure sign-up and sign-in with email and password verification.
- **Find Doctors:** Browse and search for doctors across various medical specialties.
- **Doctor Profiles:** View detailed doctor profiles including specialization, bio, years of experience, and location.
- **Appointment Booking:** Easily book appointments by selecting a preferred date and available time slot from the doctor's real-time schedule.
- **Appointment Management:** View a list of upcoming and past appointments with options to manage them.

### For Doctors
- **Profile Management:** A dedicated flow for doctors to register and complete their professional profiles with details like specialty, experience, and bio.
- **Schedule Management:** Set and update a weekly availability template, which automatically populates daily slots for the week.
- **Appointment Dashboard:** A home screen displaying key statistics for the day: total booked, completed, and cancelled appointments.
- **Appointment Tracking:** View lists of upcoming, completed, and cancelled appointments for the current day.
- **Status Updates:** Manage the lifecycle of an appointment by marking it as 'completed' or 'cancelled', which updates the availability in real-time.
<img width="608" height="906" alt="doctorSide" src="https://github.com/user-attachments/assets/e9c3047a-7374-4b60-bd03-0bfa15783ea5" />

## Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **Backend & Database:** Firebase (Authentication, Cloud Firestore)
- **State Management:** Flutter Bloc (Cubit)

## Architecture Overview

The application is architected around a dual-role system (Patient vs. Doctor), determined by an `isDoctor` flag in the user's profile on Firestore.

- **Data Model:** User data, doctor profiles, and appointment details are stored in Cloud Firestore. The collections are structured to efficiently query data for both user types.

- **Schedule Management:** Doctors define a `weeklySchedule` in their profile, which serves as a template. A service (`AppointmentService`) uses this template to generate `daily_slots` documents for the upcoming 7 days. This ensures that when a slot is booked, it only affects that specific day and not the recurring weekly template.

- **State Management:** The `flutter_bloc` package is used for managing the state of real-time data. For example, the `DailySlotsCubit` listens to a Firestore stream to provide live updates of a doctor's daily schedule to the UI.

## Project Structure

The project follows a feature-driven directory structure to maintain a clean and scalable codebase.

```
lib/
├── models/         # Data models (Appointment, Doctor, User)
├── screens/        # UI pages for both user types
│   └── doctor/     # Screens specific to the doctor's flow
├── widgets/        # Reusable UI components
│   └── doctor_widgets/ # Widgets specific to the doctor's UI
├── helper/         # Service classes for Firebase interaction (AppointmentService, WeeklyScheduleService)
├── logic/          # State management (Bloc/Cubit)
└── firebase_options.dart # Firebase configuration
```

## Getting Started

Follow these instructions to get a copy of the project up and running on your local machine.

### Prerequisites

- Flutter SDK
- A code editor like VS Code or Android Studio
- A Firebase account

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/ayanegm/InstaDoctor.git
    cd InstaDoctor
    ```

2.  **Set up Firebase:**
    - Create a new project on the [Firebase Console](https://console.firebase.google.com/).
    - In the **Build** section, enable **Authentication** and add the "Email/Password" sign-in provider.
    - In the **Build** section, create a **Cloud Firestore** database and start in test mode.
    - Install the Firebase CLI and FlutterFire CLI if you haven't already:
      ```sh
      npm install -g firebase-tools
      dart pub global activate flutterfire_cli
      ```
    - Log in to Firebase:
      ```sh
      firebase login
      ```
    - Configure the project to connect to your Firebase backend. This will automatically generate the `lib/firebase_options.dart` file and configure the native platform projects.
      ```sh
      flutterfire configure
      ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the application:**
    ```sh
    flutter run
