# zhtest
A practical test, writing in swift, UI was programatically developed with UIKIT. 
## Set up
To set up this project follow the following steps.
* Clone project to your local machine
* Navigate (cd) into the cloned project
* Run `pod install`
* Open `ZuriHealthtest.xcworkspace`
## Architecture
This test was completed following `MVVM` architecture, and changeds are notified through `delegation` and `protocols`, also the navigation responsibility
is handled by `coordinator`.
## Libraries used
* Alamofire: I used alamofire for network calls, I chose this due tom its flexibility and because its well accepted in the industry, I believe as an engineer, 
I should think about the next person who is to maintain my codes.
* KingFisher: this was used for downloading network images.
* TTGSnackBar: this was used to show a snackbar message when ever an event is completed.
## Unit test.
I added unit test for the view model and the network service.
<p float="left">
<img width="30%" height="50%" alt="Screenshot 2022-07-18 at 00 04 04" src="https://user-images.githubusercontent.com/39584544/179428538-0bb41c58-1669-4ca2-96b2-8c176862ab35.png">
<img width="30%" height="50%"alt="Screenshot 2022-07-18 at 00 04 15" src="https://user-images.githubusercontent.com/39584544/179428545-f3a32f6f-7317-4796-90b8-5d84dc6f2b21.png">
</p>
