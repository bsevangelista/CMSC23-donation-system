import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'donate_form_widgets.dart';
import '/model/donation_model.dart';
import '/provider/donation_provider.dart';
import '/model/organization_model.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// !!!!!!!!!! gagawan pa ng sariling classes ung mga nandito

class DonatePage extends StatefulWidget {
  final Organization? organization;
  const DonatePage({this.organization, super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final _formKey = GlobalKey<FormState>();

  bool _food = false;
  bool _clothes = false;
  bool _cash = false;
  bool _necessities = false;
  bool _others = false;
  List<String> _category = [];
  String _otherCategoriesString = "";
  List<Widget> _otherCategories = [];

  List<String> _deliveryModeChoices = <String>["Pickup", "Dropoff"];
  String _deliveryMode = "Pickup";

  double _weight = 0.0;
  List<String> _weightTypeChoices = <String>["kg", "lb"];
  String _weightType = "kg"; 

  DateTime _dateTime = DateTime.now();

  List<String> address = [];
  String _contactNum = "";

  //>>>>>>>>>>>>>>> di na dapat kailangan iinitialize, diretso na syang default sa add donation
  String _status = "Pending";
  //temp user
  String _user = "wFp9LhpbsOfCaKhHskPj1f7fay42";

  // int timeHour = 0;
  // int timeMinute = 0;  

  // List<String> timePeriodChoices = <String>['AM', 'PM'];
  // String timePeriod = 'AM';

  TextEditingController _weightController = TextEditingController(text: "");
  TextEditingController _contactNumController = TextEditingController(text: "");
  TextEditingController _addressStringController = TextEditingController(text: "");
  // TextEditingController _categoryController = TextEditingController(text: "");  
  TextEditingController _otherCategoriesStringController = TextEditingController(text: "");

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(184, 164, 162, 164),
          title: Text(
            "Donate",
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))
          ),
        ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Donation Type", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),

              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  children: [
                    Row(children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.green.shade200,
                        value: _food,
                        onChanged: (bool? value) {
                          setState(() {
                            _food = value!;

                            if (_food == true) {
                              _category.add("food");
                            } else {
                              _category.remove("food");
                            }
                          });
                        },
                      ),
                      Text("Food"),
                    ]),

                    Row(children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.green.shade200,
                        value: _clothes,
                        onChanged: (bool? value) {
                          setState(() {
                            _clothes = value!;

                            if (_clothes == true) {
                              _category.add("clothes");
                            } else {
                              _category.remove("clothes");
                            }
                          });
                        },
                      ),
                      Text("Clothes"),
                    ]),

                    Row(children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.green.shade200,
                        value: _cash,
                        onChanged: (bool? value) {
                          setState(() {
                            _cash = value!;

                            if (_cash == true) {
                              _category.add("cash");
                            } else {
                              _category.remove("cash");
                            }
                          });
                        },
                      ),
                      Text("Cash"),
                    ]),

                    Row(children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.green.shade200,
                        value: _necessities,
                        onChanged: (bool? value) {
                          setState(() {
                            _necessities = value!;

                            if (_food == true) {
                              _category.add("necessities");
                            } else {
                              _category.remove("necessities");
                            }
                          });
                        },
                      ),
                      Text("Necessities"),
                    ]),

                    Row(children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.green.shade200,
                        value: _others,
                        onChanged: (bool? value) {
                          setState(() {
                            _others = value!;
                          });
                        },
                      ),
                      Text("Others"),
                      Text(" (separate using commas only)", style: TextStyle(fontSize: 12, color: Color.fromRGBO(120, 117, 117, 1))),
                    ]),
                  ]
                )
              ),
            
            if (_others==true) OtherCategories(_otherCategoriesStringController, (String val) => _otherCategoriesString = val),
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            donateDivider(),
            Text("Delivery Type", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),


            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child:DropdownButton<String>(
                    value: _deliveryMode,
                    items: _deliveryModeChoices.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _deliveryMode = value!;
                      });
                    }
                  ),
            ),
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            donateDivider(),
            Text("Weight of Donated Items", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),

            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child:Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: 
                      Weight(_weightController, (double val) => _weight = val)
                  ),

                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [DropdownButton<String>(
                        value: _weightType,
                        items: _weightTypeChoices.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _weightType = value!;
                          });
                        }
                      ),]
                    )
                  ),

                  Expanded(
                    flex: 4,
                    child: Container(),
                  )
                ]
              ),
            ),

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            donateDivider(),
            Row(
              children: [
                Text("Photo of Donated Items", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                Text("(optional)", style: TextStyle(fontSize: 12, color: Color.fromRGBO(120, 117, 117, 1))),
              ]
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                    child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
                    onPressed: () {

                      // setState(() {
        
                      // });
                    },
                    child:
                      Column(
                        children: [
                          Icon(
                            Icons.upload,
                            color: Colors.grey.shade700,
                            size: 40,
                          ),
                          const Text("Upload", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0))) 
                        ]
                      ) 
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                    child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
                    onPressed: () {

                      // setState(() {
        
                      // });
                    },
                    child:
                      Column(
                        children: [
                          Icon(
                            Icons.photo_camera,
                            color: Colors.grey.shade700,
                            size: 40,
                          ),
                          const Text("Camera", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0))) 
                        ]
                      ) 
                    ),
                )      
              ]
            ),





            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            donateDivider(),
            Text("Date and Time of Delivery", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                    child: Center(
                      child: Column(
                        children: <Widget> [
                          if (_dateTime.month>=10 && _dateTime.day>=10) Text("${_dateTime.year}-${_dateTime.month}-${_dateTime.day}", style: TextStyle(fontSize: 24)),
                          if (_dateTime.month<10 && _dateTime.day<10) Text("${_dateTime.year}-0${_dateTime.month}-0${_dateTime.day}", style: TextStyle(fontSize: 24)),
                          if (_dateTime.month<10 && _dateTime.day>=10) Text("${_dateTime.year}-0${_dateTime.month}-${_dateTime.day}", style: TextStyle(fontSize: 24)),
                          if (_dateTime.month>=10 && _dateTime.day<10) Text("${_dateTime.year}-${_dateTime.month}-0${_dateTime.day}", style: TextStyle(fontSize: 24)),          
                          FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
                            onPressed: () async {
                              final DateTime? dateChosen = await showDatePicker(
                                context: context,
                                initialDate: _dateTime,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(3000),
                              );
                              if (dateChosen != null) {
                                setState(() {
                                  _dateTime = dateChosen;
                                });
                              }
                            },
                            child:
                              const Text("Choose date", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0))),
                          ),
                        ]
                      )
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                    child: Center(
                      child: Column(
                        children: <Widget> [
                          if (_dateTime.minute>=10) Text("${_dateTime.hour}:${_dateTime.minute}", style: TextStyle(fontSize: 24)),
                          if (_dateTime.minute<10) Text("${_dateTime.hour}:0${_dateTime.minute}", style: TextStyle(fontSize: 24)),
                          FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
                            onPressed: () async {
                              final TimeOfDay? timeOfDay = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(_dateTime),
                                initialEntryMode: TimePickerEntryMode.dial
                              );
                              if (timeOfDay != null) {
                                setState(() {
                                  // timeChoice = timeOfDay;

                                  _dateTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day, timeOfDay.hour, timeOfDay.minute);
                                });
                              }
                            },
                            child:
                              const Text("Choose time", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0))),
                          ),
                        ]
                      )
                    )
                )      
              ]
            ),      
            
            //             Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 28.0),
            //         child: FilledButton(
            //           style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
            //           onPressed: () async {
            //             dateTimePickerWidget(context);
            //           },
            //           child:
            //             const Text("Choose time", style: TextStyle(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0))),
            //         ),
            //     ),    
            //   ]
            // ),      

            
    //////////////////////// for pickup only       
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (_deliveryMode=="Pickup") donateDivider(),
            if (_deliveryMode=="Pickup") titleStyle("Address"),

            if (_deliveryMode=="Pickup") Address(),


            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            if (_deliveryMode=="Pickup") donateDivider(),
            if (_deliveryMode=="Pickup") titleStyle("Contact No"),

            if (_deliveryMode=="Pickup") ContactNo(_contactNumController, (String val) => _contactNum = val),
            
    //////////////////////// for pickup only       
    

    //////////////////////// for dropoff only
            if (_deliveryMode=="Dropoff") donateDivider(),
            if (_deliveryMode=="Dropoff") titleStyle("Generate QR"),

            if (_deliveryMode=="Dropoff") GenerateQR(),

     
    //////////////////////// for dropoff only   
            donateDivider(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
                  onPressed: () {
                    // Navigator.pushNamed(context, "/");
                    Navigator.pop(context);
                    // setState(() {
      
                    // });
                  },
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Donate", style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0))) ,
                        Icon(
                          Icons.volunteer_activism,
                          color: Colors.grey.shade700,
                          // semanticLabel: "QR Generator",
                          size: 20,
                        ),
                      ]
                    ) 
                    // Text("Generate QR", style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)))
                ),
              ]
            )



            ] // children
          )
        )
      ),
    );
  }
}

Widget donateDivider(){
  return Column(
    children: [
      Divider(),
      SizedBox(height: 20.0),
    ],
  );
}

Widget titleStyle(String title){
  return Text(title, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold));
}









