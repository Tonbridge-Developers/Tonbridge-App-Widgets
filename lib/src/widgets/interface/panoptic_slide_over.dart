import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticSlideOver extends StatefulWidget {
  final Widget child;
  final String? title;

  const PanopticSlideOver({
    super.key,
    required this.child,
    this.title,
  });

  @override
  State<PanopticSlideOver> createState() => _PanopticSlideOverState();
}

class _PanopticSlideOverState extends State<PanopticSlideOver>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _slideAnimation = Tween<double>(begin: 2.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: AnimatedOpacity(
                    opacity: 0.5,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      color: ThemeProvider.controllerOf(context)
                              .currentThemeId
                              .startsWith('white')
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: 0,
                left: Responsive.isDesktop(context)
                    ? _slideAnimation.value *
                        MediaQuery.of(context).size.width *
                        0.7
                    : Responsive.isTablet(context)
                        ? _slideAnimation.value *
                            MediaQuery.of(context).size.width *
                            0.5
                        : 0.0,
                bottom: 0,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    border: ThemeProvider.controllerOf(context)
                            .currentThemeId
                            .startsWith('white')
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(
                        CoreValues.cornerRadius,
                      ),
                      bottomLeft: Radius.circular(
                        CoreValues.cornerRadius,
                      ),
                    ),
                  ),
                  width: Responsive.isDesktop(context)
                      ? MediaQuery.of(context).size.width * 0.3
                      : Responsive.isTablet(context)
                          ? MediaQuery.of(context).size.width * 0.5
                          : MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: ThemeProvider.controllerOf(context)
                                  .currentThemeId
                                  .startsWith('white')
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                              CoreValues.cornerRadius,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(widget.title ?? '',
                                          textScaler:
                                              const TextScaler.linear(1.34),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: ThemeProvider
                                                              .controllerOf(
                                                                  context)
                                                          .currentThemeId
                                                          .startsWith('white')
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                  fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.of(context).maybePop(),
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: ThemeProvider.controllerOf(context)
                                              .currentThemeId
                                              .startsWith('white')
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: widget.child,
                        )),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop help us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
