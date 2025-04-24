import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:diff_match_patch/diff_match_patch.dart';
import 'dart:convert';

import 'package:panoptic_widgets/panoptic_widgets.dart';

class PanopticTextCompare extends StatefulWidget {
  const PanopticTextCompare({
    super.key,
    required this.title,
    required this.originalText,
    required this.modifiedText,
    this.isHtml = false,
    this.slideOver = false,
  });
  final String originalText;
  final String modifiedText;
  final bool isHtml;
  final String title;
  final bool slideOver;

  @override
  State<PanopticTextCompare> createState() => _PanopticTextCompareState();
}

class _PanopticTextCompareState extends State<PanopticTextCompare> {
  int view = 0;
  DiffViewMode diffViewMode = DiffViewMode.all;
  DiffThemeMode diffThemeMode = DiffThemeMode.defaultColors;
  String? diffText;
  @override
  void initState() {
    super.initState();

    if (widget.isHtml) {
      diffText = _computeHtmlDomDiff(widget.originalText, widget.modifiedText);
    } else {
      diffText = _generateDiffHtml(widget.originalText, widget.modifiedText);
    }
  }

  String _computeHtmlDomDiff(String original, String corrected) {
    final dom.Document originalDoc = html_parser.parse(original);
    final dom.Document correctedDoc = html_parser.parse(corrected);

    final bodyDiff = _diffNodes(originalDoc.body, correctedDoc.body);
    final container = dom.DocumentFragment();
    container.append(bodyDiff);
    return container.outerHtml;
  }

  String _generateDiffHtml(String oldText, String newText) {
    final dmp = DiffMatchPatch();
    final diffs = dmp.diff(oldText, newText);
    dmp.diffCleanupSemantic(diffs);

    final buffer = StringBuffer();
    for (final diff in diffs) {
      switch (diff.operation) {
        case DIFF_INSERT:
          buffer.write('<ins style="background-color: #d4edda">${diff.text}</ins>');
          break;
        case DIFF_DELETE:
          buffer.write('<del style="background-color: #f8d7da">${diff.text}</del>');
          break;
        case DIFF_EQUAL:
          buffer.write(diff.text);
          break;
      }
    }
    diffText = buffer.toString();

    return buffer.toString();
  }

  dom.Node _diffNodes(dom.Node? oldNode, dom.Node? newNode) {
    if (oldNode == null && newNode != null) {
      return _wrapWith('ins', newNode);
    } else if (oldNode != null && newNode == null) {
      return _wrapWith('del', oldNode);
    } else if (oldNode is dom.Text && newNode is dom.Text) {
      return dom.Element.tag('span')
        ..nodes.addAll(html_parser.parseFragment(_diffText(oldNode.text, newNode.text)).nodes);
    } else if (oldNode is dom.Element &&
        newNode is dom.Element &&
        oldNode.localName == newNode.localName) {
      final merged = dom.Element.tag(oldNode.localName!);
      final maxLength =
          [oldNode.nodes.length, newNode.nodes.length].reduce((a, b) => a > b ? a : b);
      for (int i = 0; i < maxLength; i++) {
        final child = _diffNodes(
          i < oldNode.nodes.length ? oldNode.nodes[i] : null,
          i < newNode.nodes.length ? newNode.nodes[i] : null,
        );
        merged.append(child);
      }
      return merged;
    } else {
      final container = dom.Element.tag('span');
      if (oldNode != null) container.append(_wrapWith('del', oldNode));
      if (newNode != null) container.append(_wrapWith('ins', newNode));
      return container;
    }
  }

  dom.Element _wrapWith(String tag, dom.Node node) {
    final wrapper = dom.Element.tag(tag);
    wrapper.append(node.clone(true));
    return wrapper;
  }

