
import 'package:ELBIdonate/models/donation_model.dart';
import 'package:ELBIdonate/models/donor_model.dart';
import 'package:ELBIdonate/models/organization_model.dart';
import 'package:ELBIdonate/providers/donation_provider.dart';
import 'package:ELBIdonate/providers/organization_list_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class DonorProfile extends StatefulWidget {
  const DonorProfile({super.key});

  @override
  State<DonorProfile> createState() => _DonorProfileState();
}

class _DonorProfileState extends State<DonorProfile> {
  Donor? _donor;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  void fetchUserInfo() async {
    DocumentSnapshot userInfoSnapshot = await Provider.of<DonationProvider>(context, listen: false).userInfoFuture;
    setState(() {
      _donor = Donor.fromSnapshot(userInfoSnapshot);
    });
  }

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

              if (userDonationsList.isEmpty) {
                return Center(
                  child: Column(
                    children: [
                      Icon(Icons.volunteer_activism),
                      Text("No donations made yet.")
                    ]
                  )
                );
              }

              // return Row(

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Header(_donor!),
                    Container(
                      height: (80*userDonationsList.length.toDouble()),
                      child:
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
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
                                    ListTile(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.5)),
                                      // if (donation.image!="") {
                                      //   leading: Image.network(donation.image),
                                      // };
                                      tileColor: Color.fromARGB(184, 0, 0, 0),
                                      title: Text(_donationOrganization, style: TextStyle(color: Colors.white)),
                                      trailing: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, "/donationdetails", arguments: DonationArguments(donation, _donationOrganization));
                                          } , 
                                        child: Text("View Details", style: TextStyle(fontSize: 10, color: Colors.white))),
                                    )
                            );
                          }) 
                        )
                    ),
                  ]
                )
              ); 
            }
          );
        }
      )
    );
  }
}


Widget Header(Donor donor){
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
              // backgroundImage: Image.network('https://docs.flutter.dev/assets/images/dash/dash-fainting.gif').image,
              // backgroundColor: Colors.blue.shade300,
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              child: Text("${donor.username.substring(0,1)}", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text("${donor.name}", style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold)),
                Text("${donor.email}"),
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









class DonationArguments{
  final Donation? donation;
  final String? orgName;

  DonationArguments(this.donation, this.orgName);
}

