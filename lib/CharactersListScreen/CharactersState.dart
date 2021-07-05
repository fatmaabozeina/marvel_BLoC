import 'package:bloc_app/CharactersListScreen/CharacterModels/CharacterModel.dart';
import 'package:equatable/equatable.dart';

abstract class CharactersState extends Equatable {
  const CharactersState();
}

class CharactersInitial extends CharactersState {
  const CharactersInitial();

  @override
  List<Object> get props => [];
}

class CharactersLoading extends CharactersState {
  const CharactersLoading();

  @override
  List<Object> get props => [];
}

class CharactersLoaded extends CharactersState {
  const CharactersLoaded({this.marvelCharactersData});
  final MarvelCharactersData marvelCharactersData;
  @override
  List<Object> get props => [marvelCharactersData];
}

class CharactersError extends CharactersState {
  final String message;
  const CharactersError(this.message);
  @override
  List<Object> get props => [message];
}
