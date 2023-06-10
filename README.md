# # Jokemania

Jokemania is a mobile application that fetches and displays random jokes from an open API. It provides a simple and entertaining way to enjoy a good laugh.

## Features

- Fetches a random joke every minute from the API
- Displays jokes in a scrollable list
- Limits the number of jokes to 10, replacing old jokes with new ones
- Persists the jokes using Core Data, allowing the user to view previous jokes upon login
- Interactive UI with colorful and aesthetically pleasing design
- Animated header with a catchy title

## Technologies Used

- Swift programming language
- Model-View-ViewModel (MVVM) architectural pattern
- Core Data for data persistence
- Networking using URLSession
- Auto Layout for UI layout and constraints

## Getting Started

These instructions will help you get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Xcode 14.0 or later
- Swift 5.0 or later

### Installation

1. Clone the repository to your local machine using the following command:

git clone https://github.com/abdul3051/JokeMania.git


2. Open the project in Xcode by double-clicking the `Jokemania.xcodeproj` file.

3. Build and run the project in the Xcode simulator or on a physical device.

## Usage

- Upon launching the app, jokes will start appearing in the scrollable list.
- The list will display a maximum of 10 jokes, with new jokes replacing old ones.
- The header at the top of the screen shows the title "Jokes of the Day" in colorful and animating text.
- The bell icon in the header indicates the presence of new jokes. It will change color when a new joke is added.
- Tapping the bell icon will scroll the list to the newly added joke, highlighting it with a subtle animation.
- Previous jokes will be displayed upon logging in again.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Jokes API provided by [https://geek-jokes.sameerkumar.website/api](https://geek-jokes.sameerkumar.website/api)
