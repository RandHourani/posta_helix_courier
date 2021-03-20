import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreensBloc {
  var _screen = BehaviorSubject<String>();

  Observable<String> get screen => _screen.stream;

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('last_screen');
    if (stringValue == null) {
      _screen.add('/');
    } else {
      _screen.add(stringValue);
    }
  }

  getScreen() {
    return _screen.value;
  }
}

final screensBloc = ScreensBloc();
