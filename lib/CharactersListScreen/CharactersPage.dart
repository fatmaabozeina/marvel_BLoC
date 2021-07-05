import 'package:bloc_app/CharactersListScreen/CharacterModels/CharacterModel.dart';
import 'package:bloc_app/Constants/Titles.dart';
import 'package:bloc_app/ReusableWidgets/UIWidgets/Cards/MarvelCharacterCard.dart';
import 'package:flutter/material.dart';
import 'package:bloc_app/CharactersListScreen/CharactersRepsitory.dart';
import 'package:bloc_app/CharactersListScreen/CharactersState.dart';
import 'package:bloc_app/ReusableWidgets/UIWidgets/Loading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app/CharactersListScreen/CharactersBloc.dart';
import 'package:bloc_app/CharactersListScreen/CharactersEvent.dart';

class MarvelCharactersPage extends StatefulWidget {
  _MarvelCharactersPage createState() => _MarvelCharactersPage();
}

class _MarvelCharactersPage extends State<MarvelCharactersPage> {
  List<MarvelCharacterResult> allMarvelCharacters = [];
  bool disablePagination = false;

  @override
  void initState() {
    super.initState();
    _loadMarvelCharacters();
  }

  void _loadMoreData() async {
    // delay to let the listview know new metrices and to not call load more more than one time
    await new Future.delayed(new Duration(seconds: 2));
    _loadMarvelCharacters();
    disablePagination = false;
  }

  void _loadMarvelCharacters() {
    final marvelCharactersBloc = BlocProvider.of<MarvelCharactersBloc>(context);
    marvelCharactersBloc.add(
        GetMarvelCharacters()); // request marvel characters by firing GetMarvelCharacters Event
  }

  Widget buidMarvelCharacters(
      {List<MarvelCharacterResult> marvelCharacters, bool paginate}) {
    this.allMarvelCharacters.addAll(marvelCharacters);

    return Container(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          var reachedListViewBottom =
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent;
          if (paginate && reachedListViewBottom) {
            if (!disablePagination) {
              _loadMoreData();
              // disabling pagination to not let the loadMoreData to be called more than one time
              disablePagination = true;
            }
          }
        },
        child: ListView.builder(
          itemCount: this.allMarvelCharacters.length + (paginate ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == this.allMarvelCharacters.length) {
              return LoadMore();
            }
            return Container(
              height: 200,
              child: MarvelCharacterCard(
                characterTitle: allMarvelCharacters[index].title,
                characterImagePath: allMarvelCharacters[index].imagePath,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Titles.marvelCharactersTitles),
      ),
      body: Container(
        child: BlocBuilder<MarvelCharactersBloc, CharactersState>(
          builder: (context, state) {
            return getStateWidget(state);
          },
        ),
      ),
    );
  }

  Widget getStateWidget(CharactersState state) {
    if (state is CharactersInitial) {
      return Loading();
    } else if (state is CharactersLoading) {
      return Loading();
    } else if (state is CharactersLoaded) {
      List<MarvelCharacterResult> marvelCharacters =
          state.marvelCharactersData.marvelCharacterResults;
      bool paginate = state.marvelCharactersData.findNewPages;
      return buidMarvelCharacters(
          marvelCharacters: marvelCharacters, paginate: paginate);
    } else if (state is CharactersError) {
      return SnackBar(content: Text(state.message));
    }
    return Container(
      child: Opacity(
        opacity: 0,
      ),
    );
  }
}
