import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:url_launcher/url_launcher.dart';
import '../definitions/colors.dart';
import '../definitions/images.dart';
import '../mixins/eventosModel.dart';
import '../screens/maps.dart';
import '../sources/firebase.dart';

class Palestra extends StatefulWidget {
  EventosModel model;
  DatabaseReference ref;
  String useruid;
  Palestra(this.model, this.ref, this.useruid) : super();
  @override
  createState() => _PalestraState();
}

class _PalestraState extends State<Palestra> {
  final definitions = ColorsDefinitions();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        cacheExtent: 10.0,
        slivers: <Widget>[
          SliverAppBar(
            floating: true,
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: ImageDefinition()
                  .obterPalestraImageWidget(widget.model.imagemtema),
              title: Text(
                widget.model.tipo + ' - ' + widget.model.hora,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.favorite),
                        color: widget.model.favoritoColorPal,
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
                                widget.model.favoritoColorPal =
                                    Colors.red.shade900.withOpacity(0.6);
                                widget.model.favoritar = true;
                                widget.model.keyfavorito = key;
                              } else {
                                widget.model.favoritoColorPal =
                                    definitions.obterPalestraIcon();
                                widget.model.favoritar = false;
                                widget.model.keyfavorito = key;
                              }
                            });
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 95.0),
                      ),
                      IconButton(
                        icon: Icon(Icons.location_on),
                        color: definitions.obterPalestraIcon(),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => Maps(),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 95.0),
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        color: definitions.obterPalestraIcon(),
                        onPressed: () {
                          launch(
                              'https://www.facebook.com/events/334206930590079/');
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 5.0, top: 5.0, right: 20.0, left: 20.0),
                  child: Text(
                    widget.model.titulo,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: definitions.obterPalestraText(),
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 5.0, top: 5.0, right: 20.0, left: 20.0),
                  child: Text(
                    widget.model.subtitulo,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: definitions.obterPalestraText(),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 10.0, top: 5.0, right: 20.0, left: 20.0),
                  child: Text(
                    widget.model.descricao,
                    style: TextStyle(
                      color: definitions.obterPalestraText(),
                      fontSize: 17.0,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 5.0,
                ),
                Container(
                  margin: EdgeInsets.only(
                      bottom: 10.0, top: 5.0, right: 10.0, left: 10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            bottom: 2.0, top: 2.0, right: 10.0, left: 10.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: ImageDefinition()
                              .obterPersonImage(widget.model.imagemperfilautor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                      ),
                      Text(
                        widget.model.autor,
                        style: TextStyle(
                          color: definitions.obterPalestraText(),
                          fontSize: 20.0,
                          height: 2.0,
                        ),
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
