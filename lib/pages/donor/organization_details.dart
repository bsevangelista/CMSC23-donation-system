import 'package:ELBIdonate/models/organization_model.dart';
import 'package:flutter/material.dart';

class OrganizationDetails extends StatelessWidget {
  final Organization? organization;
  const OrganizationDetails({this.organization, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {Navigator.pushNamed(context, "/donatepage", arguments: organization);},
        icon: Icon(Icons.volunteer_activism),
        label: Text("Donate"),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(184, 0, 0, 0),
        title: Text(
          "${organization!.name}",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
                // SizedBox(height: 20.0),
                Container(
                  height: 300,
                  child: Expanded(
                    child: Image.network(organization!.logo!)
                  )
                ),
                Text("${organization!.name}", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
                Text("${organization!.email}", style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 67, 67, 67), fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(20),
                    child: Text("${organization!.description}"),
                ),
                SizedBox(height: 60.0),
            ]
          )
        )
      )
    );
  }
}