import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PanopticGridExtension {
  static GridColumn defaultColumn(
    String columnName,
    BuildContext context,
    String label, {
    bool allowFiltering = true,
    bool allowSorting = true,
    bool allowEditing = true,
    bool visible = true,
    String? tooltip,
    ColumnWidthMode widthMode = ColumnWidthMode.none,
    double minWidth = 100,
    double maxWidth = double.nan,
    TextAlign textAlign = TextAlign.start,
    Alignment alignment = Alignment.centerLeft,
  }) {
    return GridColumn(
      columnName: columnName,
      allowEditing: allowEditing,
      allowFiltering: allowFiltering,
      allowSorting: allowSorting,
      visible: visible,
      columnWidthMode: widthMode,
      minimumWidth: minWidth,
      maximumWidth: maxWidth,
      autoFitPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
      label: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        alignment: alignment,
        child: tooltip.isNullOrWhitespace
            ? AutoSizeText(
                label,
                maxLines: 3,
                softWrap: true,
                textAlign: textAlign,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ThemeProvider.controllerOf(context)
                            .currentThemeId
                            .startsWith('white')
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onPrimary),
                overflow: TextOverflow.ellipsis,
              )
            : Tooltip(
                message: tooltip!,
                waitDuration: const Duration(milliseconds: 500),
                preferBelow: true,
                enableTapToDismiss: true,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.9),
                  borderRadius:
                      BorderRadius.circular(CoreValues.cornerRadius / 2),
                ),
                child: AutoSizeText(
                  label,
                  maxLines: 3,
                  softWrap: true,
                  textAlign: textAlign,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
      ),
    );
  }

  static defaultWidget(
    DataGridCell<dynamic> dataGridCell, {
    Alignment alignment = Alignment.centerLeft,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: dataGridCell.value as Widget,
      );

  static defaultProgress(
    DataGridCell<dynamic> dataGridCell,
    double Function(dynamic value) mapValue, {
    Color? color,
    Alignment alignment = Alignment.centerLeft,
    Color Function(dynamic value)? mapColor,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
    bool showLabel = false,
    String Function(dynamic value)? mapLabel,
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: PanopticProgress(
          showLabel: showLabel,
          value: dataGridCell.value,
          mapValue: mapValue,
          color: color,
          mapColor: mapColor,
          mapLabel: mapLabel,
        ),
      );

  static defaultString(
    DataGridCell<dynamic> dataGridCell, {
    int maxLines = 2,
    TextAlign textAlign = TextAlign.start,
    TextStyle? style,
    Alignment alignment = Alignment.centerLeft,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: SelectableText(
          (dataGridCell.value ?? '').toString(),
          maxLines: maxLines,
          textAlign: textAlign,
          style: style,
        ),
      );
  static defaultDate(
    DataGridCell<dynamic> dataGridCell,
    String format, {
    int maxLines = 2,
    TextAlign textAlign = TextAlign.start,
    TextStyle? style,
    Alignment alignment = Alignment.centerLeft,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: SelectableText(
          dataGridCell.value != null
              ? (dataGridCell.value as DateTime)
                  .toFormattedString(format: format)
              : '-',
          maxLines: maxLines,
          textAlign: textAlign,
          style: style,
        ),
      );
  static defaultChip(
    DataGridCell<dynamic> dataGridCell,
    String Function(dynamic value) mapValue, {
    Color? color,
    Alignment alignment = Alignment.centerLeft,
    Color Function(dynamic value)? mapColor,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: PanopticChip(
          label: mapValue(dataGridCell.value),
          color: mapColor != null ? mapColor(dataGridCell.value) : color,
          margin: EdgeInsets.zero,
        ),
      );

  static defaultButton(
    DataGridCell<dynamic> dataGridCell,
    Function()? onPressed,
    PanopticIcons icon, {
    Alignment alignment = Alignment.center,
    ButtonType buttonType = ButtonType.secondary,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: PanopticIconButton(
          icon: icon,
          onTap: onPressed,
          buttonType: buttonType,
          margin: EdgeInsets.zero,
        ),
      );

  static defaultButtonNoIcon(
    DataGridCell<dynamic> dataGridCell,
    Function()? onPressed,
    String label, {
    Alignment alignment = Alignment.center,
    ButtonType buttonType = ButtonType.secondary,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: PanopticButton(
          label: label,
          expanded: true,
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          onPressed: onPressed,
          buttonType: buttonType,
          margin: const EdgeInsets.all(0),
        ),
      );

  static defaultIconFromString(
    DataGridCell<dynamic> dataGridCell, {
    Alignment alignment = Alignment.centerLeft,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.only(right: 5),
    double size = 40,
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: PanopticIcon(
          margin: margin,
          icon: PanopticIcons.getIconForName(dataGridCell.value.toString()),
          size: size,
        ),
      );

  static defaultBool(
    DataGridCell<dynamic> dataGridCell, {
    Alignment alignment = Alignment.center,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.only(right: 5),
    double size = 40,
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: PanopticIcon(
          margin: margin,
          bw: true,
          icon: dataGridCell.value as bool
              ? PanopticIcons.tick
              : PanopticIcons.cross,
          size: size,
        ),
      );
  static defaultIcon(
    DataGridCell<dynamic> dataGridCell, {
    Alignment alignment = Alignment.centerLeft,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.only(right: 5),
    double size = 40,
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: PanopticIcon(
          margin: margin,
          icon: dataGridCell.value as PanopticIcons,
          size: size,
        ),
      );
  static defaultCustomIcon(DataGridCell<dynamic> dataGridCell,
          {Alignment alignment = Alignment.centerLeft,
          EdgeInsetsGeometry padding =
              const EdgeInsets.symmetric(horizontal: 16.0),
          EdgeInsetsGeometry margin = const EdgeInsets.only(right: 5),
          double size = 40,
          PanopticIcons? icon,
          Color? iconColor}) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: PanopticIcon(
          margin: margin,
          icon: icon ?? PanopticIcons.tick,
          size: size,
          color: iconColor,
        ),
      );
  static defaultStringList(
    DataGridCell<dynamic> dataGridCell, {
    Alignment alignment = Alignment.centerLeft,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.all(2),
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (dataGridCell.value as List<String?>)
                .where((element) => element!.isNotEmpty)
                .map((value) {
              return PanopticChip(
                margin: margin,
                label: value ?? '',
              );
            }).toList(),
          ),
        ),
      );

  static defaultList<T>(
    DataGridCell<dynamic> dataGridCell, {
    Alignment alignment = Alignment.centerLeft,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(horizontal: 16.0),
    EdgeInsetsGeometry margin = const EdgeInsets.all(2),
  }) =>
      Container(
        alignment: alignment,
        padding: padding,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (dataGridCell.value as List<T>)
                .where((element) => element != null)
                .map((value) {
              return PanopticChip(
                margin: margin,
                label: value.toString(),
              );
            }).toList(),
          ),
        ),
      );
}

class PanopticDataSource extends DataGridSource {
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return null;
  }

  void Function(dynamic newValue, dynamic oldValue, int rowNumber,
      String? columnName)? onChanged;
  void Function(int rowNumber, String? columnName, {dynamic additionalData})?
      onButtonClicked;

  dynamic newValue;

  List<DataGridRow> dataGridRows = [];
  List<DataGridRow>? filteredRows;

  List<Future Function(int)> onPageChangeListeners = [];

  void addOnPageChangeListener(Future Function(int) listener) {
    onPageChangeListeners.add(listener);
  }

  void removeOnPageChangeListener(Future Function(int) listener) {
    onPageChangeListeners.remove(listener);
  }

  void _notifyOnPageChangeListeners(int newPageIndex) {
    for (Future Function(int) element in onPageChangeListeners) {
      element(newPageIndex);
    }
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    if (oldPageIndex == newPageIndex) {
      return false;
    }

    _notifyOnPageChangeListeners(newPageIndex);

    return true;
  }

  void resetFilter() {
    filteredRows = null;
    notifyListeners();
  }

  void filter(String? query, {List<String> columnNames = const []}) {
    if (query.isNullOrWhitespace) {
      resetFilter();
      return;
    }

    filteredRows = dataGridRows.where((row) {
      return row.getCells().any((cell) {
        return (columnNames.isEmpty || columnNames.contains(cell.columnName)) &&
            cell.value
                .toString()
                .toLowerCase()
                .contains(query!.trim().toLowerCase());
      });
    }).toList();
    notifyListeners();
  }

  void updateDataGridSource() {
    notifyListeners();
  }

  @override
  List<DataGridRow> get rows => filteredRows ?? dataGridRows;

  @override
  Widget? buildGroupCaptionCellWidget(
      RowColumnIndex rowColumnIndex, String summaryValue) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        child: Text(summaryValue));
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) async {
    DataGridCell<dynamic>? currentCell = dataGridRow
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
            dataGridCell.columnName == column.columnName);

    if (currentCell != null) {
      dynamic value = currentCell.value;

      final int dataRowIndex = dataGridRows.indexOf(dataGridRow);

      if (newValue == null || value == newValue) {
      } else {
        var index = dataGridRow.getCells().indexWhere(
            (DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName);
        dataGridRows[dataRowIndex].getCells()[index] =
            DataGridCell(columnName: column.columnName, value: newValue);

        onChanged?.call(newValue, value, dataRowIndex, column.columnName);
      }
    }
  }

  @override
  Widget buildEditWidget(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column, CellSubmit submitCell) {
    DataGridCell<dynamic>? currentCell = dataGridRow
        .getCells()
        .firstWhereOrNull((DataGridCell dataGridCell) =>
            dataGridCell.columnName == column.columnName);

    if (currentCell == null) {
      return Container();
    }

    dynamic value = currentCell.value;
    newValue = null;
    switch (currentCell.columnName) {
      default:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: PanopticTextFormField(
              name: column.columnName,
              initialValue: value,
              contentPadding: const EdgeInsets.all(5),
              leadingPadding: EdgeInsets.zero,
              autofocus: true,
              fullWidth: true,
              onChanged: (value) {
                newValue = value;
              },
              onFieldSubmitted: (value) => submitCell(),
            ),
          ),
        );
    }
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(summaryValue),
    );
  }
}
