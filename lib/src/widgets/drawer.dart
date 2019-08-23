import 'package:SAICCIX/src/definitions/colors.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../app.dart';
import '../authentication/authentication.dart';
import '../authentication/authprovider.dart';
import '../screens/parceiros.dart';
import '../screens/patrocinadores.dart';
import '../screens/maps.dart';
import '../screens/desenvolvedores.dart';
import '../screens/organizacao.dart';
import '../mixins/parceirosModel.dart';
import '../mixins/patrocinadoresModel.dart';
import '../mixins/organizacaoModel.dart';
import '../sources/firebase.dart';
import '../definitions/images.dart';

class SideMenu extends StatefulWidget {
  final FirebaseMessaging messaging;
  final FirebaseUser user;
  final VoidCallback onSignedOut;
  List<ParceirosModel> parceiros;
  List<PatrocinadoresModel> patrocinadores;
  List<OrganizacaoModel> organizacao;
  DatabaseReference ref;
  bool notification;
  SideMenu(this.parceiros, this.patrocinadores, this.organizacao, this.ref,
      this.onSignedOut, this.user, this.messaging, this.notification)
      : super();
  @override
  _SideMenuState createState() {
    return new _SideMenuState();
  }
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    widget.messaging.configure(
      onMessage: (Map<String, dynamic> message) {
        // showDialog(
        //   context: context,
        //   builder: (context) => AlertDialog(
        //     shape: RoundedRectangleBorder(
        //         borderRadius: new BorderRadius.circular(30.0)),
        //     content: ListTile(
        //       title: Text(message['notification']['title']),
        //       subtitle: Text(message['notification']['body']),
        //     ),
        //     actions: <Widget>[
        //       FlatButton(
        //         color: ColorsDefinitions().obterAppBarColor(),
        //         shape: RoundedRectangleBorder(
        //             borderRadius: new BorderRadius.circular(30.0)),
        //         child: Text(
        //           'Ok',
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //         onPressed: () => Navigator.of(context).pop(),
        //       ),
        //     ],
        //   ),
        // );
      },
      onResume: (Map<String, dynamic> message) {
        //print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) {
        //print('on launch $message');
      },
    );
    widget.messaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: obterItens(),
      ),
    );
  }

  void setNotificationsOnTap() {
    widget.messaging.getToken().then((token) {
      FirebaseDatabaseSnapshot()
          .getTokenSmartphone(widget.ref, token, widget.user)
          .then((valor) {
        FirebaseDatabaseSnapshot()
            .updateTokenSmartphone(widget.ref, token, widget.user, valor)
            .then((valor) {
          setState(() {
            widget.notification = valor;
          });
        });
      });
    });
  }

  List<Widget> obterItens() {
    List<Widget> lista = [
      UserAccountsDrawerHeader(
        // decoration:
        accountName: Text(''),
        accountEmail: Text(
          widget.user == null ? '' : widget.user.email,
          style: TextStyle(color: Colors.black),
        ),
        currentAccountPicture: CircleAvatar(
          backgroundImage: widget.user == null
              ? ImageDefinition().obterPersonImage('')
              : ImageDefinition().obterPersonImage(widget.user.photoUrl),
        ),
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: ColorsDefinitions().obterPrimarySwatch(),
        ),
      ),
      ListTile(
        title: Text('Notificação'),
        leading: Icon(Icons.notifications),
        onTap: setNotificationsOnTap,
        trailing: new Checkbox(
          value: widget.notification,
          onChanged: (value) {
            setNotificationsOnTap();
            setState(() {
              widget.notification = value;
            });
          },
        ),
      ),
      Divider(
        color: Colors.black,
        height: 5.0,
      ),
      /*ListTile(
        title: Text('Favoritos'),
        leading: Icon(Icons.favorite),
        onTap: () {
          //widget.ref;
          setState(() {
            favoritos = !favoritos;
          });
        },
        trailing: new Checkbox(
            value: favoritos,
            onChanged: (bool value) {
              setState(() {
                favoritos = value;
              });
            }),
      ),
      Divider(
        color: Colors.black,
        height: 5.0,
      ),*/
      ListTile(
        title: Text('Como chegar'),
        leading: Icon(Icons.place),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Maps(),
            ),
          );
        },
      ),
      Divider(
        color: Colors.black,
        height: 5.0,
      ),
    ];
    if (widget.parceiros != null  && widget.parceiros.length > 0) {
      lista.add(
        ListTile(
          title: Text('Parceiros'),
          leading: Icon(Icons.people),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Parceiros(widget.parceiros),
                ));
          },
        ),
      );
      lista.add(
        Divider(
          color: Colors.black,
          height: 5.0,
        ),
      );
    }
    if (widget.patrocinadores != null  && widget.patrocinadores.length > 0) {
      lista.add(
        ListTile(
          title: Text('Patrocinadores'),
          leading: Icon(Icons.people),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Patrocinadores(widget.patrocinadores),
              ),
            );
          },
        ),
      );
      lista.add(
        Divider(
          color: Colors.black,
          height: 5.0,
        ),
      );
    }
    if (widget.organizacao != null && widget.organizacao.length > 0) {
      lista.add(
        ListTile(
          title: Text('Organizadores'),
          leading: Icon(Icons.people),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    Organizacao(widget.organizacao),
              ),
            );
          },
        ),
      );
      lista.add(Divider(
        color: Colors.black,
        height: 5.0,
      ));
    }
    lista.add(
      ListTile(
        title: Text('Desenvolvedores'),
        leading: Icon(Icons.people),
        onTap: () {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Desenvolvedores(),
            ),
          );
        },
      ),
    );
    lista.add(
      Divider(
        color: Colors.black,
        height: 5.0,
      ),
    );
    lista.add(
      ListTile(
        title: widget.user != null ? Text('Logout') : Text('Login'),
        leading: Icon(Icons.exit_to_app),
        onTap: () {
          widget.user != null ? _logout(context) : null;
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => App(),
            ),
          );
        },
      ),
    );
    return lista;
  }

  Future<void> _logout(BuildContext context) async {
    try {
      final AuthImplementation auth = AuthProvider.of(context).auth;
      await auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }
}
