import 'package:flutter/material.dart';
import '../widgets/slivergrid.dart';
import '../definitions/colors.dart';
import '../mixins/patrocinadoresModel.dart';

class Patrocinadores extends StatefulWidget {
  List<PatrocinadoresModel> patrocinadores;
  Patrocinadores(this.patrocinadores) : super();
  @override
  createState() => _PatrocinadoresState();
}

class _PatrocinadoresState extends State<Patrocinadores> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: ColorsDefinitions().obterAppBarColor(),
        title: new Text('Patrocinadores'),
      ),
      body: Container(
        margin: EdgeInsets.only(right: 5.0, left: 5.0),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverGrid.count(
                crossAxisCount: 1,
                children: SliverGridBuild().obterPatrocinadorList(
                    widget.patrocinadores, 'ouro', 175.0, 20.0, context)),
            SliverGrid.count(
              crossAxisCount: 2,
              children: SliverGridBuild().obterPatrocinadorList(
                  widget.patrocinadores, 'prata', 75.0, 15.0, context),
            ),

            ///PARTE DOS OUTROS
            SliverGrid.count(
              crossAxisCount: 3,
              children: SliverGridBuild().obterPatrocinadorList(
                  widget.patrocinadores, 'padrao', 45.0, 10.0, context),
            ),
          ],
        ),
      ),
    );
  }
}
