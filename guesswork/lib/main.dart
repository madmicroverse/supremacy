import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'core/domain/entity/sag_game/sag_game.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /**
   * Injectable
   * Keep an eye on the time the DI setup take, should be as minimal as possible
   */
  await configureDependencies();

  runApp(GetIt.instance<MaterialApp>());
}

final sagGame = SAGGame(
  id: "123",
  title: 'Animales',
  previewImage:
      'https://img.freepik.com/vector-gratis/animales-dibujados-mano-parecidos-ninos-leyendo-ilustracion_23-2151345169.jpg',
  description: 'Demo guess set description',
  sageGameItemList: [
    SAGGameItem(
      id: "0",
      version: 0,
      points: 1000,
      guessImageUrl:
          'https://images.snapwi.re/a584/5c8292fa3e294263ae5c78f9.w800.jpg',
      question: 'Que animal es?',
      optionList: [
        Option(id: 1, text: 'Elefante'),
        Option(id: 0, text: 'Perezoso'),
        Option(id: 3, text: 'Conejo'),
        Option(id: 2, text: 'Mamut'),
      ],
      answer: null,
      answerOptionId: 0,
    ),
    SAGGameItem(
      id: "1",
      version: 0,
      points: 1000,
      guessImageUrl:
          'https://imgs.search.brave.com/CUDYcKzYGYMWx32fXLdGRzqpEs0FlCoY8b_gdQyIGlM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbmth/bmRkcm9wLmNvbS9j/ZG4vc2hvcC9wcm9k/dWN0cy8xMDI5LXBy/aW50b25seS0zOTQ4/ODQuanBnP3Y9MTY5/ODkyODUzNiZ3aWR0/aD0xMjAw',
      question: 'Que animal es?',
      optionList: [
        Option(id: 1, text: 'Mamut'),
        Option(id: 0, text: 'Elefante'),
        Option(id: 3, text: 'Oso'),
        Option(id: 2, text: 'Conejo'),
      ],
      answer: null,
      answerOptionId: 1,
    ),
    SAGGameItem(
      id: "2",
      version: 0,
      points: 1000,
      guessImageUrl:
          'https://imgs.search.brave.com/M-WvUXOZ2qATbwNEewR5WUSZiVQNbQslKPzqa--YDNk/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNTQx/MDUzNzY2L3Bob3Rv/L3BvcnRyYWl0LW9m/LWFmcmljYW4tZWxl/cGhhbnQuanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPWNSVEl6/YlY1R2U4QURnRHIy/SkdJMS1oZlBaYkYz/SEYzZURMNFJqbU9G/Wmc9',
      question: 'Que animal es?',
      optionList: [
        Option(id: 1, text: 'Mamut'),
        Option(id: 0, text: 'Elefante'),
        Option(id: 3, text: 'Oso'),
        Option(id: 2, text: 'Conejo'),
      ],
      answer: null,
      answerOptionId: 1,
    ),
  ],
);
