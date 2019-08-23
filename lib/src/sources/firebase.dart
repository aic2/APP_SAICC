import 'package:SAICCIX/src/mixins/feedModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../mixins/rootModel.dart';

//request por HTTP
class FirebaseJson {
  Future<RootModel> getData() async {
    Response response = await get('https://saicix.firebaseio.com/.json');
    RootModel model = RootModel.fromJson(json.decode(response.body));
    return model;
  }
}

//request por API
class FirebaseDatabaseSnapshot {
  Future<RootModel> getData() async {
    DatabaseReference ref;
    RootModel model;
    ref = await FirebaseDatabase.instance.reference();
    try{
    await ref.child('conteudo').once().then((DataSnapshot snapshot) {
      if (snapshot != null) {
        model = RootModel.fromSnapshot(snapshot);
      }
    });
    }catch(e){
    }
    model.referencia = ref;
    return model;
  }

  Future<List<FeedModel>> getFeedData(DatabaseReference ref) async {
    FeedListModel model;
    ref = await FirebaseDatabase.instance.reference();
    await ref
        .child('conteudo')
        .child('feed')
        .once()
        .then((DataSnapshot snapshot) {
      model = FeedListModel.fromSnapshot(snapshot);
    });
    return model.feed;
  }

  Future<bool> getTokenSmartphone(
      DatabaseReference ref, String token, FirebaseUser user) async {
    bool retorno = false;
    await ref
        .child('administracao')
        .child('tokens')
        .child(user.uid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.value == '-') {
        retorno = false;
      } else {
        retorno = true;
        //   if (snapshot.value == token) {
        //   retorno = true;
        // }
      }
    });
    return retorno;
  }

  Future<bool> updateTokenSmartphone(DatabaseReference ref, String token,
      FirebaseUser user, bool temchave) async {
    bool retorno = false;
    if (temchave) {
      await ref.child('administracao').child('tokens').child(user.uid).set('-');
    } else {
      await ref
          .child('administracao')
          .child('tokens')
          .child(user.uid)
          .set(token);
      retorno = true;
    }
    return retorno;
  }

  Future<void> setFavoritos(DatabaseReference ref, String palestraid,
      String userid, bool favoritar, String keyfavorito) async {
    if (favoritar) {
      await ref
          .child('administracao')
          .child('favoritos')
          .child(userid)
          .child(keyfavorito)
          .set(null);
    } else {
      await ref
          .child('administracao')
          .child('favoritos')
          .child(userid)
          .push()
          .set(palestraid);
    }
  }

  Future<String> getLastFavorito(
      DatabaseReference ref, String palestraid, String userid) async {
    String retorno;
    await ref
        .child('administracao')
        .child('favoritos')
        .child(userid)
        .endAt(palestraid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot != null) {
        retorno = snapshot.key;
      }
    });
    return retorno;
  }

  Future<Map<String, dynamic>> getFavoritos(
      DatabaseReference ref, String userid) async {
    Map<String, dynamic> mapeamento;
    await ref
        .child('administracao')
        .child('favoritos')
        .child(userid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot != null) {
        String dados = jsonEncode(snapshot.value);
        mapeamento = json.decode(dados);
      }
    });
    return mapeamento;
  }

  Future<void> setPergunta(DatabaseReference ref, String palestraid,
      FirebaseUser user, String pergunta) async {
    bool temchave = false;
    await ref
        .child('administracao')
        .child('perguntas')
        .child(palestraid)
        .equalTo(user.uid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot.key != null) {
        temchave = true;
      }
    });
    if (!temchave) {
      Object obj = {
        user.uid: {
          'email': user.email,
          'pergunta': pergunta,
        }
      };
      await ref
          .child('administracao')
          .child('perguntas')
          .child(palestraid)
          .set(obj);
    }
  }

  Future<Map<String, dynamic>> getPergunta(
      DatabaseReference ref, String palestraid, String userid) async {
    Map<String, dynamic> mapeamento;
    await ref
        .child('administracao')
        .child('perguntas')
        .child(palestraid)
        .equalTo(userid)
        .once()
        .then((DataSnapshot snapshot) {
      if (snapshot != null) {
        String dados = jsonEncode(snapshot.value);

        mapeamento = json.decode(dados);
      }
    });
    return mapeamento;
  }
}

//API STORAGE
class FirebaseStorageFiles {
  Future<String> uploadImage(File file, FirebaseUser user) async {
    final StorageReference storageRef = FirebaseStorage.instance.ref();
    final StorageUploadTask uploadTask =
        storageRef.child('users').child(user.uid).putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    return (await downloadUrl.ref.getDownloadURL());
  }
}
