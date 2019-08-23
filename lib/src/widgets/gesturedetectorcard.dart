import 'package:flutter/material.dart';
import '../mixins/feedModel.dart';
import '../definitions/text.dart';
import '../definitions/images.dart';
import '../screens/noticia.dart';

class CardFeed extends StatefulWidget {
  FeedModel model;
  CardFeed(this.model) : super();
  @override
  _CardFeedState createState() {
    return new _CardFeedState();
  }
}

class _CardFeedState extends State<CardFeed> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => Noticia(widget.model),
          ),
        );
      },
      child: Card(
        child: new Column(
          children: <Widget>[
            new ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundImage:
                    ImageDefinition().obterPersonImage(widget.model.imagemfonte),
              ),
              title: new Text(
                TextDefinition().obterFeedFonteText(widget.model.fonte),
                style: new TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                image: DecorationImage(
                  image: ImageDefinition().obterPalestraImage(widget.model.imagemtema),
                  //fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
              height: 150.0,
            ),
            ListTile(
              title: Text(widget.model.titulo),
            )
          ],
        ),
      ),
    );
  }
}
