import 'package:ELBIdonate/models/donation_model.dart';
import 'package:ELBIdonate/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:app/models/donation_model.dart';
// import 'package:app/pages/donor/donor_profile.dart';
// import 'package:app/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonationDetails extends StatelessWidget {
  final Donation? donation;
  final String? orgName;
  const DonationDetails({this.donation, this.orgName, super.key});

  // const DonationDetails({super.key});

  @override
  Widget build(BuildContext context) {

    // final args = ModalRoute.of(context)!.settings.arguments as DonationArguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(184, 0, 0, 0),
        title: Text(
          "${orgName!}",
          // args.orgName!,
          // "Temp Org Name",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: 
      // Center(
      //   child: 
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                // padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,                  
                  children: [
                    headingDisplay("Donation Type"),
                    displayList(donation!.category),

                    donateDivider(),
                    headingDisplay("Delivery Mode"),
                    valueDisplay(donation!.deliveryMode),

                    donateDivider(),
                    headingDisplay("Weight of Donated Items"),
                    Row(
                      children: [
                        valueDisplay(donation!.weight),
                        Text(" "),
                        Text("${donation!.weightType}", style: TextStyle(fontSize: 18))
                      ]
                    ),

                    if (donation!.image != "") donateDivider(),
                    if (donation!.image != "") headingDisplay("Photo of Donated Items"),
                    if (donation!.image != "") displayImage(donation!.image!),

                    donateDivider(),
                    headingDisplay("Date and Time of Delivery"),
                    Row(
                      children: [
                        if (donation!.dateTime.month>=10 && donation!.dateTime.day>=10) valueDisplay("${donation!.dateTime.year}-${donation!.dateTime.month}-${donation!.dateTime.day}"),
                        if (donation!.dateTime.month<10 && donation!.dateTime.day<10) valueDisplay("${donation!.dateTime.year}-0${donation!.dateTime.month}-0${donation!.dateTime.day}"),
                        if (donation!.dateTime.month<10 && donation!.dateTime.day>=10) valueDisplay("${donation!.dateTime.year}-0${donation!.dateTime.month}-${donation!.dateTime.day}"),
                        if (donation!.dateTime.month>=10 && donation!.dateTime.day<10) valueDisplay("${donation!.dateTime.year}-${donation!.dateTime.month}-0${donation!.dateTime.day}"),

                        Text(" ", style: TextStyle(fontSize: 18)),

                        if (donation!.dateTime.minute>=10 && donation!.dateTime.hour >=10) Text("${donation!.dateTime.hour}:${donation!.dateTime.minute}", style: TextStyle(fontSize: 18)),
                        if (donation!.dateTime.minute>=10 && donation!.dateTime.hour <10) Text("0${donation!.dateTime.hour}:${donation!.dateTime.minute}", style: TextStyle(fontSize: 18)),
                        if (donation!.dateTime.minute<10 && donation!.dateTime.hour >=10) Text("${donation!.dateTime.hour}:0${donation!.dateTime.minute}", style: TextStyle(fontSize: 18)),
                        if (donation!.dateTime.minute<10 && donation!.dateTime.hour <10) Text("0${donation!.dateTime.hour}:0${donation!.dateTime.minute}", style: TextStyle(fontSize: 18)), 
                      ]
                    ),   

                    if (donation!.deliveryMode == "Pickup") donateDivider(),
                    if (donation!.deliveryMode == "Pickup") headingDisplay("Address/es"),
                    //listview ng addresses
                    if (donation!.deliveryMode == "Pickup") displayList(donation!.address!),

                    if (donation!.deliveryMode == "Pickup") donateDivider(),
                    if (donation!.deliveryMode == "Pickup") headingDisplay("Contact Number"),
                    if (donation!.deliveryMode == "Pickup") valueDisplay(donation!.contactNum),

                    if (donation!.deliveryMode == "Dropoff") donateDivider(),
                    if (donation!.deliveryMode == "Dropoff") headingDisplay("QR"),       
                    //qr image            

                    donateDivider(),
                    headingDisplay("Status"),
                    valueDisplay(donation!.status), 

                    donateDivider(),
                    if (donation!.status != "Canceled" && donation!.status != "Complete") cancelButton(context, donation!)
                  ]
                )
              )
            ]
          ) 
        )
      );
    // );
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

Widget headingDisplay(String heading){
  return Text(heading, style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold));
}

Widget valueDisplay(String? value){
  return Padding(
    padding: const EdgeInsets.only(left: 28.0),
    child: Text(value!, style: TextStyle(fontSize: 18))
  );
}

Widget displayImage(String image){
  return Image.network(image);
}

Widget cancelButton(BuildContext context, Donation donation){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children:[
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
        onPressed: () {
          Donation _canceledDonation = donation!;
          _canceledDonation.status = "Canceled";

          context
            .read<DonationProvider>()
            .cancelDonation(donation!.id!, _canceledDonation);
          Navigator.pop(context);
        },
        child: const Text("Cancel", style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)))
      )
    ]
  );
}

Widget displayList(List<String> list){
  return Container(
    height: (26*list.length.toDouble()),
    child: 
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context, index) {
          // return ListTile(
          //   contentPadding: EdgeInsets.zero,
          //   title: valueDisplay(list[index])
          // );
          return Container(
            child: valueDisplay(list[index])
          );
        }
      ),
  );
}