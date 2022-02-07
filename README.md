# MVVMSkeleton

1. Structure
2. Module components
3. Navigation
4. Environments management



## Structure

* Application - contains app's entry point files(AppDelegate, SceneDelegate), app configurations(dev, stg, prod) and 
  * App entry points (AppDelegate, SceneDelegate)
  * AppContainer - container/builder for app services
  * App configuraion
    * Environment type (dev, stg, prod)
    * Constants (special keys/identifiers)
* BusinessLogic
  * Models - response, database, domain entities
  * Services - Independent services and managers
  * Coordinators - app navigation control services
* Core
  * Base - Base classes for app's modules
  * Extensions - Extensions for Foundation, UIKit, Combine, other classes/structs
  * Helpers - Independent and reusable tools
  * Views - Reusable views(which can be used twice or more times)
* Presentation - all modules in the app (can be grouped by flow)
* Resources - assets, colors, fonts, strings resources

<img width="370" alt="Screenshot 2022-02-07 at 21 44 31" src="https://user-images.githubusercontent.com/34213871/152874448-fcfc9ae8-434c-4e1d-af9a-95bbc4f95b25.png">



## Module Components

Each module has 4 main components(can be more if you need to split giant logic in some of them):
  * View
  * ViewController
  * ViewModel
  * Builder

Which are connected with controller though the bindings. In this case case controller acts as a connector between View and ViewModel.

<img width="1290" alt="Screenshot 2022-02-07 at 23 53 03" src="https://user-images.githubusercontent.com/34213871/152878435-a65d9d6a-6033-4f5e-934e-9b5ffb2b65bf.png">



### View

- View is independent component. 
- Each View has its own action publisher where you should notify subscribers(ex. ViewController) about user interaction inside its view.
- Action enum, publisher and subject will be generated automatically with providing template.
- (Optional) I prefer building UI from the code, but you can use Xib with IB.

<img width="634" alt="Screenshot 2022-02-08 at 00 04 53" src="https://user-images.githubusercontent.com/34213871/152879970-a4f79633-96c6-4837-95e5-cc2207d6aaec.png">



### ViewModel

- ViewModel is independent component. 
- Each ViewModel has its own transition publisher where you should notify subscribers(ex. Coordinator) when you should go forward or backward in your flow.
- If ViewModel need some services or parameters, the should be injected through the initializer.
- Transion publisher and subject will be generated automatically with providing template.
- (Optional) I prefer storing temporary data in ViewModel directly, but you can create Model component and move it there.

<img width="661" alt="Screenshot 2022-02-08 at 00 12 30" src="https://user-images.githubusercontent.com/34213871/152880972-0f6b6f14-4fcd-4fbd-b6dd-e5b13046ef59.png">



### ViewController

- ViewController holds strong reference to View and ViewModel(BaseViewController contains ViewModel property as a generic type of "ViewModel").
- ViewController listen to View's action publisher and pass it to ViewModel.
- ViewController listen to ViewModel publishers and pass its data to View or interact by itself on its signals.

<img width="597" alt="Screenshot 2022-02-08 at 00 22 45" src="https://user-images.githubusercontent.com/34213871/152882214-f7196fb3-8c22-48c5-ae09-0cff55827e88.png">



### Builder

- Builder constructs a Module
- It creates needed components with injecting needed services and parameters and wrap it into "Module" type - which is just container with 2 generic types(controller and transition, image below)
- Builder also generates automatically with included template

<img width="709" alt="Screenshot 2022-02-08 at 00 29 00" src="https://user-images.githubusercontent.com/34213871/152883005-8371d794-3b2c-4b5b-9cf0-2d2a5193ee3e.png">
<img width="398" alt="Screenshot 2022-02-08 at 00 29 42" src="https://user-images.githubusercontent.com/34213871/152883103-ef00498f-16dd-43d3-a0bb-a05ccf4f0d74.png">


## Navigation

<img width="1049" alt="Screenshot 2022-02-08 at 00 38 13" src="https://user-images.githubusercontent.com/34213871/152884095-2a22a251-2d40-462e-a8a6-cb048b552c0f.png">

- When app starts it builds an App Coordinator and starts one of the flows(run child coordinator)
- When its flow(child coordinator) will send finish signal througn the "didFinishPublisher", parent coordinator can move its own flow or run another coordinator.
<img width="950" alt="Screenshot 2022-02-08 at 00 46 31" src="https://user-images.githubusercontent.com/34213871/152885072-1110db4a-ceb2-459a-bcbb-d148f494b9f2.png">

- Each coordinator initializes with UINavigationController and AppContainer and has "start" method 
- "start" method build first(root) module for its coordinator
- Each methods in the coordinator should create a module(using Builder) pass container and other parameters if needed into it, subscribe to its transition publisher for running next modules or finishing the flow

<img width="672" alt="Screenshot 2022-02-08 at 00 45 30" src="https://user-images.githubusercontent.com/34213871/152884968-c29aae31-4a1c-4763-af69-3b28b544767e.png">



## Environment management



- Application folder contains xcconfig files for managing different environments(contains type of environment, app name and bundleId)

<img width="798" alt="Screenshot 2022-02-08 at 01 03 17" src="https://user-images.githubusercontent.com/34213871/152886939-1a4537f5-bb43-4f96-abe5-b80dfddc167a.png">



- When AppConfiguration initializes it retrives environment type and other info from Info.plist by key

<img width="823" alt="Screenshot 2022-02-08 at 01 00 41" src="https://user-images.githubusercontent.com/34213871/152886822-4b520a0d-36de-487e-b1c1-9ba6e0048ac7.png">
<img width="853" alt="Screenshot 2022-02-08 at 00 55 50" src="https://user-images.githubusercontent.com/34213871/152886126-a4f08078-c890-4661-93fd-8cab780d8b74.png">

- Inside AppEvironment enum you should specify differences between your environments(ex. baseURL, apiToken, ...)

<img width="527" alt="Screenshot 2022-02-08 at 01 06 27" src="https://user-images.githubusercontent.com/34213871/152887485-05b33c02-4f73-4a35-956d-e3e4ae779e8a.png">



- For running app with needed environment type - just select needed scheme

<img width="383" alt="Screenshot 2022-02-08 at 01 09 04" src="https://user-images.githubusercontent.com/34213871/152887654-6b24af58-9f39-4b70-8f00-3e711b28ca2d.png">



