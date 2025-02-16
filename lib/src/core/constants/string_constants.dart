import '../app_state/app_state.dart';

///Created typedef for Map <String, dynamic> (JSON File Type)
typedef JsonPayLoad = Map<String, dynamic>;

/// Global variable for AppState class
AppState appState = AppState();

/// StringConstants contains all constant string used in app.
class StringConstants {
  static const appName = 'InnCircles';
  static const developerName = 'Meet Shah';
  static const by = 'by';
  static const home = 'Home';
  static const save = 'Save';
  static const welcome = 'Welcome!';
  static const cancel = 'Cancel';
  static const yes = 'Yes';
  static const no = 'No';
  static const ok = 'Ok';
  static const getStarted = 'Get Started';
  static const addACategory = 'Add a category';
  static const noSubscriptions = 'No Subscriptions';
  static const enterAName = 'Enter a name';
  static const selectSubscription = 'Select subscriptions';
  static const copiedToClipBoard = 'Copied to Clipboard!';
  static const manageAllYourSub = 'Manage all your subscriptions';
  static const keppRegularExpenses = 'Keep regular expenses on hand and receive timely notifications of upcoming fees';

  //Error
  static const requestTimedOut = 'Request timed out';
  static const serverError = 'Server error';
  static const connectTimedOut = 'Connect timed out';
  static const pleaseTryAgain = 'Please try again.';
  static const somethingWentWrong = 'Something Went Wrong';
  static const pleaseCheckInternet = 'Please Check Internet';
  static const internetConnectionLost = 'Internet connection lost. Please retry';
  static const errorMessage = 'Authentication failed, Please contact to admin for onBoarding!';
}
