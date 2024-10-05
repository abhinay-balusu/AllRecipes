# AllRecipes

### Steps to Run the App
- Clone the repo, open .xcodeproj and run by selecting a run destination

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

#### Architecture:  
I prioritized this to create a scalable, maintainable, and testable codebase. Used TCA (The Composable Architecture) with SwiftUI which provides a clear separation of concerns, allowing to better handle state, actions and business logic.

#### Asynchronous Data Fetching: 
Safe, efficient data fetching is critical for delivering a smooth user experience. I leveraged async/await for asynchronous operations to write cleaner, more readable code, while avoiding callback hell or unnecessary complexity. I used throws for error handling to ensure proper propagation of errors in a controlled way.

#### Dependency Injection into Repository:
I focused on this to enhance testability and flexibility. By injecting the data-fetching logic into the repository layer, I ensured that the application remains modular and that the core logic can be easily tested or modified without affecting the entire system.

#### Image Fetching and Caching:
I also prioritized optimizing image fetching and caching using the Kingfisher package. Kingfisher provides a lightweight and powerful solution for loading and caching images asynchronously.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
Approx 5 hrs

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
While there were no major trade-offs, one consideration was whether to simplify the architecture by directly using a network manager for data fetching instead of injecting the network logic into a repository. However, I wouldn’t classify this as a significant trade-off because using a repository pattern improves code maintainability, testability, and scalability.

### Weakest Part of the Project: What do you think is the weakest part of your project?
Although I’ve optimized state management with The Composable Architecture, SwiftUI lazy loading, image caching and ensured smooth data fetching, there’s still room for improvement in UI performance, especially for larger datasets. We can use pagination like by sections or numbers per page as an effective, scalable solution which reduces the load on the UI and network 

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?
Yes, I used a couple of external libraries
The Composable Architecture (TCA) for state management and event handling, and
Kingfisher for efficient image downloading and caching

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I would add more UI tests in the future as the app scales but for now, with the simnplicity of the current screen, unit tests should cover most of the cases 
