// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticThemeWidget extends StatefulWidget {
  const PanopticThemeWidget(
      {super.key, required this.inSlideOver, this.onThemeChange});
  final bool inSlideOver;
  final ValueChanged<String>? onThemeChange;

  @override
  State<PanopticThemeWidget> createState() => _PanopticThemeWidgetState();
}

class _PanopticThemeWidgetState extends State<PanopticThemeWidget> {
  String? _currentTheme;
  bool showPreview = false;
  @override
  void initState() {
    showPreview = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _currentTheme = ThemeProvider.controllerOf(context).currentThemeId;

    return ListView(
      shrinkWrap: true,
      physics: widget.inSlideOver ? const NeverScrollableScrollPhysics() : null,
      children: [
        PanopticCard(
          child: Column(
            children: [
              const PanopticIcon(icon: PanopticIcons.pallet, size: 80),
              Text(
                "This is a demonstration of the different themes available in the app. Click on a theme to change the app's theme. The App Icon will also change to match the theme. Some themes look better on light mode, some on dark mode. ",
                style: Theme.of(context).textTheme.titleMedium!,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PanopticButton(
              label: 'Confirm Theme',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        PanopticCheckboxFormField(
          name: 'preview',
          label: 'Show Theme Preview',
          initialValue: showPreview,
          onChanged: (value) {
            showPreview = value ?? false;
            setState(() {});
          },
        ),
        PanopticGridView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(10),
          columnCount: columnCount,
          children: [
            for (var theme in Themes.getThemes()) ...{
              PanopticCard(
                onPressed: () => _setTheme(theme.id),
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                border: Border.all(
                  color: theme.data.colorScheme.primary,
                  width: 2,
                ),
                child: Column(
                  children: [
                    PanopticRow(
                      padding: showPreview
                          ? const EdgeInsets.only(
                              bottom: 5, top: 10, right: 10, left: 10)
                          : const EdgeInsets.only(
                              bottom: 10, top: 10, right: 10, left: 10),
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  CoreValues.cornerRadius * 0.8),
                              gradient: LinearGradient(
                                  colors: [
                                    theme.data.colorScheme.primary,
                                    theme.data.colorScheme.primary,
                                    theme.data.colorScheme.secondary,
                                    theme.data.colorScheme.secondary,
                                    theme.data.colorScheme.tertiary,
                                    theme.data.colorScheme.tertiary,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: const [0.0, 0.8, 0.8, 0.9, 0.9, 1.0])),
                        ),
                        Expanded(
                          child: Text(
                            theme.description,
                          ),
                        ),
                        if (theme.id == _currentTheme) ...{
                          const Icon(Icons.check_rounded),
                        }
                      ],
                    ),
                    showPreview
                        ? Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: 500 *
                                MediaQuery.of(context).textScaler.scale(1),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: theme.data.colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(
                                  CoreValues.cornerRadius),
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                PanopticButton(
                                  key: const Key("primaryButton"),
                                  expanded: true,
                                  onPressed: () {},
                                  label: "Primary Button",
                                  buttonType: ButtonType.primary,
                                  color: theme.data.colorScheme.primary,
                                  textColor: theme.data.colorScheme.onPrimary,
                                ),
                                PanopticButton(
                                  icon: PanopticIcons.add,
                                  key: const Key("secondaryButton"),
                                  onPressed: () {},
                                  expanded: true,
                                  label: "Secondary Button",
                                  buttonType: ButtonType.secondary,
                                  color: theme.data.colorScheme.secondary,
                                  textColor: theme.data.colorScheme.onSecondary,
                                ),
                                PanopticButton(
                                  key: const Key("accentButton"),
                                  onPressed: () {},
                                  trailing: const Icon(Icons.save_rounded),
                                  expanded: true,
                                  label: "Accent Button",
                                  buttonType: ButtonType.accent,
                                  color: theme.data.colorScheme.tertiary,
                                  textColor: theme.data.colorScheme.onTertiary,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                      text: "Headline ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    TextSpan(
                                      text: "Title ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                    TextSpan(
                                      text: "Body ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    TextSpan(
                                      text: "Label\n",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    TextSpan(
                                      text:
                                          "This is some sample text to show what the theme will generally look like. When the bit of text has a link this is what it looks like: ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    TextSpan(
                                        text: "https://google.com",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: theme
                                                .data.colorScheme.secondary)),
                                    TextSpan(
                                      text: ".",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ])),
                                ),
                                PanopticInfoCard(
                                  color: theme.data.colorScheme.primary,
                                  margin: const EdgeInsets.all(10),
                                  leading: Icon(
                                    Icons.info_outline_rounded,
                                    color: theme.data.colorScheme.primary,
                                  ),
                                  child: const Text(
                                      "This is some important information that you should read."),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            }
          ],
        )
      ],
    );
  }

  int get columnCount => widget.inSlideOver
      ? 1
      : Responsive.isDesktop(context)
          ? 3
          : Responsive.isTablet(context)
              ? 2
              : 1;

  void _setTheme(String themeId) async {
    ThemeProvider.controllerOf(context).setTheme(themeId);

    if (widget.onThemeChange != null) {
      widget.onThemeChange!(themeId);
    }

    setState(() {
      _currentTheme = themeId;
    });
  }
}
