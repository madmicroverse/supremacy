import 'package:guesswork/core/domain/entity/sag_game/sag_game.dart';
import 'package:guesswork/core/domain/extension/basic.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';

extension ListUtils<T> on List<T> {
  List<T> replaceWhere(T replacement, bool Function(T e) condition) {
    var newList = [...this];
    final newSAGGameItemIndex = indexWhere(condition);
    newList[newSAGGameItemIndex] = replacement;
    return newList;
  }

  bool all(bool Function(T e) condition) {
    for (final item in this) {
      if (!condition(item)) {
        return false;
      }
    }
    return true;
  }
}

extension SAGGameMutation on SAGGame {
  SAGGame withSAGGameItem(SAGGameItem newSagGameItem) {
    final newSAGeGameItemList = sageGameItemList.replaceWhere(
      newSagGameItem,
      (sagGameItem) => sagGameItem.id == newSagGameItem.id,
    );
    return copyWith(sageGameItemList: newSAGeGameItemList);
  }

  SAGGame get withoutAnswers {
    final newSAGeGameItemList =
        sageGameItemList
            .map((sagGameItem) => sagGameItem.withoutAnswer)
            .toList();
    return copyWith(sageGameItemList: newSAGeGameItemList);
  }

  SAGGame get completed => copyWith(
    isCompleted: sageGameItemList.all((sagGameItem) {
      final result = sagGameItem.answer.isNotNull;
      return result;
    }),
  );

  SAGGame get claimed => copyWith(isClaimed: true);
}

extension SAGGameQueries on SAGGame? {
  int get pointsGained =>
      this?.sageGameItemList.fold(0, (acc, sagGameItem) {
        final points =
            sagGameItem.points *
            sagGameItem.answer.concealedRatioOrZero *
            sagGameItem.isCorrectAnswer.intValue;
        return acc! + points.toInt();
      }) ??
      0;
}

extension SAGGameMutations on SAGGameItem {
  SAGGameItem withAnswer(SAGGameItemAnswer answer) => copyWith(answer: answer);

  SAGGameItem get withoutAnswer => copyWith(answer: null);
}

extension SAGGameItemQueries on SAGGameItem? {
  bool get isCorrectAnswer =>
      isNotNull && this?.answer?.answerOptionId == this?.answerOptionId;
}

extension SAGGameAnswerQueries on SAGGameItemAnswer? {
  double get concealedRatioOrZero => this?.concealedRatio ?? 0;
}
