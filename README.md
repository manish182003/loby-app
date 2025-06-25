# 🎮 Loby App - Esports Tournament Platform (Frontend)

![Flutter](https://img.shields.io/badge/Flutter-v3.0.0+-blue?logo=flutter) ![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-green) ![License](https://img.shields.io/badge/License-MIT-yellow)

## 📋 Overview

Loby App is a **cross-platform esports tournament platform** built with [Flutter](https://flutter.dev/), enabling gamers to compete in tournaments for popular games like **PUBG**, **Free Fire**, and **Call of Duty**. The app supports multiple game modes (Solo, TDM, Duo) and features a **token-based payment system** where users purchase coins to join tournaments, with winnings distributed after deducting platform fees. The frontend follows a **clean architecture** pattern for maintainability and scalability.

---

## ✨ Features

- **🏆 Tournament Participation**: Join esports tournaments across various games and modes with an intuitive interface.
- **💰 Token-Based Payments**: Purchase coins to enter tournaments, with tokens held during matches and winnings credited post-game.
- **⚡ Real-Time Updates**: Seamless navigation and state management for live tournament updates and user balance tracking.
- **📱 Cross-Platform Support**: Built with Flutter for consistent performance on iOS and Android.

---

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **API Integration**: [Dio](https://pub.dev/packages/dio)
- **Architecture**: Clean Architecture
- **Backend**: Node.js, MySQL (refer to [backend repository](https://github.com/yourusername/loby-app-backend) for details)

---

## 📂 Project Structure

```plaintext
lib/
├── core/                    # Core utilities (constants, themes, etc.)
├── data/                    # Data layer (models, APIs, repositories)
│   ├── models/              # Data models
│   ├── api/                 # API services using Dio
│   └── repositories/        # Repository classes
├── domain/                  # Domain layer (entities, use cases)
│   ├── entities/            # Business entities
│   └── use_cases/           # Business logic
├── presentation/            # Presentation layer (UI, widgets, screens)
│   ├── screens/             # App screens (e.g., tournament, profile)
│   ├── widgets/             # Reusable UI components
│   └── providers/           # GetX controllers
├── routes/                  # GoRouter navigation setup
└── main.dart                # App entry point
```

---

## 🚀 Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/loby-app-frontend.git
   ```
2. **Install Dependencies**:
   ```bash
   cd loby-app-frontend
   flutter pub get
   ```
3. **Configure Environment**:
   - Create a `lib/core/config.dart` file and add the API base URL (refer to the backend repository for endpoint details).
   - Ensure [Flutter SDK](https://flutter.dev/docs/get-started/install) (version >= 3.0.0) is installed.
4. **Run the App**:
   ```bash
   flutter run
   ```

---

## 🎮 Usage

1. **Sign Up/Login**: Create an account or log in to access tournaments.
2. **Purchase Coins**: Buy coins via the payment system to join tournaments.
3. **Join Tournaments**: Select a game and mode, place tokens, and compete.
4. **Track Winnings**: View real-time balance updates after tournament results.

---


## 🤝 Contributing

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature
   ```
3. Commit changes:
   ```bash
   git commit -m 'Add your feature'
   ```
4. Push to the branch:
   ```bash
   git push origin feature/your-feature
   ```
5. Open a pull request.

---

## 📜 License

This project is licensed under the [MIT License](LICENSE) - see the [LICENSE](LICENSE) file for details.

---

## 📬 Contact

For inquiries, reach out via [your email] or [GitHub profile](https://github.com/yourusername).
