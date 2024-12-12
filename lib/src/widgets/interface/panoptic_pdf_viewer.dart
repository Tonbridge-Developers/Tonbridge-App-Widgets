import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:panoptic_widgets/panoptic_widgets.dart';
import 'package:panoptic_widgets/src/widgets/interface/panoptic_page_indicator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PanopticPdfViewer extends StatefulWidget {
  const PanopticPdfViewer({
    super.key,
    required this.pdfBytes,
    required this.title,
    this.password,
    this.searchQuery,
    this.url,
    this.subTitle,
  });
  final Uint8List pdfBytes;
  final String title;
  final String? password;
  final String? url;
  final String? subTitle;
  final ValueNotifier<String?>? searchQuery;

  @override
  State<PanopticPdfViewer> createState() => _PanopticPdfViewerState();
}

class _PanopticPdfViewerState extends State<PanopticPdfViewer> {
  late PdfViewerController _pdfViewerController;
  final ValueNotifier<int> _pageCount = ValueNotifier(1);
  final ValueNotifier<int> _currentPage = ValueNotifier(1);
  late PdfTextSearchResult _searchResult;

  bool loaded = false;
  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();

    if (widget.searchQuery != null) {
      widget.searchQuery!.addListener(() {
        if (widget.searchQuery!.value != null) {
          _searchResult =
              _pdfViewerController.searchText(widget.searchQuery!.value!);
          setState(() {});
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PanopticColumn(
      children: [
        PanopticCard(
          child: PanopticResponsiveLayout(
            children: [
              PanopticExpanded(
                expandOnMobile: false,
                child: RichText(
                    text: TextSpan(
                  text: widget.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  children: [
                    if (widget.subTitle != null) ...{
                      TextSpan(
                        text: '${widget.subTitle}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    },
                  ],
                )),
              ),
              if (_searchResult.hasResult) ...{
                PanopticRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PanopticIconButton(
                      icon: PanopticIcons.chevronleft,
                      onTap: () {
                        _searchResult.previousInstance();
                        setState(() {});
                      },
                    ),
                    Text(
                        '${_searchResult.currentInstanceIndex} of ${_searchResult.totalInstanceCount}'),
                    PanopticIconButton(
                      icon: PanopticIcons.chevronright,
                      onTap: () {
                        _searchResult.nextInstance();
                        setState(() {});
                      },
                    )
                  ],
                ),
              },
              PanopticRow(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PanopticButton(
                    margin: EdgeInsets.zero,
                    icon: PanopticIcons.download,
                    label: 'Download',
                    onPressed: () {
                      PanopticExtension.saveFile(widget.pdfBytes,
                          '${widget.title}.pdf', 'application/pdf', context);
                    },
                  ),
                  if (widget.url != null)
                    PanopticButton(
                      margin: EdgeInsets.zero,
                      icon: PanopticIcons.open,
                      label: 'View Online',
                      onPressed: () {
                        PanopticExtension.launch(widget.url!);
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: SfPdfViewer.memory(
            widget.pdfBytes,
            controller: _pdfViewerController,
            password: widget.password,
            enableTextSelection: true,
            enableDoubleTapZooming: true,
            enableDocumentLinkAnnotation: false,
            enableHyperlinkNavigation: true,
            canShowTextSelectionMenu: false,
            scrollDirection: PdfScrollDirection.vertical,
            pageLayoutMode: PdfPageLayoutMode.single,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _currentPage.value = _pdfViewerController.pageNumber;
                _pageCount.value = _pdfViewerController.pageCount;

                loaded = true;
              });
            },
            onHyperlinkClicked: (details) {
              PanopticExtension.launch(details.uri);
            },
            onPageChanged: (PdfPageChangedDetails details) {
              setState(() {
                _currentPage.value = details.newPageNumber;
              });
            },
          ),
        ),
        if (loaded)
          PanopticPageIndicator(
            pageCount: _pageCount,
            currentPage: _currentPage,
            visibleButtonCount: 5,
            onPageChanged: (int page) {
              _pdfViewerController.jumpToPage(page + 1);

              setState(() {});
            },
          ),
      ],
    );
  }
}
