class TextDefinition {
  String obterAppHomeText() {
    return 'SAICC IX';
  }

  String obterSplashScreenText() {
    return 'SAICC IX';
  }

  String obterFeedFonteText(String fonte) {
    if (fonte == '') {
      return "PET Ciências Computacionais";
    } else {
      return fonte;
    }
  }
}
