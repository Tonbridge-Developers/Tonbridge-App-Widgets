import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticLoadingDropdownWrapper extends StatelessWidget {
  final Future<dynamic>? future;
  final List<DropdownMenuItem<dynamic>> Function(BuildContext, dynamic)?
      itemsBuilder;
  final PanopticDropdownFormField child;
  final bool? isLoading;

  const PanopticLoadingDropdownWrapper({
    super.key,
    this.future,
    required this.child,
    this.itemsBuilder,
    this.isLoading,
  });

  double? getWidth() => child.forceColumn || child.fullWidth ? null : 400;

  Color? getColor(BuildContext context) {
    return (child.alternative
            ? Theme.of(context).colorScheme.surfaceContainer
            : Theme.of(context).colorScheme.surface)
        .withAlpha(255);
  }

  @override
  Widget build(BuildContext context) {
    assert(future != null || isLoading != null);
    if (future != null) assert(itemsBuilder != null);

    if (isLoading != null) {
      return isLoading! ? _buildLoadingWidget(context) : child;
    }

    return FutureBuilder(
      future: future,
      builder: (ctx, snapshot) {
        return snapshot.connectionState != ConnectionState.done
            ? _buildLoadingWidget(context)
            : _buildChildWidget(context, snapshot);
      },
    );
  }

  Widget _buildChildWidget(
      BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return PanopticDropdownFormField(
      key: child.key,
      onSaved: child.onChanged,
      validator: child.validator,
      initialValue: child.initialValue,
      name: child.name,
      enabled: child.enabled,
      onChanged: child.onChanged,
      forceColumn: child.forceColumn,
      autoValidate: child.autoValidate,
      label: child.label,
      hintText: child.hintText,
      placeholder: child.placeholder,
      icon: child.icon,
      checked: child.checked,
      alternative: child.alternative,
      fullWidth: child.fullWidth,
      nullLabel: child.nullLabel,
      items: itemsBuilder?.call(context, snapshot.data),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    Widget loadingWidget = Container(
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
      width: getWidth(),
      height: 48,
      decoration: BoxDecoration(
        color: getColor(context),
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius * 0.8),
        border: Border.all(
            width: 1, color: Theme.of(context).colorScheme.onSurface),
      ),
      child: const PanopticLoading(
          isLoading: true, loadingType: LoadingType.circular),
    );

    Widget? labelWidget = child.label.isNullOrWhitespace
        ? null
        : Row(
            children: [
              Text(child.label!, style: Theme.of(context).textTheme.bodyLarge),
              if (child.hintText != null)
                Tooltip(
                  message: child.hintText,
                  preferBelow: true,
                  triggerMode: PanopticExtension.isWebOrDesktop()
                      ? null
                      : TooltipTriggerMode.tap,
                  verticalOffset: 10,
                  child: PanopticIcon(
                    icon: PanopticIcons.infoRound,
                    size: 15,
                    margin: const EdgeInsets.only(left: 5, top: 2),
                    color:
                        Theme.of(context).colorScheme.onSurface.withAlpha(100),
                  ),
                ),
            ],
          );

    return child.fullWidth
        ? loadingWidget
        : PanopticResponsiveLayout(
            forceColumn: child.forceColumn,
            childrenPadding: const EdgeInsets.all(2),
            rowCrossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (labelWidget != null) labelWidget,
              const Padding(padding: EdgeInsets.all(5)),
              loadingWidget,
            ],
          );
  }
}
