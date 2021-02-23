///Dart imports
import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart' show DateFormat;

///Package imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///calendar import
import 'package:syncfusion_flutter_calendar/calendar.dart';

///Local import
import '../../model/sample_view.dart';

/// Widget of customization calendar
class CustomizationCalendar extends SampleView {
  /// Creates default customization calendar
  const CustomizationCalendar(Key key) : super(key: key);

  @override
  _CustomizationCalendarState createState() => _CustomizationCalendarState();
}

class _CustomizationCalendarState extends SampleViewState {
  _CustomizationCalendarState();

  List<String> _subjectCollection;
  List<IconData> _iconCollection;
  List<Color> _colorCollection;
  _MeetingDataSource _events;
  CalendarController _calendarController;

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.schedule,
    CalendarView.timelineWeek,
    CalendarView.timelineWorkWeek,
    CalendarView.timelineMonth,
  ];

  ScrollController _controller;

  CalendarView _currentView;

  /// Global key used to maintain the state, when we change the parent of the
  /// widget
  GlobalKey _globalKey;

  @override
  void initState() {
    _calendarController = CalendarController();
    _currentView = CalendarView.week;
    _calendarController.view = _currentView;
    _globalKey = GlobalKey();
    _controller = ScrollController();
    addAppointmentDetails();
    _events = _MeetingDataSource(<_Meeting>[]);
    super.initState();
  }

  @override
  Widget build([BuildContext context]) {
    final Widget calendar = Theme(

        /// The key set here to maintain the state,
        ///  when we change the parent of the widget
        key: _globalKey,
        data: model.themeData.copyWith(accentColor: model.backgroundColor),
        child: _getCustomizationCalendar(
            _calendarController, _events, _onViewChanged, _getAppointmentUI));

    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(children: <Widget>[
        Expanded(
          child: _calendarController.view == CalendarView.month &&
                  model.isWeb &&
                  screenHeight < 800
              ? Scrollbar(
                  isAlwaysShown: true,
                  controller: _controller,
                  child: ListView(
                    controller: _controller,
                    children: <Widget>[
                      Container(
                        color: model.cardThemeColor,
                        height: 600,
                        child: calendar,
                      )
                    ],
                  ))
              : Container(color: model.cardThemeColor, child: calendar),
        )
      ]),
    );
  }

  /// The method called whenever the calendar view navigated to previous/next
  /// view or switched to different calendar view, based on the view changed
  /// details new appointment collection added to the calendar
  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    final List<_Meeting> appointment = <_Meeting>[];
    _events.appointments.clear();
    final Random random = Random();

    /// Remove the scroll bar on sample while change the view from
    /// month view or change the view to month view.
    if (_currentView != _calendarController.view &&
        model.isWeb &&
        (_currentView == CalendarView.month ||
            _calendarController.view == CalendarView.month)) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        setState(() {});
      });
    }

    _currentView = _calendarController.view;
    if (_currentView == CalendarView.day ||
        _currentView == CalendarView.week ||
        _currentView == CalendarView.workWeek) {
      final Map<String, String> events = <String, String>{};
      events['Environmental Discussion'] =
          'The day that creates awareness to promote the healthy planet and reduce air pollution crisis on nature earth';
      events['Health Checkup'] =
          'The day that raises awareness on different health issues. It marks the anniversary of the foundation of WHO';
      events['Cancer awareness'] =
          'The day that creates awareness on cancer and its preventive measures. Early detection saves life';
      events['Happiness'] =
          'The general idea is to promote happiness and smile around the world';
      events['Tourism'] =
          'The day that creates awareness to the role of tourism and its effect on social and economic values';
      final List<Color> colors = <Color>[
        Color(0xFF56AB56),
        Color(0xFF357CD2),
        Color(0xFF7FA90E),
        Colors.deepOrangeAccent,
        Color(0xFF5BBEAF)
      ];
      final List<String> images = <String>[
        'environment_day',
        'health_day',
        'cancer_day',
        'happiness_day',
        'tourism_day'
      ];
      final List<String> keys = events.keys.toList();
      DateTime date = DateTime.now();
      date = DateTime(date.year, date.month, date.day, 9, 0, 0)
          .subtract(Duration(days: date.weekday - 1));
      for (int i = 0; i < 5; i++) {
        final String key = keys[i];
        appointment.add(_Meeting(key, date, date.add(Duration(hours: 6)),
            colors[i], false, events[key], images[i], null));
        date = date.add(Duration(days: 1));
      }
    }

    /// Creates new appointment collection based on
    /// the visible dates in calendar.
    else if (_currentView != CalendarView.schedule) {
      for (int i = 0; i < visibleDatesChangedDetails.visibleDates.length; i++) {
        final DateTime date = visibleDatesChangedDetails.visibleDates[i];
        final int count = _currentView != CalendarView.month
            ? 1
            : 1 + random.nextInt(model.isWeb ? 2 : 3);
        for (int j = 0; j < count; j++) {
          final DateTime startDate = DateTime(
              date.year, date.month, date.day, 8 + random.nextInt(8), 0, 0);
          appointment.add(_Meeting(
              _subjectCollection[random.nextInt(7)],
              startDate,
              startDate.add(Duration(hours: random.nextInt(3))),
              _colorCollection[random.nextInt(9)],
              false,
              '',
              '',
              null));
        }
      }
    } else {
      final DateTime rangeStartDate =
          DateTime.now().add(const Duration(days: -(365 ~/ 2)));
      final DateTime rangeEndDate =
          DateTime.now().add(const Duration(days: 365));
      for (DateTime i = rangeStartDate;
          i.isBefore(rangeEndDate);
          i = i.add(const Duration(days: 1))) {
        final DateTime date = i;
        final int count = 1 + random.nextInt(3);
        for (int j = 0; j < count; j++) {
          final DateTime startDate = DateTime(
              date.year, date.month, date.day, 8 + random.nextInt(8), 0, 0);
          final int index = random.nextInt(7);
          appointment.add(_Meeting(
              _subjectCollection[index],
              startDate,
              startDate.add(Duration(hours: random.nextInt(3))),
              _colorCollection[random.nextInt(9)],
              false,
              '',
              '',
              _iconCollection[index]));
        }
      }
    }

    for (int i = 0; i < appointment.length; i++) {
      _events.appointments.add(appointment[i]);
    }

    /// Resets the newly created appointment collection to render
    /// the appointments on the visible dates.
    _events.notifyListeners(CalendarDataSourceAction.reset, appointment);
  }

  /// Creates the required appointment details as a list.
  void addAppointmentDetails() {
    _subjectCollection = <String>[];
    _subjectCollection.add('General Meeting');
    _subjectCollection.add('Plan Execution');
    _subjectCollection.add('Project Plan');
    _subjectCollection.add('Consulting');
    _subjectCollection.add('Support');
    _subjectCollection.add('Development Meeting');
    _subjectCollection.add('Scrum');
    _subjectCollection.add('Project Completion');
    _subjectCollection.add('Release updates');
    _subjectCollection.add('Performance Check');

    _iconCollection = <IconData>[];
    _iconCollection.add(Icons.people_outlined);
    _iconCollection.add(Icons.supervisor_account_outlined);
    _iconCollection.add(Icons.sticky_note_2_outlined);
    _iconCollection.add(Icons.headset_mic_outlined);
    _iconCollection.add(Icons.perm_phone_msg_outlined);
    _iconCollection.add(Icons.file_copy_outlined);
    _iconCollection.add(Icons.personal_video_outlined);
    _iconCollection.add(Icons.fact_check_outlined);
    _iconCollection.add(Icons.new_releases_outlined);
    _iconCollection.add(Icons.speed_outlined);

    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  Widget _getAppointmentUI(
      BuildContext context, CalendarAppointmentDetails details) {
    final _Meeting meeting = details.appointments.first;
    final Color textColor = model.themeData == null ||
            model.themeData.brightness == Brightness.light
        ? Colors.black
        : Colors.white;
    if (_calendarController.view == CalendarView.timelineDay ||
        _calendarController.view == CalendarView.timelineWeek ||
        _calendarController.view == CalendarView.timelineWorkWeek ||
        _calendarController.view == CalendarView.timelineMonth) {
      final double horizontalHighlight =
          _calendarController.view == CalendarView.timelineMonth ? 10 : 20;
      final double cornerRadius = horizontalHighlight / 4;
      return Container(
        child: Row(
          children: [
            Container(
              width: horizontalHighlight,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cornerRadius),
                    bottomLeft: Radius.circular(cornerRadius)),
                color: meeting.background,
              ),
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    color: meeting.background.withOpacity(0.8),
                    padding: EdgeInsets.only(left: 2),
                    child: Text(
                      meeting.eventName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ))),
            Container(
              width: horizontalHighlight,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(cornerRadius),
                    bottomRight: Radius.circular(cornerRadius)),
                color: meeting.background,
              ),
            ),
          ],
        ),
      );
    } else if (_calendarController.view != CalendarView.month &&
        _calendarController.view != CalendarView.schedule) {
      return Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              height: 50,
              alignment: model.isMobileResolution
                  ? Alignment.topLeft
                  : Alignment.centerLeft,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: meeting.background,
              ),
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meeting.eventName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: model.isMobileResolution ? 3 : 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                  model.isMobileResolution
                      ? Container()
                      : Text(
                          'Time: ${DateFormat('hh:mm a').format(meeting.from)} - ' +
                              '${DateFormat('hh:mm a').format(meeting.to)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        )
                ],
              )),
            ),
            Container(
              height: details.bounds.height - 70,
              padding: EdgeInsets.fromLTRB(3, 5, 3, 2),
              color: meeting.background.withOpacity(0.8),
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Image(
                          image: ExactAssetImage(
                              'images/' + meeting.image + '.png'),
                          fit: BoxFit.contain,
                          width: details.bounds.width,
                          height: 60)),
                  Text(
                    meeting.notes,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  )
                ],
              )),
            ),
            Container(
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                color: meeting.background,
              ),
            ),
          ],
        ),
      );
    } else if (_calendarController.view == CalendarView.month) {
      final double fontSize =
          details.bounds.height > 11 ? 10 : details.bounds.height - 1;
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: details.isMoreAppointmentRegion
            ? Padding(
                padding: EdgeInsets.only(left: 2),
                child: Text(
                  '+ More',
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                  ),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ))
            : model.isMobileResolution
                ? Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: meeting.background,
                        size: fontSize,
                      ),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(left: 2),
                              child: Text(
                                meeting.eventName,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: fontSize,
                                ),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                              ))),
                    ],
                  )
                : Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: meeting.background,
                        size: fontSize,
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 2),
                          child: Text(
                            meeting.isAllDay
                                ? 'All'
                                : '${DateFormat('h a').format(meeting.from)}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: fontSize,
                            ),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Expanded(
                          child: Text(
                        meeting.eventName,
                        style: TextStyle(
                          color: textColor,
                          fontSize: fontSize,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                    ],
                  ),
      );
    }

    return Container(
      child: Row(
        children: [
          Container(
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
              color: meeting.background,
            ),
          ),
          Expanded(
              child: Container(
                  alignment: Alignment.center,
                  color: meeting.background.withOpacity(0.8),
                  padding: EdgeInsets.only(left: 2),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            meeting.eventName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Time: ${DateFormat('hh:mm a').format(meeting.from)} - ' +
                                '${DateFormat('hh:mm a').format(meeting.to)}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      )),
                      _getScheduleAppointmentIcon(meeting),
                      Container(
                        margin: EdgeInsets.all(0),
                        width: 30,
                        alignment: Alignment.center,
                        child: Icon(
                          meeting.icon,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ))),
          Container(
            margin: EdgeInsets.all(0),
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5)),
              color: meeting.background,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getScheduleAppointmentIcon(_Meeting meeting) {
    if (meeting.eventName == 'General Meeting') {
      return Container(
        margin: EdgeInsets.all(0),
        width: 30,
        alignment: Alignment.center,
        child: Icon(
          Icons.priority_high_outlined,
          size: 20,
          color: Colors.red,
        ),
      );
    }

    return Container(
      width: 30,
    );
  }

  /// Returns the calendar widget based on the properties passed.
  SfCalendar _getCustomizationCalendar(
      [CalendarController _calendarController,
      CalendarDataSource _calendarDataSource,
      ViewChangedCallback viewChangedCallback,
      CalendarAppointmentBuilder appointmentBuilder]) {
    return SfCalendar(
        controller: _calendarController,
        dataSource: _calendarDataSource,
        allowedViews: _allowedViews,
        appointmentBuilder: appointmentBuilder,
        showNavigationArrow: model.isWeb,
        showDatePickerButton: true,
        cellEndPadding: 3,
        onViewChanged: viewChangedCallback,
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            showTrailingAndLeadingDates: true,
            appointmentDisplayCount: 3),
        timeSlotViewSettings: TimeSlotViewSettings(
            timelineAppointmentHeight: 50,
            timeIntervalWidth: 100,
            minimumAppointmentDuration: const Duration(minutes: 60)));
  }
}

/// An object to set the appointment collection data source to collection, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(this.source);

  List<_Meeting> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return source[index].eventName;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class _Meeting {
  _Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay,
      this.notes, this.image, this.icon);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String notes;
  String image;
  IconData icon;
}
