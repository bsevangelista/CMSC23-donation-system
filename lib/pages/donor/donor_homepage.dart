
import 'package:ELBIdonate/models/organization_model.dart';
import 'package:ELBIdonate/providers/organization_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class DonorHomepage extends StatefulWidget {
  const DonorHomepage({super.key});

  @override
  State<DonorHomepage> createState() => _DonorHomepageState();
}

class _DonorHomepageState extends State<DonorHomepage> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Text("${_donor?.username}", style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<UserAuthProvider>().signOut();
                Navigator.pushNamed(context, '/');
              }
            )
          ],
          bottom: TabBar(
            // labelColor: Colors.white,
            // unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Donate'),
              Tab(text: 'Profile')
            ]
          ),
        ),
        body: TabBarView(
          children: [
            DonorOrganizationsView(),
            DonorProfile(),
          ]
        )
      )
    );
  }
}



class DonorOrganizationsView extends StatefulWidget {
  const DonorOrganizationsView({super.key});

  @override
  State<DonorOrganizationsView> createState() => _DonorOrganizationsViewState();
}

class _DonorOrganizationsViewState extends State<DonorOrganizationsView> {
  @override
  Widget build(BuildContext context) {

 Stream<QuerySnapshot> organizationsStream = context.watch<OpenOrganizationProvider>().openOrganization;

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


          // else if (!snapshot.hasData) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Icon(Icons.corporate_fare),
          //         Text("No organization open for donations yet."),
          //       ]
          //     )
          //   );
          // }

          List<DocumentSnapshot> organizationsList = snapshot.data!.docs;

          if (organizationsList.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Icon(Icons.corporate_fare),
                  Text("No organization open for donations yet.")
                ]
              )
            );
          }



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
                    tileColor: Color.fromARGB(184, 7, 7, 7),
                    title: Text(organization.name, style: TextStyle(color: Colors.white)),
                    // trailing: FilledButton(onPressed: () {Navigator.pushNamed(context, "/second", arguments: snapshot.data?.docs[index]);} , child: Text("View Details", style: TextStyle(fontSize: 10))),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/organizationdetails", arguments: organization);
                        } , 
                      child: Text("View Details", style: TextStyle(fontSize: 10, color: Colors.white))),
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



