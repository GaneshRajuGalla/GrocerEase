
# GrocerEase

## Overview

GrocerEase is a standard grocery purchase app designed to make your grocery shopping experience easier and more convenient. This README provides an overview of the project's features and the technologies used to build it.

## Features Highlights

### Stiffed Launching Screen
- The app features a sleek and visually appealing launch screen that welcomes users with an elegant design when they start the app.

### Customized TabBar
- GrocerEase offers a user-friendly customized TabBar that allows users to navigate through different categories of food items effortlessly.

### Stripe Integration
- We've integrated Stripe for seamless and secure payment processing during checkout, ensuring a safe and reliable payment experience.

### Persistence Data Using Latest SwiftData
- All your data is locally stored using the latest SwiftData, which allows the app to work smoothly, even when the internet is unavailable. You can access your favorite items, cart contents, and more without needing an internet connection.

## Tech Stack

- Xcode 15.1
- macOS Ventura 13.5.2
- iOS 17
- Swift 5.9
- SwiftUI
- Swift Data
- Stripe ThirdParty

## Architecture

- GrocerEase follows the MVVM (Model-View-ViewModel) architecture, ensuring a clean and maintainable codebase.

## Customizations

- Custom URLSession Network Layer: We've implemented a custom URLSession network layer inspired by Moya for efficient and clean network requests.

- Custom NavigationStack: The app features a custom navigation stack for enhanced navigation and user experience.

## Getting Started

To get started with GrocerEase, follow these simple steps:

1. Clone the project from the provided GitHub repository.

2. Open the project in Xcode.

3. Build and run the app on your iOS device or simulator.

## Stripe

- For payment and checkout functionality, GrocerEase relies on a Stripe. 

## Data Storage

- All your data is stored locally on your device. In case the internet is unavailable, the app will load data from the local database. This ensures a seamless user experience even in offline mode.

## Demo

To see GrocerEase in action, check out our demo video: [Demo Video Link](https://drive.google.com/drive/folders/1yeeI18U0cGxDnRgJj4TqvPDNmwPfmn5d?usp=sharing).

## Support and Contact

If you have any questions or need assistance, please reach out to us at ganeshrajugalla@gmail.com.

I hope you enjoy using GrocerEase and find it a valuable addition to your grocery shopping routine. Happy shopping!


## App SnapShots
| Launch | Welcome | Categories |
| -- | -- | -- |
| ![Launch](GrocerEase/Media/Launch.png) | ![Welcome](GrocerEase/Media/Welcome.png) | ![Categories](GrocerEase/Media/Categories.png) 
| SubCategories | Item Detail | Cart |
| -- | -- | -- |
| ![SubCategories](GrocerEase/Media/SubCategory.png) | ![Item Detail](GrocerEase/Media/Detail.png) | ![Payment](GrocerEase/Media/PaymentConfirmation.png)
| Card Details | Stripe | Profile |
| -- | -- | -- |
| ![Card Details](GrocerEase/Media/CardDetails.png)  |  ![Stripe](GrocerEase/Media/Stripe.png) | ![Profile](GrocerEase/Media/Profile.png) 



