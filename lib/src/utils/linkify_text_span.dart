import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:linkfy_text/src/model/link.dart';

class LinkifyTextSpan {
  TextSpan linkify({
    String text = '',
    TextStyle? linkStyle,
    List<LinkType>? linkTypes,
    Map<LinkType, TextStyle>? customLinkStyles,
    Function(Link)? onTap,
  }) {
    final _regExp = constructRegExpFromLinkType(linkTypes ?? [LinkType.url]);

    //  return the full text if there's no match or if empty
    if (!_regExp.hasMatch(text) || text.isEmpty) return TextSpan(text: text);

    final texts = text.split(_regExp);
    final List<InlineSpan> spans = [];
    final links = _regExp.allMatches(text).toList();

    for (final text in texts) {
      spans.add(TextSpan(
        text: text,
      ));
      if (links.isNotEmpty) {
        final match = links.removeAt(0);
        final link = Link.fromMatch(match);
        // add the link
        spans.add(
          TextSpan(
            text: link.value,
            style: customLinkStyles?[link.type] ?? linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                if (onTap != null) onTap(link);
              },
          ),
        );
      }
    }
    return TextSpan(children: spans);
  }
}
