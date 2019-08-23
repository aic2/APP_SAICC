import 'package:flutter/material.dart';
import '../mixins/parceirosModel.dart';
import '../mixins/patrocinadoresModel.dart';
import '../definitions/colors.dart';

class SliverGridBuild {
  List<Widget> obterParceirosList(List<ParceirosModel> parceiros, BuildContext context) {
    List<Widget> lista = new List<Widget>();
    for (int i = 0; i < parceiros.length; i++) {
      lista.add(
        GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              content: Image.network(parceiros[i].logo),
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
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: 75.0,
              height: 75.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  //fit: BoxFit.fill,
                  image: new NetworkImage(parceiros[i].logo),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text(
              parceiros[i].nome,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      );
    }
    return lista;
  }

  List<Widget> obterPatrocinadorList(List<PatrocinadoresModel> patrocinadores,
      String tipo, double alturalargura, double fonte, BuildContext context) {
    List<PatrocinadoresModel> simples = List<PatrocinadoresModel>();
    for (int a = 0; a < patrocinadores.length; a++) {
      if (patrocinadores[a].tipo == tipo) {
        simples.add(patrocinadores[a]);
      }
    }
    List<Widget> lista = new List<Widget>();
    for (int i = 0; i < simples.length; i++) {
      lista.add(GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              content: Image.network(simples[i].logo),
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
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: alturalargura,
              height: alturalargura,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                  //fit: BoxFit.fill,
                  image: new NetworkImage(simples[i].logo),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Text(
              simples[i].nome,
              style: TextStyle(
                fontSize: fonte,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ));
    }
    return lista;
  }
}
