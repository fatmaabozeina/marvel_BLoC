import 'package:flutter/material.dart';

class MarvelCharacterCard extends StatelessWidget {
  final String characterTitle;
  final String characterImagePath;
  MarvelCharacterCard({Key key, this.characterTitle, this.characterImagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Colors.black,
          child: Image(
            fit: BoxFit.fill,
            image: NetworkImage(characterImagePath),
          ),
        ),
        Positioned(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Text(characterTitle),
              color: Colors.white),
          bottom: 15,
          left: 20,
        )
      ],
    );
  }
}
