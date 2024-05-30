import 'dart:io';

import 'package:app/models/donation_model.dart';
import 'package:app/models/organization_model.dart';
import 'package:app/providers/donation_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'donate_form_widgets.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// !!!!!!!!!! gagawan pa ng sariling classes ung mga nandito

class DonatePage extends StatefulWidget {
  final Organization? organization;
  const DonatePage({required this.organization,super.key});

  @override
  State<DonatePage> createState() => _DonatePageState(organization!);
}

class _DonatePageState extends State<DonatePage> {
  _DonatePageState(this.organization);
  final Organization organization;

  // User? user = FirebaseAuth.instance.currentUser;


  final _formKey = GlobalKey<FormState>();

  bool _food = false;
  bool _clothes = false;
  bool _cash = false;
  bool _necessities = false;
  bool _others = false;
  List<String> _category = [];
  String _otherCategoriesString = "";
  List<String> _otherCategories = [];

  List<String> _deliveryModeChoices = <String>["Pickup", "Dropoff"];
  String _deliveryMode = "Pickup";

  String _weight = "";
  List<String> _weightTypeChoices = <String>["kg", "lb"];
  String _weightType = "kg"; 

  DateTime _dateTime = DateTime.now().add(Duration(hours: 8));

  String _addressString = "";
  List<String> _address = [];
  String _contactNum = "";

  String _imageUrl = "";


  // int timeHour = 0;
  // int timeMinute = 0;  

  // List<String> timePeriodChoices = <String>['AM', 'PM'];
  // String timePeriod = 'AM';

  TextEditingController _weightController = TextEditingController(text: "");
  TextEditingController _contactNumController = TextEditingController(text: "");
  TextEditingController _addressStringController = TextEditingController(text: "");  
  TextEditingController _otherCategoriesStringController = TextEditingController(text: "");

  //user!!!!
  Donation _tempDonation = Donation(
    category: [],
    deliveryMode: "Pickup",
    weight: "",
    weightType: "kg",
    // dateTime: dateTimetoTimestamp(DateTime.now()),
    dateTime: DateTime.now(),
    status: "Pending",
    organization: "",
    user: ""
  );

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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
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
                  // OtherCategories(_otherCategoriesStringController, (String val) => _otherCategoriesString = val),
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
                            Weight(_weightController, (String val) => _weight = val),
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
                          onPressed: () async{

                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
                            print('${file?.path}');


                            if(file==null) return;
                            String _uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                            // /data/user/0/com.example.app/cache/d48e0afc-f7ac-4531-982a-a2546878569a8604006521332836381.jpg
                            Reference referenceRoot = FirebaseStorage.instance.ref();
                            Reference referenceDirImages = referenceRoot.child('donation');
                            Reference referenceImageToUpload = referenceDirImages.child(_uniqueFileName);

                            try{
                              await referenceImageToUpload.putFile(File(file!.path));
                              _imageUrl = await referenceImageToUpload.getDownloadURL();
                            }catch(error){

                            }

                            referenceImageToUpload.putFile(File(file!.path));
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
                          onPressed: () async {

                            ImagePicker imagePicker = ImagePicker();
                            XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
                            print('${file?.path}');


                            if(file==null) return;
                            String _uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

                            // /data/user/0/com.example.app/cache/d48e0afc-f7ac-4531-982a-a2546878569a8604006521332836381.jpg
                            Reference referenceRoot = FirebaseStorage.instance.ref();
                            Reference referenceDirImages = referenceRoot.child('donation');
                            Reference referenceImageToUpload = referenceDirImages.child(_uniqueFileName);

                            try{
                              await referenceImageToUpload.putFile(File(file!.path));
                              _imageUrl = await referenceImageToUpload.getDownloadURL();
                            }catch(error){

                            }

                            referenceImageToUpload.putFile(File(file!.path));
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
                                      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
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

                  
          //////////////////////// for pickup only       
                  ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                  if (_deliveryMode=="Pickup") donateDivider(),
                  if (_deliveryMode=="Pickup") Row(children: [titleStyle("Address"), Text(" (separate using semicolons only)", style: TextStyle(fontSize: 12, color: Color.fromRGBO(120, 117, 117, 1))),]),

                  if (_deliveryMode=="Pickup") Address(_addressStringController, (String val) => _addressString = val),


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


                          if (_dateTime.compareTo(DateTime.now())<0) {
                            ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Please set delivery time in the future")));
                          }
                          else if (_formKey.currentState!.validate()) {
                            _formKey.currentState?.save();
                              
                              if (_others==true) {
                                _otherCategories = _otherCategoriesString.split(",").map((x) => x.trim()).where((element)=>element.isNotEmpty).toList();

                                for (int i=0; i<_otherCategories.length; i++) {
                                  _category.add(_otherCategories[i]);
                                }
                              }

                              _address = _addressString.split(";").map((x) => x.trim()).where((element)=>element.isNotEmpty).toList();
                              _tempDonation.address = _address;

                              _tempDonation.category=_category;
                              _tempDonation.organization=organization.id!;
                              _tempDonation.deliveryMode=_deliveryMode;
                              _tempDonation.weight=_weight;
                              // _tempDonation.weight=double.parse(_weight);
                              _tempDonation.weightType=_weightType;
                              // _tempDonation.dateTime=dateTimetoTimestamp(_dateTime);
                              _tempDonation.dateTime=_dateTime;
                              // _tempDonation.user=user!.uid;

                              if (_imageUrl!="") {
                                _tempDonation.image=_imageUrl;
                              }


                            if (_deliveryMode=="Pickup") {
                              // setState(() {
                                //address
                                _tempDonation.contactNum=_contactNum;
                              // });
                            } else{
                              // setState(() {
                                //qr
                              // });
                            }

                            

                            context.read<DonationProvider>().addDonation(_tempDonation);
                            
                            Navigator.pop(context);
                          }
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
            ]
          )
        )
      ),
    );
  }
}


//////////////////////////////////////



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

// Timestamp dateTimetoTimestamp(DateTime dateTime) {
//   // return Timestamp.fromMillisecondsSinceEpoch(
//   //   dateTime.millisecondsSinceEpoch
//   // );
//   return Timestamp.fromMicrosecondsSinceEpoch(
//     dateTime.microsecondsSinceEpoch
//   );
// }









