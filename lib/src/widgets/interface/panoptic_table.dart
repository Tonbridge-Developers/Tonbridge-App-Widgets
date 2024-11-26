import 'package:flutter/material.dart';
import 'package:measure_size_builder/measure_size_builder.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_pager.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_slide_over.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:theme_provider/theme_provider.dart';

class PanopticTable extends StatefulWidget {
  const PanopticTable(
      {super.key,
      required this.tableKey,
      required this.dataSource,
      required this.columns,
      this.allowSorting = false,
      this.allowEditing = false,
      this.allowFiltering = false,
      this.showCheckboxColumn = false,
      this.frozenColumnsCount = 0,
      this.frozenRowsCount = 0,
      this.controller,
      this.onCellTap,
      this.onCellLongPress,
      this.summaryRows = const [],
      this.allowExpandCollapseGroup = false,
      this.forceSingleLine = false,
      this.groupCaptionTitleFormat =
          '{ColumnName} : {Key} - {ItemsCount} Items',
      this.selectionMode = SelectionMode.single,
      this.desktopColumnWidthMode = ColumnWidthMode.fill,
      this.headerRowHeight = double.nan,
      this.onFilterChanged,
      this.expanded = true,
      this.autoSize = false,
      this.paginated = false,
      this.clearSelectionOnBuild = true,
      this.pageSize = 10,
      this.totalRowCount = 1,
      this.filterCount,
      this.flex = 1,
      this.tableHeight,
      this.onRowsPerPageChanged,
      this.availableRowsPerPage = const <int>[10, 20, 50, 100],
      this.editingGestureType = EditingGestureType.doubleTap,
      this.globalPageHeight});
  final GlobalKey<SfDataGridState> tableKey;
  final PanopticDataSource dataSource;
  final List<GridColumn> columns;
  final List<GridTableSummaryRow> summaryRows;
  final bool allowSorting;
  final bool allowEditing;
  final bool allowFiltering;
  final bool forceSingleLine;
  final bool showCheckboxColumn;
  final int frozenColumnsCount;
  final int frozenRowsCount;
  final bool allowExpandCollapseGroup;
  final SelectionMode selectionMode;
  final DataGridController? controller;
  final String groupCaptionTitleFormat;
  final ColumnWidthMode desktopColumnWidthMode;
  final Function(DataGridCellTapDetails)? onCellTap;
  final Function(DataGridCellLongPressDetails)? onCellLongPress;
  final Function(DataGridFilterChangeDetails)? onFilterChanged;
  final double headerRowHeight;
  final bool expanded;
  final int flex;
  final bool autoSize;
  final bool paginated;
  final bool clearSelectionOnBuild;
  final int totalRowCount;
  final int pageSize;
  final int? filterCount;
  final double? tableHeight;
  final void Function(int? rowCount)? onRowsPerPageChanged;
  final List<int> availableRowsPerPage;
  final EditingGestureType editingGestureType;
  final int? globalPageHeight;

  @override
  State<PanopticTable> createState() => _PanopticTableState();
}

