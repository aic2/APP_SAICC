import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';
import 'authprovider.dart';
import '../mixins/rootModel.dart';
import '../screens/login.dart';
import '../screens/home.dart';
import '../screens/splashPage.dart';

class MappingPage extends StatefulWidget {
  final RootModel model;

  MappingPage({this.model});

  @override
  createState() => _MappingPageState();
}

enum AuthStatus {
  loading,
  notSignedIn,
  signIn,
}

class _MappingPageState extends State<MappingPage> {
  AuthStatus _authStatus = AuthStatus.loading;
  FirebaseUser _user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AuthImplementation auth = AuthProvider.of(context).auth;
    auth.getCurrentUser().then((FirebaseUser user) {
      setState(() {
        _user = user;
        _authStatus = user == null ? AuthStatus.notSignedIn : AuthStatus.signIn;
      });
    });
  }

  void _signedIn() {
    final AuthImplementation auth = AuthProvider.of(context).auth;
    auth.getCurrentUser().then((FirebaseUser user) {
      setState(() {
        _user = user;
        _authStatus = AuthStatus.signIn;
      });
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus) {
      case AuthStatus.loading:
        return Splash().screen();
      case AuthStatus.notSignedIn:
        return Login(
            model: widget.model, onSignedIn: _signedIn);
      case AuthStatus.signIn:
        return Home(model: widget.model, onSignedOut: _signedOut, user: _user);
    }
    return null;
  }
}
