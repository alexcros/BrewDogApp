# BrewDogApp

BrewDogApp is a beer recomendation iOS-client powered by RxSwift and RxCocoa with:

  - MVP Clean architecture
  - [Assembly + DI](https://github.com/LosZigerianos/JourTrip/blob/master/Documentation/Architecture.md)
  - Unit Tests
  - Swift 5: POO + POP
  - Realm database
  
## Architecture: Model View Presenter
  
  ![MVP Clean architecture](https://github.com/alexcros/BrewDogApp/blob/master/architecture-image.png)
  
### MVP + Assembly + DI

This easy arquitecture is similar to MVVM and is very testable, configurable, scalable, easy to maintain and follows the SOLID principles

The most easy way to solve the complexity is to divide the responsabilities in many entities (divide and conquer)

DI is the most important thing. Helps code testability

### Clean Architecture

All classes are configurable

#### View / ViewController

The same life cycle of the presenter

#### Presenter 

Presenter is responsible of present information in the screen, communicate to view and show info and takes input from view for make a decision 

Life cycle linked to the object of his dependency

No business logic class

#### Navigator

Separate navigation from the rest of the code. It's fine to configure 2 navigations: iPhone and iPad

#### Repository

Internal/external cache Datasource 

Object that belongs alive throughout the life cycle of the app (singleton lazy)

#### Assembly

Tool class to empower DI

* Inject new instance objects
* Singleton, for all object graphs throughout the app (in memory from starts until quit)
* Fresh objects created in every injection

#### Network / DB

#### Model
  
### Dependency manager

* [Cocoa Pods](https://cocoapods.org/) - Easy and fast set-up dependency manager. Recommended for small projects

### Frameworks

* [RxSwift](https://github.com/ReactiveX/RxSwift) - ReactiveX: Observer-oriented development / functional development
* [SwiftLint](https://github.com/realm/SwiftLint) - Swift style and conventions. Take care of quality code rules
* [Kingfisher](https://github.com/onevcat/Kingfisher) - Swift library for downloading and caching images from the web

### Realm: Mobile persistence database

* [Realm](https://github.com/realm/realm-cocoa)

Why Realm?

* Faster than CoreData 
* Has easy database encryption
* API simpler
* No context problems anymore
* Updating an object automatically updates all other instances of that object, regardless of thread
* Realm changes persist inmediatelly
* Trivial migrations

But...

* No cascade deletions 

### Api REST

* [Punk Api](https://punkapi.com/documentation/v2)

### Project Installation

BrewDog app needs XCode 10.2.1 or greater (iOS 12)

```sh

$ git clone https://github.com/alexcros/BrewDogApp.git
$ pod install
$ open BrewDogApp.xcworkspace


```

## Exercise things done!

- Rest api rx connection

- Sorting beers by abv and with all the information: beerName, image, etc

- Search results online done. 

- Checking beers first on disk, then if there are no results, calls the webService  

## To do

- Reverse abv sorting

## Improvements

Perform search in background

## Nice to have
* [Reachability](https://github.com/tonymillion/Reachability) - Reachability for internet connection
