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
          Class to control API Call Core.

          fetchToken(): fetch User's token.
          
          getMyAccount(): get User's Account and parse it from Imgur Response.
                    
          getPersonalImages: API Call to get Personal Images.
          
          getFavoriteImages: API Call to get PersonalFavorites Images.
          
      - Heart
        - 
          StatefulWidget that manage the heart of the application.
          
          Manage state of the application bar.
          
      - Account
        - 
          Display User information (Username, Bio) and summary of stats based on personal datas (Likes, fav, views)
          
          Display a list of the user Images and can be zoomed in with [Image Dialog](#image-dialog)
                    
      - AddPost
        - 
          Stateful Widget to manage Upload to Imgur Image.
          
          _imgFromCamera(): get an image from Camera.
          
          _imgFromGallery(): get an image from Gallery.
          
      - Bottom Navigation
        - 
          Stateless Widget to control Application Bottom Bar.
          
          Display icons and use function from [Heart](#heart) to move between application menus.
          
      - Favorites
        - 
          Stateful Widget to control Application Bottom Bar.
          
          Favorites: Display a list of FavoriteImage.
          
          FavoriteImage: Display each image and spawn a dialog when cliked on it.
          
      - Image Dialog
        - 
          Stateless Widget to display an Alert Dialog in [Account](#account).
          
      - ImgurAccountObject
        - 
          Stateless Widget to control Imgur Account.

          fromJson(): method to parse Api Json Response into an object.
                    
          getPersonalImages(): API Call to get Personal Images.
          
          getFavoriteImages(): API Call to get PersonalFavorites Images.
          
      - ImgurGalleryObject
        - 
          Stateless Widget to control Imgur Galleries.
          
          favGallery(): Favorite a gallery.
          
          upvote(): upvote a gallery.
          
          downvote(): downvote a gallery.
          
          setVote(): manage votes.
          
      - ImgurImageObject
        - 
          Stateless Widget to control Imgur Image.
          
          fromJson(): method to parse Api Json Response into an object.
          
          favImage(): API Call to favorite an image.
          
      - Search
        - 
          Search an image with a text search and get from [Account](#account)

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