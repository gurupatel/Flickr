# 📸 Flickr Image Viewer

A simple iOS app that fetches and displays images from Flickr's public feed. Built with Swift and UIKit.

## 🚀 Features

- **Fetch Images:** Retrieves images from Flickr's public feed API.
- **Custom UICollectionView Layout:** Displays images in a clean grid layout.
- **Image Caching:** Caches images to improve performance and avoid repeated downloads.
- **Error Handling:** Graceful handling of network or decoding errors.

## 🛠️ Technologies Used

- Swift
- UIKit
- URLSession
- NSCache
- JSON Decoding

## 📂 Folder Structure

```
Flickr
│
├── 📁 Model
│   └── FlickrPhoto.swift
│
├── 📁 View
│   └── ImageCell.swift
│
├── 📁 Controller
│   └── FlickrImageViewController.swift
│
└── 📁 Service
    └── FlickrAPIService.swift
```

## 📝 Setup

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/FlickrImageViewer.git
    ```

2. Open the project in Xcode.

3. Run the project on the simulator or your device.

## 🛠 Configuration

No API key is required — it uses Flickr's public feed.

## 🧠 Future Enhancements

- Search functionality
- Pagination
- Save favorite images
- Improved error handling (e.g., retries, alerts)

## 💡 Acknowledgments

- Flickr Public API for free access to images
- UIKit for smooth UI components

## 👨‍💻 Author

**Gaurang Patel**  
Feel free to reach out for collaborations or suggestions!

---

Happy coding! 🚀✨
