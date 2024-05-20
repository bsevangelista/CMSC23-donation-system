import 'package:flutter/material.dart';



////////////////////////////        address        ////////////////////////////
class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child:Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      onSaved: (String? value) {

                      }
                    ),
                  ),

                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {

                            setState(() {
              
                            });
                          },
                          icon: Icon(Icons.add),

                        )
                      ]
                    )
                  ),

                  Expanded(
                    flex: 1,
                    child: Container(),
                  )
                ]
              ),
            );
  }
}
////////////////////////////        address        ////////////////////////////



////////////////////////////        contact no        ////////////////////////////
class ContactNo extends StatefulWidget {
  const ContactNo({super.key});

  @override
  State<ContactNo> createState() => _ContactNoState();
}

class _ContactNoState extends State<ContactNo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child:Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      onSaved: (String? value) {

                      }
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Container(),
                  )
                ]
              ),
            );
  }
}
////////////////////////////        contact no        ////////////////////////////



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
          if (dateChoice.month>=10 && dateChoice.day>=10) Text("${dateChoice.year}-${dateChoice.month}-${dateChoice.day}", style: TextStyle(fontSize: 24)),
          if (dateChoice.month<10 && dateChoice.day<10) Text("${dateChoice.year}-0${dateChoice.month}-0${dateChoice.day}", style: TextStyle(fontSize: 24)),
          if (dateChoice.month<10 && dateChoice.day>=10) Text("${dateChoice.year}-0${dateChoice.month}-${dateChoice.day}", style: TextStyle(fontSize: 24)),
          if (dateChoice.month>=10 && dateChoice.day<10) Text("${dateChoice.year}-${dateChoice.month}-0${dateChoice.day}", style: TextStyle(fontSize: 24)),          
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
          if (timeChoice.minute>=10) Text("${timeChoice.hour}:${timeChoice.minute}", style: TextStyle(fontSize: 24)),
          if (timeChoice.minute<10) Text("${timeChoice.hour}:0${timeChoice.minute}", style: TextStyle(fontSize: 24)),
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



////////////////////////////        generate qr        ////////////////////////////
class GenerateQR extends StatefulWidget {
  const GenerateQR({super.key});

  @override
  State<GenerateQR> createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child:             FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
              onPressed: () {

                setState(() {
  
                });
              },
              child:
                Column(
                  children: [
                    Icon(
                      Icons.qr_code,
                      color: Colors.grey.shade700,
                      // semanticLabel: "QR Generator",
                      size: 40,
                    ),
                    const Text("Generate QR", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0))) 
                  ]
                ) 
              ),
            );
  }
}

////////////////////////////        generate qr        ////////////////////////////