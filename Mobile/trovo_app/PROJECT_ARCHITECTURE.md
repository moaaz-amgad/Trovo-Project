# Torvo — Technical Architecture Documentation

> **Version:** 1.0  
> **Platform:** Flutter (iOS & Android)  
> **Architecture Pattern:** Clean Architecture + Feature-First Structure  
> **State Management:** BLoC / Cubit (flutter_bloc)

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [High-Level Architecture](#2-high-level-architecture)
3. [Folder Structure](#3-folder-structure)
4. [Core Layer](#4-core-layer)
   - 4.1 [Theming](#41-theming)
   - 4.2 [Routing](#42-routing)
   - 4.3 [Network](#43-network)
   - 4.4 [Dependency Injection (DI)](#44-dependency-injection-di)
   - 4.5 [Error Handling](#45-error-handling)
   - 4.6 [Services](#46-services)
   - 4.7 [Utils & Widgets](#47-utils--widgets)
5. [Features Layer](#5-features-layer)
   - 5.1 [auth](#51-auth)
   - 5.2 [onboarding](#52-onboarding)
   - 5.3 [splash](#53-splash)
   - 5.4 [home](#54-home)
   - 5.5 [questionnaire](#55-questionnaire)
   - 5.6 [phone_usage](#56-phone_usage)
   - 5.7 [memory_sequence](#57-memory_sequence)
   - 5.8 [number_letter](#58-number_letter)
   - 5.9 [stroop](#59-stroop)
   - 5.10 [diagnosis](#510-diagnosis)
   - 5.11 [time_focus](#511-time_focus)
6. [Data Flow Diagrams](#6-data-flow-diagrams)
7. [Technology Stack](#7-technology-stack)

---

## 1. Project Overview

**Torvo** is a Flutter application focused on cognitive health and digital wellness. It provides users with:

- Cognitive mini-games (Memory Sequence, Number & Letter, Stroop Test)
- Phone usage monitoring and reporting
- Personalized questionnaires for digital habit assessment
- AI-generated diagnosis and progress reports
- Multi-language support (Arabic / English)

The application is built using **Clean Architecture** principles, ensuring a clear separation of concerns, high testability, and ease of scalability. Each feature is fully isolated — a change in one feature does not affect others.

---

## 2. High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        Flutter App                          │
├─────────────────────────────────────────────────────────────┤
│                    Presentation Layer                       │
│         Screens  ◄──►  Cubits  ◄──►  State (Freezed)       │
├─────────────────────────────────────────────────────────────┤
│                      Domain Layer                           │
│         Repository Abstractions  +  Failure Types          │
├─────────────────────────────────────────────────────────────┤
│                       Data Layer                            │
│   Remote Data Sources  ◄──►  Local Data Sources            │
│         Models (Freezed + json_serializable)               │
├─────────────────────────────────────────────────────────────┤
│                       Core Layer                            │
│  Network │ DI │ Routing │ Theming │ Error │ Services        │
└─────────────────────────────────────────────────────────────┘
```

### Architecture Principles

| Principle | How It's Applied |
|-----------|-----------------|
| **Single Responsibility** | Each class has one clear job (DataSource fetches, Repository transforms, Cubit manages state) |
| **Dependency Inversion** | Cubits depend on abstract Repository interfaces, not concrete implementations |
| **Open/Closed** | New features are added as isolated modules without touching existing code |
| **DRY** | Shared logic lives in `core/` and is reused across all features |
| **Immutability** | All models and states are immutable Freezed classes |

---

## 3. Folder Structure

```
lib/
└── src/
    ├── core/
    │   ├── api/                  ← API config, client, token storage
    │   ├── constants/            ← App-wide constants and values
    │   ├── cubits/               ← Shared cubits (locale)
    │   ├── di/                   ← Dependency injection setup
    │   ├── errors/               ← Failure types and error handler
    │   ├── extensions/           ← Dart extension methods
    │   ├── network/              ← Dio setup, interceptors, endpoints
    │   ├── routing/              ← GoRouter configuration
    │   ├── services/             ← Secure storage, Hive cache, image picker
    │   ├── theming/              ← Colors, text styles, themes
    │   ├── utils/                ← Validators, observers, snackbar
    │   └── widgets/              ← Reusable shared widgets
    │
    └── features/
        ├── auth/
        ├── onboarding/
        ├── splash/
        ├── home/
        ├── questionnaire/
        ├── phone_usage/
        ├── memory_sequence/
        ├── number_letter/
        ├── stroop/
        ├── diagnosis/
        └── time_focus/
```

---

## 4. Core Layer

The `core/` folder contains all shared infrastructure that every feature depends on. It is framework-agnostic in design — business features should never know the details of how networking or storage work.

---

### 4.1 Theming

**Location:** `core/theming/`

```
theming/
├── app_colors.dart       ← All color constants
├── app_text_styles.dart  ← Typography system
└── app_themes.dart       ← ThemeData configuration
```

#### Color System

The app uses a semantic color system grouped into categories:

```
Primary Gradient
  ├── Deep Blue:   #162C83  ← Dark brand color
  └── Light Blue:  #4C6AE4  ← Bright brand color

Semantic Colors
  ├── Error:    #F44336
  ├── Success:  #34C759
  └── Warning:  #FFA000

Text Colors
  ├── Primary:    #111827  ← Main body text
  └── Secondary:  #6B7280  ← Subtitles, hints

Backgrounds
  ├── Light:  #FFFFFF
  └── Dark:   #0B1720

Auth-Specific Colors
  ├── Auth Primary / Secondary
  ├── Card Backgrounds
  └── Button Colors

Onboarding Dots
  ├── Active:    #162C83
  └── Inactive:  #E2E3E3
```

#### Typography System

Font: **Tajawal** — chosen for excellent Arabic/English bilingual support.

All sizes are responsive using `flutter_screenutil` (`.sp` suffix scales with device screen size).

```
Scale                     Size       Weight
──────────────────────────────────────────
Display Large             57.sp      Regular
Display Medium            45.sp      Regular
Display Small             36.sp      Regular

Headline Large            32.sp      Bold
Headline Medium           28.sp      Bold
Headline Small            24.sp      Bold

Title Large               22.sp      Regular
Title Medium              16.sp      Medium (w500)
Title Small               14.sp      Medium (w500)

Body Large                16.sp      Regular
Body Medium               14.sp      Regular
Body Small                12.sp      Regular

Label Large               14.sp      Medium (w500)
Label Medium              12.sp      Medium (w500)
Label Small               11.sp      Medium (w500)
```

> **Legacy aliases** (headline1-6, bodyText1-2, etc.) remain for backward compatibility but new code uses the semantic scale above.

---

### 4.2 Routing

**Location:** `core/routing/`

```
routing/
├── app_router.dart        ← GoRouter instance and route definitions
└── app_router_paths.dart  ← String path constants
```

#### Framework: GoRouter

GoRouter is Flutter's official recommended router. It provides:
- Declarative route definition
- Deep-link support
- Type-safe navigation
- Redirect and guard logic

#### Route Map

```
Route Path               Screen                    Parameters
──────────────────────────────────────────────────────────────────
/                        SplashScreen              —
/onboarding              OnboardingScreen          —
/login                   LoginScreen               —
/sign-up                 RegisterScreen            —
/otp                     OtpScreen                 —
/forget-password         ForgotPasswordScreen      —
/reset-password          NewPasswordScreen         ?email, ?code
/home                    HomeScreen                —
/layout                  LayoutScreen              —
/questionnaire           QuestionnaireScreen       —
/phone-usage             PhoneUsageScreen          —
/time-focus              TimeFocusScreen           —
/diagnosis-result        DiagnosisResultScreen     —
/number-letter           NumberLetterScreen        —
/stroop                  StroopScreen              —
/memory-sequence         MemorySequenceScreen      —
```

#### Navigation Flow Diagram

```
App Launch
    │
    ▼
SplashScreen
    │
    ├── First Time? ──► OnboardingScreen ──► LoginScreen
    │
    └── Returning User?
            │
            ├── No Token ──► LoginScreen
            │                    │
            │                    ├── Login ──► QuestionnaireScreen ──► HomeScreen
            │                    │
            │                    └── Register ──► OtpScreen ──► QuestionnaireScreen
            │
            └── Token Exists ──► HomeScreen / LayoutScreen
```

---

### 4.3 Network

**Location:** `core/network/`

```
network/
├── dio_factory.dart             ← Dio instance creation and configuration
├── dio_client.dart              ← Wrapper with typed HTTP methods
├── endpoints.dart               ← All API endpoint paths
└── interceptors/
    ├── auth_interceptor.dart    ← Bearer token injection + 401 refresh
    └── language_interceptor.dart ← Accept-Language header injection
```

#### HTTP Client: Dio

Dio is a powerful HTTP client for Dart supporting interceptors, timeouts, FormData, and download streaming.

#### Configuration (`dio_factory.dart`)

```
Base URL:    https://brandy-bronzelike-lai.ngrok-free.dev
Connect Timeout:   60 seconds
Receive Timeout:   60 seconds
Send Timeout:      60 seconds
Default Headers:   Content-Type: application/json
                   Accept: application/json
```

#### Interceptor Chain

Every HTTP request passes through this chain in order:

```
Outgoing Request
      │
      ▼
┌─────────────────────┐
│  LanguageInterceptor │  ← Adds: Accept-Language: ar / en
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│   AuthInterceptor    │  ← Adds: Authorization: Bearer <access_token>
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│  PrettyDioLogger     │  ← Logs request/response in dev mode
└──────────┬──────────┘
           │
           ▼
         Server
           │
           ▼
     Response (2xx) ──────────────────────► Return to caller
           │
     Response (401) ──► AuthInterceptor
                              │
                              ├── POST /api/refresh-token
                              │
                              ├── Success ──► Retry original request with new token
                              │
                              └── Fail ──► Clear tokens ──► Redirect to Login
```

#### Auth Interceptor Detail

The `AuthInterceptor` uses `QueuedInterceptor` — this ensures that if multiple requests fail with 401 simultaneously, only **one** token refresh call is made. All pending requests are then retried with the new token.

```
Request A ──────────► 401 ─────┐
Request B ──────────► 401 ─────┤ ──► Single refresh call ──► Retry A, B, C
Request C ──────────► 401 ─────┘
```

#### Endpoints Map

```
Category         Path                              Method
────────────────────────────────────────────────────────────
Auth             /api/login                        POST
                 /api/register                     POST
                 /api/logout                       POST
                 /api/forgot-password              POST
                 /api/reset-password               POST
                 /api/refresh-token                POST

Phone Usage      /api/phone-usage                  POST (submit)
                 /api/phone-usage                  GET  (history)

Questionnaire    /api/questionnaire                POST (submit)
                 /api/questionnaire                GET  (history)

Diagnosis        /api/diagnosis/generate           POST
                 /api/diagnosis-history            GET

Mini Games       /api/mini-game                    POST (submit result)
                 /api/mini-game/history            GET
                 /api/mini-game/stats              GET

Progress         /api/progress                     POST
                 /api/progress/history             GET
```

#### `DioClient` — HTTP Wrapper

`DioClient` wraps the raw Dio instance and exposes semantic methods used across all data sources:

```
Method          Description
────────────────────────────────────────────
get()           Fetch a resource
post()          Create a resource
put()           Replace a resource
patch()         Partially update a resource
delete()        Remove a resource
download()      Download a file to local path
upload()        Upload file via multipart/form-data
```

---

### 4.4 Dependency Injection (DI)

**Location:** `core/di/injection_container.dart`

**Framework:** GetIt (Service Locator pattern)

#### What is GetIt?

GetIt is a lightweight service locator. Instead of passing dependencies down through widget constructors, any layer of the app can call `sl<SomeService>()` to get the registered instance. This decouples construction from usage.

#### Registration Strategy

```
Registration Type    When Used
──────────────────────────────────────────────────────────────
Lazy Singleton       Created once on first use, reused forever
                     → Services: DioClient, SecureStorageService, HiveCacheService
                     → Data Sources, Repositories

Factory              New instance created every time it's requested
                     → Cubits: so each screen gets a fresh Cubit
```

#### Dependency Graph

```
                    ┌──────────────┐
                    │     Dio      │  ← Created by DioFactory
                    └──────┬───────┘
                           │
                    ┌──────▼───────┐
                    │  DioClient   │  ← Wraps Dio
                    └──────┬───────┘
                           │
          ┌────────────────┼────────────────┐
          │                │                │
┌─────────▼────┐  ┌────────▼──────┐  ┌─────▼──────────┐
│AuthDataSource│  │PhoneUsageSrc  │  │OtherDataSources│
└─────────┬────┘  └────────┬──────┘  └─────┬──────────┘
          │                │                │
┌─────────▼────┐  ┌────────▼──────┐  ┌─────▼──────────┐
│AuthRepository│  │PhoneUsageRepo │  │OtherRepositories│
└─────────┬────┘  └────────┬──────┘  └─────┬──────────┘
          │                │                │
┌─────────▼────┐  ┌────────▼──────┐  ┌─────▼──────────┐
│  AuthCubit   │  │PhoneUsageCubit│  │  OtherCubits   │
└──────────────┘  └───────────────┘  └────────────────┘
```

#### Registered Components

```
Category             Component                         Type
──────────────────────────────────────────────────────────────────
Infrastructure       Dio                               Lazy Singleton
                     DioClient                         Lazy Singleton
                     SecureStorageService              Lazy Singleton
                     HiveCacheService                  Lazy Singleton
                     ImagePickerService                Lazy Singleton

Auth                 AuthRemoteDataSource              Lazy Singleton
                     AuthRepository                    Lazy Singleton
                     AuthCubit                         Factory

Diagnosis            DiagnosisRemoteDataSource         Lazy Singleton
                     DiagnosisRepository               Lazy Singleton
                     DiagnosisCubit                    Factory

Phone Usage          PhoneUsagePlatformDataSource      Lazy Singleton
                     PhoneUsageRemoteDataSource        Lazy Singleton
                     PhoneUsageRepository              Lazy Singleton
                     PhoneUsageCubit                   Factory

Questionnaire        QuestionnaireLocalDataSource      Lazy Singleton
                     QuestionnaireRemoteDataSource     Lazy Singleton
                     QuestionnaireRepository           Lazy Singleton
                     QuestionnaireCubit                Factory

Memory Sequence      MemorySequenceRepository          Lazy Singleton
                     MemorySequenceCubit               Factory

Stroop               StroopRepository                  Lazy Singleton
                     StroopCubit                       Factory

Number & Letter      NlRepository                      Lazy Singleton
                     NlCubit                           Factory
```

---

### 4.5 Error Handling

**Location:** `core/errors/`

```
errors/
├── error_handler.dart  ← Converts DioExceptions into Failure objects
└── failures.dart       ← Sealed class hierarchy of all failure types
```

#### Design: Typed Failures with `Either`

The app uses the **functional programming** pattern of `Either<Failure, T>` (from the `dartz` package). Every repository method returns one of two things:

```
Either<Failure, SuccessData>
   │                │
   └── Left(Failure) ← Something went wrong (network, server, validation...)
   └── Right(Data)   ← Everything worked, here's your data
```

This eliminates runtime exceptions being thrown across layers. Errors are **values**, not exceptions.

#### Failure Type Hierarchy

```
Failure (sealed class)
│
├── NetworkFailure          ← No internet or socket error
├── TimeoutFailure          ← Request took too long
├── ServerFailure           ← HTTP 500+
├── NotFoundFailure         ← HTTP 404
├── UnauthorizedFailure     ← HTTP 401
├── ForbiddenFailure        ← HTTP 403
├── BadRequestFailure       ← HTTP 400
├── ValidationFailure       ← HTTP 422 (with field-level error map)
├── CacheFailure            ← Local storage read/write error
├── CancelledFailure        ← Request was cancelled
└── UnknownFailure          ← Unexpected error
```

All `Failure` subclasses extend `Equatable` and carry:
- `message: String` — Human-readable error description
- `statusCode: int?` — HTTP status code (if applicable)

`ValidationFailure` additionally carries:
- `errors: Map<String, List<String>>` — Field-level validation errors from the API (e.g., `{"email": ["already taken"]}`)

#### Error Handler Logic

```
DioException
      │
      ▼
   type?
      │
      ├── connectionTimeout ──────► TimeoutFailure
      ├── sendTimeout ────────────► TimeoutFailure
      ├── receiveTimeout ─────────► TimeoutFailure
      ├── connectionError ────────► NetworkFailure
      ├── cancel ─────────────────► CancelledFailure
      │
      ├── badResponse ────► statusCode?
      │                           │
      │                           ├── 400 ──► BadRequestFailure
      │                           ├── 401 ──► UnauthorizedFailure
      │                           ├── 403 ──► ForbiddenFailure
      │                           ├── 404 ──► NotFoundFailure
      │                           ├── 422 ──► ValidationFailure (parse field errors)
      │                           └── 500+ ► ServerFailure
      │
      └── unknown ────► SocketException? ──► NetworkFailure
                                        └──► UnknownFailure
```

#### Repository Usage Pattern

```dart
Future<Either<Failure, LoginResponse>> login(LoginRequest request) async {
  try {
    final response = await _remoteDataSource.login(request);
    return Right(response);
  } on DioException catch (e) {
    return Left(ErrorHandler.handle(e));
  }
}
```

#### Cubit Consumption Pattern

```dart
final result = await _repository.login(request);
result.fold(
  (failure) => emit(AuthState.error(failure.message)),
  (data)    => emit(AuthState.loginSuccess(data)),
);
```

---

### 4.6 Services

**Location:** `core/services/`

```
services/
├── secure_storage_service.dart     ← Encrypted key-value (tokens, user data)
├── hive_cache_service.dart         ← Fast local key-value cache
└── image_picker_service.dart       ← Device camera / gallery access
```

#### SecureStorageService

Uses `flutter_secure_storage`. Data is encrypted at rest.

- **Android:** Android Keystore backed encryption
- **iOS:** Keychain with `first_unlock_this_device` accessibility

```
Method                              Purpose
──────────────────────────────────────────────────────────
saveTokens(access, refresh)         Store both JWT tokens
getAccessToken()                    Read access token
getRefreshToken()                   Read refresh token
removeTokens()                      Delete tokens on logout
saveUserData(json)                  Store serialized user profile
removeUserData()                    Clear user profile
save(key, value)                    Generic secure write
read(key)                           Generic secure read
delete(key)                         Generic secure delete
clearAll()                          Wipe all secure data
containsKey(key)                    Check key existence
```

**Stored Keys:**
```
access_token      ← JWT access token
refresh_token     ← JWT refresh token
user_data         ← Serialized user profile JSON
app_language      ← Selected UI language (ar / en)
```

#### HiveCacheService

Uses `Hive` — a fast NoSQL local database for Flutter.

```
Box Name        Purpose
───────────────────────────────────────────
general_box     General app cache
auth_box        Auth-related cached data
```

```
Method                              Purpose
──────────────────────────────────────────────────────────
put(box, key, value)                Write a value to a box
get(box, key)                       Read a value from a box
remove(box, key)                    Delete a specific entry
clearAll(box)                       Clear an entire box
cacheAuthToken(token)               Convenience: cache access token
getCachedToken()                    Convenience: retrieve cached token
```

#### Why Both Secure Storage AND Hive?

| | SecureStorageService | HiveCacheService |
|--|---|---|
| **Encryption** | Always encrypted | Not encrypted |
| **Use Case** | Tokens, credentials, user PII | General cache, preferences |
| **Speed** | Slower (crypto overhead) | Very fast |
| **Persistence** | Until explicitly deleted | Until cleared |

---

### 4.7 Utils & Widgets

**Location:** `core/utils/` and `core/widgets/`

#### Utils

| File | Purpose |
|------|---------|
| `app_bloc_observer.dart` | Global BLoC observer — logs all state changes and errors in debug mode |
| `custom_snackbar.dart` | Centralized SnackBar helper for success / error / info messages |
| `validators.dart` | Form field validation functions (email, password, phone, etc.) |

#### Shared Widgets

| Widget | Purpose |
|--------|---------|
| `gradient_button.dart` | Primary CTA button with the brand gradient |
| `language_button.dart` | Language toggle button (AR / EN) |
| `language_selector_bottom_sheet.dart` | Bottom sheet for language selection |
| `image_source_bottom_sheet.dart` | Bottom sheet for camera vs. gallery selection |
| `notification_icon.dart` | App-bar notification icon with badge |

---

## 5. Features Layer

Each feature is a self-contained module. Features can only communicate through:
1. **Routing** (navigate to another feature's screen via GoRouter)
2. **Shared services** (via DI — e.g., SecureStorageService)

They **never** import each other's internal classes.

### Feature Internal Structure

Every feature follows the same internal layout:

```
feature_name/
├── data/
│   ├── datasources/          ← How data is fetched (API, device, local DB)
│   ├── models/               ← Data classes (Freezed + json_serializable)
│   └── repositories/         ← Interface + implementation (bridges data ↔ domain)
└── presentation/
    ├── cubit/                ← State management (Cubit + Freezed states)
    ├── screens/              ← Full-screen widgets
    └── widgets/              ← Feature-specific reusable widgets
```

#### What Each Sub-Folder Does

```
datasources/
  └─ Knows HOW to get data (HTTP call, read file, query DB)
  └─ Returns raw maps or model objects
  └─ Has no business logic

models/
  └─ Plain data structures
  └─ Immutable (Freezed)
  └─ Serializable (json_serializable)
  └─ NO business logic

repositories/
  └─ Defines the contract (abstract class)
  └─ Implementation bridges data sources
  └─ Returns Either<Failure, T>
  └─ This is the boundary the Cubit talks to

cubit/
  └─ Owns the feature's state machine
  └─ Calls repository methods
  └─ Emits typed state transitions
  └─ Contains no widgets

screens/
  └─ Listens to Cubit state with BlocBuilder / BlocListener
  └─ Dispatches actions to Cubit on user interaction
  └─ Contains only UI code

widgets/
  └─ Smaller UI components used by screens
  └─ Stateless when possible
```

---

### 5.1 auth

**Purpose:** User registration, login, OTP verification, and password reset.

```
auth/
├── data/
│   ├── datasources/
│   │   └── auth_remote_data_source.dart    ← API calls to /api/login, /api/register, etc.
│   ├── models/
│   │   ├── auth_action_response.dart       ← Generic action response (message, success)
│   │   ├── login_response.dart             ← Login payload (user + tokens)
│   │   └── register_response.dart          ← Registration payload
│   └── repositories/
│       ├── auth_repository.dart            ← Abstract interface
│       └── auth_repository_impl.dart       ← Saves tokens to SecureStorage after login
└── presentation/
    ├── cubit/
    │   └── auth_cubit.dart                 ← Manages login/register/OTP/reset states
    ├── screens/
    │   ├── login_screen.dart
    │   ├── register_screen.dart
    │   ├── otp_screen.dart
    │   ├── forgot_password_screen.dart
    │   └── new_password_screen.dart
    └── widgets/
        ├── auth_background.dart            ← Branded gradient background
        ├── auth_header.dart                ← Logo + title area
        ├── auth_primary_button.dart        ← Submit button
        ├── auth_social_row.dart            ← Social sign-in row
        └── auth_text_field.dart            ← Styled text input
```

#### Auth Flow

```
LoginScreen
    │  user submits credentials
    ▼
AuthCubit.login(email, password)
    │
    ▼
AuthRepositoryImpl.login()
    │
    ├──► AuthRemoteDataSource.login()  →  POST /api/login
    │
    ├── On success:
    │     ├── SecureStorageService.saveTokens(access, refresh)
    │     └── emit AuthState.loginSuccess(data)
    │
    └── On error:
          └── emit AuthState.error(failure.message)
```

---

### 5.2 onboarding

**Purpose:** First-launch walkthrough introducing the app to new users.

```
onboarding/
├── models/
│   └── onboarding_page_model.dart     ← Title, description, illustration asset path
└── presentation/
    ├── onboarding_screen.dart         ← PageView with swipe navigation
    └── widgets/
        ├── onboarding_dot_indicator.dart     ← Page position indicator
        └── onboarding_illustration.dart      ← SVG/image display per page
```

> **No data layer** — content is hardcoded locally. No API calls needed.

---

### 5.3 splash

**Purpose:** Initial loading screen that decides where to navigate based on app state.

```
splash/
└── presentation/
    └── splash_screen.dart    ← Checks token existence → routes to Login or Home
```

> **No data layer** — reads SecureStorageService directly to check token.

---

### 5.4 home

**Purpose:** Main dashboard after login.

```
home/
└── presentation/
    ├── home_screen.dart       ← Dashboard overview
    └── layout_screen.dart     ← Shell with bottom navigation bar
```

> **No data layer** — aggregates data from other features via navigation. Pure UI.

---

### 5.5 questionnaire

**Purpose:** Multi-step form collecting user information about digital habits and demographics.

```
questionnaire/
├── data/
│   ├── datasources/
│   │   ├── questionnaire_local_data_source.dart   ← Reads/writes draft answers from Hive
│   │   └── questionnaire_remote_data_source.dart  ← POST /api/questionnaire
│   ├── models/
│   │   └── questionnaire_response.dart            ← Server response after submission
│   └── repositories/
│       ├── questionnaire_repository.dart
│       └── questionnaire_repository_impl.dart     ← Saves locally, submits remotely
└── presentation/
    ├── cubit/
    │   └── questionnaire_cubit.dart               ← Step navigation, answer tracking
    ├── screens/
    │   └── questionnaire_screen.dart              ← Multi-step form screen
    └── widgets/
        ├── questionnaire_intro_card.dart
        ├── questionnaire_question_card.dart
        ├── questionnaire_question_title.dart
        ├── questionnaire_gender_option.dart
        ├── questionnaire_horizontal_picker.dart
        ├── questionnaire_labeled_slider.dart
        ├── questionnaire_nav_buttons.dart
        ├── questionnaire_phone_purpose_option.dart
        ├── questionnaire_sloth_header.dart
        └── questionnaire_step_indicator.dart
```

**Notable design:** Uses **both** local and remote data sources. Answers are saved locally as the user progresses (preventing data loss), then submitted to the API on final step.

---

### 5.6 phone_usage

**Purpose:** Reads device phone usage statistics and submits them to the backend.

```
phone_usage/
├── data/
│   ├── datasources/
│   │   ├── phone_usage_platform_data_source.dart  ← Reads native OS usage stats
│   │   └── phone_usage_remote_data_source.dart    ← POST /api/phone-usage
│   ├── models/
│   │   ├── phone_usage_data.dart                  ← Per-app usage entry
│   │   └── phone_usage_metrics.dart               ← Aggregated metrics (total time, etc.)
│   └── repositories/
│       └── phone_usage_repository_impl.dart       ← Merges platform + remote sources
└── presentation/
    ├── cubit/
    │   └── phone_usage_cubit.dart
    └── phone_usage_screen.dart
```

**Notable design:** Uses **two data sources simultaneously** — one reads native OS data (platform channel), the other communicates with the API. The repository merges both.

```
PhoneUsageRepository
    │
    ├── PhoneUsagePlatformDataSource  ← Reads from Android UsageStatsManager / iOS Screen Time
    └── PhoneUsageRemoteDataSource    ← Submits to /api/phone-usage
```

---

### 5.7 memory_sequence

**Purpose:** Cognitive mini-game — user must repeat a sequence of symbols shown in order.

```
memory_sequence/
├── data/
│   ├── models/
│   │   ├── memory_round.dart     ← One round's data (sequence, time limit)
│   │   └── memory_symbol.dart    ← A single symbol in the sequence
│   └── repositories/
│       ├── memory_sequence_repository.dart
│       └── memory_sequence_repository_impl.dart  ← Game logic + API submission
└── presentation/
    ├── cubit/
    │   └── memory_sequence_cubit.dart  ← Sequence generation, answer validation
    └── screens/
        └── memory_sequence_screen.dart
```

---

### 5.8 number_letter

**Purpose:** Cognitive mini-game combining number and letter recognition under time pressure.

```
number_letter/
├── data/
│   ├── models/
│   │   └── nl_round.dart          ← One round's stimulus and expected answer
│   └── repositories/
│       ├── nl_repository.dart
│       └── nl_repository_impl.dart
└── presentation/
    ├── cubit/
    │   ├── nl_cubit.dart          ← Full game state machine
    │   └── nl_state.dart          ← Freezed state types
    └── screens/
        └── nl_screen.dart
```

#### Game State Machine

```
Initial
  │
  ▼
NlInProgress ──────────────────────────────────┐
  │                                             │
  ├── user.answer(correct) ──► +10pts, feedback │
  ├── user.answer(wrong)   ──► -5pts (lvl3)    │
  ├── timeout()            ──► move to next    │
  └── advance()            ──────────────────►┘
                                    │
                         Last Round?
                                    │
                                    ▼
                              NlCompleted
                         (score, accuracy, avgReactionTime)
```

**Scoring rules:**
- Correct answer: **+10 points**
- Fast answer (< 2000ms): **+5 bonus points**
- Wrong answer (level 3 only): **−5 points**

---

### 5.9 stroop

**Purpose:** Classic Stroop Test — user must identify the ink color of a word, not its meaning.

```
stroop/
├── data/
│   ├── models/
│   │   ├── stroop_color.dart    ← Color enum (red, blue, green, yellow)
│   │   └── stroop_round.dart    ← Word text + ink color
│   └── repositories/
│       ├── stroop_repository.dart
│       └── stroop_repository_impl.dart
└── presentation/
    ├── cubit/
    │   ├── stroop_cubit.dart    ← Round generation, answer check
    │   └── stroop_state.dart    ← Freezed states
    └── screens/
        └── stroop_screen.dart
```

---

### 5.10 diagnosis

**Purpose:** Fetches and displays an AI-generated cognitive health report based on the user's game and questionnaire data.

```
diagnosis/
├── data/
│   ├── datasources/
│   │   └── diagnosis_remote_data_source.dart   ← POST /api/diagnosis/generate
│   ├── models/
│   │   └── diagnosis_response.dart             ← Report structure from AI
│   └── repositories/
│       ├── diagnosis_repository.dart
│       └── diagnosis_repository_impl.dart
└── presentation/
    ├── cubit/
    │   └── diagnosis_cubit.dart
    └── screens/
        └── diagnosis_result_screen.dart         ← Report display screen
```

---

### 5.11 time_focus

**Purpose:** Focus timer / digital wellness tool for managing screen time.

```
time_focus/
└── presentation/
    └── time_focus_screen.dart    ← Focus session timer UI
```

> **No data layer yet** — currently UI-only. Backend integration planned.

---

## 6. Data Flow Diagrams

### 6.1 Full Request Flow (API Call)

```
User Interaction (e.g., taps "Login")
          │
          ▼
     Screen Widget
          │  calls
          ▼
        Cubit
          │  calls
          ▼
     Repository (impl)
          │  calls
          ▼
   RemoteDataSource
          │  calls
          ▼
       DioClient
          │
          ▼
   [ AuthInterceptor ]    ← adds Bearer token
   [ LangInterceptor ]    ← adds Accept-Language
          │
          ▼
        HTTP Server
          │
          ▼
      Response
          │
    ┌─────┴─────┐
  2xx         4xx/5xx
    │               │
    ▼               ▼
 Model(fromJson)  ErrorHandler
    │               │
    ▼               ▼
Right(data)     Left(Failure)
    │               │
    └─────┬─────────┘
          ▼
       Cubit
       emit(state)
          │
          ▼
     BlocBuilder
     re-renders UI
```

### 6.2 Token Refresh Flow

```
Any Request ──► Server returns 401
                      │
                      ▼
           AuthInterceptor catches it
                      │
                      ▼
         POST /api/refresh-token
         (with stored refresh_token)
                      │
             ┌────────┴────────┐
           200               4xx
             │                 │
    Save new tokens      Clear all tokens
    Retry original       Navigate to Login
    request
```

### 6.3 State Management Flow

```
┌──────────────────────────────────────────────┐
│                   Cubit                       │
│                                               │
│  initial ──► loading ──► success             │
│                    └────► error              │
└──────────────────────────────────────────────┘
          │ emits state
          ▼
┌──────────────────────────────────────────────┐
│               BlocBuilder / BlocListener      │
│                                               │
│  .when(                                       │
│    initial: () => placeholder,                │
│    loading: () => CircularProgressIndicator,  │
│    success: (data) => ContentWidget(data),    │
│    error:   (msg)  => ErrorWidget(msg),       │
│  )                                            │
└──────────────────────────────────────────────┘
```

---

## 7. Technology Stack

| Category | Package | Version | Purpose |
|---|---|---|---|
| **Routing** | go_router | latest | Declarative navigation |
| **State Management** | flutter_bloc | latest | Cubit / BLoC pattern |
| **HTTP Client** | dio | latest | Network requests |
| **DI** | get_it | latest | Service locator |
| **Immutability** | freezed | latest | Data classes & sealed unions |
| **JSON** | json_serializable | latest | Code-gen serialization |
| **Functional** | dartz | latest | Either type for error handling |
| **Secure Storage** | flutter_secure_storage | latest | Encrypted token storage |
| **Local Cache** | hive | latest | Fast local key-value DB |
| **Localization** | flutter_localizations | SDK | i18n support |
| **State Persistence** | hydrated_bloc | latest | Persist Cubit state across sessions |
| **Responsive UI** | flutter_screenutil | latest | Screen-size adaptive sizing |
| **Font** | Tajawal | — | Arabic/English bilingual font |
| **Image Picker** | image_picker | latest | Camera / gallery access |
| **HTTP Logging** | pretty_dio_logger | latest | Dev-mode request/response logs |
| **Equality** | equatable | latest | Value equality for state/failure classes |

---

## Summary

Torvo follows **Clean Architecture** with a **Feature-First** folder structure. This means:

1. **Each feature is a silo** — its internals are hidden from other features.
2. **The core layer is shared infrastructure** — networking, storage, theming, DI.
3. **Data flows one way** — UI → Cubit → Repository → DataSource → API.
4. **Errors are values, not exceptions** — `Either<Failure, T>` across every layer boundary.
5. **State is immutable** — Freezed ensures no accidental mutation.
6. **The app is testable at every layer** — DataSources, Repositories, and Cubits can all be unit tested in isolation.

This architecture makes the codebase ready to scale — adding new features, new developers, or new data sources requires zero changes to existing modules.

---

*Document generated for technical handoff. All paths relative to `lib/src/`.*
