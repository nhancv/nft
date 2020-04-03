# nft
Flutter Template

## Structure

```
                                                     
     main.dart                                       
         |                                           
 +-------|------+                                    
 |     login     |                                    
 +--------------+                                    
 - Login with fake api                                    
         |                                           
 +-------|------+                                    
 |     home     |                                    
 +--------------+                                    
 - Show repo info                                    
 - Navigate to search screen                         
         |                                           
         |                                           
 +-------|------+                                    
 |    search    |                                    
 +--------------+                                    
 - Search github user                                
 - Show a list of user                               
 - Tap on specific user and navigate to detail screen
         |                                           
         |                                           
 +-------|------+                                    
 |    detail    |                                    
 +--------------+                                    
 - Show detail of github user                        

```

## Update app icon

```
flutter pub get
flutter pub run flutter_launcher_icons:main
```

## Clone initial setup

- Search and Replace All `nft` to new package id
- Search and Replace All `NFT App` to new App display name
- Search and Replace All `com.app.nft` to new App bundle id
- Update directory folder path name of Android (`android/app/src/main/kotlin/`) same with new App bundle id
