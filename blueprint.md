
# Project Blueprint

## Overview

This application is a Flutter-based utility that provides a detailed overview of a device's screen and hardware information. It is designed with a clean, modern, and user-friendly interface that adapts to both light and dark themes.

## Implemented Features & Design

### Core Functionality

*   **Device Information:** The app displays a comprehensive set of device and screen metrics, including:
    *   **Display:** Resolution (physical and logical), aspect ratio, pixel density, and refresh rate.
    *   **Hardware:** Device model and IMEI.
    *   **Brightness:** Current screen brightness level.
    *   **Safe Area:** The safe area insets (top and bottom) for the display.

### User Interface & Design

*   **Themeing:**
    *   The application features a robust and customizable theme system.
    *   It uses the `google_fonts` package to implement the "Lato" font for a clean and modern look.
    *   It includes distinct and harmonious color schemes for both light and dark modes, seeded from `Colors.deepPurple`.
    *   The theme is managed globally using the `flutter_bloc` package, with a `ThemeCubit` to handle state changes.
*   **Navigation:**
    *   The app uses the `go_router` package for navigation, although it currently only has a single screen.
*   **UI Components:**
    *   The UI is built with standard Material Design components, including `Scaffold`, `AppBar`, `ListView`, and `Card`.
    *   Information is presented in a clear and organized manner using custom-styled cards for each data point.
    *   A theme toggle button is present in the `AppBar` to allow users to switch between light and dark modes.

### Code & Project Structure

*   **State Management:** The app uses `flutter_bloc` for theme management, providing a clean separation of UI and business logic.
*   **Dependencies:** The project utilizes the following key packages:
    *   `flutter_bloc` for state management.
    *   `go_router` for navigation.
    *   `google_fonts` for custom typography.
    *   `device_information`, `flutter_displaymode`, and `screen_brightness` to retrieve device and screen information.
*   **Code Quality:** The code follows standard Flutter best practices, including the use of a linter (`flutter_lints`) to enforce a consistent style.

## Current Plan

This marks the completion of the initial development phase. The application is fully functional and meets all the specified requirements. The next steps would involve:

*   Adding more device information (e.g., battery level, storage, etc.).
*   Implementing more advanced features, such as real-time monitoring of device metrics.
*   Adding unit and widget tests to ensure the application's reliability.
