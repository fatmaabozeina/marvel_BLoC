import 'package:bloc/bloc.dart';
import 'package:bloc_app/CharactersListScreen/CharactersEvent.dart';
import 'package:bloc_app/CharactersListScreen/CharactersRepsitory.dart';
import 'package:bloc_app/CharactersListScreen/CharactersState.dart';

class MarvelCharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository repository;
  int page = 0;
  MarvelCharactersBloc(this.repository) : super(CharactersInitial());

  CharactersState get initialState => CharactersInitial();

  @override
  Stream<CharactersState> mapEventToState(CharactersEvent event) async* {
    CharactersLoading();
    if (event == GetMarvelCharacters()) {
      final marvelCharacters =
          await repository.fetchMarvelCharacters(page: page);
      if (marvelCharacters.code == 200) {
        yield CharactersLoaded(marvelCharactersData: marvelCharacters.data);
        page++;
      } else {
        yield CharactersError(marvelCharacters.message);
      }
    }
  }
}
