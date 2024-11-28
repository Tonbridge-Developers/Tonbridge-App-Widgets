import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticChip extends StatefulWidget {
  const PanopticChip(
      {super.key,
      required this.label,
      this.leading,
      this.onDelete,
      this.color,
      this.margin,
      this.type = ChipType.small,
      this.largeDeleteIcon,
      this.expand = false});

  final String label;
  final Widget? leading;
  final VoidCallback? onDelete;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final ChipType type;
  final PanopticIcons? largeDeleteIcon;
  final bool expand;

  @override
  State<PanopticChip> createState() => _PanopticChipState();
}

class _PanopticChipState extends State<PanopticChip> {
  @override
  Widget build(BuildContext context) {
    return widget.type == ChipType.small
        ? _buildSmallChip()
        : widget.expand
            ? _buildExpandedChip()
            : _buildLargeChip();
  }

  Widget _buildSmallChip() => Padding(
        padding: widget.margin ?? const EdgeInsets.all(10),
        child: Chip(
          label: Text(
            widget.label,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color:
                      (widget.color ?? Theme.of(context).colorScheme.primary),
                ),
          ),
          backgroundColor: ThemeProvider.controllerOf(context)
                  .currentThemeId
                  .startsWith('white')
              ? Theme.of(context).colorScheme.surface
              : (widget.color ?? Theme.of(context).colorScheme.primary)
                  .withAlpha(45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
            side: BorderSide(
              color: (widget.color ??
                  Theme.of(context).colorScheme.primary.withAlpha(60)),
              width: 0.5,
            ),
          ),
          avatar: widget.leading,
          onDeleted: widget.onDelete,
          deleteIconColor:
              (widget.color ?? Theme.of(context).colorScheme.primary),
        ),
      );

  Widget _buildLargeChip() => Padding(
        padding: widget.margin ?? const EdgeInsets.all(10),
        child: PanopticRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          children: [
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 50),
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: (widget.color ?? Theme.of(context).colorScheme.primary)
                      .withAlpha(45),
                  borderRadius:
                      BorderRadius.circular(CoreValues.cornerRadius * 0.8),
                ),
                child: PanopticRow(
                  padding: const EdgeInsets.only(right: 5),
                  children: [
                    if (widget.leading != null) ...{
                      widget.leading!,
                      const SizedBox(width: 10),
                    },
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        textAlign: TextAlign.center,
                        widget.label,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: (widget.color ??
                                  Theme.of(context).colorScheme.primary),
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (widget.onDelete != null) ...{
              PanopticIconButton(
                icon: widget.largeDeleteIcon ?? PanopticIcons.cross,
                onTap: widget.onDelete,
                size: 50,
              )
            }
          ],
        ),
      );
  Widget _buildExpandedChip() => Padding(
        padding: widget.margin ?? const EdgeInsets.all(10),
        child: PanopticRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 50),
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: (widget.color ?? Theme.of(context).colorScheme.primary)
                    .withAlpha(45),
                borderRadius:
                    BorderRadius.circular(CoreValues.cornerRadius * 0.8),
              ),
              child: PanopticRow(
                padding: const EdgeInsets.only(right: 5),
                children: [
                  if (widget.leading != null) ...{
                    widget.leading!,
                    const SizedBox(width: 10),
                  },
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.label,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: (widget.color ??
                                Theme.of(context).colorScheme.primary),
                          ),
                    ),
                  )
                ],
              ),
            ),
            if (widget.onDelete != null) ...{
              PanopticIconButton(
                icon: widget.largeDeleteIcon ?? PanopticIcons.cross,
                onTap: widget.onDelete,
                size: 50,
              )
            }
          ],
        ),
      );
}
