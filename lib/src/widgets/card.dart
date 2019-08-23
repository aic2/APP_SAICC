import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/palestra.dart';
import '../screens/palestrante.dart';
import '../mixins/eventosModel.dart';
import '../definitions/colors.dart';
import '../definitions/images.dart';
import '../screens/maps.dart';
import '../sources/firebase.dart';

class CardPalestra extends StatefulWidget {
  EventosModel model;
  DatabaseReference ref;
  String useruid;
  CardPalestra(this.model, this.ref, this.useruid) : super();
  @override
  _CardPalestraState createState() {
    return new _CardPalestraState();
  }
}

class _CardPalestraState extends State<CardPalestra> {
  final definitions = ColorsDefinitions();
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Palestra(widget.model, widget.ref, widget.useruid),
                ),
              );
            },
            child: Container(
              decoration: new BoxDecoration(
                color: definitions.obterCardBackground(),
                image: DecorationImage(
                  image: ImageDefinition()
                      .obterPalestraImage(widget.model.imagemtema),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.rectangle,
              ),
              height: 150.0,
            ),
          ),
          Container(
            color: definitions.obterCardContainerColor(),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.model.titulo,
                    style: TextStyle(
                      color: definitions.obterDiaCardText(),
                      fontSize: 20.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    widget.model.hora + ' - ' + widget.model.tipo,
                    style: TextStyle(
                      color: definitions.obterDiaCardText(),
                      fontSize: 15.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Palestra(widget.model, widget.ref, widget.useruid),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundImage: ImageDefinition()
                        .obterPersonImage(widget.model.imagemperfilautor),
                  ),
                  title: Text(
                    widget.model.autor,
                    style: TextStyle(
                      color: definitions.obterDiaCardText(),
                      fontSize: 15.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            Palestrante(widget.model),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        color: widget.model.favoritoColor,
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          if (widget.useruid == '') {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                content: ListTile(
                                  title: Text('Ação não permitida!'),
                                  subtitle: Text(
                                      'É necessário estar logado para realizar essa operação!'),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    color:
                                        ColorsDefinitions().obterAppBarColor(),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0)),
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            String key;
                            FirebaseDatabaseSnapshot().setFavoritos(
                                widget.ref,
                                widget.model.key,
                                widget.useruid,
                                widget.model.favoritar,
                                widget.model.keyfavorito);
                            FirebaseDatabaseSnapshot()
                                .getLastFavorito(widget.ref, widget.model.key,
                                    widget.useruid)
                                .then((onValue) {
                              key = onValue;
                            });
                            setState(() {
                              if (!widget.model.favoritar) {
                                widget.model.favoritoColor =
                                    Colors.white.withOpacity(0.6);
                                widget.model.favoritar = true;
                                widget.model.keyfavorito = key;
                              } else {
                                widget.model.favoritoColor =
                                    Colors.black.withOpacity(0.4);
                                widget.model.favoritar = false;
                                widget.model.keyfavorito = key;
                              }
                            });
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.location_on),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Maps(),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          launch(
                              'https://www.facebook.com/events/334206930590079/');
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
