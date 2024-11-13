# Waller 

**Waller** is a SwiftUI-based wallpaper downloading app that leverages **SwiftData** for data persistence and **AppStorage** for user settings. This app fetches beautiful, high-quality photos from the **Pexels API**, and allows users to search, view, download, like, and share wallpapers. It also offers a Favorites section where users can save their favorite images.

---

## Features

- **Getting Started Page**: Welcomes the user.
- **Home Page**: Displays a feed of images fetched from the Pexels API with a search bar for users to find photos related to specific topics like nature, animals, landscapes, etc.
- **Favorites Tab**: Allows users to save their liked photos. These are stored persistently using **SwiftData** and can be accessed even after the app is closed and reopened.
- **Photo View**: Clicking on a photo opens it in a larger view with options to:
  - Download the photo
  - Like the photo (saved to favorites)
  - Share the photo via standard sharing options
- **Search Functionality**: The search bar allows users to look for photos based on keywords like "nature", "birds", etc.

---

## Screenshots

Here are some screenshots of the app:
![1](https://github.com/user-attachments/assets/a42651b7-e490-4249-8597-0e83a6debfe6)

![2](https://github.com/user-attachments/assets/40b368c2-05cb-4655-93d7-96c0d8aae1b9)

---

## Installation & Setup Guide

Follow these steps to set up and run **Waller** on your local machine:

### Prerequisites

Make sure you have the following installed:

- **Xcode** (latest version)
- A **Pexels API key** (You can get it [here](https://www.pexels.com/api/)).

### Steps to Install

1. **Clone the Repository**
   Open a terminal window and run the following command to clone the repository to your local machine:
   ```bash
   git clone https://github.com/Reshamhere/Waller.git
   ```

2. **Open the Project**
   Navigate to the project directory:
   ```bash
   cd Waller
   ```
   Open the project in **Xcode**:
   ```bash
   open Waller.xcodeproj
   ```

3. **Set Up the Pexels API**
   - Create an account on [Pexels](https://www.pexels.com/) if you don’t have one.
   - Get your **API key** from the Pexels website.
   - In Xcode, open the file where the API key is required and paste the key in the appropriate place.

4. **Run the App**
   - Select a simulator or a connected device in Xcode.
   - Hit the **Run** button or press `Cmd + R` to build and run the app.

The app should now launch and you can begin using it to search for wallpapers, like images, and add them to your Favorites!

---

## Technologies Used

- **SwiftUI**: Used to build the user interface with declarative views.
- **SwiftData**: Employed for persisting liked photos in a local database.
- **AppStorage**: Utilized for storing user preferences and settings.
- **Pexels API**: Integrated to fetch high-quality wallpapers and photos based on search queries.

---

## Key Learnings

Throughout the development of **Waller**, I’ve gained a wealth of knowledge and honed my skills in the following areas:

1. **Fetching Data from an API**: I learned how to interact with an API (Pexels in this case) to fetch and display images dynamically within the app.
2. **Working with SwiftData**: I gained hands-on experience with **SwiftData** to store, manage, and fetch the user's liked photos, ensuring data persistence even after app restarts.
3. **AppStorage for Settings**: Implementing **AppStorage** helped me learn how to store simple user preferences locally, such as favorite photos or app settings.
4. **Dynamic UI with SwiftUI**: This project helped me deepen my understanding of **SwiftUI**'s declarative syntax, and how to use it to create responsive, dynamic interfaces, such as the interactive photo viewer.
5. **Search Functionality**: I learned how to integrate search functionality that dynamically updates the UI based on the user's input and fetches related images from the API.
6. **Sharing Options**: Implementing the photo sharing feature gave me insight into how to utilize **iOS sharing APIs** to let users share content via different platforms.

Overall, this project has been a tremendous learning experience, improving my knowledge of SwiftUI, networking, and data storage, while allowing me to apply these concepts in a practical, real-world project.

---

## Future Improvements

While this app is fully functional, I plan to enhance it with the following features in the future:

- Implement more advanced search filters for photo categories.
- Add user authentication to allow users to save their favorites across devices.
- Enhance the UI/UX for a smoother, more polished experience.

---

*Note: This project is an original work created by me, and the source code is provided as part of my portfolio.*

