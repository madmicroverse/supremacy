import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const defaultPreferredSize = Size.fromHeight(kToolbarHeight);

class PreferredSizeBlocProvider extends BlocProvider
    implements PreferredSizeWidget {
  final Size size;

  const PreferredSizeBlocProvider({
    required super.create,
    super.key,
    required super.child,
    super.lazy,
    this.size = defaultPreferredSize,
  });

  @override
  Size get preferredSize => size;
}
