import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:guesswork/core/domain/entity/result.dart';
import 'package:guesswork/core/domain/extension/object_utils.dart';

part 'selection_button_bs.freezed.dart';

@freezed
abstract class SelectionButtonBS with _$SelectionButtonBS {
  const factory SelectionButtonBS({
    bool? isSelection,
    Function()? onPressed,
    SelectionButtonViewError? selectionButtonViewError,
  }) = _SelectionButtonBS;
}

extension SelectionButtonBSMutations on SelectionButtonBS {
  SelectionButtonBS withIsSelection(bool isSelection) =>
      copyWith(isSelection: isSelection);

  SelectionButtonBS withOnPressed(Function() onPressed) =>
      copyWith(onPressed: onPressed);

  SelectionButtonBS withError(
    SelectionButtonViewError selectionButtonViewError,
  ) => copyWith(selectionButtonViewError: selectionButtonViewError);

  SelectionButtonBS get withoutError =>
      copyWith(selectionButtonViewError: null);
}

extension SelectionButtonBSQueries on SelectionButtonBS {
  bool get isLoadingSelection => isSelection.isNotNull;

  bool get isSelectionSafe => isSelection ?? false;

  bool get isVisible => selectionButtonViewError.isNull;
}

sealed class SelectionButtonViewError extends BaseError {}

class SelectionButtonViewDataAccessError extends SelectionButtonViewError {}
