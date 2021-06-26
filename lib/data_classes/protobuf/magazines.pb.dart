///
//  Generated code. Do not modify.
//  source: magazines.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'magazines.pbenum.dart';

export 'magazines.pbenum.dart';

class Color extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Color', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'red', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'green', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'blue', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Color._() : super();
  factory Color({
    $core.int? red,
    $core.int? green,
    $core.int? blue,
  }) {
    final _result = create();
    if (red != null) {
      _result.red = red;
    }
    if (green != null) {
      _result.green = green;
    }
    if (blue != null) {
      _result.blue = blue;
    }
    return _result;
  }
  factory Color.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Color.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Color clone() => Color()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Color copyWith(void Function(Color) updates) => super.copyWith((message) => updates(message as Color)) as Color; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Color create() => Color._();
  Color createEmptyInstance() => create();
  static $pb.PbList<Color> createRepeated() => $pb.PbList<Color>();
  @$core.pragma('dart2js:noInline')
  static Color getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Color>(create);
  static Color? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get red => $_getIZ(0);
  @$pb.TagNumber(1)
  set red($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasRed() => $_has(0);
  @$pb.TagNumber(1)
  void clearRed() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get green => $_getIZ(1);
  @$pb.TagNumber(2)
  set green($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasGreen() => $_has(1);
  @$pb.TagNumber(2)
  void clearGreen() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get blue => $_getIZ(2);
  @$pb.TagNumber(3)
  set blue($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBlue() => $_has(2);
  @$pb.TagNumber(3)
  void clearBlue() => clearField(3);
}

class TextStyle extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'TextStyle', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..aOM<Color>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'color', subBuilder: Color.create)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'font')
    ..e<TextStyle_FontWeight>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'weight', $pb.PbFieldType.OE, defaultOrMaker: TextStyle_FontWeight.NA, valueOf: TextStyle_FontWeight.valueOf, enumValues: TextStyle_FontWeight.values)
    ..hasRequiredFields = false
  ;

  TextStyle._() : super();
  factory TextStyle({
    Color? color,
    $core.String? font,
    TextStyle_FontWeight? weight,
  }) {
    final _result = create();
    if (color != null) {
      _result.color = color;
    }
    if (font != null) {
      _result.font = font;
    }
    if (weight != null) {
      _result.weight = weight;
    }
    return _result;
  }
  factory TextStyle.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TextStyle.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TextStyle clone() => TextStyle()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TextStyle copyWith(void Function(TextStyle) updates) => super.copyWith((message) => updates(message as TextStyle)) as TextStyle; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static TextStyle create() => TextStyle._();
  TextStyle createEmptyInstance() => create();
  static $pb.PbList<TextStyle> createRepeated() => $pb.PbList<TextStyle>();
  @$core.pragma('dart2js:noInline')
  static TextStyle getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextStyle>(create);
  static TextStyle? _defaultInstance;

  @$pb.TagNumber(1)
  Color get color => $_getN(0);
  @$pb.TagNumber(1)
  set color(Color v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasColor() => $_has(0);
  @$pb.TagNumber(1)
  void clearColor() => clearField(1);
  @$pb.TagNumber(1)
  Color ensureColor() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get font => $_getSZ(1);
  @$pb.TagNumber(2)
  set font($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFont() => $_has(1);
  @$pb.TagNumber(2)
  void clearFont() => clearField(2);

  @$pb.TagNumber(3)
  TextStyle_FontWeight get weight => $_getN(2);
  @$pb.TagNumber(3)
  set weight(TextStyle_FontWeight v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasWeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearWeight() => clearField(3);
}

class DimensionalValue extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DimensionalValue', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'top', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bottom', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'left', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'right', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  DimensionalValue._() : super();
  factory DimensionalValue({
    $core.int? top,
    $core.int? bottom,
    $core.int? left,
    $core.int? right,
  }) {
    final _result = create();
    if (top != null) {
      _result.top = top;
    }
    if (bottom != null) {
      _result.bottom = bottom;
    }
    if (left != null) {
      _result.left = left;
    }
    if (right != null) {
      _result.right = right;
    }
    return _result;
  }
  factory DimensionalValue.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DimensionalValue.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DimensionalValue clone() => DimensionalValue()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DimensionalValue copyWith(void Function(DimensionalValue) updates) => super.copyWith((message) => updates(message as DimensionalValue)) as DimensionalValue; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DimensionalValue create() => DimensionalValue._();
  DimensionalValue createEmptyInstance() => create();
  static $pb.PbList<DimensionalValue> createRepeated() => $pb.PbList<DimensionalValue>();
  @$core.pragma('dart2js:noInline')
  static DimensionalValue getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DimensionalValue>(create);
  static DimensionalValue? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get top => $_getIZ(0);
  @$pb.TagNumber(1)
  set top($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTop() => $_has(0);
  @$pb.TagNumber(1)
  void clearTop() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get bottom => $_getIZ(1);
  @$pb.TagNumber(2)
  set bottom($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasBottom() => $_has(1);
  @$pb.TagNumber(2)
  void clearBottom() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get left => $_getIZ(2);
  @$pb.TagNumber(3)
  set left($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLeft() => $_has(2);
  @$pb.TagNumber(3)
  void clearLeft() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get right => $_getIZ(3);
  @$pb.TagNumber(4)
  set right($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasRight() => $_has(3);
  @$pb.TagNumber(4)
  void clearRight() => clearField(4);
}

class Image extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Image', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'alt')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'source')
    ..hasRequiredFields = false
  ;

  Image._() : super();
  factory Image({
    $core.String? url,
    $core.String? alt,
    $core.String? source,
  }) {
    final _result = create();
    if (url != null) {
      _result.url = url;
    }
    if (alt != null) {
      _result.alt = alt;
    }
    if (source != null) {
      _result.source = source;
    }
    return _result;
  }
  factory Image.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Image.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Image clone() => Image()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Image copyWith(void Function(Image) updates) => super.copyWith((message) => updates(message as Image)) as Image; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Image create() => Image._();
  Image createEmptyInstance() => create();
  static $pb.PbList<Image> createRepeated() => $pb.PbList<Image>();
  @$core.pragma('dart2js:noInline')
  static Image getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Image>(create);
  static Image? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get alt => $_getSZ(1);
  @$pb.TagNumber(2)
  set alt($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAlt() => $_has(1);
  @$pb.TagNumber(2)
  void clearAlt() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get source => $_getSZ(2);
  @$pb.TagNumber(3)
  set source($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSource() => $_has(2);
  @$pb.TagNumber(3)
  void clearSource() => clearField(3);
}

class Date extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Date', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'date', $pb.PbFieldType.OU3)
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'month', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'year', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Date._() : super();
  factory Date({
    $core.int? date,
    $core.int? month,
    $core.int? year,
  }) {
    final _result = create();
    if (date != null) {
      _result.date = date;
    }
    if (month != null) {
      _result.month = month;
    }
    if (year != null) {
      _result.year = year;
    }
    return _result;
  }
  factory Date.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Date.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Date clone() => Date()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Date copyWith(void Function(Date) updates) => super.copyWith((message) => updates(message as Date)) as Date; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Date create() => Date._();
  Date createEmptyInstance() => create();
  static $pb.PbList<Date> createRepeated() => $pb.PbList<Date>();
  @$core.pragma('dart2js:noInline')
  static Date getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Date>(create);
  static Date? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get date => $_getIZ(0);
  @$pb.TagNumber(1)
  set date($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDate() => $_has(0);
  @$pb.TagNumber(1)
  void clearDate() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get month => $_getIZ(1);
  @$pb.TagNumber(2)
  set month($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMonth() => $_has(1);
  @$pb.TagNumber(2)
  void clearMonth() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get year => $_getIZ(2);
  @$pb.TagNumber(3)
  set year($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasYear() => $_has(2);
  @$pb.TagNumber(3)
  void clearYear() => clearField(3);
}

class Contact extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Contact', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..hasRequiredFields = false
  ;

  Contact._() : super();
  factory Contact({
    $core.String? name,
    $core.String? email,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (email != null) {
      _result.email = email;
    }
    return _result;
  }
  factory Contact.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Contact.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Contact clone() => Contact()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Contact copyWith(void Function(Contact) updates) => super.copyWith((message) => updates(message as Contact)) as Contact; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Contact create() => Contact._();
  Contact createEmptyInstance() => create();
  static $pb.PbList<Contact> createRepeated() => $pb.PbList<Contact>();
  @$core.pragma('dart2js:noInline')
  static Contact getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Contact>(create);
  static Contact? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get email => $_getSZ(1);
  @$pb.TagNumber(2)
  set email($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEmail() => $_has(1);
  @$pb.TagNumber(2)
  void clearEmail() => clearField(2);
}

class PublicationTheme extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PublicationTheme', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..aOM<Color>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'primaryColor', protoName: 'primaryColor', subBuilder: Color.create)
    ..aOM<Color>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'accentColor', protoName: 'accentColor', subBuilder: Color.create)
    ..aOM<Image>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'logo', subBuilder: Image.create)
    ..aOM<TextStyle>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'paragraphStyle', protoName: 'paragraphStyle', subBuilder: TextStyle.create)
    ..aOM<TextStyle>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'headingStyle', protoName: 'headingStyle', subBuilder: TextStyle.create)
    ..aOM<TextStyle>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'titleStyle', protoName: 'titleStyle', subBuilder: TextStyle.create)
    ..aOM<TextStyle>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subheadingStyle', protoName: 'subheadingStyle', subBuilder: TextStyle.create)
    ..aOB(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contentProtection', protoName: 'contentProtection')
    ..hasRequiredFields = false
  ;

  PublicationTheme._() : super();
  factory PublicationTheme({
    Color? primaryColor,
    Color? accentColor,
    Image? logo,
    TextStyle? paragraphStyle,
    TextStyle? headingStyle,
    TextStyle? titleStyle,
    TextStyle? subheadingStyle,
    $core.bool? contentProtection,
  }) {
    final _result = create();
    if (primaryColor != null) {
      _result.primaryColor = primaryColor;
    }
    if (accentColor != null) {
      _result.accentColor = accentColor;
    }
    if (logo != null) {
      _result.logo = logo;
    }
    if (paragraphStyle != null) {
      _result.paragraphStyle = paragraphStyle;
    }
    if (headingStyle != null) {
      _result.headingStyle = headingStyle;
    }
    if (titleStyle != null) {
      _result.titleStyle = titleStyle;
    }
    if (subheadingStyle != null) {
      _result.subheadingStyle = subheadingStyle;
    }
    if (contentProtection != null) {
      _result.contentProtection = contentProtection;
    }
    return _result;
  }
  factory PublicationTheme.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PublicationTheme.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PublicationTheme clone() => PublicationTheme()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PublicationTheme copyWith(void Function(PublicationTheme) updates) => super.copyWith((message) => updates(message as PublicationTheme)) as PublicationTheme; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PublicationTheme create() => PublicationTheme._();
  PublicationTheme createEmptyInstance() => create();
  static $pb.PbList<PublicationTheme> createRepeated() => $pb.PbList<PublicationTheme>();
  @$core.pragma('dart2js:noInline')
  static PublicationTheme getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicationTheme>(create);
  static PublicationTheme? _defaultInstance;

  @$pb.TagNumber(1)
  Color get primaryColor => $_getN(0);
  @$pb.TagNumber(1)
  set primaryColor(Color v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasPrimaryColor() => $_has(0);
  @$pb.TagNumber(1)
  void clearPrimaryColor() => clearField(1);
  @$pb.TagNumber(1)
  Color ensurePrimaryColor() => $_ensure(0);

  @$pb.TagNumber(2)
  Color get accentColor => $_getN(1);
  @$pb.TagNumber(2)
  set accentColor(Color v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAccentColor() => $_has(1);
  @$pb.TagNumber(2)
  void clearAccentColor() => clearField(2);
  @$pb.TagNumber(2)
  Color ensureAccentColor() => $_ensure(1);

  @$pb.TagNumber(3)
  Image get logo => $_getN(2);
  @$pb.TagNumber(3)
  set logo(Image v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLogo() => $_has(2);
  @$pb.TagNumber(3)
  void clearLogo() => clearField(3);
  @$pb.TagNumber(3)
  Image ensureLogo() => $_ensure(2);

  @$pb.TagNumber(4)
  TextStyle get paragraphStyle => $_getN(3);
  @$pb.TagNumber(4)
  set paragraphStyle(TextStyle v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasParagraphStyle() => $_has(3);
  @$pb.TagNumber(4)
  void clearParagraphStyle() => clearField(4);
  @$pb.TagNumber(4)
  TextStyle ensureParagraphStyle() => $_ensure(3);

  @$pb.TagNumber(5)
  TextStyle get headingStyle => $_getN(4);
  @$pb.TagNumber(5)
  set headingStyle(TextStyle v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasHeadingStyle() => $_has(4);
  @$pb.TagNumber(5)
  void clearHeadingStyle() => clearField(5);
  @$pb.TagNumber(5)
  TextStyle ensureHeadingStyle() => $_ensure(4);

  @$pb.TagNumber(6)
  TextStyle get titleStyle => $_getN(5);
  @$pb.TagNumber(6)
  set titleStyle(TextStyle v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasTitleStyle() => $_has(5);
  @$pb.TagNumber(6)
  void clearTitleStyle() => clearField(6);
  @$pb.TagNumber(6)
  TextStyle ensureTitleStyle() => $_ensure(5);

  @$pb.TagNumber(7)
  TextStyle get subheadingStyle => $_getN(6);
  @$pb.TagNumber(7)
  set subheadingStyle(TextStyle v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasSubheadingStyle() => $_has(6);
  @$pb.TagNumber(7)
  void clearSubheadingStyle() => clearField(7);
  @$pb.TagNumber(7)
  TextStyle ensureSubheadingStyle() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.bool get contentProtection => $_getBF(7);
  @$pb.TagNumber(8)
  set contentProtection($core.bool v) { $_setBool(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasContentProtection() => $_has(7);
  @$pb.TagNumber(8)
  void clearContentProtection() => clearField(8);
}

class PublicationFrequency extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PublicationFrequency', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'n', $pb.PbFieldType.OU3)
    ..e<PublicationFrequency_PublicationFrequencyType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'every', $pb.PbFieldType.OE, defaultOrMaker: PublicationFrequency_PublicationFrequencyType.DAY, valueOf: PublicationFrequency_PublicationFrequencyType.valueOf, enumValues: PublicationFrequency_PublicationFrequencyType.values)
    ..hasRequiredFields = false
  ;

  PublicationFrequency._() : super();
  factory PublicationFrequency({
    $core.int? n,
    PublicationFrequency_PublicationFrequencyType? every,
  }) {
    final _result = create();
    if (n != null) {
      _result.n = n;
    }
    if (every != null) {
      _result.every = every;
    }
    return _result;
  }
  factory PublicationFrequency.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PublicationFrequency.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PublicationFrequency clone() => PublicationFrequency()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PublicationFrequency copyWith(void Function(PublicationFrequency) updates) => super.copyWith((message) => updates(message as PublicationFrequency)) as PublicationFrequency; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PublicationFrequency create() => PublicationFrequency._();
  PublicationFrequency createEmptyInstance() => create();
  static $pb.PbList<PublicationFrequency> createRepeated() => $pb.PbList<PublicationFrequency>();
  @$core.pragma('dart2js:noInline')
  static PublicationFrequency getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PublicationFrequency>(create);
  static PublicationFrequency? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get n => $_getIZ(0);
  @$pb.TagNumber(1)
  set n($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasN() => $_has(0);
  @$pb.TagNumber(1)
  void clearN() => clearField(1);

  @$pb.TagNumber(2)
  PublicationFrequency_PublicationFrequencyType get every => $_getN(1);
  @$pb.TagNumber(2)
  set every(PublicationFrequency_PublicationFrequencyType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasEvery() => $_has(1);
  @$pb.TagNumber(2)
  void clearEvery() => clearField(2);
}

class Publication extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Publication', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOM<PublicationTheme>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'theme', subBuilder: PublicationTheme.create)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'caption')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..aOM<PublicationFrequency>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frequency', subBuilder: PublicationFrequency.create)
    ..hasRequiredFields = false
  ;

  Publication._() : super();
  factory Publication({
    $core.String? id,
    $core.String? title,
    PublicationTheme? theme,
    $core.String? caption,
    $core.String? description,
    PublicationFrequency? frequency,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (title != null) {
      _result.title = title;
    }
    if (theme != null) {
      _result.theme = theme;
    }
    if (caption != null) {
      _result.caption = caption;
    }
    if (description != null) {
      _result.description = description;
    }
    if (frequency != null) {
      _result.frequency = frequency;
    }
    return _result;
  }
  factory Publication.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Publication.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Publication clone() => Publication()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Publication copyWith(void Function(Publication) updates) => super.copyWith((message) => updates(message as Publication)) as Publication; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Publication create() => Publication._();
  Publication createEmptyInstance() => create();
  static $pb.PbList<Publication> createRepeated() => $pb.PbList<Publication>();
  @$core.pragma('dart2js:noInline')
  static Publication getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Publication>(create);
  static Publication? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  PublicationTheme get theme => $_getN(2);
  @$pb.TagNumber(3)
  set theme(PublicationTheme v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTheme() => $_has(2);
  @$pb.TagNumber(3)
  void clearTheme() => clearField(3);
  @$pb.TagNumber(3)
  PublicationTheme ensureTheme() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.String get caption => $_getSZ(3);
  @$pb.TagNumber(4)
  set caption($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCaption() => $_has(3);
  @$pb.TagNumber(4)
  void clearCaption() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get description => $_getSZ(4);
  @$pb.TagNumber(5)
  set description($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDescription() => $_has(4);
  @$pb.TagNumber(5)
  void clearDescription() => clearField(5);

  @$pb.TagNumber(6)
  PublicationFrequency get frequency => $_getN(5);
  @$pb.TagNumber(6)
  set frequency(PublicationFrequency v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasFrequency() => $_has(5);
  @$pb.TagNumber(6)
  void clearFrequency() => clearField(6);
  @$pb.TagNumber(6)
  PublicationFrequency ensureFrequency() => $_ensure(5);
}

class Season extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Season', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicationId', protoName: 'publicationId')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceNumber', $pb.PbFieldType.OU3, protoName: 'sequenceNumber')
    ..aOM<Date>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'startDate', protoName: 'startDate', subBuilder: Date.create)
    ..aOM<Date>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endDate', protoName: 'endDate', subBuilder: Date.create)
    ..hasRequiredFields = false
  ;

  Season._() : super();
  factory Season({
    $core.String? id,
    $core.String? publicationId,
    $core.int? sequenceNumber,
    Date? startDate,
    Date? endDate,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (publicationId != null) {
      _result.publicationId = publicationId;
    }
    if (sequenceNumber != null) {
      _result.sequenceNumber = sequenceNumber;
    }
    if (startDate != null) {
      _result.startDate = startDate;
    }
    if (endDate != null) {
      _result.endDate = endDate;
    }
    return _result;
  }
  factory Season.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Season.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Season clone() => Season()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Season copyWith(void Function(Season) updates) => super.copyWith((message) => updates(message as Season)) as Season; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Season create() => Season._();
  Season createEmptyInstance() => create();
  static $pb.PbList<Season> createRepeated() => $pb.PbList<Season>();
  @$core.pragma('dart2js:noInline')
  static Season getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Season>(create);
  static Season? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get publicationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set publicationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPublicationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get sequenceNumber => $_getIZ(2);
  @$pb.TagNumber(3)
  set sequenceNumber($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSequenceNumber() => $_has(2);
  @$pb.TagNumber(3)
  void clearSequenceNumber() => clearField(3);

  @$pb.TagNumber(4)
  Date get startDate => $_getN(3);
  @$pb.TagNumber(4)
  set startDate(Date v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasStartDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartDate() => clearField(4);
  @$pb.TagNumber(4)
  Date ensureStartDate() => $_ensure(3);

  @$pb.TagNumber(5)
  Date get endDate => $_getN(4);
  @$pb.TagNumber(5)
  set endDate(Date v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEndDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEndDate() => clearField(5);
  @$pb.TagNumber(5)
  Date ensureEndDate() => $_ensure(4);
}

class Edition extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Edition', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publicationId', protoName: 'publicationId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'seasonId', protoName: 'seasonId')
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceNumber', $pb.PbFieldType.OU3, protoName: 'sequenceNumber')
    ..aOM<Date>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'publishedDate', protoName: 'publishedDate', subBuilder: Date.create)
    ..aOM<Image>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'coverImage', protoName: 'coverImage', subBuilder: Image.create)
    ..hasRequiredFields = false
  ;

  Edition._() : super();
  factory Edition({
    $core.String? id,
    $core.String? publicationId,
    $core.String? title,
    $core.String? seasonId,
    $core.int? sequenceNumber,
    Date? publishedDate,
    Image? coverImage,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (publicationId != null) {
      _result.publicationId = publicationId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (seasonId != null) {
      _result.seasonId = seasonId;
    }
    if (sequenceNumber != null) {
      _result.sequenceNumber = sequenceNumber;
    }
    if (publishedDate != null) {
      _result.publishedDate = publishedDate;
    }
    if (coverImage != null) {
      _result.coverImage = coverImage;
    }
    return _result;
  }
  factory Edition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Edition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Edition clone() => Edition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Edition copyWith(void Function(Edition) updates) => super.copyWith((message) => updates(message as Edition)) as Edition; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Edition create() => Edition._();
  Edition createEmptyInstance() => create();
  static $pb.PbList<Edition> createRepeated() => $pb.PbList<Edition>();
  @$core.pragma('dart2js:noInline')
  static Edition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Edition>(create);
  static Edition? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get publicationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set publicationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasPublicationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearPublicationId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get seasonId => $_getSZ(3);
  @$pb.TagNumber(4)
  set seasonId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasSeasonId() => $_has(3);
  @$pb.TagNumber(4)
  void clearSeasonId() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get sequenceNumber => $_getIZ(4);
  @$pb.TagNumber(5)
  set sequenceNumber($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSequenceNumber() => $_has(4);
  @$pb.TagNumber(5)
  void clearSequenceNumber() => clearField(5);

  @$pb.TagNumber(6)
  Date get publishedDate => $_getN(5);
  @$pb.TagNumber(6)
  set publishedDate(Date v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasPublishedDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearPublishedDate() => clearField(6);
  @$pb.TagNumber(6)
  Date ensurePublishedDate() => $_ensure(5);

  @$pb.TagNumber(7)
  Image get coverImage => $_getN(6);
  @$pb.TagNumber(7)
  set coverImage(Image v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasCoverImage() => $_has(6);
  @$pb.TagNumber(7)
  void clearCoverImage() => clearField(7);
  @$pb.TagNumber(7)
  Image ensureCoverImage() => $_ensure(6);
}

enum Section_BannerBackground {
  bannerImage, 
  bannerColor, 
  notSet
}

class Section extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Section_BannerBackground> _Section_BannerBackgroundByTag = {
    5 : Section_BannerBackground.bannerImage,
    6 : Section_BannerBackground.bannerColor,
    0 : Section_BannerBackground.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Section', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..oo(0, [5, 6])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'editionId', protoName: 'editionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'displayTitleInBanner', protoName: 'displayTitleInBanner')
    ..aOM<Image>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bannerImage', protoName: 'bannerImage', subBuilder: Image.create)
    ..aOM<Color>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bannerColor', protoName: 'bannerColor', subBuilder: Color.create)
    ..aOM<TextStyle>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'headingStyle', protoName: 'headingStyle', subBuilder: TextStyle.create)
    ..a<$core.int>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceNumber', $pb.PbFieldType.OU3, protoName: 'sequenceNumber')
    ..hasRequiredFields = false
  ;

  Section._() : super();
  factory Section({
    $core.String? id,
    $core.String? editionId,
    $core.String? title,
    $core.bool? displayTitleInBanner,
    Image? bannerImage,
    Color? bannerColor,
    TextStyle? headingStyle,
    $core.int? sequenceNumber,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (editionId != null) {
      _result.editionId = editionId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (displayTitleInBanner != null) {
      _result.displayTitleInBanner = displayTitleInBanner;
    }
    if (bannerImage != null) {
      _result.bannerImage = bannerImage;
    }
    if (bannerColor != null) {
      _result.bannerColor = bannerColor;
    }
    if (headingStyle != null) {
      _result.headingStyle = headingStyle;
    }
    if (sequenceNumber != null) {
      _result.sequenceNumber = sequenceNumber;
    }
    return _result;
  }
  factory Section.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Section.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Section clone() => Section()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Section copyWith(void Function(Section) updates) => super.copyWith((message) => updates(message as Section)) as Section; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Section create() => Section._();
  Section createEmptyInstance() => create();
  static $pb.PbList<Section> createRepeated() => $pb.PbList<Section>();
  @$core.pragma('dart2js:noInline')
  static Section getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Section>(create);
  static Section? _defaultInstance;

  Section_BannerBackground whichBannerBackground() => _Section_BannerBackgroundByTag[$_whichOneof(0)]!;
  void clearBannerBackground() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get editionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set editionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEditionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearEditionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get displayTitleInBanner => $_getBF(3);
  @$pb.TagNumber(4)
  set displayTitleInBanner($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasDisplayTitleInBanner() => $_has(3);
  @$pb.TagNumber(4)
  void clearDisplayTitleInBanner() => clearField(4);

  @$pb.TagNumber(5)
  Image get bannerImage => $_getN(4);
  @$pb.TagNumber(5)
  set bannerImage(Image v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasBannerImage() => $_has(4);
  @$pb.TagNumber(5)
  void clearBannerImage() => clearField(5);
  @$pb.TagNumber(5)
  Image ensureBannerImage() => $_ensure(4);

  @$pb.TagNumber(6)
  Color get bannerColor => $_getN(5);
  @$pb.TagNumber(6)
  set bannerColor(Color v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasBannerColor() => $_has(5);
  @$pb.TagNumber(6)
  void clearBannerColor() => clearField(6);
  @$pb.TagNumber(6)
  Color ensureBannerColor() => $_ensure(5);

  @$pb.TagNumber(7)
  TextStyle get headingStyle => $_getN(6);
  @$pb.TagNumber(7)
  set headingStyle(TextStyle v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasHeadingStyle() => $_has(6);
  @$pb.TagNumber(7)
  void clearHeadingStyle() => clearField(7);
  @$pb.TagNumber(7)
  TextStyle ensureHeadingStyle() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.int get sequenceNumber => $_getIZ(7);
  @$pb.TagNumber(8)
  set sequenceNumber($core.int v) { $_setUnsignedInt32(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasSequenceNumber() => $_has(7);
  @$pb.TagNumber(8)
  void clearSequenceNumber() => clearField(8);
}

class Article extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Article', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sectionId', protoName: 'sectionId')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..pc<Contact>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'authors', $pb.PbFieldType.PM, subBuilder: Contact.create)
    ..pc<Node>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contents', $pb.PbFieldType.PM, subBuilder: Node.create)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sequenceNumber', $pb.PbFieldType.OU3, protoName: 'sequenceNumber')
    ..aOM<Image>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'image', subBuilder: Image.create)
    ..hasRequiredFields = false
  ;

  Article._() : super();
  factory Article({
    $core.String? id,
    $core.String? sectionId,
    $core.String? title,
    $core.Iterable<Contact>? authors,
    $core.Iterable<Node>? contents,
    $core.int? sequenceNumber,
    Image? image,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (sectionId != null) {
      _result.sectionId = sectionId;
    }
    if (title != null) {
      _result.title = title;
    }
    if (authors != null) {
      _result.authors.addAll(authors);
    }
    if (contents != null) {
      _result.contents.addAll(contents);
    }
    if (sequenceNumber != null) {
      _result.sequenceNumber = sequenceNumber;
    }
    if (image != null) {
      _result.image = image;
    }
    return _result;
  }
  factory Article.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Article.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Article clone() => Article()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Article copyWith(void Function(Article) updates) => super.copyWith((message) => updates(message as Article)) as Article; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Article create() => Article._();
  Article createEmptyInstance() => create();
  static $pb.PbList<Article> createRepeated() => $pb.PbList<Article>();
  @$core.pragma('dart2js:noInline')
  static Article getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Article>(create);
  static Article? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get sectionId => $_getSZ(1);
  @$pb.TagNumber(2)
  set sectionId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSectionId() => $_has(1);
  @$pb.TagNumber(2)
  void clearSectionId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<Contact> get authors => $_getList(3);

  @$pb.TagNumber(5)
  $core.List<Node> get contents => $_getList(4);

  @$pb.TagNumber(6)
  $core.int get sequenceNumber => $_getIZ(5);
  @$pb.TagNumber(6)
  set sequenceNumber($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSequenceNumber() => $_has(5);
  @$pb.TagNumber(6)
  void clearSequenceNumber() => clearField(6);

  @$pb.TagNumber(7)
  Image get image => $_getN(6);
  @$pb.TagNumber(7)
  set image(Image v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasImage() => $_has(6);
  @$pb.TagNumber(7)
  void clearImage() => clearField(7);
  @$pb.TagNumber(7)
  Image ensureImage() => $_ensure(6);
}

class StructuredRichText extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'StructuredRichText', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  StructuredRichText._() : super();
  factory StructuredRichText() => create();
  factory StructuredRichText.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory StructuredRichText.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  StructuredRichText clone() => StructuredRichText()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  StructuredRichText copyWith(void Function(StructuredRichText) updates) => super.copyWith((message) => updates(message as StructuredRichText)) as StructuredRichText; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static StructuredRichText create() => StructuredRichText._();
  StructuredRichText createEmptyInstance() => create();
  static $pb.PbList<StructuredRichText> createRepeated() => $pb.PbList<StructuredRichText>();
  @$core.pragma('dart2js:noInline')
  static StructuredRichText getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<StructuredRichText>(create);
  static StructuredRichText? _defaultInstance;
}

enum RichTextNode_Renderer {
  markdown, 
  richText, 
  notSet
}

class RichTextNode extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, RichTextNode_Renderer> _RichTextNode_RendererByTag = {
    1 : RichTextNode_Renderer.markdown,
    2 : RichTextNode_Renderer.richText,
    0 : RichTextNode_Renderer.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RichTextNode', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'markdown')
    ..aOM<StructuredRichText>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'richText', protoName: 'richText', subBuilder: StructuredRichText.create)
    ..hasRequiredFields = false
  ;

  RichTextNode._() : super();
  factory RichTextNode({
    $core.String? markdown,
    StructuredRichText? richText,
  }) {
    final _result = create();
    if (markdown != null) {
      _result.markdown = markdown;
    }
    if (richText != null) {
      _result.richText = richText;
    }
    return _result;
  }
  factory RichTextNode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RichTextNode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RichTextNode clone() => RichTextNode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RichTextNode copyWith(void Function(RichTextNode) updates) => super.copyWith((message) => updates(message as RichTextNode)) as RichTextNode; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RichTextNode create() => RichTextNode._();
  RichTextNode createEmptyInstance() => create();
  static $pb.PbList<RichTextNode> createRepeated() => $pb.PbList<RichTextNode>();
  @$core.pragma('dart2js:noInline')
  static RichTextNode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RichTextNode>(create);
  static RichTextNode? _defaultInstance;

  RichTextNode_Renderer whichRenderer() => _RichTextNode_RendererByTag[$_whichOneof(0)]!;
  void clearRenderer() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get markdown => $_getSZ(0);
  @$pb.TagNumber(1)
  set markdown($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMarkdown() => $_has(0);
  @$pb.TagNumber(1)
  void clearMarkdown() => clearField(1);

  @$pb.TagNumber(2)
  StructuredRichText get richText => $_getN(1);
  @$pb.TagNumber(2)
  set richText(StructuredRichText v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasRichText() => $_has(1);
  @$pb.TagNumber(2)
  void clearRichText() => clearField(2);
  @$pb.TagNumber(2)
  StructuredRichText ensureRichText() => $_ensure(1);
}

class ImageNode extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ImageNode', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..aOM<Image>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value', subBuilder: Image.create)
    ..hasRequiredFields = false
  ;

  ImageNode._() : super();
  factory ImageNode({
    Image? value,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    return _result;
  }
  factory ImageNode.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ImageNode.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ImageNode clone() => ImageNode()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ImageNode copyWith(void Function(ImageNode) updates) => super.copyWith((message) => updates(message as ImageNode)) as ImageNode; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ImageNode create() => ImageNode._();
  ImageNode createEmptyInstance() => create();
  static $pb.PbList<ImageNode> createRepeated() => $pb.PbList<ImageNode>();
  @$core.pragma('dart2js:noInline')
  static ImageNode getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImageNode>(create);
  static ImageNode? _defaultInstance;

  @$pb.TagNumber(1)
  Image get value => $_getN(0);
  @$pb.TagNumber(1)
  set value(Image v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);
  @$pb.TagNumber(1)
  Image ensureValue() => $_ensure(0);
}

enum Node_NodeContent {
  text, 
  image, 
  notSet
}

class Node extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Node_NodeContent> _Node_NodeContentByTag = {
    1 : Node_NodeContent.text,
    2 : Node_NodeContent.image,
    0 : Node_NodeContent.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Node', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'mymgs'), createEmptyInstance: create)
    ..oo(0, [1, 2])
    ..aOM<RichTextNode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text', subBuilder: RichTextNode.create)
    ..aOM<ImageNode>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'image', subBuilder: ImageNode.create)
    ..hasRequiredFields = false
  ;

  Node._() : super();
  factory Node({
    RichTextNode? text,
    ImageNode? image,
  }) {
    final _result = create();
    if (text != null) {
      _result.text = text;
    }
    if (image != null) {
      _result.image = image;
    }
    return _result;
  }
  factory Node.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Node.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Node clone() => Node()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Node copyWith(void Function(Node) updates) => super.copyWith((message) => updates(message as Node)) as Node; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Node create() => Node._();
  Node createEmptyInstance() => create();
  static $pb.PbList<Node> createRepeated() => $pb.PbList<Node>();
  @$core.pragma('dart2js:noInline')
  static Node getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Node>(create);
  static Node? _defaultInstance;

  Node_NodeContent whichNodeContent() => _Node_NodeContentByTag[$_whichOneof(0)]!;
  void clearNodeContent() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  RichTextNode get text => $_getN(0);
  @$pb.TagNumber(1)
  set text(RichTextNode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);
  @$pb.TagNumber(1)
  RichTextNode ensureText() => $_ensure(0);

  @$pb.TagNumber(2)
  ImageNode get image => $_getN(1);
  @$pb.TagNumber(2)
  set image(ImageNode v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasImage() => $_has(1);
  @$pb.TagNumber(2)
  void clearImage() => clearField(2);
  @$pb.TagNumber(2)
  ImageNode ensureImage() => $_ensure(1);
}

