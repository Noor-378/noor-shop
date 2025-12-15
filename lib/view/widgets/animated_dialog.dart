import 'package:flutter/material.dart';
import 'package:noor_store/utils/colors.dart';

class AnimatedDialog extends StatefulWidget {
  final VoidCallback onConfirm;
  final String title;
  final Widget content;
  final String onCancelText;
  final String onConfirmText;
  final TextStyle? onConfirmTextStyle;
  final TextStyle? onCancelTextTextStyle;
  final bool hideCancelButton;

  const AnimatedDialog({
    super.key,
    required this.onConfirm,
    required this.title,
    required this.content,
    required this.onCancelText,
    required this.onConfirmText,
    this.onConfirmTextStyle,
    this.onCancelTextTextStyle,
    this.hideCancelButton = false,
  });

  @override
  _AnimatedDialogState createState() => _AnimatedDialogState();
}

class _AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool canClick = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: widget.content,
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!widget.hideCancelButton)
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.onCancelText,
                      style:
                          widget.onCancelTextTextStyle ??
                          TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                    ),
                  ),
                ),
              if (!widget.hideCancelButton) const SizedBox(width: 12),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    backgroundColor: mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    if (canClick) {
                      canClick = false;
                      widget.onConfirm();
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(seconds: 1), () {
                        canClick = true;
                      });
                    }
                  },
                  child: Text(
                    widget.onConfirmText,
                    style:
                        widget.onConfirmTextStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
