import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticActionSheet extends StatelessWidget {
  const PanopticActionSheet({
    super.key,
    required this.context,
    this.padding = 10.0,
    required this.title,
    this.subTitle = "",
    this.margin = 10.0,
    required this.actions,
  });

  final BuildContext context;
  final double padding;
  final String title;
  final String? subTitle;
  final double margin;
  final List<PanopticActionSheetAction> actions;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(margin),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(
                    Radius.circular(CoreValues.cornerRadius)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  subTitle != null && subTitle != ""
                      ? Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            subTitle!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : Container(),
                  Container(
                    height: 2,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.2),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: (MediaQuery.of(context).size.height) - 262),
                    child: ListView(
                      shrinkWrap: true,
                      children: actions,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: margin),
              padding: EdgeInsets.all(padding / 4),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(
                    Radius.circular(CoreValues.cornerRadius)),
              ),
              child: PanopticActionSheetAction(
                context: context,
                child: Text(
                  'Cancel',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PanopticActionSheetAction extends StatelessWidget {
  const PanopticActionSheetAction(
      {super.key,
      required this.context,
      required this.child,
      required this.onPressed});

  final BuildContext context;
  final Widget child;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          onPressed();
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [child],
          ),
        ),
      ),
    );
  }
}

void showPanopticActionSheet(
    {required PanopticActionSheet builder, required BuildContext context}) {
  showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => DraggableScrollableSheet(
          maxChildSize: 0.9,
          minChildSize: 0.9,
          initialChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) => builder),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      showDragHandle: false,
      barrierColor:
          ThemeProvider.controllerOf(context).currentThemeId.startsWith('white')
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.surfaceContainer.withOpacity(0.8),
      elevation: 0,
      constraints: BoxConstraints(
          maxWidth: PanopticExtension.getDeviceType(context) == DeviceType.large
              ? MediaQuery.of(context).size.width / 2
              : MediaQuery.of(context).size.width,
          minWidth: PanopticExtension.getDeviceType(context) == DeviceType.large
              ? MediaQuery.of(context).size.width / 2
              : MediaQuery.of(context).size.width));
}
