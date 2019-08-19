# BrewDogApp

BrewDogApp is a beer recomendation iOS-client powered by RxSwift and RxCocoa with:

  - MVP Clean architecture
  - [Assembly + DI](https://github.com/LosZigerianos/JourTrip/blob/master/Documentation/Architecture.md)
  - Unit Tests
  - Swift 5
  - Realm database
  
### Dependency manager

* [Cocoa Pods](https://cocoapods.org/) 

### Frameworks

* [RxSwift](https://github.com/ReactiveX/RxSwift) - ReactiveX programming
* [SwiftLint](https://github.com/realm/SwiftLint) - Swift style and conventions
* [Realm](https://github.com/realm/realm-cocoa) - Mobile persistence database
* [Kingfisher](https://github.com/onevcat/Kingfisher) - Swift library for downloading and caching images from the web

### Api

* [Punk Api](https://punkapi.com/documentation/v2)  

### Installation

BrewDog app  needs XCode 10.2.1 or greater

```sh

$ pod install
$ open BrewDogApp.xcworkspace

```

## Exercise things done!

- Rest api rx connection

- Sorting beers by abv and with all the information: beerName, image, etc

- Search results online done. Checking first on disk and then in the webService  

## To do

- Reverse abv sorting

## Nice to have
* [Reachability](https://github.com/tonymillion/Reachability) - Reachability (the swift version seems to not work with the simulator)
