import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PanopticDataGridRow<T> extends DataGridRow {
  final T item;

  PanopticDataGridRow({required super.cells, required this.item});
}
