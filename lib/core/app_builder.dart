import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/notifier/loader.notifier.dart';
import 'package:provider/provider.dart';

class AppBuilder extends StatefulWidget {
  final Widget widget;
  const AppBuilder({Key? key, required this.widget}) : super(key: key);

  @override
  State<AppBuilder> createState() => _AppBuilderState();
}

class _AppBuilderState extends State<AppBuilder> {
  @override
  Widget build(BuildContext context) {
    final loaderNotifier = context.watch<LoaderNotifier>();

    return Stack(
      children: [
        widget.widget,
        if (loaderNotifier.isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: CircularProgressIndicator(
                backgroundColor: AppThemes.highlightGreen,
                color: Colors.black,
              ),
            ),
          ),
      ],
    );
  }
}
