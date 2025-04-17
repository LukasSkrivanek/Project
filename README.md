# 📚 Book Search App

A simple iOS app built with SwiftUI that allows users to search for books by author and view detailed information. The app uses the Coordinator pattern for navigation and retrieves data from an external API (Google Books API).

---

## 🚀 Features

- **Search books by author**
  - User types an author's name.
  - The app displays a list of books available in Czech by that author.

- **Book details**
  - Tap on a book to view its detailed info including title, description, authors, and more.

---

## 📦 Requirements

- iOS 17+
- Google Books API key
- Swift 6

---

## 🛠️ Setup

### 1. Clone the repository

```bash
git clone https://github.com/LukasSkrivanek/SeznamTask.git
```

## 2. Add API key

1.Create Config File
In the project root directory, create a new file named ```Config.xcconfig```
2.Add API Key
Insert the following content into the file:

```plaintext
API_KEY = YOUR_API_KEY
```
YOUR_API_KEY reflace with real apikey

3. 

- Choose simulator with atleast iOS 17.6 .
(18.4) is buggy with loading api ```https://developer.apple.com/forums/thread/777999```

4. Sources
   
[Dokumentation Google Books API](https://developers.google.com/books/docs/v1/using)

