import 'package:flutter/material.dart';

class ImageDefinition {
  Image obterSplashScreenImage() {
    return Image.asset(
      'assets/logosaicc.png',
      height: 140,
      width: 150,
      alignment: Alignment.center,
      fit: BoxFit.contain,
    );
  }

  ImageProvider obterPersonImage(String imagem) {
    try {
      if (imagem == '') {
        return AssetImage('assets/temp_person.png');
      } else {
        return NetworkImage(imagem);
      }
    } catch (e) {
      return AssetImage('assets/temp_person.png');
    }
  }

  Widget obterPersonImageWidget(String imagem) {
    try {
      if (imagem == '') {
        return Image.asset(
          'assets/temp_person.png',
          fit: BoxFit.cover,
        );
      } else {
        return Image.network(
          imagem,
          fit: BoxFit.cover,
        );
      }
    } catch (e) {
      return Image.asset(
        'assets/temp_person.png',
        fit: BoxFit.cover,
      );
    }
  }

  ImageProvider obterPalestraImage(String imagem) {
    try {
      if (imagem == '') {
        return AssetImage('assets/temp_palestra.jpg');
      } else {
        return NetworkImage(imagem);
      }
    } catch (e) {
      return AssetImage('assets/temp_palestra.jpg');
    }
  }

  Widget obterPalestraImageWidget(String imagem) {
    try {
      if (imagem == '') {
        return Image.asset('assets/temp_palestra.jpg', fit: BoxFit.cover);
      } else {
        return Image.network(imagem, fit: BoxFit.cover);
      }
    } catch (e) {
      return Image.asset('assets/temp_palestra.jpg', fit: BoxFit.cover);
    }
  }

  AssetImage obterDrawerTema() {
    return AssetImage('assets/logosaicc.png');
  }

  ImageProvider obterLogin() {
    return AssetImage('assets/temp_personv_1.png');
  }
}
