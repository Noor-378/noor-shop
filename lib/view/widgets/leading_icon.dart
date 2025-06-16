
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class LeadingIcon extends StatelessWidget {
  const LeadingIcon({
    super.key,
    required this.advancedDrawer,
  });

  final AdvancedDrawerController advancedDrawer;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AdvancedDrawerValue>(
      valueListenable: advancedDrawer,
      builder: (_, value, __) {
        return IconButton(
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder:
                (child, animation) => RotationTransition(
                  turns:
                      // ignore: unrelated_type_equality_checks
                      child == const ValueKey('arrow')
                          ? animation
                          : Tween(begin: 0.5, end: 1.0).animate(animation),
                  child: child,
                ),
            child: Icon(
              value.visible ? Icons.arrow_back : Icons.menu,
              key: ValueKey(value.visible ? 'arrow' : 'menu'),
            ),
          ),
          onPressed: () => advancedDrawer.showDrawer(),
        );
      },
    );
  }
}