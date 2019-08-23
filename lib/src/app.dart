import 'package:flutter/material.dart';
import 'screens/splashPage.dart';
import 'screens/outoffdata.dart';
import 'authentication/mapping.dart';
import 'authentication/authentication.dart';
import 'authentication/authprovider.dart';
import 'definitions/colors.dart';
import 'definitions/text.dart';
import 'sources/firebase.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: TextDefinition().obterAppHomeText(),
        theme: ThemeData(
          primarySwatch: ColorsDefinitions().obterPrimarySwatch(),
        ),
        home: FutureBuilder(
          future: FirebaseDatabaseSnapshot().getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            try {
              if (snapshot.error != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    content: ListTile(
                      title: const Text('Algo saiu errado!'),
                      subtitle: Text(snapshot.error.toString()),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        color: ColorsDefinitions().obterAppBarColor(),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        child: Text(
                          'Ok',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                );
              }
              if (snapshot.data == null) {
                return Splash().screen();
              } else {
                return MappingPage(model: snapshot.data);
              }
            } catch (e) {
              print(e);
              return ErrorScreen().screen();
            }
          },
        ),
      ),
    );
  }
}
