\`\`\`markdown

# ORU Copy - Used Phone Marketplace App

Hey there\! 👋 This is the README for my Flutter internship assessment for OruPhones.  I've built a used phone marketplace app, kind of like a mini version of the real OruPhones app.  It's been a fun project and I've tried to implement as much as I could from the brief and the real app as a guide.

## Project Overview

The goal was to create a mobile app for buying and selling used phones.  Think of it as a platform where users in India can browse listings, compare prices, and connect to buy or sell second-hand devices. The focus was on making it user-friendly and smooth, just like the actual OruPhones app on the app stores.

This project was a great opportunity to dive deep into Flutter and build something that resembles a real-world application.  I've included features like user login (OTP-based), browsing products with pagination, handling likes, and even push notifications with Firebase.

## State Management Approach

For managing the app's state, I went with **Riverpod**.

**Why Riverpod, you might ask?** Well, here's why I chose it:

  * **It's pretty straightforward:**  Riverpod makes state management logic really clean and understandable.  It just clicked with me, and I found it easier to grasp than some other options, especially for a project of this scale.
  * **Testing is a breeze:**  I could easily test the different parts of my state logic in isolation with Riverpod.  This made me feel more confident in the code and that it's less likely to break unexpectedly.
  * **Scoped providers are cool:**  Being able to control how long state lives and where it's available using scoping is super handy in Flutter. It felt like a good fit for managing UI updates and data flow in a Flutter-centric way.
  * **It's type-safe:**  Riverpod uses Flutter's strong typing, which helps catch errors early on while coding rather than at runtime.  Less debugging headaches later\!
  * **Made for Flutter:**  It’s designed specifically for Flutter, so it just feels natural to use and integrates nicely with the Flutter widget tree.

In this app, Riverpod is handling things like:

  * **Login status (`isLoggedInProvider`):**  Knowing if the user is logged in or not.
  * **OTP input (`otpProvider`):**  Keeping track of the OTP during the login process.
  * **Product listings (`paginatedProductProvider`):** Managing the list of products, handling loading more products (pagination), and error states when fetching data.

Using Riverpod has really helped keep my code organized and made managing the app's data and UI updates much smoother.

## Architecture

I aimed for a simple but effective layered architecture to keep things organized.  It's not super complex, but it helped me separate different parts of the app.

**Here's how I broke it down:**

1.  **Presentation Layer (UI):**

      * This is all the visual stuff you see in the app – the screens and widgets.  Folders like `screens` and `widgets` are where you'll find this.
      * It's built using Flutter widgets, of course\!
      * This layer mainly *shows* data and handles user clicks. It gets the data it needs from Riverpod providers.
      * Examples:  `home_page_screen.dart`, `otp_screen.dart`, `name_screen.dart`, all the `product_card_widgets`, `banner_widget`, `hamburger_menu`, etc.

2.  **Business Logic Layer (Providers):**

      * This is where all the brainwork of the app happens.  The `providers` folder is the heart of this layer.
      * Riverpod providers live here. They manage the app's state, do data processing, and basically tell the Data Layer what to do and then tell the UI Layer what to display.
      * Examples: `login_provider.dart` (containing `otpProvider`, `isLoggedInProvider`, and `OtpAuthService`), and `paginated_products_provider.dart` (with `paginatedProductProvider`).

3.  **Data Layer (Services):**

      * This layer deals with getting and sending data.  The `services` folder is where it lives.
      * It handles things like making API calls to the backend and storing stuff locally (like login cookies using `shared_preferences`).
      * Examples: `otp_auth_service.dart` (which is inside `login_provider.dart`, handling API calls), `notification_service.dart`.

**Why this layering?**

  * **Keeps things tidy:**  Each part of the app has its own place and job.  Makes it easier to find things and understand what's going on.
  * **Easier to maintain:** If I need to change something in the UI, it's less likely to mess up the data logic, and vice versa.  Makes updates less scary.
  * **Testable pieces:** I can test the business logic and data fetching separately without even running the UI.  This really helps make sure each piece works well on its own.
  * **Scales better:** If the app gets bigger and more complex (which they always do\!), this structure will make it easier to add new features without creating a giant mess of code.
  * **Reusable bits:**  Code in the business logic and data layers can be reused in different parts of the app, saving time and effort.

This layered structure is pretty basic, but it's been really helpful for this project. It's made the code more organized, easier to work with, and hopefully, more robust.

## Steps to Set Up and Run the Project

Alright, want to run this project yourself? Here's what you need to do:

**First, the stuff you'll need installed:**

  * **Flutter SDK:** You'll need Flutter installed on your computer. If you haven't already, grab it from the official Flutter site: [https://flutter.dev/docs/get-started/install](https://www.google.com/url?sa=E&source=gmail&q=https://www.google.com/url?sa=E%26source=gmail%26q=https://flutter.dev/docs/get-started/install).  Make sure you've set it up correctly so you can run Flutter commands in your terminal.
  * **IDE (Android Studio or VS Code):**  Get yourself a good code editor. Android Studio and VS Code are both great for Flutter development.  Pick your favorite and install the Flutter plugins.
  * **Emulator or Phone:** You'll need to run the app on something\! Set up an Android emulator using Android Studio (or your preferred emulator). Or, even better, connect your own Android phone for testing.  You can also use an iOS simulator if you've got Flutter set up for iOS, but I've primarily tested on Android.

**Now, the setup steps:**

1.  **Clone the Repo:** Open your terminal and type:

    ```bash
    git clone <repository_url>  #  <-- Put the actual repo URL here!
    cd <repository_folder>     #  <--  Go into the project folder
    ```

2.  **Get the Dependencies:**  In the project folder, run:

    ```bash
    flutter pub get
    ```

    This will download all the packages listed in `pubspec.yaml`.

3.  **Run It\!** Make sure your emulator or phone is connected, then type:

    ```bash
    flutter run
    ```

    This will build the app and launch it on your device.  Pretty cool, huh?

**For iOS (if you're set up for it):**

If you're developing for iOS as well, you can run it on the iOS simulator like this:

```bash
flutter run -t lib/main.dart -d ios # For iOS Simulator
# OR
flutter run -t lib/main.dart -d all # If you have multiple devices connected, to choose
```

**Important things to keep in mind:**

  * **Firebase:**  This app uses Firebase for push notifications. You'll probably need to set up your own Firebase project and put your Firebase config info in `firebase_options.dart`.  Check out Firebase's Flutter setup guide: [https://firebase.google.com/docs/flutter/setup](https://www.google.com/url?sa=E&source=gmail&q=https://www.google.com/url?sa=E%26source=gmail%26q=https://firebase.google.com/docs/flutter/setup) and the Firebase CLI docs: [https://firebase.google.com/docs/cli](https://www.google.com/url?sa=E&source=gmail&q=https://www.google.com/url?sa=E%26source=gmail%26q=https://firebase.google.com/docs/cli).
  * **Backend API:** The app talks to a backend at `http://40.90.224.241:5000`.  Make sure this API is running and reachable, otherwise, the app won't work fully.
  * **Emulators can be slow:**  Emulators are okay for testing, but for really seeing how smooth the app is, run it on a real phone. It's usually way faster.

