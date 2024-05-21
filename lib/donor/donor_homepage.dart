import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/model/organization_model.dart';
import '/provider/organization_list_provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';



class DonorHomepage extends StatefulWidget {
  const DonorHomepage({super.key});

  @override
  State<DonorHomepage> createState() => _DonorHomepageState();
}

class _DonorHomepageState extends State<DonorHomepage> {
  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot> organizationsStream = context.watch<OrganizationListProvider>().organization;

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
                  Text("No organizations open for donations yet."),
                ]
              )
            );
          }

          // kailangan ng condition to only show open
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
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
                  trailing: FilledButton(onPressed: () {Navigator.pushNamed(context, "/second");} , child: Text("View Details", style: TextStyle(fontSize: 10))),
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