class _PanopticTableState extends State<PanopticTable> {
  bool pride = false;
  bool notExpanded = false;
  bool isLoading = false;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        pride = prefs.getBool('pride') ?? false;
      });
    });
    setState(() {
      notExpanded = !widget.expanded;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildSizer();
  }

  Widget _buildSizer() {
    Widget result;
    if (widget.autoSize) {
      result = MeasureSizeBuilder(builder: (context, size) {
        updateSize(size);
        return notExpanded
            ? _buildTable()
            : Expanded(flex: widget.flex, child: _buildTable());
      });
    } else if (widget.expanded) {
      result = Expanded(
        flex: widget.flex,
        child: _buildTable(),
      );
    } else {
      result = _buildTable();
    }

    if (widget.paginated) {
      result = Column(children: [
        result,
        _buildPager(),
      ]);
      if (widget.expanded) {
        result = Expanded(
          child: result,
        );
      }
    }

    return result;
  }

  void updateSize(Size size) {
    if (widget.globalPageHeight != null &&
        widget.globalPageHeight != 0 &&
        size.height != 0 &&
        size.height != 310) {
      if (size.height > (widget.globalPageHeight! - 400)) {
        //setState(() {
        notExpanded = false;
        // });
      } else {
        // setState(() {
        notExpanded = true;
        // });
      }
    } else {
      print('Global Page Height is null');
    }
  }

  void clearSelection() {
    if (!widget.clearSelectionOnBuild) {
      return;
    }
    widget.controller?.selectedRows.clear();
    widget.controller?.selectedRow = null;
  }

  Widget _buildTable() {
    clearSelection();
    ThemeData theme = Theme.of(context);
    return Container(
      margin: widget.paginated
          ? const EdgeInsets.fromLTRB(5, 5, 5, 0)
          : const EdgeInsets.all(5),
      clipBehavior: Clip.antiAlias,
      height: widget.tableHeight,
      decoration: BoxDecoration(
        //border: Border.all(width: 0, color: Theme.of(context).colorScheme.onSurface),
        borderRadius: BorderRadius.circular(CoreValues.cornerRadius),
        color: theme.colorScheme.surface,
      ),
      child: Stack(
        children: [
          SfTheme(
            data: SfThemeData(
              dataGridThemeData: SfDataGridThemeData(
                  headerColor: ThemeProvider.controllerOf(context)
                          .currentThemeId
                          .startsWith('white')
                      ? Theme.of(context).colorScheme.surface
                      : theme.colorScheme.primary.withOpacity(0.7),
                  sortIconColor: ThemeProvider.controllerOf(context)
                          .currentThemeId
                          .startsWith('white')
                      ? Theme.of(context).colorScheme.primary
                      : theme.colorScheme.onPrimary,
                  selectionColor: theme.colorScheme.primary.withOpacity(0.5),
                  filterIconColor: ThemeProvider.controllerOf(context)
                          .currentThemeId
                          .startsWith('white')
                      ? Theme.of(context).colorScheme.primary
                      : theme.colorScheme.onPrimary,
                  frozenPaneLineColor: theme.colorScheme.primary),
            ),
            child: SfDataGrid(
              tableSummaryRows: widget.summaryRows,
              groupCaptionTitleFormat: widget.groupCaptionTitleFormat,
              checkboxShape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(CoreValues.cornerRadius / 4),
              ),
              selectionMode: widget.selectionMode,
              controller: widget.controller,
              showColumnHeaderIconOnHover: true,
              allowExpandCollapseGroup: widget.allowExpandCollapseGroup,
              navigationMode: GridNavigationMode.cell,
              showCheckboxColumn: widget.showCheckboxColumn,
              key: widget.tableKey,
              allowSorting: widget.allowSorting,
              allowEditing: widget.allowEditing,
              onCellTap: widget.onCellTap != null
                  ? (details) {
                      if (widget.controller != null) {
                        if (!widget.controller!.isCurrentCellInEditing) {
                          widget.onCellTap!(details);
                        }
                      } else {
                        widget.onCellTap!(details);
                      }
                    }
                  : null,
              onCellLongPress: widget.onCellLongPress != null
                  ? (details) {
                      if (widget.controller != null) {
                        if (!widget.controller!.isCurrentCellInEditing) {
                          widget.onCellLongPress!(details);
                        }
                      } else {
                        widget.onCellLongPress!(details);
                      }
                    }
                  : null,
              onFilterChanged: widget.onFilterChanged,
              editingGestureType: widget.editingGestureType,
              gridLinesVisibility: GridLinesVisibility.none,
              headerGridLinesVisibility: GridLinesVisibility.none,
              headerRowHeight: widget.headerRowHeight,
              frozenColumnsCount: widget.frozenColumnsCount,
              frozenRowsCount: widget.frozenRowsCount,
              allowFiltering: widget.allowFiltering,
              shrinkWrapRows: notExpanded,
              onQueryRowHeight: (details) {
                if (widget.allowExpandCollapseGroup) {
                  return details.rowHeight;
                } else if (widget.forceSingleLine) {
                  return details.rowHeight;
                } else {
                  return details.getIntrinsicRowHeight(details.rowIndex);
                }
              },
              columnSizer: ColumnSizeController(),
              columnWidthMode: Responsive.isMobile(context)
                  ? mobileWidthMode()
                  : Responsive.isTablet(context)
                      ? tabletWidthMode()
                      : widget.desktopColumnWidthMode,
              source: widget.dataSource,
              columns: widget.columns,
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black12,
              width: double.infinity,
              height: double.infinity,
              child: const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }

  ColumnWidthMode mobileWidthMode() {
    if (widget.columns.length <= 5) {
      return ColumnWidthMode.fill;
    } else {
      return ColumnWidthMode.fitByColumnName;
    }
  }

  ColumnWidthMode tabletWidthMode() {
    if (widget.columns.length <= 7) {
      return ColumnWidthMode.fill;
    } else {
      return ColumnWidthMode.fitByColumnName;
    }
  }

  Widget _buildPager() {
    return PanopticPager(
      totalRowCount: widget.totalRowCount,
      pageSize: widget.pageSize,
      dataSource: widget.dataSource,
      availableRowsPerPage: widget.availableRowsPerPage,
      onRowsPerPageChanged: widget.onRowsPerPageChanged,
      onPageNavigationStart: () {
        setState(() {
          isLoading = true;
          clearSelection();
        });
      },
      onPageNavigationEnd: () {
        setState(() => isLoading = false);
      },
    );

    // return SfTheme(
    //   data: SfThemeData(
    //     dataPagerThemeData: SfDataPagerThemeData(
    //       selectedItemColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
    //       itemBorderRadius: BorderRadius.circular(CoreValues.cornerRadius),
    //     ),
    //   ),
    //   child: SfDataPager(
    //     delegate: widget.dataSource,
    //     pageCount: widget.pageCount,
    //     onRowsPerPageChanged: widget.onRowsPerPageChanged,
    //     availableRowsPerPage: widget.availableRowsPerPage,
    //     onPageNavigationStart: (pageIndex) {
    //       setState(() => isLoading = true);
    //     },
    //     onPageNavigationEnd: (pageIndex) {
    //       setState(() => isLoading = false);
    //     },
    //   ),
    // );
  }
}
