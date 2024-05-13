import 'package:app/firebase_options.dart';
import 'package:app/pages/organizationHome.dart';
import 'package:app/providers/organization_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => OrgListProvider())),
  ], child: const RootWidget()));
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  Widget build(BuildContext) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.indigo,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        colorScheme: ColorScheme.dark(),
      ),
      title: "Organization Name",
      initialRoute: "/",
      home: OrganizationHomePage(), //initializing first page
      onGenerateRoute: (settings) {
        //sets routes
        if (settings.name == "/") {
          return MaterialPageRoute(builder: (context) => OrganizationHomePage());
        }

        // if (settings.name == "/second") {
        //   return MaterialPageRoute(builder: (context) => SecondPage());
        // }

        return null;
      },
    );
  }
}