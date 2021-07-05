import 'package:bloc_app/CharactersListScreen/MarvelCharactersNetworkManager.dart';
import 'package:bloc_app/Constants/ConfigurationKeys.dart';

import 'CharacterModels/CharacterModel.dart';
import 'package:bloc_app/Constants/APIConstants.dart';

class CharactersRepository {
  Future<CharactersResponseRootModel> fetchMarvelCharacters(
      {int page = 0}) async {
    Map<String, dynamic> queryParamters = {
      "ts": ConfigurationKeys.timeStamp,
      "apikey": ConfigurationKeys.apiKey,
      "hash": ConfigurationKeys.hash,
      "offset": "$page"
    };
    MarvelCharactersNetworkManager networkManager =
        MarvelCharactersNetworkManager();
    CharactersResponseRootModel charactersResponseRootModel =
        await networkManager.getCharacters(URLs.characters, queryParamters);
    return charactersResponseRootModel;
  }
}

extension MarvelCharacterUIModel on MarvelCharacterResult {
  String get title => name;
  String get imagePath => (this.thumbnail.path + "." + this.thumbnail.extension)
      .replaceFirst("http:", "https:");
}

extension MarvelCharactersPagination on MarvelCharactersData {
  bool get findNewPages {
    int pageNumber = offset;
    int totalPages = total;
    int pageLimit = limit;

    if (pageNumber < totalPages && pageLimit == marvelCharacterResults.length) {
      return true;
    } else {
      return false;
    }
  }
}

// mixin MarvelCharacterUIModel {
//   String get imageTitle;
//   String get imagePath {
//     return "this.thumbnail.path + this.thumbnail.extension.toString()";
//   }
// }
