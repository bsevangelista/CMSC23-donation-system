import 'package:app/models/organization_model.dart';
import 'package:app/providers/auth_provider.dart';
import 'package:app/providers/organization_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgAboutPage extends StatefulWidget {
  final String organizationId;

  OrgAboutPage(this.organizationId);

  @override
  _OrgAboutPageState createState() => _OrgAboutPageState();
}

class _OrgAboutPageState extends State<OrgAboutPage> {
  late bool _isOpen;
  Organization? _organization;

  @override
  void initState() {
    super.initState();
    _isOpen = false;
    fetchOrganizationDetails();
  }

  void fetchOrganizationDetails() async {
    DocumentSnapshot snapshot =
        await Provider.of<OrgProvider>(context, listen: false)
            .organizationFuture;
    setState(() {
      _organization = Organization.fromSnapshot(snapshot);
      _isOpen = _organization?.status == 'OPEN';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_organization?.name}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _organization == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _organization?.logo != null
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Image.network(
                            _organization!.logo.toString(),
                            width: 250,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 20),
                Text('Description: ${_organization?.description}'),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text('Status: '),
                    Switch(
                      value: _isOpen,
                      onChanged: (value) {
                        setState(() {
                          _isOpen = value;
                          String newStatus = value ? 'OPEN' : 'CLOSED';
                          Provider.of<OrgProvider>(context, listen: false)
                              .updateOrganizationStatus(
                                  _organization!.id!, newStatus);
                        });
                      },
                    ),
                    Text(_isOpen ? 'OPEN' : 'CLOSED'),
                  ],
                ),
              ],
            ),
    );
  }
}