## Packages Used

Here’s a list of the main Flutter packages I used and why they were helpful in this project:

| Package Name             | Version (or Latest) | Why Used in OruPhones App?                                                                                                  |
| ------------------------ | ------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| `flutter_riverpod`      | Latest              | **State Management:**  The backbone of managing state throughout the app, making UI updates reactive and data flow predictable.   |
| `http`                   | Latest              | **API Communication:** For making all the network requests to fetch product listings, handle login, and other backend interactions. |
| `url_launcher`           | Latest              | **Social Media Links:** To directly open social media apps (Instagram, Telegram, etc.) when users tap on those icons.        |
| `share_plus`             | Latest              | **Sharing:**  For implementing the share functionality, like sharing product listings on social media (though placeholder in this version). |
| `firebase_core`          | Latest              | **Firebase Foundation:** Required to initialize Firebase in the app, which is needed for Firebase Cloud Messaging.            |
| `firebase_messaging`     | Latest              | **Push Notifications:**  To handle receiving and displaying push notifications, both when the app is running and in the background/closed. |
| `cupertino_icons`        | Latest              | **iOS-style Icons:** Provides a set of nice-looking Cupertino icons for UI elements, adding a bit of visual polish.           |
| `animated_scale_widget` | *Custom Widget*     | **UI Animation (FAB):** This is a custom widget I created to get that smooth scaling animation effect for the "Sell +" Floating Action Button. |
| `banner_carousel`        | Latest               | **Image Carousels:** For displaying image banners on the home screen, creating a visually engaging experience for deals and offers.   |

This README should give you a good overview of the project.  Feel free to dive into the code and run it yourself\!  Let me know if you have any questions. 😊
