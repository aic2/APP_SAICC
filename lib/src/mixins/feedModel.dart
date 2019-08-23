import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

class FeedModel {
  String key;
  String descricao;
  String imagemtema;
  String titulo;
  String fonte;
  String imagemfonte;

  FeedModel(this.descricao, this.imagemtema, this.titulo, this.key, this.fonte, this.imagemfonte);

  FeedModel.fromJson(Map<String, dynamic> parsedJson, String id) {
    key = id;
    descricao = parsedJson['descricao']!= null ? parsedJson['descricao'] : '';
    titulo = parsedJson['titulo']!= null ? parsedJson['titulo'] : '';
    imagemtema = parsedJson['imagemtema']!= null ? parsedJson['imagemtema'] : '';
    fonte = parsedJson['fonte']!= null ? parsedJson['fonte'] : '';
    imagemfonte = parsedJson['imagemfonte']!= null ? parsedJson['imagemfonte'] : '';
  }
}
class FeedListModel{
  List<FeedModel> feed = List<FeedModel>();
  FeedListModel(this.feed);

  FeedListModel.fromSnapshot(DataSnapshot snapshot) {
    String dados = jsonEncode(snapshot.value);
    
    Map<String, dynamic> mapeamento = json.decode(dados);

    List<String> keys = mapeamento.keys.toList();
    for (int a = 0; a < keys.length; a++) {
      Map<String, dynamic> parsed = mapeamento[keys[a]];
      feed.add(FeedModel.fromJson(parsed, keys[a]));
    }
  }
}