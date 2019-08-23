import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../widgets/drawer.dart';
import '../widgets/tabbar.dart';
import '../mixins/rootModel.dart';
import '../definitions/text.dart';
import '../definitions/colors.dart';
import '../sources/firebase.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;
  final RootModel model;
  final VoidCallback onSignedOut;

  Home({this.model, this.onSignedOut, this.user});
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;
  final FirebaseMessaging _messaging = FirebaseMessaging();
  bool _temFeed = false;
  bool _notificacao = false;

  @override
  void initState() {
    var add = widget.model.feed.length > 0 ? 1 : 0;
    _temFeed = add == 1 ? true : false;
    _controller = new TabController(
      vsync: this,
      length: widget.model.dias.dia.length + add,
    );
    if (widget.user != null) {
      setNotificationsOnStart();
    }
    super.initState();
  }

  void setNotificationsOnStart() {
    _messaging.getToken().then((token) {
      FirebaseDatabaseSnapshot()
          .getTokenSmartphone(widget.model.referencia, token, widget.user)
          .then((valor) {
        if (valor) {
          FirebaseDatabaseSnapshot()
              .updateTokenSmartphone(
                  widget.model.referencia, token, widget.user, !valor)
              .then((valor) {
            setState(() {
              _notificacao = valor;
            });
          });
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _back() {
    if (_controller.index != 0) {
      setState(() {
        _controller.animateTo(0);
      });
    }else{
      return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
                title: new Text('Deseja sair?'),
                actions: <Widget>[
                  FlatButton(
                      color: ColorsDefinitions().obterAppBarColor(),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        'Não',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  FlatButton(
                      color: ColorsDefinitions().obterAppBarColor(),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      child: Text(
                        'Sim',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                ],
              ),
        ) ??
        false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _back,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TextDefinition().obterAppHomeText()),
          bottom: TabBar(
            isScrollable: true,
            controller: _controller,
            tabs:
                TabBarBuild().obterTabBarList(widget.model.dias.dia, _temFeed),
          ),
          backgroundColor: ColorsDefinitions().obterAppBarColor(),
        ),
        body: TabBarView(
          controller: _controller,
          children: TabBarBuild().obterTabBarItensList(
              widget.model.dias.dia,
              widget.model.eventos,
              widget.model.feed,
              widget.model.referencia,
              widget.user,
              _temFeed),
        ),
        drawer: SideMenu(
            widget.model.parceiros,
            widget.model.patrocinadores,
            widget.model.organizacao,
            widget.model.referencia,
            widget.onSignedOut,
            widget.user,
            _messaging,
            _notificacao),
      ),
    );
  }
}
