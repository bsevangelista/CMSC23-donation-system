import 'package:app/models/donation_model.dart';
import 'package:app/models/organization_model.dart';
import 'package:app/providers/donation_provider.dart';
import 'package:app/providers/organization_list_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// bHFOC8lDAKTiXhFhSuPfLPR2Tm42


class DonorProfile extends StatefulWidget {
  const DonorProfile({super.key});

  @override
  State<DonorProfile> createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> userDonationsStream = context.watch<DonationProvider>().userDonation;
    Stream<QuerySnapshot> organizationsStream = context.watch<AllOrganizationProvider>().organization;

    return Scaffold(
      body: StreamBuilder(
        stream: organizationsStream,
        builder: (context, snapshot1){
          if (snapshot1.hasError) {
            return Center(
              child: Text("Error encountered! ${snapshot1.error}"),
            );
          } 
          else if (snapshot1.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }  
          else if (!snapshot1.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.corporate_fare),
                  Text("No organization open for donations yet."),
                ]
              )
            );
          }

           List<DocumentSnapshot> organizationsList = snapshot1.data!.docs;


           return StreamBuilder(
            stream: userDonationsStream,
            builder: (context, snapshot2) {
              if (snapshot2.hasError) {
                return Center(
                  child: Text("Error encountered! ${snapshot2.error}"),
                );
              } 
              else if (snapshot2.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }  
              else if (!snapshot2.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.corporate_fare),
                      Text("No donations yet."),
                    ]
                  )
                );
              }

              List<DocumentSnapshot> userDonationsList = snapshot2.data!.docs;

              // return Row(

              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Header(),

                  ////////////////////
                  // Expanded(
                  //   flex: 3,
                  //   child: Header()
                  // ),
                

                  Expanded(
                    // flex: 7,
                  ////////////////////

                  // Container(
                    // clipBehavior: Clip.hardEdge,
                    // height: 460,

                /////////////
                // height: 200.0,
                    // flex: 7,
                /////////////

                    ////// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    //  decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.blueAccent)
                    // ),
                    ////// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                    child:

                    ///////////
                    // children: [
                    ///////////
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: userDonationsList.length,
                        itemBuilder: ((context, index) {
                          Donation donation = Donation.fromJson(
                            snapshot2.data?.docs[index].data() as Map<String,dynamic>
                          );

                          donation.id = snapshot2.data?.docs[index].id;

                          String _donationOrganization = "";

                          for (int i = 0; i < organizationsList.length; i++) {
                            if (donation.organization==snapshot1.data?.docs[i].id) {
                              Organization organization = Organization.fromJson(
                                snapshot1.data?.docs[i].data() as Map<String,dynamic>
                              );

                              _donationOrganization = organization.name;
                            }
                          } 
                                      
                        

                          return Padding(
                            padding: EdgeInsets.all(10),
                            child: 
                              // Card(
                                // child:
                                  ListTile(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5)),
                                    tileColor: Color.fromARGB(184, 164, 162, 164),
                                    // title: Text(donation.id),
                                    // title: Text(donation.organization),
                                    title: Text(_donationOrganization),
                                    // trailing: FilledButton(onPressed: () {Navigator.pushNamed(context, "/second", arguments: snapshot.data?.docs[index]);} , child: Text("View Details", style: TextStyle(fontSize: 10))),
                                    trailing: FilledButton(
                                      onPressed: () {
                                        // Navigator.pushNamed(context, "/organizationdetails", arguments: organization);
                                        } , 
                                      child: Text("View Details", style: TextStyle(fontSize: 10))),
                                  )
                              // )
                          );
                        }) 
                      )
                    // ]
                  ),
                  ////////////////////
                  // Expanded(
                  //   flex: 1,
                  //   child: Container(),
                  // )
                  ////////////////////
                ]
              ); 
            }
          );
        }
      )
    );
  }
}


Widget Header(){
  return Padding(
    // padding: const EdgeInsets.all(20),
    padding: EdgeInsets.only(left: 20, top: 20, right: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: Image.network('https://docs.flutter.dev/assets/images/dash/dash-fainting.gif').image,
            ),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text("Temp Donor Name", style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                Text("tempdonor@email.com"),
              ]
            )
          ]
        ),
        SizedBox(height: 30),
        Text("Donations:", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
      ]
    )

  );
}













