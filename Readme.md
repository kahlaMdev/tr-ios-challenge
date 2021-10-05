# The challenge
Fork this repo and keep your fork public until we have been able to review it. This challenge is meant to take 2-4 hours to complete.

Implement a simple browser of a movie library. The list of movies is available in JSON format and has examples below in the API section. On tap on a cell open a details page and present details from response of `details/{id}` and `details/recommended/{id}`. Examples of the URLs are in API section below. Use Swift 5.0 for the solution.

There's absolutely no expectation of pixel perfection, so feel free to use the mocks below as a guidance rather than a final design.

Feel free to use any 3rd-party libraries of your choice, but don't overuse and be ready to justify the reason you picked them.


# Mocks
### List example

<img src="./List.png" width="300">

### Details example

<img src="./Details.png" width="300">

# API

### List 
`https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/list.json` to get the list

### Details
Construct the URL using the template `https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/details/{id}.json`, 

i.e. https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/details/1.json

### Recommended

Construct the URL using the template `https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/details/recommended/{id}.json`,

i.e. https://raw.githubusercontent.com/TradeRev/tr-ios-challenge/master/details/recommended/1.json

# Evaluation

Required:
- Solution compiles. If there are necessary steps required to get it to compile, those should be covered in README.md.
- No crashes, bugs, compiler warnings
- Conforms to SOLID principles
- Code is easily understood and communicative
- Commit history is consistent, easy to follow and understand

Nice to have (not required):
- Unit Tests
- Caching

# Developement and Design
- Used xCode 12.4 
- Swift 5

- Architecture: MVVM swift POP (protocol oriented programming)
- Dependency Injection 
- Design
    1.    Main View = UINavigation controller --> Root View Controller is UIViewController with a UITableView of Movies List Cells 
    2.    Movie Details View controller: UIViewController with 2 child controllers
    a.    Child 1 : UIViewController with UIScrollView with movie details
    b.    Child 2: UICollection View of "Recommended Movies"
    3.    Network datasource downloader
    4.    Used Core Data to save/cache movies datas. 
    5.    View Models Class uses data Box Binding (Box Class) to bind data in View Controllers 
    6.    Models data are saved in Movie class as an NSManagedObject in Core Data
    7.    Implemented error checking for Network and data parsing 
    8.    Testing for Movie Data and Model Views classes. 
    9.    The HTTPClient uses cachePolicy: .reloadRevalidatingCacheData
    10.    LibrairyAPI Class is singleton. A Face pattern for downloading data from server and from Core Data
    11.    The MovieDetailViewController's View contains a UIScroll View to scroll the movie details. 
    12.    Core Data methods expect to be run on the same thread. Used the DispatchQueue on the main thread.

- No compiler warning and errors 
- Run Instruments tool for memory leak detection and performance success 
- All Unit tests passes
- Manually Tested the application in iPhone 11's Simulator (iOS Version 14.4)
- Tested with no Internet connection and display an error message on startup!
- Tested in Portrait and Landscape mode 

What can be done farther? 

# Optimization
- Handle very big movie list by only requesting the first chunk like 30 movies at a time. When the tableView scrolls up to the bottom we fetch the next chunk and so on. 
This will speed the display for very big data list to display as they are only fetched on demand
- 
- Display a visual indicator (like an activity indicator View or an animated Text) while the app is downloading data so to inform the user and the overall UX experience is better.  
- Adding more tests (Edge case like very big data lists and unsupported Images (format or size)) 
- Supporting Dynamic Font Sizing
- Supporting deleting from the list 
- Supporting rating display and Vote. 
- Supporting Movie search (Core Data might be a good help for This using relation ships and predicates)
- Text Localization
- Supporting dark mode
- icons and starting Splashs are easy to add in asset catalog 
- Handle memory/storage warning (Limited resources) 
