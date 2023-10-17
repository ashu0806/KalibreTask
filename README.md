# Kalibre Task - Flutter Project

Description:
The Kalibre Task is a Flutter project that showcases various features and functionalities implemented using Firebase, GetX state management, Firebase Firestore, HTTP packages, and shared_preferences.

Project Features:

1. _Splash Page and Sign-In Flow_: The app starts with a splash page and then redirects users to the sign-in page. Existing users can sign in, while new users are redirected to the sign-up page to create an account.

2. _Getx State Management Approach_: GetX is used for state management, handling sign-in and sign-out processes using Firebase's authStreamChanges() method within the ever() method of GetX.

3. _Firebase Firestore Integration_: User data is stored in Firebase Firestore during sign-in or sign-up.

4. _Dashboard and Lists Display_: After signing in, users are redirected to the dashboard page, where list of movies with some displayed using ListView builder.

5. _Caching_: Shared_preferences is utilized to cache user data.

Challenges and Solutions:

The development process did not face any significant challenges, and all instructions were implemented successfully.

Note:

- The Google-services.json file is not provided in the repository, and key.properties and .jks files for building the release mode of the Android platform are also not included.

Android App Build Link: [Kalibre Task Android Build](https://drive.google.com/file/d/14HstZOnyVw_pHZpwi6yKIbPx7fSI39ck/view?usp=share_link)

Please note that this project serves as a demonstration and does not contain sensitive files required for complete functionality. The purpose is to showcase the implementation of various features using Flutter and associated libraries.
