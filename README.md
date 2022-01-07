# HappySnapp

[HappySnapp](https://happysnapp.netlify.app/) is an iOS app built with SwiftUI for iOS 14. I used a number of resources, including courses, blogs and Stack Overflow, to teach myself a number of languages (primarily SwiftUI) to build my vision of a simple app to make people happy. The whole point of the app was to provide a simple experience to block out the chaos of the world and put a smile on your face. Unfortunately, the AppStore insisted that more functionality be added which defeated the purpose of my initial vision - alas, it remains a shelved product but a great learning experience.

## Preview

<p align="middle">
  <img src="https://i.ibb.co/P6ZsxNs/screenshot1.jpg" width="250"/>
  <img src="https://i.ibb.co/RH6bdqY/screenshot2.jpg" width="250"/>
  <img src="https://i.ibb.co/WWSbZ0t/screenshot3.jpg" width="250"/>
  <img src="https://i.ibb.co/2gnhPdW/screenshot4.jpg" width="250"/>
  <img src="https://i.ibb.co/FV4KY19/screenshot5.jpg" width="250"/>
  <img src="https://i.ibb.co/KKq83P5/screenshot6.jpg" width="250"/>
</p>

## Optimisations

* Built for iOS 14
* Optimised for all screen sizes, in addition to iPad (some special tweaks required)

## Cool Functionality and Build

### Design

* App design was done by me - assets were either purchased or use within free commercial license

### Onboarding

* Custom load screen while app loads
* Onboarding screen for first time use
* * Swipe through for instructions on how to use the app
* * Required user data collection 'accept' or 'decline' option at first use
* * Option through menu to toggle data collection choice and restart onboarding sequence
* Menu links to landing page, privacy, terms and Pexels licence

### Security & Privacy

* API keys excluded with .gitignore
* User data secured and encrypted with Firebase
* Anonymous account and Apple ID sign in for passwordless access

### Content

* Used [Pexels](https://www.pexels.com/) images for the app. They have a free license, but the website doesn't allow direct links to the API.
* * Solution: Built a program to run manual queries and fetch batches of images from the API. Cached images locally before program uploaded to a custom Firebase Firestore.
* Google AdMob used to insert interstitial and banner ads on two separate screens of app
* * Standard test links for ads included in code

### Account Setup

* Firebase was used to set up the initial database and also to store basic encrypted user data. When users access the app for the first time, Firebase instantly crates an anonymous account linked to their device. This allows users to have an account without needing to set up an account right away. User preferences and favourites lists for images are saved to their account.
* If at a future date the user wishes to sign in with Apple, they can do so with a few easy clicks and Face ID. The user can then access their account from any Apple device.

### The Small Things

* Different display for dark vs. light mode
* Ability to share photos via local apps (i.e. iMessage, WhatsApp, social media, etc...) and save locally
* * Share/save screen popup on iPad small in centre
* Metadata from photos displayed on images when saved to favourites to include artist name
* Slider to resize images for quick scrolling

## Download and Install

The product is no longer available for TestFlight download, but I am happy to provide a demo.