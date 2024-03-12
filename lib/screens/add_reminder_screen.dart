import 'package:alarm/alarm.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<StatefulWidget> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> with RestorationMixin {
  bool _isChecked = false;
  DateTime _userSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Add Reminder'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              child: const TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                minLines: 8,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionChip(
                    avatar: const Icon(Icons.date_range),
                    label: const Text('Set Reminder'),
                    onPressed: () {
                      _restorableDatePickerRouteFuture.present();
                    }),
                Row(
                  children: [
                    Switch.adaptive(
                      value: _isChecked,
                      onChanged: (bool? newValue) {
                        setState(() {
                          _isChecked = newValue ?? false;
                        });
                      },
                      activeColor: Colors.deepPurple,
                    ),
                    const Text('Official'),
                  ],
                ),
                // ActionChip(
                //     avatar: const Icon(Icons.timelapse_sharp),
                //     label: const Text('Pick time'),
                //     onPressed: () {
                //       _restorableDatePickerRouteFuture.present();
                //     })
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime.now());

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
      _userSelectedDate = newSelectedDate;
      // setAlarm(newSelectedDate);
      showLocalTimePicker(newSelectedDate);
    }
  }

  void onTimeChanged(Time newTime) {
    // setState(() {
    //   _time = newTime;
    // });
    print("Time selected is $newTime");
    // setAlarm(dateTime)
  }

  void onDateTimeChanged(DateTime dateTime){
    // print("Users selected time is hr ${dateTime.hour} minute is ${dateTime.minute}");
    // print("Time selected is $dateTime and user selected Date is $_userSelectedDate");
    DateTime userDT = DateTime(_userSelectedDate.year,_userSelectedDate.month,_userSelectedDate.day,
        dateTime.hour,dateTime.minute);
    print("time now ${DateTime.now()} user selected date time is $userDT");
    setAlarm(DateTime.now());
  }

  void showLocalTimePicker(DateTime dateTime) {
    Time _time = Time(hour: 11, minute: 30, second: 20);
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: _time,
        sunrise: TimeOfDay(hour: 6, minute: 0),
        // optional
        sunset: TimeOfDay(hour: 18, minute: 0),
        // optional
        duskSpanInMinutes: 120,
        // optional
        onChange: onTimeChanged,
        onChangeDateTime: onDateTimeChanged
      ),
    );
  }

  Future<void> setAlarm(DateTime dateTime) async {
    final alarmSettings = AlarmSettings(
      id: 42,
      dateTime: dateTime,
      assetAudioPath: 'assets/marimba.mp3',
      loopAudio: true,
      vibrate: true,
      volume: 0.8,
      fadeDuration: 3.0,
      notificationTitle: "Display this title",
      notificationBody: "Display this body Display this body Display this body",
      enableNotificationOnKill: true,
    );

    await Alarm.set(alarmSettings: alarmSettings);
  }

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2024),
          lastDate: DateTime(2025),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }
}
