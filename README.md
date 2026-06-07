# UnRide

Community ride-sharing application built with Flutter. The project is designed to help users within a university environment find or offer transportation through a dual-role system where each user can act as either a passenger or a driver.

## Overview

UnRide is a cross-platform mobile application focused on community-based transportation. The app allows passengers to publish ride requests and browse available driver offers, while drivers can publish available rides and manage their own offers.

The project integrates Firebase for authentication and cloud data storage, BLoC for state management, SQLite for local history, and a responsive interface that adapts depending on the user's active role and connection status.

## Key Features

* Cross-platform Flutter application
* Dual-role system: Client and Driver
* User registration and login
* Google Sign-In support
* Password reset flow
* Firebase Authentication integration
* Cloud Firestore data storage
* Passenger ride request creation
* Driver ride offer publication
* Role switching between Client and Driver views
* Profile and ride management
* Local ride history using SQLite
* Connectivity detection and offline handling
* Reusable UI components
* Clean BLoC-based state management
* Environment-based Firebase configuration

## Tech Stack

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* BLoC
* Cubit
* SQLite
* SharedPreferences
* Google Sign-In
* Flutter Dotenv
* Connectivity Plus
* Google Fonts
* Lottie

## Architecture

The project follows a layered architecture that separates presentation, business logic, data access, and local persistence.

### Presentation Layer

The presentation layer is built with Flutter widgets and reusable UI components. The interface changes depending on the user's current role, allowing the same authenticated user to interact with the app as a passenger or as a driver.

### Business Logic Layer

The app uses the BLoC pattern to manage state transitions and keep business logic separated from the UI. Main BLoCs and Cubits handle authentication, ride posts, connectivity status, and role switching.

Important state management components include:

* `AuthenticationBloc`
* `ClientPostBloc`
* `DriverPostBloc`
* `ConnectivityBloc`
* `RoleCubit`

### Data Layer

The data layer uses repositories and models to abstract Firebase and local database operations. This keeps the UI and BLoC layers independent from the direct implementation of Firestore or SQLite.

Main data domains include:

* User identity
* Client ride requests
* Driver ride offers
* Local ride history

### Authentication

Authentication is handled through Firebase Authentication and supports email/password login, Google Sign-In, session persistence, password recovery, and user profile data stored in Cloud Firestore.

The authentication state controls the navigation flow of the app, deciding whether the user should see the login screen, the main client interface, or driver-related features when a vehicle is registered.

### Ride Management

The application separates ride logic between passengers and drivers:

* **Client role:** Users can browse driver offers, create ride requests, and manage their passenger profile.
* **Driver role:** Users with vehicle information can browse passenger requests, publish ride offers, and manage their driver profile.

### Local Persistence

SQLite is used to store local ride history. This allows the application to keep a record of ride-related data locally while Firestore handles the main cloud-based synchronization.

### Connectivity Handling

A global connectivity system monitors the device's internet connection. When the app detects that the user is offline, it displays a no-connection screen to avoid data inconsistencies during cloud operations.

## Getting Started

### Requirements

* Flutter SDK
* Dart
* Firebase project
* Android Studio, VS Code, or another Flutter-compatible IDE

### Installation

Clone the repository:

```bash
git clone https://github.com/JorgeRojas720s/UnRide.git
```

Install dependencies:

```bash
flutter pub get
```

Create a `.env` file in the root directory and configure the Firebase variables:

```env
API_KEY=
APP_ID=
MESSAGING_SENDER_ID=
PROJECT_ID=
STORAGE_BUCKET=
AUTH_DOMAIN=
MEASUREMENT_ID=
```

Run the application:

```bash
flutter run
```

## Project Purpose

This project was created to practice mobile application development with Flutter while implementing a real-world transportation use case. It demonstrates skills in cross-platform UI development, Firebase integration, authentication, cloud data management, local persistence, role-based navigation, state management with BLoC, and connectivity-aware application behavior.

UnRide highlights the ability to build a structured mobile app with multiple user flows, reusable architecture, and a clear separation between interface, business logic, and data access.
