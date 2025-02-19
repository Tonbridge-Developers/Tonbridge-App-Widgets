import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticChip extends StatefulWidget {
  const PanopticChip({
    super.key,
    required this.label,
    this.tooltip,
    this.leading,
    this.onDelete,
    this.color,
    this.margin,
    this.type = ChipType.small,
    this.largeDeleteIcon,
    this.expand = false,
    this.onSelected,
    this.selected = false,
  });

  final String label;
  final String? tooltip;
  final Widget? leading;
  final VoidCallback? onDelete;

  /// for Filter chip only
  final Function(bool)? onSelected;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final ChipType type;
  final PanopticIcons? largeDeleteIcon;
  final bool expand;
  final bool selected;

  @override
  State<PanopticChip> createState() => _PanopticChipState();
}

class _PanopticChipState extends State<PanopticChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? const EdgeInsets.all(10),
      child: widget.type == ChipType.small
          ? _buildSmallChip(context)
          : widget.type == ChipType.filter
              ? _buildFilterChip(context)
              : _buildLargeOrExpandedChip(context),
    );
  }

  Widget _buildSmallChip(BuildContext context) {
    return Chip(
      label: Tooltip(
        message: widget.tooltip ?? '',
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: widget.color ?? Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
      backgroundColor: _getBackgroundColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        side: BorderSide(
          color: widget.color ??
              Theme.of(context).colorScheme.primary.withAlpha(60),
          width: 0.5,
        ),
      ),
      avatar: widget.leading,
      onDeleted: widget.onDelete,
      deleteIconColor: widget.color ?? Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildFilterChip(BuildContext context) {
    return FilterChip(
      label: Tooltip(
        message: widget.tooltip ?? '',
        child: Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      backgroundColor: _getBackgroundColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        side: BorderSide(
          color: widget.color ??
              Theme.of(context).colorScheme.primary.withAlpha(60),
          width: 0.5,
        ),
      ),
      selected: widget.selected,
      checkmarkColor: widget.color ?? Theme.of(context).colorScheme.onPrimary,
      avatar: widget.leading,
      onSelected: widget.onSelected,
      onDeleted: widget.onDelete,
      deleteIconColor: widget.color ?? Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildLargeOrExpandedChip(BuildContext context) {
    return PanopticRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      children: [
        Expanded(
          child: Container(
            constraints: const BoxConstraints(minHeight: 50),
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: _getBackgroundColor(context),
              borderRadius:
                  BorderRadius.circular(CoreValues.cornerRadius * 0.8),
            ),
            child: PanopticRow(
              padding: const EdgeInsets.only(right: 5),
              children: [
                if (widget.leading != null) ...[
                  widget.leading!,
                  const SizedBox(width: 10),
                ],
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Tooltip(
                    message: widget.tooltip ?? '',
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.label,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: widget.color ??
                                Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.onDelete != null)
          PanopticIconButton(
            icon: widget.largeDeleteIcon ?? PanopticIcons.cross,
            onTap: widget.onDelete,
            size: 50,
          ),
      ],
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    return ThemeProvider.controllerOf(context)
            .currentThemeId
            .startsWith('white')
        ? Theme.of(context).colorScheme.surface
        : (widget.color ?? Theme.of(context).colorScheme.primary).withAlpha(45);
  }
}
