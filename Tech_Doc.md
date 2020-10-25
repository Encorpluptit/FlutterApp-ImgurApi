# Technical Documentation

## Requirements:


 - Language:    [Flutter](https://flutter.dev/docs/get-started/install)
 - Emulator:    [Android Studio](https://developer.android.com/studio?gclid=Cj0KCQjwxNT8BRD9ARIsAJ8S5xaah9VVQqGA1Hj8V5QDa4-ykJb2rP-aN2PHyN20IQHqJ3Gd6Txk_HIaAlCcEALw_wcB&gclsrc=aw.ds) or [XCode](https://developer.apple.com/xcode/)
 - IDE:         [VSCODE](https://code.visualstudio.com/), [IntelliJ](https://www.jetbrains.com/idea/) or [Android Studio](https://developer.android.com/studio?gclid=Cj0KCQjwxNT8BRD9ARIsAJ8S5xaah9VVQqGA1Hj8V5QDa4-ykJb2rP-aN2PHyN20IQHqJ3Gd6Txk_HIaAlCcEALw_wcB&gclsrc=aw.ds)
 
## Install
  - Follow Flutter install instruction (run ```flutter doctor``` and ```flutter doctor --android-licenses``` to accept android licenses)
  - Clone the repository get into app_epicture_gregoire.
  - Open Emulator and run command ```flutter run```

## Architecture
 - lib Folder
    - 
      - main
        - 
          Entry point for the Application.
          
          StateFul Widget { MyApp } that display a button to Imgur OAuth2 Webview.
          
          Redirect to [Home](#home) if user is connected.
          
      - Home
        - 
          List all hot tendencies from Imgur.
          
          StateFul Widget { Home } that get a list of [ImgurGallery](#imgurgaleryobject).
          
          Display a button to fetch more if the user get to the end of the list.
          
      - HomeCard
        - 
          Card to display [ImgurGallery](#imgurgalleryobject) from [Home](#home).
          
          You can Like a picture and Upvote/Downvote a gallery.
          
      - Global
        - 
          lol
      - Heart
        - 
          lol
      - Account
        - 
          lol
          
          a
          
      - AddPost
        - 
          lol
      - Bottom Navigation
        - 
          lol
      - Favorites
        - 
          lol
      - Image Dialog
        - 
          Stateless Widget to display an Alert Dialog in [Account](#account).
          
      - ImgurAccountObject
        - 
          lol
      - ImgurGalleryObject
        - 
          Stateless Widget to control Imgur Galleries.
          
          fromJson(): method to parse Api Json Response into an object.
          
          getPersonalImages: API Call to get Personal Images.
          
          getFavoriteImages: API Call to get PersonalFavorites Images.
          
      - ImgurImageObject
        - 
          Stateless Widget to control Imgur Image.
          
          fromJson(): method to parse Api Json Response into an object.
          
          favImage: API Call to favorite an image.
          
      - Profile
        - 
          Display User information (Username, Bio) and summary of stats based on personal datas (Likes, fav, views)
          
          
      - Search
        - 
          lol

 - android Folder
    -
    Sources files for Android Build.

 - ios Folder
    -
    Sources files for Iphone Build.

 - test Folder
    -
    Sources files for flutter tests.

## Commits
 - Follow the [Conventional Commit](https://www.conventionalcommits.org/en/v1.0.0/) specification 