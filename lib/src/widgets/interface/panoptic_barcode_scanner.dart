import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panoptic_widgets/src/static/core_values.dart';

class PanopticBarcodeScanner extends StatefulWidget {
  const PanopticBarcodeScanner({super.key});

  @override
  State<PanopticBarcodeScanner> createState() => _PanopticBarcodeScannerState();
}

class _PanopticBarcodeScannerState extends State<PanopticBarcodeScanner> {
  bool detected = false;

  @override
  Widget build(BuildContext context) {
    return AiBarcodeScanner(
      borderRadius: CoreValues.cornerRadius,
      controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          useNewCameraSelector: true),
      bottomSheetBuilder: (context, controller) => const SizedBox.shrink(),
      onDetect: (barcode) {
        if (detected) return;
        detected = true;
        Navigator.of(context).pop(barcode.barcodes.first.displayValue);
      },
      sheetTitle: 'Scan Book Barcode',
      onDispose: () {
        if (Theme.of(context).brightness == Brightness.dark) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        } else {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
        }
      },
    );
  }
}
