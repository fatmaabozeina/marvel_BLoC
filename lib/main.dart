import 'package:bloc_app/CharactersListScreen/CharactersBloc.dart';
import 'package:bloc_app/CharactersListScreen/CharactersPage.dart';
import 'package:bloc_app/CharactersListScreen/CharactersRepsitory.dart';
import 'package:bloc_app/Constants/Titles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Titles.marvelCharactersTitles,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => MarvelCharactersBloc(CharactersRepository()),
        child: MarvelCharactersPage(),
      ),
    );
  }
}
