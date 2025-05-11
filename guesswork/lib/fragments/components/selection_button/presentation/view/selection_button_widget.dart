import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guesswork/fragments/components/selection_button/presentation/bloc/selection_button_bs.dart';

import '../bloc/selection_button_be.dart';
import '../bloc/selection_button_bloc.dart';

extension ContextBloc on BuildContext {
  SelectionButtonBloc get bloc => read<SelectionButtonBloc>();

  addEvent(SelectionButtonBE selectionButtonBE) => bloc.add(selectionButtonBE);
}

class SelectionButton extends StatelessWidget {
  const SelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionButtonBloc, SelectionButtonBS>(
      builder: (context, state) {
        return Visibility(
          visible: state.isVisible,
          child: IconButton.filled(
            onPressed: state.onPressed,
            icon: Icon(
              state.isSelectionSafe ? Icons.favorite : Icons.favorite_border,
            ),
          ),
        );
      },
    );
  }
}
