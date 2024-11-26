import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_icon.dart';
import 'keyboard_controller.dart';

class KeyboardAction extends StatefulWidget {
  final FocusNode focusNode;
  final FocusActionType focusActionType;
  final Widget? child;
  final VoidCallback? onTap;

  ///Creates a IOSKeyboardAction that can be used to your text field to add a keyboard action above the system keyboard.
  ///
  ///The [focusActionType] is the type of action that will be performed when the user taps the action button defaults to [focusActionType.done].
  ///The [backgroundColor] is the background color of the action button defaults to [Color(0xffeeeeed)].
  ///The [textColor] is the text color of the action button defaults to [Colors.black].
  ///The [focusNode] is the focus node that will be used to determine if the keyboard is visible.
  ///The [child] is the child widget that will be wrapped with the IOSKeyboardAction.
  ///The [onTap] is the callback that will be called when the user taps the action button.
  const KeyboardAction(
      {super.key,
      required this.focusNode,
      this.child,
      this.focusActionType = FocusActionType.done,
      this.onTap,
      l});

  @override
  _KeyboardActionState createState() => _KeyboardActionState();
}

class _KeyboardActionState extends State<KeyboardAction> {
  OverlayEntry? _overlayEntry;
  bool forceHide = false;

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      KeyboardController.getFunctionAction(
                          action: widget.focusActionType,
                          focusNode: widget.focusNode);
                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                      setState(() {
                        forceHide = true;
                      });
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: PanopticIcon(
                          margin: const EdgeInsets.all(7),
                          icon: CoreIcons.keyboard,
                          size: 35,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 50),
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (Theme.of(context).platform == TargetPlatform.iOS ||
          Theme.of(context).platform == TargetPlatform.android) {
        widget.focusNode.addListener(() {
          if (widget.focusNode.hasFocus == true && !forceHide) {
            _overlayEntry = _createOverlayEntry();
            Overlay.of(context).insert(_overlayEntry!);
          } else {
            _overlayEntry!.remove();
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(() {});
    _overlayEntry?.remove();
    super.dispose();
  }
}
