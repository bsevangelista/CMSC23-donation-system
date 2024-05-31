import 'package:app/models/donation_model.dart';
import 'package:app/pages/donor/donor_profile.dart';
import 'package:app/providers/donation_provider.dart';
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
        backgroundColor: Color.fromARGB(184, 164, 162, 164),
        title: Text(
          "${orgName!}",
          // args.orgName!,
          // "Temp Org Name",
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
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
                    //listview ng categories

                    // Column(
                    //   children: [
                    //     Container(
                    //       child: ListView.builder(
                    //         itemCount: donation!.category.length,
                    //         itemBuilder: ((context, index) {

                    //           return Padding(
                    //             padding: EdgeInsets.all(10),
                    //             child: ListTile(
                    //               tileColor: Color.fromARGB(184, 164, 162, 164),
                    //               title: Text(donation!.address![index])
                    //             )
                    //           );

                    //         })
                    //       ),
                    //     ),
                    //   ]
                    // ),

                    donateDivider(),
                    headingDisplay("Delivery Mode"),
                    valueDisplay(donation!.deliveryMode),

                    donateDivider(),
                    headingDisplay("Weight of Donated Items"),
                    Row(
                      children: [
                        valueDisplay(donation!.weight),
                        Text(" "),
                        Text("${donation!.weightType}")
                      ]
                    ),

                    if (donation!.image != null) donateDivider(),
                    headingDisplay("Photo of Donated Items"),
                    if (donation!.image != null) displayImage(donation!.image!),

                    donateDivider(),
                    headingDisplay("Date and Time of Delivery"),
                    //display date and time

                    if (donation!.deliveryMode == "Pickup") donateDivider(),
                    if (donation!.deliveryMode == "Pickup") headingDisplay("Address"),
                    //listview ng addresses

                    if (donation!.deliveryMode == "Pickup") donateDivider(),
                    if (donation!.deliveryMode == "Pickup") headingDisplay("Contact Number"),
                    if (donation!.deliveryMode == "Pickup") valueDisplay(donation!.contactNum),

                    if (donation!.deliveryMode == "Dropoff") donateDivider(),
                    if (donation!.deliveryMode == "Dropoff") headingDisplay("QR"),       
                    //qr image            

                    donateDivider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                         FilledButton(
                          style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
                          onPressed: () {
                            //set donation status to canceled
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
                    )
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
    child: Text(value!)
  );
}

Widget displayImage(String image){
  return Image.network(image);
}