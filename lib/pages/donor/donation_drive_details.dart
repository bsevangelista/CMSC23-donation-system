import 'package:app/models/donationDrive_model.dart';
import 'package:flutter/material.dart';

class DonationDriveDetails extends StatelessWidget {
  final DonationDrive? donationDrive;
  const DonationDriveDetails({this.donationDrive, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {Navigator.pushNamed(context, "/third");},
        icon: Icon(Icons.volunteer_activism),
        label: Text("Donate"),
      ),
        // Container(
        //   height: 60,
        //   width: 100,
        //   child: FittedBox(
        //     child: FloatingActionButton(
        //   onPressed: () {Navigator.pushNamed(context, "/third");},
        //         child:
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //             // crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               const Text("Donate", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0))) ,
        //               Icon(
        //                 Icons.volunteer_activism,
        //                 color: Colors.grey.shade700,
        //                 size: 14,
        //               ),
        //             ]
        //           )
        // ),
        //   ),
        // ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(184, 164, 162, 164),
        title: Text(
          // "${values?[1]}",
          // "Temp Org Name",
          "${donationDrive!.name}",
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text("${donationDrive!.name}", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
              Text("organized by {Temp Org Name}", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 67, 67, 67), fontWeight: FontWeight.bold)),
              Center(
                // padding: const EdgeInsets.only(left: 28.0),
                  child: Text("${donationDrive!.description}"),
                ), 
              // Text("Temp Org Info"),

              // FilledButton(
              //   style: FilledButton.styleFrom(backgroundColor: Color.fromARGB(184, 208, 208, 208), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5))), 
              //   onPressed: () {
              //     Navigator.pushNamed(context, "/third");
              //   },
              //   child:
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       // crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         const Text("Donate", style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0))) ,
              //         Icon(
              //           Icons.volunteer_activism,
              //           color: Colors.grey.shade700,
              //           size: 20,
              //         ),
              //       ]
              //     ) 
              // ),            
            ]
          )
        )
      )
    );
  }
}