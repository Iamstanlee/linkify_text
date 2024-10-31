import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkfy_text/src/enum.dart';
import 'package:linkfy_text/src/model/link.dart';
import 'package:linkfy_text/src/utils/linkify_text_span.dart';

/// Linkify [text] containing urls, emails or hashtag
class LinkifyText extends StatelessWidget {
  const LinkifyText(this.text,
      {this.textStyle,
      this.linkStyle,
      this.linkTypes,
      this.onTap,
      this.customLinkStyles,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.locale,
      this.softWrap,
      this.overflow,
      this.textScaler,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      Key? key})
      : super(key: key);

  /// text to be linkified
  final String text;

  /// [textStyle] applied the text
  final TextStyle? textStyle;

  /// [textStyle] added to the formatted links in the text
  final TextStyle? linkStyle;

  /// called when a formatted link is pressed, it returns the link as a parameter
  /// ```dart
  ///   LinkifyText("#helloWorld", onTap: (link) {
  ///       // do stuff with link
  ///       print("${link.value} hashtag was tapped");
  ///   });
  /// ```
  final void Function(Link)? onTap;

  /// option to override the links to be formatted in the text, defaults to `[LinkType.url]`
  /// so only urls are being linkified in the text
  final List<LinkType>? linkTypes;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// Defaults to retrieving the value from the nearest [DefaultTextStyle] ancestor.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaler] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final TextScaler? textScaler;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  final String? semanticsLabel;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  final Map<LinkType, TextStyle>? customLinkStyles;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      LinkifyTextSpan().linkify(
          text: text,
          linkStyle: linkStyle,
          onTap: onTap,
          linkTypes: linkTypes,
          customLinkStyles: customLinkStyles),
      key: key,
      style: textStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaler: textScaler,
      textWidthBasis: textWidthBasis,
      semanticsLabel: semanticsLabel,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      locale: locale,
    );
  }
}

class LinkifySelectableText extends StatelessWidget {
  const LinkifySelectableText(
    this.text, {
    Key? key,
    this.focusNode,
    this.textStyle,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.autofocus = false,
    this.minLines,
    this.maxLines,
    this.showCursor = false,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.enableInteractiveSelection = true,
    this.selectionControls,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTap,
    this.scrollPhysics,
    this.semanticsLabel,
    this.textHeightBehavior,
    this.textWidthBasis,
    this.onSelectionChanged,
    this.customLinkStyles,
    this.linkStyle,
    this.linkTypes,
    this.contextMenuBuilder,
  }) : super(key: key);

  /// The text to display.
  ///
  final String text;

  /// Defines the focus for this widget.
  ///
  /// Text is only selectable when widget is focused.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// focusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode] with
  /// [FocusNode.skipTraversal] parameter set to `true`, which causes the widget
  /// to be skipped over during focus traversal.
  final FocusNode? focusNode;

  /// The style to use for the text.
  ///
  /// If null, defaults [DefaultTextStyle] of context.
  final TextStyle? textStyle;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign? textAlign;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.textScaler}
  final TextScaler? textScaler;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int? maxLines;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool showCursor;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorHeight}
  final double? cursorHeight;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to the theme's `cursorColor` when null.
  final Color? cursorColor;

  /// Controls how tall the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxHeightStyle] for details on available styles.
  final ui.BoxHeightStyle selectionHeightStyle;

  /// Controls how wide the selection highlight boxes are computed to be.
  ///
  /// See [ui.BoxWidthStyle] for details on available styles.
  final ui.BoxWidthStyle selectionWidthStyle;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.selectionControls}
  final TextSelectionControls? selectionControls;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final DragStartBehavior dragStartBehavior;

  /// Configuration of toolbar options.
  ///
  /// Paste and cut will be disabled regardless.
  ///
  /// If not set, select all and copy will be enabled by default.
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  /// {@macro flutter.widgets.editableText.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.Text.semanticsLabel}
  final String? semanticsLabel;

  /// {@macro dart.ui.textHeightBehavior}
  final TextHeightBehavior? textHeightBehavior;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro flutter.widgets.editableText.onSelectionChanged}
  final SelectionChangedCallback? onSelectionChanged;

  final Map<LinkType, TextStyle>? customLinkStyles;

  /// [textStyle] added to the formatted links in the text
  final TextStyle? linkStyle;

  /// called when a formatted link is pressed, it returns the link as a parameter
  /// ```dart
  ///   LinkifyText("#helloWorld", onTap: (link) {
  ///       // do stuff with link
  ///       print("${link.value} hashtag was tapped");
  ///   });
  /// ```
  final void Function(Link)? onTap;

  /// option to override the links to be formatted in the text, defaults to `[LinkType.url]`
  /// so only urls are being linkified in the text
  final List<LinkType>? linkTypes;

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(
      LinkifyTextSpan().linkify(
        text: text,
        linkStyle: linkStyle,
        onTap: onTap,
        linkTypes: linkTypes,
        customLinkStyles: customLinkStyles,
      ),
      key: key,
      focusNode: focusNode,
      style: textStyle,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaler: textScaler,
      showCursor: showCursor,
      autofocus: autofocus,
      contextMenuBuilder: contextMenuBuilder,
      minLines: minLines,
      maxLines: maxLines,
      cursorWidth: cursorWidth,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      selectionHeightStyle: selectionHeightStyle,
      selectionWidthStyle: selectionWidthStyle,
      dragStartBehavior: dragStartBehavior,
      enableInteractiveSelection: enableInteractiveSelection,
      selectionControls: selectionControls,
      scrollPhysics: scrollPhysics,
      semanticsLabel: semanticsLabel,
      textHeightBehavior: textHeightBehavior,
      textWidthBasis: textWidthBasis,
      onSelectionChanged: onSelectionChanged,
    );
  }
}
