import 'package:flutter/material.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({super.key});

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  bool food = false;
  bool clothes = false;
  bool cash = false;
  bool necessities = false;
  bool others = false;

  // List<String> deliveryType = ["Pickup", "Dropoff"];
  List<String> deliveryTypeChoices = <String>['Pickup', 'Dropoff'];
  String deliveryType = 'Pickup';

  double weight = 0;
  List<String> weightTypeChoices = <String>['kg', 'lb'];
  String weightType = 'kg'; 

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
                        value: food,
                        onChanged: (bool? value) {
                          setState(() {
                            food = value!;
                          });
                        },
                      ),
                      Text("Food"),
                    ]),

                    Row(children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.green.shade200,
                        value: clothes,
                        onChanged: (bool? value) {
                          setState(() {
                            clothes = value!;
                          });
                        },
                      ),
                      Text("Clothes"),
                    ]),

                    Row(children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.green.shade200,
                        value: cash,
                        onChanged: (bool? value) {
                          setState(() {
                            cash = value!;
                          });
                        },
                      ),
                      Text("Cash"),
                    ]),

                    Row(children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.green.shade200,
                        value: necessities,
                        onChanged: (bool? value) {
                          setState(() {
                            necessities = value!;
                          });
                        },
                      ),
                      Text("Necessities"),
                    ]),

                    Row(children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: Colors.green.shade200,
                        value: others,
                        onChanged: (bool? value) {
                          setState(() {
                            others = value!;
                          });
                        },
                      ),
                      Text("Others"),
                    ]),
                  ]
                )
              ),

            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            Divider(),
            SizedBox(height: 20.0),
            Text("Delivery Type", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),


            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child:DropdownButton<String>(
                    value: deliveryType,
                    items: deliveryTypeChoices.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        deliveryType = value!;
                      });
                    }
                  ),
            ),
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////
            Divider(),
            SizedBox(height: 20.0),
            Text("Weight of Donated Items", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),

            Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child:Row(
                children: [
                  Expanded(
                    flex: 4,
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
                      children: [DropdownButton<String>(
                        value: weightType,
                        items: weightTypeChoices.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            weightType = value!;
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
            Divider(),
            SizedBox(height: 20.0),
            Row(
              children: [
                Text("Photo", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                Text("(optional)", style: TextStyle(fontSize: 12, color: Color.fromRGBO(120, 117, 117, 1))),
              ]
            ),


            
           

            

            ] // children
          )
        )
      ),
    );
  }
}




















// class _RelationshipWidgetState extends State<RelationshipWidget> {
//   _RelationshipWidgetState(this._relationshipController, this.callback);
//   final Function callback;
//   final TextEditingController _relationshipController;

//   @override
//   void dispose(){
//    _relationshipController.dispose();
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Switch.adaptive(
//       value: bool.parse(_relationshipController.text),
//       onChanged: (bool value) {
//         setState(() {
//           _relationshipController.text = value.toString();
//         });
//         widget.callback(bool.parse(_relationshipController.text));
//       }
//     );
//   }
// }







  // Widget Results(Friend friend) {
  //    return Column(
  //      children: [
  //       Divider(
  //         color: Colors.white,
  //         indent: 20,
  //         endIndent: 20,
  //         height: 50,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //          children: [
  //            Text("Summary", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
  //          ]
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Expanded(
  //             flex: 4,
  //             child: Padding(
  //               padding: EdgeInsets.all(20),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   labelText("Name"),
  //                   labelText("Nickname"),
  //                   labelText("Age"),
  //                   labelText("In a Relationship?"),
  //                   labelText("Happiness"),
  //                   labelText("Super Power"),
  //                   if(Text(friend.superpowerChosen)=="Mapaitim ang tuhod ng iniibig niya") labelText(""),
  //                   labelText("Motto in Life"),
  //                 ]
  //               ),
  //             )
  //           ),
  //           Expanded(
  //             flex: 6,
  //             child: Padding(
  //               padding: EdgeInsets.all(20),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   valueText(friend.name.toString()),
  //                   valueText(friend.nickname.toString()),
  //                   valueText(friend.age.toString()),
  //                   valueText(friend.isInRelationship.toString()),
  //                   valueText(friend.happinessNum.toString()),
  //                   valueText(friend.superpowerChosen.toString()),
  //                   valueText(friend.motto.toString()),
  //                 ]
  //               )
  //             )
  //           ),
  //         ]
  //       )
  //     ]
  //   ); 
  // }