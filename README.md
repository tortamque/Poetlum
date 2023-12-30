<a href="https://firebase.google.com/"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Firebase_icon.svg/2048px-Firebase_icon.svg.png" align="right" width="8%"></a>
<a href="https://flutter.dev/"><img src="https://cdn.icon-icons.com/icons2/2107/PNG/512/file_type_flutter_icon_130599.png" align="right" width="8%"></a>
<a href="https://github.com/tortamque/Poetlum/releases"><img src="https://github.com/tortamque/Poetlum/assets/90132962/b1ed40cd-68a8-4ecc-8154-120366f9ef3d" align="right" width="8%"></a>

# Poetlum

## Before you read...
Poetlum is my coursework, with its theme being a mobile application designed for searching poetry on a given topic. So, enjoy reading through this lengthy documentation 👀

## Description
Poetlum is a mobile application designed to offer users the ability to search, save, and share poems based on specific themes, simplifying and automating the process of engaging with poetry through mobile devices. This application not only eases access to poetic works but also allows users to create their own poems, save them in the cloud for secure storage, and manage their personal collections with ease, thus increasing the accessibility and comfort of reading poetry and fulfilling their creative needs.<br>
Designed with the user in mind, Poetlum integrates a [Clean architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) pattern, combining [Repository](https://developer.android.com/codelabs/basic-android-kotlin-training-repository-pattern#3), [Separation of Conserns](https://medium.com/@evon.dong3/key-ideas-about-separation-of-concerns-f971bdb8bd6b), [Dependency Injection](https://www.tutorialsteacher.com/ioc/dependency-injection) and [Bloc](https://bloclibrary.dev/#/flutterbloccoreconcepts) patterns, to ensure efficient data management and an intuitive experience.<br>

## Table of Contents
- [Used Technologies](#used-technologies)
- [Architecture](#architecture)
- [Features](#features)
- [Supported platforms](#supported-platforms)
- [Usage](#usage)
- [Deployment](#deployment)
- [Screenshots and Demo](#screenshots-and-demo)
- [Changelog](#changelog)
- [Firebase Database](#database)
- [Diagrams](#diagrams)
- [Used Packages](#used-packages)
- [License](#license)

<a name="used-technologies"/></a>
## Used Technologies
Poetlum utilizes <b>Firebase Realtime Database</b> as its primary database, along with <b>Firebase Authentication</b> for user registration and login. Additionally, it leverages <b>Firebase Crashlytics</b> for swift crash reports and <b>Firebase Analytics</b> for analyzing user preferences.<br>
The program also integrates [PoetryDB](https://poetrydb.org/index.html) API for fetching poems.

<a name="architecture"/></a>
## Architecture
Poetlum fully embraces the Clean Architecture pattern, incorporating Bloc, Repository, Separation of Concerns, and Dependency Injection patterns.</br>
Clean Architecture consists of the following layers: 
1) Data Layer
2) Domain Layer (Business Logic)
3) Presentation Layer (UI) </br></br>

<b>Call Flow Diagram</b>:<br>
<img width="65%" alt="Call Flow Diagram" src="https://github.com/tortamque/Poetlum/assets/90132962/6d2e5a2e-cdc8-4a62-9a6f-ca824da2b00c"><br>

<b>Onion Diagram</b>:<br>
<img width="65%" alt="Onion Diagram" src="https://github.com/tortamque/Poetlum/assets/90132962/75b02676-81c2-4fe0-8372-dc3783ea0849"><br>

<a name="features"/></a>
## Features
- Advanced poem search filters, allowing criteria selection such as author, poem title, line count, and the number of poems displayed.
- Capability to write and manage your own poems within the application.
- Captivating animations that will leave a lasting impression 😎
- Creation and management of collections for organizing your favorite poems, ensuring easy access.
- Saving favorite poems to your profile and the cloud database for seamless retrieval.
- Viewing personal and saved poems directly within the app.
- Sharing personal and saved poems using various external applications.
- Customizing the app with a variety of selectable color themes.
- Updating account details, including nickname, email, and password, within the app settings.

<a name="supported-platforms"/></a>
## Supported platforms
Poetlum is a mobile application that supports <b>Android</b> platform.

<a name="usage"/></a>
## Usage
1. Upon first launch of the app, you will be directed to the registration page.
2. If you are already registered, you can navigate to the login page.
3. After registration or login, you will be taken to the main page.
4. On the main page, you can:
   - Update poems.
   - Access the settings menu.
   - Go to the poem search menu.
   - Navigate to the saved collections menu.
   - View a poem.
5. In the poem viewing menu, you can:
   - Add the poem to your library.
   - Share the poem.
6. On the collections viewing page, you can:
   - Delete a collection.
   - Create a new collection.
   - Write your own poem.
   - View a collection.
7. In the collection creation menu, you can create a collection.
8. In the poem writing menu, you can create a poem.
9. In the collection viewing menu, you can:
   - View a poem.
   - Delete a poem.

<a name="deployment"/></a>
## Deployment
To deploy the Poetlum app, follow these steps:
1. Ensure that the Flutter SDK is installed. If not, install it.
2. Clone the source code repository of the application.
3. Navigate to the development environment, open the terminal, and execute the command `flutter pub get` to install the necessary packages.
4. For deploying the Firebase part, go to the Firebase console and create a new project.
5. In the platform selection menu, choose the Android platform and enter the package name from the <b>AndroidManifest.xml</b> file.
6. To generate the <b>google-services.json</b> file, add the Android application to the Firebase console project by specifying the package name.
7. Download the configuration file <b>google-services.json</b> and place it in the <b>android/app</b> folder.
8. Update the <b>build.gradle</b> file at both project and app levels.
9. In the project-level build.gradle, add plugins `com.google.gms:google-services:4.3.10` and `com.android.tools.build:gradle:7.1.2`.
10. For the app-level build.gradle, set up plugins `com.google.firebase:firebase-bom:32.4.0`, `com.google.firebase:firebase-analytics-ktx`, and `com.android.installreferrer:installreferrer:2.2`.
11. Generate the <b>firebase_options.dart</b> file, which will contain configuration parameters for initializing Firebase in Flutter.
12. Use FlutterFire CLI for generation. Install it by running the command `dart pub global activate flutterfire_cli`.
13. After installing FlutterFire CLI, execute `flutterfire configure` and follow the instructions. This will generate the firebase_options.dart file.
14. To integrate Firebase into the project, add the code `WidgetsFlutterBinding.ensureInitialized();` and `await Firebase.initializeApp();` before running the main function to initialize Firebase before the app starts.

<a name="screenshots-and-demo"/></a>
## Screenshots and Demo
### Screenshots
<details>
  <summary>Click here to view a lot of screenshots 👀</summary>

  <img src="https://github.com/tortamque/Poetlum/assets/90132962/9a1190bb-9381-46da-9eda-cf0653e5f6f4" alt="Screenshot_1" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/3ac99efc-1e20-4ca6-bf62-b6001cad7c64" alt="Screenshot_2" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/bdc49516-75fa-40ef-91c8-f5e0be467f76" alt="Screenshot_3" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/c6d966dc-d2df-46f6-9290-a8731988a0e1" alt="Screenshot_4" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/dd5579ba-03cd-4312-8de8-a74a96817c8d" alt="Screenshot_5" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/277a2da6-6a84-48c5-baab-154aeeb159b7" alt="Screenshot_6" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/905f9e5f-4bea-4294-9b1c-5f0b8562fa8f" alt="Screenshot_7" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/d262d8e6-f2d3-4ddd-bfa9-307289cd44b5" alt="Screenshot_8" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/1db3d300-4a37-4ccd-ad0c-f23b8272c267" alt="Screenshot_9" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/8653174c-9441-473f-98eb-e5ff2d37243e" alt="Screenshot_10" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/a04f88c5-b846-4c01-aeee-759799839521" alt="Screenshot_11" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/1624ca34-7b27-45ae-9056-acf7373a56ab" alt="Screenshot_12" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/fef55c08-2c60-486e-bdc1-235bf74b75ba" alt="Screenshot_13" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/d6e19222-8b46-42b3-ad4b-81d9f417cdf6" alt="Screenshot_14" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/698a682a-d8c2-4751-b73d-4f337f68f590" alt="Screenshot_15" width="200">
  <img src="https://github.com/tortamque/Poetlum/assets/90132962/9bd2e8eb-4a2b-4fd0-a8a3-c7037e3e62a0" alt="Screenshot_16" width="200">
  
</details>

### Demo
https://github.com/tortamque/Poetlum/assets/90132962/75b2bffc-e70d-47aa-8907-ff759e865692

<a name="changelog"/></a>
## Changelog
### [1.0] - 26.12.2023
  #### Added
 - Initial release.
<a name="database"/></a>
## Firebase Realtime Database
### Database Schema
- **User ID** `String` (Primary Key)
  - **collections** `Collection`
    - **Collection ID** `String` (Primary Key)
      - **name** `String`
      - **poems** `Collection`
        - **Poem ID** `String` (Primary Key)
          - **author** `String`
          - **linecount** `Integer`
          - **text** `String`
          - **title** `String`
  - **poems** `Collection`
    - **Poem ID** `String` (Primary Key)
      - **author** `String`
      - **linecount** `Integer`
      - **text** `String`
      - **title** `String`
### Database Example
<img src="https://github.com/tortamque/Poetlum/assets/90132962/b53469de-a12d-43c5-95b3-f4443e4d18b6" alt="Database" width="700">

<a name="diagrams"/></a>
## Diagrams
### Usecase Diagram
<img src="https://github.com/tortamque/Poetlum/assets/90132962/5aa37a34-c709-4086-af24-de068a537276" alt="Usecase" width="500">

### Sequence Diagram
<img src="https://github.com/tortamque/Poetlum/assets/90132962/4e953809-7d65-44f7-8423-4e4535907ec5" alt="Sequence" width="500">

<a name="used-packages"/></a>
## Used Packages
The Poetlum app utilizes the following packages:
| Name                   | Version | Link on pub.dev                                         |
|------------------------|---------|---------------------------------------------------------|
| firebase_core          | 2.19.0  | [Link](https://pub.dev/packages/firebase_core)          |
| firebase_analytics     | 10.6.1  | [Link](https://pub.dev/packages/firebase_analytics)     |
| firebase_crashlytics   | 3.4.1   | [Link](https://pub.dev/packages/firebase_crashlytics)   |
| firebase_auth          | 4.11.1  | [Link](https://pub.dev/packages/firebase_auth)          |
| firebase_database      | 10.3.1  | [Link](https://pub.dev/packages/firebase_database)      |
| get_it                 | 7.6.4   | [Link](https://pub.dev/packages/get_it)                 |
| equatable              | 2.0.5   | [Link](https://pub.dev/packages/equatable)              |
| connectivity_plus      | 5.0.1   | [Link](https://pub.dev/packages/connectivity_plus)      |
| get                    | 4.6.6   | [Link](https://pub.dev/packages/get)                    |
| dio                    | 5.3.3   | [Link](https://pub.dev/packages/dio)                    |
| retrofit               | 4.0.3   | [Link](https://pub.dev/packages/retrofit)               |
| json_annotation        | 4.8.1   | [Link](https://pub.dev/packages/json_annotation)        |
| flutter_bloc           | 8.1.3   | [Link](https://pub.dev/packages/flutter_bloc)           |
| email_validator        | 2.1.17  | [Link](https://pub.dev/packages/email_validator)        |
| fluttertoast           | 8.0.9   | [Link](https://pub.dev/packages/fluttertoast)           |
| google_nav_bar         | 5.0.6   | [Link](https://pub.dev/packages/google_nav_bar)         |
| like_button            | 2.0.5   | [Link](https://pub.dev/packages/like_button)            |
| multi_dropdown         | 2.1.1   | [Link](https://pub.dev/packages/multi_dropdown)         |
| shared_preferences     | 2.2.2   | [Link](https://pub.dev/packages/shared_preferences)     |
| share_plus             | 7.2.1   | [Link](https://pub.dev/packages/share_plus)             |


<a name="licenses"/></a>
## License
Apache License Version 2.0
