# SRP Demo – SwiftUI (Single Responsibility Principle)

## Overview

This project demonstrates the **Single Responsibility Principle (SRP)** using a **SwiftUI + MVVM** architecture.

Each layer in the app has **one clearly defined responsibility**, making the codebase easy to understand, test, and extend.

---

## What is SRP?

**Single Responsibility Principle** states:

> A class or module should have **only one reason to change**.

In this demo:

* Views only handle UI
* ViewModels only handle presentation logic
* Repositories only handle data fetching
* Networking only handles HTTP communication
* Models only represent data

---

## Project Structure

```
SRPDemo/
│
├── APIServices/
│   └── UserRepository.swift
│
├── Model/
│   └── User.swift
│
├── Networking/
│   └── Networking.swift
│
├── Screens/
│   └── UserScreenView.swift
│
├── ViewModel/
│   └── UserViewModel.swift
│
├── ContentView.swift
└── SRPDemoApp.swift
```

---

## Responsibility Breakdown (SRP in Action)

### 1. Model Layer

**File:** `User.swift`

**Responsibility:**

* Represents user data structure
* No business logic

```swift
struct User: Codable {
    let id: Int
    let name, username, email: String
}
```

---

### 2. Networking Layer

**File:** `Networking.swift`

**Responsibility:**

* Executes HTTP requests
* Handles networking errors
* Does NOT decode models

Key Components:

* `HttpClientProtocol`
* `HttpClient`
* `NetworkError`

This allows easy mocking and testing.

---

### 3. Repository Layer

**File:** `UserRepository.swift`

**Responsibility:**

* Fetches user data
* Decodes API response into `User`
* Depends on `HttpClientProtocol`, not concrete implementation

Why SRP-compliant?

* Networking logic is NOT mixed here
* Decoding responsibility stays focused

---

### 4. ViewModel Layer

**File:** `UserViewModel.swift`

**Responsibility:**

* Acts as a bridge between View and Repository
* Holds UI state (`user`, `message`)
* Calls repository to load data

No UI rendering or network code here.

---

### 5. View Layer (UI)

**File:** `UserScreenView.swift`

**Responsibility:**

* Displays UI using SwiftUI
* Observes ViewModel state
* Triggers data load

```swift
.task {
    await viewModel.loadData()
}
```

The View never knows **how** data is fetched.

---

## Why This Design is SRP-Friendly

| Layer      | Responsibility      |
| ---------- | ------------------- |
| View       | UI rendering        |
| ViewModel  | Presentation logic  |
| Repository | Data fetching       |
| Networking | HTTP communication  |
| Model      | Data representation |

Each component has **one reason to change**.

---

## Benefits

* Clean architecture
* Easy unit testing
* Mockable dependencies
* Scalable for larger apps
* Interview‑ready MVVM + SRP example

---

## How to Run

1. Open `SRPDemo.xcodeproj`
2. Select iOS Simulator
3. Run the app

The screen fetches and displays a user from:

```
https://jsonplaceholder.typicode.com/users/1
```

---

## Key Takeaways

* SRP reduces tight coupling
* MVVM complements SRP well
* Protocols help enforce responsibilities

---

## Author

**Viswa Bharath Dakka**

---
