import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/r.horani/AndroidStudioProjects/helix_courier_project/helix_courier_project/lib/src/constants/application_colors_value.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:posta_courier/models/calendar.dart';
import 'package:posta_courier/src/blocs/home_blocs/new_vehicle_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/interview_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/personal_details_bloc.dart';
import 'package:posta_courier/src/blocs/signIn_and_createAccount_blocs/vehicle_bloc.dart';
import 'package:posta_courier/src/utils/util.dart';
import 'package:posta_courier/validation/text_field_validation.dart';

enum CalendarViews { dates, months, year }

class CalendarWidget extends StatefulWidget {
  final screen;

  const CalendarWidget({this.screen});

  @override
  _MyAppState createState() => _MyAppState(screen);
}

class _MyAppState extends State<CalendarWidget> {
  final screen;

  DateTime _currentDateTime;
  DateTime _selectedDateTime;
  List<Calendar> _sequentialDates;
  int midYear;
  CalendarViews _currentView = CalendarViews.dates;
  final List<String> _weekDays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  final List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  _MyAppState(this.screen);

  @override
  void initState() {
    super.initState();
    final date = DateTime.now();
    _currentDateTime = DateTime(date.year, date.month);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _getCalendar());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(right: 15, left: 15),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              width: 2000,
              height: 320,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: (_currentView == CalendarViews.dates)
                  ? _datesView()
                  : (_currentView == CalendarViews.months)
                      ? _showMonthsList()
                      : _yearsView(midYear ?? _currentDateTime.year)),
        ],
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 10, right: 5),
          child: InkWell(
            child: Text(
              "Cancel",
              style: TextStyle(
                color: AppColors.labelColor,
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, right: 20, left: 10),
          child: InkWell(
            child: Text(
              "Ok",
              style: TextStyle(
                  color: AppColors.MAIN_COLOR,
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700),
            ),
            onTap: () {
              switch (screen) {
                case "BIRTHDAY_DATE":
                  {personalDetailsBloc
                      .setBirthday(_selectedDateTime.toString());
                    TextFieldValidation()
                        .checkBirthdayValidation(_selectedDateTime);

                  }
                  break;

                case "DRIVER_LICENSE_ISSUE_DATE":
                  {
                    personalDetailsBloc.setLicenseIssueDate(_selectedDateTime.toString());
                  }

                  break;
                case "DRIVER_LICENSE_EXPIRED_DATE":
                  {
                    personalDetailsBloc
                        .setLicenseExpiredOn(_selectedDateTime.toString());
                  }

                  break;
                case "REGISTRATION_EXPIRY_DATE":
                  {
                    vehicleBloc.setRegistrationExpireDate(
                        _selectedDateTime.toString());
                  }

                  break;
                case "REGISTRATION_EXPIRY_DATE_NEW_CAR":
                  {
                    newVehicleBloc.setRegistrationExpireDate(
                        _selectedDateTime.toString());
                  }

                  break;
                case "INTERVIEW_DATE":
                  {
                    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
                    interviewBloc.resetTime();
                    interviewBloc.addInterviewDate(
                        Utils.dateFormat1(_selectedDateTime.toString()));
                    interviewBloc.fetchAllAvailableTime();
                  }

                  break;

                default:
                  {
                    //statements;
                  }
                  break;
              }
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  // dates view
  Widget _datesView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      // mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        // header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // prev month button

            // month and year
            InkWell(
              onTap: () => setState(() => _currentView = CalendarViews.months),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${_monthNames[_currentDateTime.month - 1]}' + ',',
                    style: TextStyle(
                        color: AppColors.labelColor,
                        fontSize: 20,
                        letterSpacing: 1.0,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' ${_currentDateTime.year}',
                      style: TextStyle(
                        color: AppColors.labelColor,
                        fontSize: 17,
                        fontFamily: 'poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Row(
                children: <Widget>[
                  _toggleBtn(false),
                  // next month button
                  _toggleBtn(true),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.black26,
        ),

        Flexible(child: _calendarBody()),
      ],
    );
  }

  // next / prev month buttons
  Widget _toggleBtn(bool next) {
    return InkWell(
      onTap: () {
        if (_currentView == CalendarViews.dates) {
          setState(() => (next) ? _getNextMonth() : _getPrevMonth());
        } else if (_currentView == CalendarViews.year) {
          if (next) {
            midYear =
                (midYear == null) ? _currentDateTime.year + 9 : midYear + 9;
          } else {
            midYear =
                (midYear == null) ? _currentDateTime.year - 9 : midYear - 9;
          }
          setState(() {});
        }
      },
      child: Container(
        alignment: Alignment.centerRight,
        width: 40,
        height: 40,
        child: Icon(
          (next) ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
          color: AppColors.LIGHT_GREY,
          size: 18,
        ),
      ),
    );
  }

  // calendar
  Widget _calendarBody() {
    if (_sequentialDates == null) return Container();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _sequentialDates.length + 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 10,
        crossAxisCount: 7,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        if (index < 7)
          return Padding(
              padding: EdgeInsets.only(left: 7), child: _weekDayTitle(index));
        if (_sequentialDates[index - 7].date == _selectedDateTime)
          return _selector(_sequentialDates[index - 7]);
        return _calendarDates(_sequentialDates[index - 7]);
      },
    );
  }

  // calendar header
  Widget _weekDayTitle(int index) {
    return Text(
      _weekDays[index],
      style: TextStyle(
          color: AppColors.LIGHT_GREY, fontSize: 20, fontFamily: 'Poppins'),
    );
  }

  // calendar element
  Widget _calendarDates(Calendar calendarDate) {
    return InkWell(
      onTap: () {
        if (_selectedDateTime != calendarDate.date) {
          if (calendarDate.nextMonth) {
            _getNextMonth();
          } else if (calendarDate.prevMonth) {
            _getPrevMonth();
          }
          setState(() => _selectedDateTime = calendarDate.date);
        }
      },
      child: Center(
          child: Text(
        '${calendarDate.date.day}',
        style: TextStyle(
            color: (calendarDate.thisMonth)
                ? AppColors.labelColor
                : AppColors.LIGHT_GREY,
            fontSize: 15,
            fontFamily: 'Poppins'),
      )),
    );
  }

  // date selector
  Widget _selector(Calendar calendarDate) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.MAIN_COLOR,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.MAIN_COLOR, width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.black26.withOpacity(0.9),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            '${calendarDate.date.day}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  // get next month calendar
  void _getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    _getCalendar();
  }

  // get previous month calendar
  void _getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    _getCalendar();
  }

  // get calendar for current month
  void _getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
        _currentDateTime.month, _currentDateTime.year,
        startWeekDay: StartWeekDay.monday);
  }

  // show months list
  Widget _showMonthsList() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => setState(() => _currentView = CalendarViews.year),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              '${_currentDateTime.year}',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.black26),
            ),
          ),
        ),
        Divider(
          color: Colors.black26,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _monthNames.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                _currentDateTime = DateTime(_currentDateTime.year, index + 1);
                _getCalendar();
                setState(() => _currentView = CalendarViews.dates);
              },
              title: Center(
                child: Text(
                  _monthNames[index],
                  style: TextStyle(
                      fontSize: 18,
                      color: (index == _currentDateTime.month - 1)
                          ? AppColors.MAIN_COLOR
                          : Colors.black26),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // years list views
  Widget _yearsView(int midYear) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _toggleBtn(false),
            Spacer(),
            _toggleBtn(true),
          ],
        ),
        Expanded(
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                int thisYear;
                if (index < 4) {
                  thisYear = midYear - (4 - index);
                } else if (index > 4) {
                  thisYear = midYear + (index - 4);
                } else {
                  thisYear = midYear;
                }
                return ListTile(
                  onTap: () {
                    _currentDateTime =
                        DateTime(thisYear, _currentDateTime.month);
                    _getCalendar();
                    setState(() => _currentView = CalendarViews.months);
                  },
                  title: Text(
                    '$thisYear',
                    style: TextStyle(
                        fontSize: 18,
                        color: (thisYear == _currentDateTime.year)
                            ? AppColors.MAIN_COLOR
                            : Colors.black26),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
