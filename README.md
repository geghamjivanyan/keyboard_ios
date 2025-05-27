# iOS Custom Keyboard

This is a custom keyboard extension for iOS devices. The keyboard provides a unique typing experience with customizable features.

## Requirements

- Xcode 14.0 or later
- iOS 15.0 or later
- Swift 5.0 or later

## Project Structure

- `Keyboard/` - Main keyboard extension target
  - `KeyboardViewController.swift` - Main keyboard view controller
  - `KeyboardView.swift` - Custom keyboard view
  - `KeyboardLayout.swift` - Keyboard layout configuration
  - `Assets.xcassets/` - Keyboard assets and images

## Setup Instructions

1. Clone the repository
2. Open `Keyboard.xcodeproj` in Xcode
3. Select your development team in project settings
4. Build and run the keyboard extension

## Features

- Custom keyboard layout
- Theme support
- Emoji support
- Basic text input functionality

## Development

To add new features or modify the keyboard:

1. Edit the keyboard layout in `KeyboardLayout.swift`
2. Modify the UI in `KeyboardView.swift`
3. Handle keyboard logic in `KeyboardViewController.swift`

## License

This project is licensed under the MIT License - see the LICENSE file for details.
