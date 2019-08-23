import 'package:flutter/material.dart';
import '../definitions/colors.dart';

class Desenvolvedores extends StatefulWidget {
  @override
  createState() => _DesenvolvedoresState();
}

class _DesenvolvedoresState extends State<Desenvolvedores> {
  @override
  Widget build(BuildContext context) {
    final definitions = ColorsDefinitions();
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Desenvolvedores'),
        backgroundColor: definitions.obterAppBarColor(),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 2.0, top: 2.0, right: 10.0, left: 10.0),
                    child: Text(
                      "Aplicativo produzido e orientado pela disciplina de Atividade de Integração Currícular II, do curso de Sistemas de Informação da Universidade Federal do Rio Grande - FURG, cuja disciplina é orientada pelas professoras Luciane Baldassari Soares e Regina Barwaldt.",
                      style: TextStyle(
                        color: definitions.obterPalestraText(),
                        fontSize: 20.0,
                        height: 2.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 2.0, top: 2.0, right: 10.0, left: 10.0),
                    child: Text(
                      "Aplicativo desenvolvido por:",
                      style: TextStyle(
                        color: definitions.obterPalestraText(),
                        fontSize: 20.0,
                        height: 2.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
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
                            backgroundImage: NetworkImage(
                                'https://scontent.fpet2-1.fna.fbcdn.net/v/t1.0-9/59977750_137316370766509_815752570277462016_n.jpg?_nc_cat=101&_nc_ht=scontent.fpet2-1.fna&oh=2e390b9c95edcaefe74fb8aea1436d76&oe=5D9B70F6'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                        ),
                        Text(
                          'Jardel Dargas Silva',
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
                            backgroundImage: NetworkImage(
                                'https://scontent.fpet2-1.fna.fbcdn.net/v/t1.0-1/52629677_2072246332860912_8931786032819470336_n.jpg?_nc_cat=105&_nc_ht=scontent.fpet2-1.fna&oh=bbb61e8e137641d520318ab3cfc2ff6a&oe=5D9014CC'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                        ),
                        Text(
                          'Joelson Sartory Junior',
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
                            backgroundImage: NetworkImage(
                                'https://scontent.fpet2-1.fna.fbcdn.net/v/t1.0-9/57121024_1775256899242933_6712583010866167808_n.jpg?_nc_cat=103&_nc_ht=scontent.fpet2-1.fna&oh=78742f07d72a7301ea043dc5375bff14&oe=5D97CECA'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                        ),
                        Text(
                          'Junior Zilles',
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
            ]),
          ),
        ],
      ),
    );
  }
}
