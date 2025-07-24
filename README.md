# bolsquare ios app

A sample iOS application built with **UIKit**, showcasing a modular and scalable architecture using **MVVM-C**, **Tuist**, and modern Swift features like `async/await`. This project emphasizes code quality, maintainability, and clean architectural practices.

---

## 📀 Architecture

- **MVVM-C (Model-View-ViewModel-Coordinator)** pattern
- Clear separation of concerns between UI, business logic, and navigation
- Dependency injection via [InjectGrail](https://github.com/SwingDev/ios-inject-grail)
- Asynchronous networking using `async/await`

---

## 🛠️ Project Setup

This project uses [Tuist](https://tuist.io) for managing Xcode project configuration.

### Requirements

- Xcode 16+
- Swift 5.9+
- Tuist (Install via `brew install tuist`)

### Generate the project

```bash
tuist fetch
tuist generate
```

---

## ✅ Testing

Includes both **unit tests** and **snapshot tests** to ensure reliability and maintainable UI:

- Snapshot tests (using iOS simulator)
- ViewModel logic covered with XCTest & Nimble

Run tests:

```bash
xcodebuild test -scheme bolsquare -destination 'platform=iOS Simulator,name=iPhone 16'
```

---

## 🧱 Tech Stack

- **UIKit** with programmatic UI
- **Tuist** for project generation
- **Swift async/await** for networking
- **Nimble** for expressive test assertions
- **InjectGrail** for DI
- **Custom view layer abstractions** and reusable components

---

## 🚫 UI Disclaimer

While the UI layer is implemented with consistency and a scalable style system, this project mainly focuses on demonstrating:

- App architecture
- ViewModel design
- Coordinator pattern
- Code quality and modularity

---

## 📌 Goals

This project aims to:

- Demonstrate a real-world MVVM-C setup
- Encourage clean architecture & testable design
- Serve as a starting point or inspiration for production-ready UIKit apps

---
