import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tmpl_bloc.dart';

TmplBloc _bloc(BuildContext context) => context.read<TmplBloc>();

class TmplRouteWidget extends StatelessWidget {
  const TmplRouteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Tmpl")));
  }
}
