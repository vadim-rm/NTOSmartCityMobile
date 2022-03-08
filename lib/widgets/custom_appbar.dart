import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Widget title;
  final List<Widget>? buttons;

  CustomAppBar({
    Key? key,
    required this.title,
    this.buttons,
  })  : preferredSize = const Size.fromHeight(40),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      titleTextStyle: Theme.of(context).textTheme.headline4,
      leading: ModalRoute.of(context)?.isFirst == true
          ? null
          : Container(
              margin: const EdgeInsets.only(left: 8),
              child: IconButton(
                splashRadius: 18,
                color: Colors.black,
                icon: const Icon(
                  Icons.chevron_left,
                  size: 26,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
      title: FittedBox(
      child: title,
      ),
      leadingWidth: 48,
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      actions: buttons ?? [],
    );
  }
}
