import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/model/organization_model.dart';
import '/provider/organization_list_provider.dart';
import '/donor/organization_details.dart';

// import '/model/donationDrive_model.dart';
// import '/provider/donationDrive_list_provider.dart';
// import '/donor/donation_drive_details.dart';

import 'package:cloud_firestore/cloud_firestore.dart';



// class AllOrgValues{
//   static List<List<String>> _allOrgValues=[];
// }

// void valuesReceiver(List<String> values){
//   AllOrgValues._allOrgValues.add(values);
// }



class DonorHomepage extends StatefulWidget {
  const DonorHomepage({super.key});

  @override
  State<DonorHomepage> createState() => _DonorHomepageState();
}

class _DonorHomepageState extends State<DonorHomepage> {
  @override
  Widget build(BuildContext context) {

    // Stream<QuerySnapshot> donationDrivesStream = context.watch<DonationDriveProvider>().donationDrive;
    Stream<QuerySnapshot> organizationsStream = context.watch<OrganizationProvider>().organization;

    // return const Placeholder();
    return Scaffold(
      body: StreamBuilder(
        stream: organizationsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot.error}"),
            );
          } 
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }  
          else if (!snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.corporate_fare),
                  Text("No organization donation drive open for donations yet."),
                ]
              )
            );
          }

          List<DocumentSnapshot> organizationsList = snapshot.data!.docs;
          //ung list ng donation drives

          if (organizationsList.isEmpty) {
            return Center(
              child: Text("No organization donation drive open for donations yet.")
            );
          }



          // kailangan ng condition to only show organizations with open status for donations
          return ListView.builder(
            itemCount: organizationsList.length,
            itemBuilder: ((context, index) {
              Organization organization = Organization.fromJson(
                snapshot.data?.docs[index].data() as Map<String,dynamic>
              );

              organization.id = snapshot.data?.docs[index].id;

              return Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5)),
                  tileColor: Color.fromARGB(184, 164, 162, 164),
                  title: Text(organization.name),
                  // trailing: FilledButton(onPressed: () {Navigator.pushNamed(context, "/second", arguments: snapshot.data?.docs[index]);} , child: Text("View Details", style: TextStyle(fontSize: 10))),
                  trailing: FilledButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/second", arguments: organization);
                      } , 
                    child: Text("View Details", style: TextStyle(fontSize: 10))),
                )
              );
            }

            ) 
          );         
        }
      )
    );
  }
}