  String _diffText(String a, String b) {
    final dmp = DiffMatchPatch();
    final diffs = dmp.diff(a, b);
    dmp.diffCleanupSemantic(diffs);

    final buffer = StringBuffer();
    for (final diff in diffs) {
      switch (diff.operation) {
        case DIFF_INSERT:
          buffer.write('<ins>${htmlEscape.convert(diff.text)}</ins>');
          break;
        case DIFF_DELETE:
          buffer.write('<del>${htmlEscape.convert(diff.text)}</del>');
          break;
        case DIFF_EQUAL:
          buffer.write(htmlEscape.convert(diff.text));
          break;
      }
    }
    diffText = buffer.toString();
    return buffer.toString();
  }

  String _filterDiffByMode(String html, DiffViewMode mode) {
    switch (mode) {
      case DiffViewMode.insertsOnly:
        return html.replaceAll(RegExp(r'<del[^>]*>.*?<\/del>', dotAll: true), '');
      case DiffViewMode.deletesOnly:
        return html.replaceAll(RegExp(r'<ins[^>]*>.*?<\/ins>', dotAll: true), '');
      default:
        return html;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PanopticResponsiveLayout(
            forceColumn: widget.slideOver,
            childrenPadding: EdgeInsets.zero,
            columnCrossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5, top: 5),
                child: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              PanopticResponsiveLayout(
                forceColumn: widget.slideOver,
                childrenPadding: EdgeInsets.zero,
                columnCrossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PanopticButton(
                        margin: EdgeInsets.zero,
                        buttonPosition: ButtonPosition.left,
                        buttonType: diffViewMode == DiffViewMode.all
                            ? ButtonType.primary
                            : ButtonType.unselected,
                        label: 'Full',
                        onPressed: () {
                          setState(() {
                            diffViewMode = DiffViewMode.all;
                          });
                        },
                      ),
                      PanopticButton(
                        margin: EdgeInsets.zero,
                        buttonType: diffViewMode == DiffViewMode.insertsOnly
                            ? ButtonType.primary
                            : ButtonType.unselected,
                        buttonPosition: ButtonPosition.center,
                        label: 'Inserts',
                        onPressed: () {
                          setState(() {
                            diffViewMode = DiffViewMode.insertsOnly;
                          });
                        },
                      ),
                      PanopticButton(
                        margin: EdgeInsets.zero,
                        buttonType: diffViewMode == DiffViewMode.deletesOnly
                            ? ButtonType.primary
                            : ButtonType.unselected,
                        buttonPosition: ButtonPosition.center,
                        label: 'Deletions',
                        onPressed: () {
                          setState(() {
                            diffViewMode = DiffViewMode.deletesOnly;
                          });
                        },
                      ),
                      PanopticButton(
                        margin: EdgeInsets.zero,
                        buttonPosition: ButtonPosition.right,
                        buttonType: diffViewMode == DiffViewMode.sideBySide
                            ? ButtonType.primary
                            : ButtonType.unselected,
                        label: 'Side-By-Side',
                        onPressed: () {
                          setState(() {
                            diffViewMode = DiffViewMode.sideBySide;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 8,
                    height: 8,
                  ),
                  SizedBox(
                      width: 200,
                      child: PanopticDropdownFormField(
                        fullWidth: true,
                        name: 'colour',
                        items: [
                          DropdownMenuItem(
                              value: DiffThemeMode.defaultColors, child: Text("Red/Green")),
                          DropdownMenuItem(
                              value: DiffThemeMode.accessible, child: Text("Blue/Gold")),
                          DropdownMenuItem(
                              value: DiffThemeMode.monochrome, child: Text("Monochrome")),
                          DropdownMenuItem(
                              value: DiffThemeMode.userTheme, child: Text("Theme Colours")),
                        ],
                        initialValue: diffThemeMode,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              diffThemeMode = value;
                            });
                          }
                        },
                      ))
                ],
              )
            ]),
        if (diffViewMode != DiffViewMode.sideBySide) ...{
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  diffViewMode == DiffViewMode.all
                      ? 'Full Diff'
                      : diffViewMode == DiffViewMode.insertsOnly
                          ? 'Inserts'
                          : 'Deletions',
                  style: Theme.of(context).textTheme.titleMedium),
              PanopticCard(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Html(
                  data: _filterDiffByMode(diffText!, diffViewMode),
                  style: _getDiffStyles(diffThemeMode),
                ),
              ))
            ],
          ),
        } else ...{
          PanopticResponsiveLayout(
            forceColumn: widget.slideOver,
            children: [
              PanopticExpanded(
                expandOnMobile: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Original Text', style: Theme.of(context).textTheme.titleMedium),
                    PanopticCard(
                        child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Html(
                        data: widget.originalText,
                        style: _getDiffStyles(diffThemeMode),
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(width: 8),
              PanopticExpanded(
                expandOnMobile: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Modified Text', style: Theme.of(context).textTheme.titleMedium),
                    PanopticCard(
                        child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Html(
                        data: widget.modifiedText,
                        style: _getDiffStyles(diffThemeMode),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          )
        },
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Key:'),
              const SizedBox(width: 12),
              _buildKeyChip("Inserts", diffThemeMode, true),
              const SizedBox(width: 12),
              _buildKeyChip("Deletion", diffThemeMode, false),
            ],
          ),
        ),
      ],
    );
  }

  Map<String, Style> _getDiffStyles(DiffThemeMode mode) {
    switch (mode) {
      case DiffThemeMode.accessible:
        return {
          "ins": Style(
            backgroundColor: Color(0xFFD0EBFF),
            textDecoration: TextDecoration.underline,
          ),
          "del": Style(
            backgroundColor: Color(0xFFFFE0B3),
            textDecoration: TextDecoration.lineThrough,
          ),
        };
      case DiffThemeMode.monochrome:
        return {
          "ins": Style(
            textDecoration: TextDecoration.underline,
          ),
          "del": Style(
            textDecoration: TextDecoration.lineThrough,
          ),
        };
      case DiffThemeMode.defaultColors:
        return {
          "ins": Style(
            backgroundColor: Colors.green[100],
            textDecoration: TextDecoration.none,
          ),
          "del": Style(
            backgroundColor: Colors.red[100],
            textDecoration: TextDecoration.lineThrough,
          ),
        };
      case DiffThemeMode.userTheme:
        return {
          "ins": Style(
            backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(55),
            textDecoration: TextDecoration.none,
          ),
          "del": Style(
            backgroundColor: Theme.of(context).colorScheme.secondary.withAlpha(55),
            textDecoration: TextDecoration.lineThrough,
          ),
        };
    }
  }

  Widget _buildKeyChip(String label, DiffThemeMode theme, bool isInsert) {
    Color? bg;
    TextDecoration decoration = TextDecoration.none;

    switch (theme) {
      case DiffThemeMode.accessible:
        bg = isInsert ? Color(0xFFD0EBFF) : Color(0xFFFFE0B3);
        decoration = isInsert ? TextDecoration.underline : TextDecoration.lineThrough;
        break;
      case DiffThemeMode.monochrome:
        bg = null;
        decoration = isInsert ? TextDecoration.underline : TextDecoration.lineThrough;
        break;
      case DiffThemeMode.defaultColors:
        bg = isInsert ? Colors.green[100] : Colors.red[100];
        decoration = isInsert ? TextDecoration.none : TextDecoration.lineThrough;
        break;
      case DiffThemeMode.userTheme:
        bg = isInsert
            ? Theme.of(context).colorScheme.primary.withAlpha(55)
            : Theme.of(context).colorScheme.secondary.withAlpha(55);
        decoration = isInsert ? TextDecoration.none : TextDecoration.lineThrough;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(
        label,
        style: TextStyle(decoration: decoration, fontSize: 14),
      ),
    );
  }
}
