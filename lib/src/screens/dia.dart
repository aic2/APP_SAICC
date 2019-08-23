import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/card.dart';
import '../mixins/eventosModel.dart';

class Dia extends StatefulWidget {
  String dia;
  List<EventosModel> eventos;
  DatabaseReference ref;
  String useruid;
  Dia(this.dia, this.eventos, this.ref, this.useruid) : super();
  @override
  createState() => _DiaState();
}

class _DiaState extends State<Dia> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: obterListaCards(widget.eventos, widget.dia, widget.ref),
      ),
    );
  }

  List<Widget> obterListaCards(List<EventosModel> eventos, String dia, DatabaseReference ref) {
    List<EventosModel> eventodia = List<EventosModel>();
    for (int a = 0; a < eventos.length; a++) {
      if (eventos[a].data == dia) {
        eventodia.add(eventos[a]);
      }
    }
    eventodia.sort((a, b)=> (a.hora).compareTo(b.hora));
    if(widget.useruid != ''){
      eventodia.sort((a, b)=> (b.favoritar == true ? 1 : 0).compareTo(a.favoritar == true ? 1 : 0));
    }
    List<Widget> lista = new List<Widget>();
    for (int a = 0; a < eventodia.length; a++) {
      lista.add(CardPalestra(eventodia[a], ref, widget.useruid));
    }
    return lista;
  }
}
