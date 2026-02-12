# SwiftUI Unified Contacts - Lead Refactor

A professional implementation of a Contact Registry application, evolved from a 90-minute live-coding interview task into a production-grade, state-driven architecture. This repository demonstrates the transition from a "baseline" solution to a "Lead Engineer" standard.

---

## 📽️ Project Demonstration
View the high-level architecture and UI implementation in action:
[**Download or View Demo Video**](./video/demo_unified_contacts.mp4) 


---

## 🚀 Key Achievements

### 1. Architectural Evolution
* **State-Driven UI**: Transitioned from multiple boolean flags to a robust **ViewState enum** (`idle`, `loading`, `success`, `error`) to prevent impossible UI states.
* **Dependency Injection**: Decoupled the ViewModel from the Service layer using protocols, allowing for seamless swapping between `Mock` and `Production` data sources.
* **MainActor Isolation**: Ensured UI thread safety by isolating the ViewModel to the `@MainActor`, aligning with modern SwiftUI best practices.

### 2. Advanced TDD & Testing
* **Dual-Framework Testing**: Implemented a comprehensive test suite in both **XCTest** (industry standard) and the new **Swift Testing** framework (modern Apple standard).
* **Memory Hygiene**: Integrated a custom memory leak tracking extension to ensure all components are properly deallocated, preventing resource leaks.
* **The Spy Pattern**: Utilized a `ServiceSpy` to verify not just data delivery, but also call counts and execution order during service requests.

### 3. Modern Swift Standards
* **Swift 6 Concurrency**: Models conform to `Sendable` and `Identifiable`, ensuring safety in strict concurrency environments.
* **Structured Concurrency**: Used `.task` modifiers to manage asynchronous lifecycles effectively.

---

## 🛠️ Tech Stack
* **UI**: SwiftUI
* **Logic**: Combine / Async-Await
* **Architecture**: MVVM + State Machine
* **Testing**: XCTest & Swift Testing
* **Patterns**: Protocol-Oriented Programming, Dependency Injection, Spy Pattern

---

## 📁 Project Structure
* **/Template**: The original starter project provided for the task.
* **/Interview-Execution**: The baseline code completed during the 90-minute live session.
* **/UnifiedContacts (Lead-Solution)**: The refined, production-ready implementation featuring high-level architecture and TDD.

---

## 📝 Reflection
This project highlights a proactive approach to engineering. Following an interview session, I chose to refactor the initial solution to show how I apply **Lead-level patterns**—focusing on stability, testability, and the latest Swift ecosystem advancements. It serves as a testament to continuous growth and technical discipline.

---
