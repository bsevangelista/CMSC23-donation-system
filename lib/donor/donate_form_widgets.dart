import 'package:flutter/material.dart';

////////////////////////////        date picker        ////////////////////////////
class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime dateChoice = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget> [
          Text("${dateChoice.year}-${dateChoice.month}-${dateChoice.day}", style: TextStyle(fontSize: 24)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
            onPressed: () async {
              final DateTime? dateChosen = await showDatePicker(
                context: context,
                initialDate: dateChoice,
                firstDate: DateTime.now(),
                lastDate: DateTime(3000),
              );
              if (dateChosen != null) {
                setState(() {
                  dateChoice = dateChosen;
                });
              }
            },
            child:
              const Text("Choose date", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0))),
          ),
        ]
      )
    );
  }
}
////////////////////////////        date picker        ////////////////////////////



////////////////////////////        time picker        ////////////////////////////
class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay timeChoice = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget> [
          Text("${timeChoice.hour}:${timeChoice.minute}", style: TextStyle(fontSize: 24)),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
            onPressed: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: timeChoice,
                initialEntryMode: TimePickerEntryMode.dial
              );
              if (timeOfDay != null) {
                setState(() {
                  timeChoice = timeOfDay;
                });
              }
            },
            child:
              const Text("Choose time", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0))),
          ),
        ]
      )
    );
  }
}
////////////////////////////        time picker        ////////////////////////////