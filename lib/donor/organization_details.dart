import 'package:flutter/material.dart';

class OrganizationDetails extends StatelessWidget {
  final List<String>? values;
  const OrganizationDetails({this.values,super.key});

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
          "Temp Org Name",
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Temp Org Info"),
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
    );
  }
}