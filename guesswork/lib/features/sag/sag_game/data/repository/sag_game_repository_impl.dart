import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/features/sag/sag_game/domain/repository/sag_game_repository.dart';

class SAGGameRepositoryImpl extends SAGGameRepository {
  @override
  Future<List<SAGGamePreview>> getSAGGamePreviewList() async {
    return [
      SAGGamePreview.fromJson(sagJson).copyWith(id: 0),
      SAGGamePreview.fromJson(sagJson).copyWith(id: 1),
      SAGGamePreview.fromJson(sagJson).copyWith(id: 2),
    ];
  }

  @override
  Future<SAGGame> getSAGGame(String url) async {
    return SAGGame.fromJson(sagJson);
  }
}

final sagJson = {
  'id': 123,
  'title': 'Animales',
  'previewImage':
      'https://img.freepik.com/vector-gratis/animales-dibujados-mano-parecidos-ninos-leyendo-ilustracion_23-2151345169.jpg',
  'description': 'Demo guess set description',
  'guessGameList': [
    {
      'id': 0,
      'version': 0,
      'points': 1000,
      'question': 'Que animal es?',
      "answer": 0,
      'guessImageUrl':
          'https://images.snapwi.re/a584/5c8292fa3e294263ae5c78f9.w800.jpg',
      'optionList': [
        {'id': 1, 'text': 'Elefante'},
        {'id': 0, 'text': 'Perezoso'},
        {'id': 3, 'text': 'Conejo'},
        {'id': 2, 'text': 'Mamut'},
      ],
    },
    {
      'id': 1,
      'version': 0,
      'points': 1000,
      'question': 'Que animal es?',
      "answer": 3,
      'guessImageUrl':
          'https://imgs.search.brave.com/CUDYcKzYGYMWx32fXLdGRzqpEs0FlCoY8b_gdQyIGlM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbmth/bmRkcm9wLmNvbS9j/ZG4vc2hvcC9wcm9k/dWN0cy8xMDI5LXBy/aW50b25seS0zOTQ4/ODQuanBnP3Y9MTY5/ODkyODUzNiZ3aWR0/aD0xMjAw',
      'optionList': [
        {'id': 2, 'text': 'Mamut'},
        {'id': 1, 'text': 'Elefante'},
        {'id': 0, 'text': 'Oso'},
        {'id': 3, 'text': 'Conejo'},
      ],
    },
    {
      'id': 1,
      'version': 0,
      'points': 1000,
      'question': 'Que animal es?',
      "answer": 1,
      'guessImageUrl':
          'https://imgs.search.brave.com/M-WvUXOZ2qATbwNEewR5WUSZiVQNbQslKPzqa--YDNk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNTQx/MDUzNzY2L3Bob3Rv/L3BvcnRyYWl0LW9m/LWFmcmljYW4tZWxl/cGhhbnQuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPWNSVEl6/YlY1R2U4QURnRHIy/SkdJMS1oZlBaYkYz/SEYzZURMNFJqbU9G/Wmc9',
      'optionList': [
        {'id': 2, 'text': 'Mamut'},
        {'id': 1, 'text': 'Elefante'},
        {'id': 0, 'text': 'Oso'},
        {'id': 3, 'text': 'Conejo'},
      ],
    },
  ],
};
