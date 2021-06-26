///
//  Generated code. Do not modify.
//  source: magazines.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class TextStyle_FontWeight extends $pb.ProtobufEnum {
  static const TextStyle_FontWeight NA = TextStyle_FontWeight._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NA');
  static const TextStyle_FontWeight LIGHT = TextStyle_FontWeight._(200, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LIGHT');
  static const TextStyle_FontWeight NORMAL = TextStyle_FontWeight._(400, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'NORMAL');
  static const TextStyle_FontWeight BOLD = TextStyle_FontWeight._(600, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BOLD');

  static const $core.List<TextStyle_FontWeight> values = <TextStyle_FontWeight> [
    NA,
    LIGHT,
    NORMAL,
    BOLD,
  ];

  static final $core.Map<$core.int, TextStyle_FontWeight> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TextStyle_FontWeight? valueOf($core.int value) => _byValue[value];

  const TextStyle_FontWeight._($core.int v, $core.String n) : super(v, n);
}

class PublicationFrequency_PublicationFrequencyType extends $pb.ProtobufEnum {
  static const PublicationFrequency_PublicationFrequencyType DAY = PublicationFrequency_PublicationFrequencyType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DAY');
  static const PublicationFrequency_PublicationFrequencyType WEEK = PublicationFrequency_PublicationFrequencyType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'WEEK');
  static const PublicationFrequency_PublicationFrequencyType MONTH = PublicationFrequency_PublicationFrequencyType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MONTH');
  static const PublicationFrequency_PublicationFrequencyType YEAR = PublicationFrequency_PublicationFrequencyType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'YEAR');
  static const PublicationFrequency_PublicationFrequencyType TERM = PublicationFrequency_PublicationFrequencyType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TERM');
  static const PublicationFrequency_PublicationFrequencyType HALF_TERM = PublicationFrequency_PublicationFrequencyType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'HALF_TERM');

  static const $core.List<PublicationFrequency_PublicationFrequencyType> values = <PublicationFrequency_PublicationFrequencyType> [
    DAY,
    WEEK,
    MONTH,
    YEAR,
    TERM,
    HALF_TERM,
  ];

  static final $core.Map<$core.int, PublicationFrequency_PublicationFrequencyType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static PublicationFrequency_PublicationFrequencyType? valueOf($core.int value) => _byValue[value];

  const PublicationFrequency_PublicationFrequencyType._($core.int v, $core.String n) : super(v, n);
}

