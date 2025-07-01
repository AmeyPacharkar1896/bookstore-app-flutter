# 📱 Bookstore E-commerce App (Flutter)

![Bookstore App & Admin Demo](YOUR_DEMO_GIF_URL_HERE)

This repository contains the **user-facing Flutter application** for a complete full-stack e-commerce platform. It provides a seamless mobile shopping experience, allowing users to browse products, manage a shopping cart, and complete a full checkout flow.

> **Note:** This is the user app. The corresponding **React Admin Dashboard** for managing products can be found here: **[bookstore-admin-react](https://github.com/AmeyPacharkar1896/bookstore-admin-react)**

---

## ✨ Key Features

- ✅ **Full User Authentication:** Secure sign-up and login functionality powered by Supabase Auth.
- ✅ **Dynamic Product Catalog:** Browse products managed via the admin dashboard, with real-time updates.
- ✅ **Complete E-commerce Flow:** Full cart management (add, update, remove) and a multi-step checkout process with address entry.
- ✅ **Efficient State Management:** Built with the **BLoC (Business Logic Component)** pattern for a scalable and maintainable architecture, separating UI from business logic.
- ✅ **Order History:** Authenticated users can view a list of their past orders, demonstrating a full-loop user journey.

## 🛠️ Tech Stack

| Category         | Technology                                  |
| ---------------- | ------------------------------------------- |
| **Framework**    | Flutter (Dart)                              |
| **State Mngmt**  | BLoC / flutter_bloc                         |
| **Routing**      | GoRouter                                    |
| **Backend**      | Supabase (PostgreSQL Database & Auth)       |
| **Media Source** | Cloudinary (Images managed via Admin Panel) |

## 👨‍💻 Author

-   **Amey Pacharkar** – [LinkedIn](https://www.linkedin.com/in/amey-pacharkar-28520b307) | [GitHub](https://github.com/AmeyPacharkar1896)

---

<details>
<summary><b>View Technical Details & Setup Instructions</b></summary>
<br>

### 📁 Simplified Folder Structure
```bash
lib/
├── models/ # Data models (Product, Order, etc.)
├── blocs/ # BLoC logic for each feature
├── services/ # API layer for Supabase communication
├── screens/ # UI for each page/view
├── widgets/ # Reusable UI components
└── main.dart
```


### 🚀 Getting Started Locally

#### Prerequisites
-   Flutter SDK >= 3.x
-   A configured Supabase project (shared with the admin panel)

#### Steps
1.  **Clone the repository:**
    ```bash
    git clone https://github.com/AmeyPacharkar1896/bookstore-app-flutter.git
    cd bookstore-app-flutter
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Set up environment variables:**
    Create a `.env` file in the root directory and add your Supabase credentials:
    ```
    SUPABASE_URL=YOUR_SUPABASE_URL
    SUPABASE_ANON_KEY=YOUR_SUPABASE_KEY
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```
</details>

---