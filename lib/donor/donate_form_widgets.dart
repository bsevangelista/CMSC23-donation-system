import 'package:flutter/material.dart';

import 'package:qr_flutter/qr_flutter.dart';

////////////////////////////        other categories        ////////////////////////////
class OtherCategories extends StatefulWidget {
  final Function callback;
  final TextEditingController _otherCategoriesStringController;
  const OtherCategories(this._otherCategoriesStringController, this.callback, {super.key});

  @override
  State<OtherCategories> createState() => _OtherCategoriesState(_otherCategoriesStringController, callback);
}

class _OtherCategoriesState extends State<OtherCategories> {
  _OtherCategoriesState(this._otherCategoriesStringController, this.callback);
  final Function callback;
  final TextEditingController _otherCategoriesStringController;

  // @override
  // void dispose() {
  //   _otherCategoriesStringController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 48.0),
              child:Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      validator: (val) {
                        if (val == null || val.isEmpty || val=="") return "Please enter some text";
                      },
                      controller: _otherCategoriesStringController,
                      onChanged: (value) {
                        widget.callback(_otherCategoriesStringController.text);
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
////////////////////////////        other categories        ////////////////////////////



////////////////////////////        address        ////////////////////////////
class Address extends StatefulWidget {
  final Function callback;
  final TextEditingController _addressStringController;
  const Address(this._addressStringController, this.callback, {super.key});

  @override
  State<Address> createState() => _AddressState(_addressStringController, callback);
}

class _AddressState extends State<Address> {
  _AddressState(this._addressStringController, this.callback);
  final Function callback;
  final TextEditingController _addressStringController;

  // @override
  // void dispose() {
  //   _addressStringController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child:Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: TextFormField(
                      controller: _addressStringController,
                      validator: (val) {
                        if (val == null || val.isEmpty || val=="") return "Please enter some text";
                      },                     
                      onChanged: (value) {
                        widget.callback(_addressStringController.text);
                      },
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),

                  // Expanded(
                  //   flex: 2,
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       IconButton(
                  //         onPressed: () {

                  //           setState(() {
              
                  //           });
                  //         },
                  //         icon: Icon(Icons.add),

                  //       )
                  //     ]
                  //   )
                  // ),

                  Expanded(
                    flex: 3,
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
  final Function callback;
  final TextEditingController _contactNumController;
  const ContactNo(this._contactNumController, this.callback, {super.key});

  @override
  State<ContactNo> createState() => _ContactNoState(_contactNumController, callback);
}

class _ContactNoState extends State<ContactNo> {
  _ContactNoState(this._contactNumController, this.callback);
  final Function callback;
  final TextEditingController _contactNumController;

  // @override
  // void dispose(){
  //   _contactNumController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0),
      child:Row(
        children: [
           Expanded(
            flex: 7,
            child: TextFormField(
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val == null || val.isEmpty || val=="" || num.tryParse(val)==null) return "Please enter contact number";
             },
              controller: _contactNumController,
              onChanged: (value) {
               setState(() {
                  widget.callback(_contactNumController.text);
              });
             },
            decoration: InputDecoration(border: OutlineInputBorder())
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          )
        ]
      )
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

                // setState(() {
  
                // });
                // QrImageView(
                //   data: '',
                //   version: QrVersions.auto,
                //   size: 200
                // )
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



////////////////////////////        weight        ////////////////////////////
class Weight extends StatefulWidget {
  final Function callback;
  final TextEditingController _weightController;
  const Weight(this._weightController, this.callback, {super.key});

  @override
  State<Weight> createState() => _WeightState(_weightController, callback);
}

class _WeightState extends State<Weight> {
  _WeightState(this._weightController, this.callback);
  final Function callback;
  final TextEditingController _weightController;

  @override
  void dispose(){
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
        flex: 10,
        child: TextFormField(
          keyboardType: TextInputType.number,
          validator: (val) {
            if (val == null || val.isEmpty || val=="" || num.tryParse(val)==null) return "Please enter numerical weight of donation";
          },
          controller: _weightController,
          onChanged: (value) {
            setState(() {
              widget.callback(_weightController.text);
            });
          },
          decoration: InputDecoration(border: OutlineInputBorder())
          ),
        ),
      ]
    );
  }
}
////////////////////////////        weight        ////////////////////////////