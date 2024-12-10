# Notes

Notes is a simple note taking application created using Swift/UIKit that utilizes an SQLLite DB for data persistence and CRUD operations. The DB is saved in the local filesystem of the physical device.

Alamofire is used to perform a network call that fetches the current time from a server based on the ip address of the physical device.

## Table of Contents

- [Screens](#screens)
- [Data Models](#data-models)
- [Design Philosophy](#design-philosophy)
- [Getting Started](#getting-started)
- [Created By](#created-by)


## App Overview

### Screens

1. **Home**
   - Lists all the notes created by the user in a list that filters sections by note category.
   - List cells have swipe mechanism implemented for editing and deleting of notes.

2. **Navigation Drawer**
   - Navigation to add a new note.

3. **Add Note**
   - Shows all note attributes for the user to input and create or update.
   - Basic validation is implemented to DISALLOW insertion of notes with an empty titile or body.
   - Current time is fetched from a server to update the date of creation or update after submission.
   - The note is persisted in an SQLLite DB after submission.

### Data Models

The app code includes data models for the following:

- **Note:** Represents the note attributes (title, body, category, created_at, updated_at).
- **ServerTime:** Used for decoding the json response for fetching the time from a server.

### Design Philosophy

- **Clean Code:** The app is built with clean coding principles to ensure a maintainable and scalable codebase.
- **Archetectural Design Pattern** The app was created using an MVVM design pattern.

## Getting Started

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/amer266030/NotesUIKit.git
    ```

2. Install packages if required and adjust deployment settings if required.

3. Run the app.


## Created By

- **Amer Alyusuf**
- [Personal Website](https://amer266030.github.io)
- [LinkedIn](https://www.linkedin.com/in/amer-alyusuf)