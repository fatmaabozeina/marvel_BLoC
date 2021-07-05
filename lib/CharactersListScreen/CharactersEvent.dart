import 'package:equatable/equatable.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();
}

class GetMarvelCharacters extends CharactersEvent {
  final String characterName = "";
  @override
  List<Object> get props => [characterName];
}

class SearchMarvelCharacter extends CharactersEvent {
  final characterName;
  const SearchMarvelCharacter(this.characterName);
  @override
  List<Object> get props => [characterName];
}
