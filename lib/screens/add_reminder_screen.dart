import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddReminder extends StatefulWidget {

  const AddReminder({super.key, this.restorationId});

  final String? restorationId;

  @override
  State<StatefulWidget> createState() => _AddReminderState();

}
  class _AddReminderState extends State<AddReminder> with RestorationMixin{
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
                      label: const Text('Pick date'),
                      onPressed: () {
                        _restorableDatePickerRouteFuture.present();
                      }),
                  ActionChip(
                      avatar: const Icon(Icons.timelapse_sharp),
                      label: const Text('Pick time'),
                      onPressed: () {
                        _restorableDatePickerRouteFuture.present();
                      })
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
    RestorableDateTime(DateTime(2021, 2, 12));
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
      }
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
            firstDate: DateTime(2021),
            lastDate: DateTime(2022),
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



