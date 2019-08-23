import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EventosModel {
  String key;
  String autor;
  String autoremail;
  String autorformacao;
  String autorprofissao;
  String data;
  String descricao;
  String hora;
  bool favoritar = false;
  Color favoritoColor = Colors.black.withOpacity(0.4);
  Color favoritoColorPal = Colors.grey[600];
  String keyfavorito;
  String imagemperfilautor;
  String imagemtema;
  String subtitulo;
  String lattes;
  String linkedin;
  String tipo;
  String titulo;

  EventosModel(
      this.key,
      this.tipo,
      this.autor,
      this.autoremail,
      this.autorformacao,
      this.autorprofissao,
      this.data,
      this.descricao,
      this.hora,
      this.imagemperfilautor,
      this.imagemtema,
      this.lattes,
      this.linkedin,
      this.subtitulo,
      this.titulo);

  EventosModel.fromJson(Map<String, dynamic> parsedJson, String id) {
    key = id;
    tipo = parsedJson['tipo'] != null ? parsedJson['tipo'] : '';
    autor = parsedJson['autor']!= null ? parsedJson['autor'] : '';
    autoremail = parsedJson['autoremail']!= null ? parsedJson['autoremail'] : '';
    autorformacao = parsedJson['autorformacao']!= null ? parsedJson['autorformacao'] : '';
    autorprofissao = parsedJson['autorprofissao']!= null ? parsedJson['autorprofissao'] : '';
    data = parsedJson['data']!= null ? parsedJson['data'] : '';
    descricao = parsedJson['descricao']!= null ? parsedJson['descricao'] : '';
    hora = parsedJson['hora']!= null ? parsedJson['hora'] : '';
    imagemperfilautor = parsedJson['imagemperfilautor']!= null ? parsedJson['imagemperfilautor'] : '';
    lattes = parsedJson['lattes']!= null ? parsedJson['lattes'] : '';
    linkedin = parsedJson['linkedin']!= null ? parsedJson['linkedin'] : '';
    subtitulo = parsedJson['subtitulo']!= null ? parsedJson['subtitulo'] : '';
    titulo = parsedJson['titulo']!= null ? parsedJson['titulo'] : '';
    imagemtema = parsedJson['imagemtema']!= null ? parsedJson['imagemtema'] : '';
  }

  EventosModel.fromSnapshot(DataSnapshot snapshot, String id) {
    key = id;
    tipo = snapshot.value['tipo']!= null ? snapshot.value['tipo'] : '';
    autor = snapshot.value['autor']!= null ? snapshot.value['autor'] : '';
    autoremail = snapshot.value['autoremail']!= null ? snapshot.value['autoremail'] : '';
    autorformacao = snapshot.value['autorformacao']!= null ? snapshot.value['autorformacao'] : '';
    autorprofissao = snapshot.value['autorprofissao']!= null ? snapshot.value['autorprofissao'] : '';
    data = snapshot.value['data']!= null ? snapshot.value['data'] : '';
    descricao = snapshot.value['descricao']!= null ? snapshot.value['descricao'] : '';
    hora = snapshot.value['hora']!= null ? snapshot.value['hora'] : '';
    imagemperfilautor = snapshot.value['imagemperfilautor']!= null ? snapshot.value['imagemperfilautor'] : '';
    lattes = snapshot.value['lattes']!= null ? snapshot.value['lattes'] : '';
    linkedin = snapshot.value['linkedin']!= null ? snapshot.value['linkedin'] : '';
    subtitulo = snapshot.value['subtitulo']!= null ? snapshot.value['subtitulo'] : '';
    titulo = snapshot.value['titulo']!= null ? snapshot.value['titulo'] : '';
    imagemtema = snapshot.value['imagemtema']!= null ? snapshot.value['imagemtema'] : '';
  }
}
