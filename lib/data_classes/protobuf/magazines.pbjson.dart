///
//  Generated code. Do not modify.
//  source: magazines.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use colorDescriptor instead')
const Color$json = const {
  '1': 'Color',
  '2': const [
    const {'1': 'red', '3': 1, '4': 1, '5': 13, '10': 'red'},
    const {'1': 'green', '3': 2, '4': 1, '5': 13, '10': 'green'},
    const {'1': 'blue', '3': 3, '4': 1, '5': 13, '10': 'blue'},
  ],
};

/// Descriptor for `Color`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List colorDescriptor = $convert.base64Decode('CgVDb2xvchIQCgNyZWQYASABKA1SA3JlZBIUCgVncmVlbhgCIAEoDVIFZ3JlZW4SEgoEYmx1ZRgDIAEoDVIEYmx1ZQ==');
@$core.Deprecated('Use textStyleDescriptor instead')
const TextStyle$json = const {
  '1': 'TextStyle',
  '2': const [
    const {'1': 'color', '3': 1, '4': 1, '5': 11, '6': '.mymgs.Color', '10': 'color'},
    const {'1': 'font', '3': 2, '4': 1, '5': 9, '10': 'font'},
    const {'1': 'weight', '3': 3, '4': 1, '5': 14, '6': '.mymgs.TextStyle.FontWeight', '10': 'weight'},
  ],
  '4': const [TextStyle_FontWeight$json],
};

@$core.Deprecated('Use textStyleDescriptor instead')
const TextStyle_FontWeight$json = const {
  '1': 'FontWeight',
  '2': const [
    const {'1': 'NA', '2': 0},
    const {'1': 'LIGHT', '2': 200},
    const {'1': 'NORMAL', '2': 400},
    const {'1': 'BOLD', '2': 600},
  ],
};

/// Descriptor for `TextStyle`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textStyleDescriptor = $convert.base64Decode('CglUZXh0U3R5bGUSIgoFY29sb3IYASABKAsyDC5teW1ncy5Db2xvclIFY29sb3ISEgoEZm9udBgCIAEoCVIEZm9udBIzCgZ3ZWlnaHQYAyABKA4yGy5teW1ncy5UZXh0U3R5bGUuRm9udFdlaWdodFIGd2VpZ2h0IjgKCkZvbnRXZWlnaHQSBgoCTkEQABIKCgVMSUdIVBDIARILCgZOT1JNQUwQkAMSCQoEQk9MRBDYBA==');
@$core.Deprecated('Use dimensionalValueDescriptor instead')
const DimensionalValue$json = const {
  '1': 'DimensionalValue',
  '2': const [
    const {'1': 'top', '3': 1, '4': 1, '5': 13, '10': 'top'},
    const {'1': 'bottom', '3': 2, '4': 1, '5': 13, '10': 'bottom'},
    const {'1': 'left', '3': 3, '4': 1, '5': 13, '10': 'left'},
    const {'1': 'right', '3': 4, '4': 1, '5': 13, '10': 'right'},
  ],
};

/// Descriptor for `DimensionalValue`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dimensionalValueDescriptor = $convert.base64Decode('ChBEaW1lbnNpb25hbFZhbHVlEhAKA3RvcBgBIAEoDVIDdG9wEhYKBmJvdHRvbRgCIAEoDVIGYm90dG9tEhIKBGxlZnQYAyABKA1SBGxlZnQSFAoFcmlnaHQYBCABKA1SBXJpZ2h0');
@$core.Deprecated('Use imageDescriptor instead')
const Image$json = const {
  '1': 'Image',
  '2': const [
    const {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    const {'1': 'alt', '3': 2, '4': 1, '5': 9, '10': 'alt'},
    const {'1': 'source', '3': 3, '4': 1, '5': 9, '9': 0, '10': 'source', '17': true},
  ],
  '8': const [
    const {'1': '_source'},
  ],
};

/// Descriptor for `Image`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageDescriptor = $convert.base64Decode('CgVJbWFnZRIQCgN1cmwYASABKAlSA3VybBIQCgNhbHQYAiABKAlSA2FsdBIbCgZzb3VyY2UYAyABKAlIAFIGc291cmNliAEBQgkKB19zb3VyY2U=');
@$core.Deprecated('Use dateDescriptor instead')
const Date$json = const {
  '1': 'Date',
  '2': const [
    const {'1': 'date', '3': 1, '4': 1, '5': 13, '10': 'date'},
    const {'1': 'month', '3': 2, '4': 1, '5': 13, '10': 'month'},
    const {'1': 'year', '3': 3, '4': 1, '5': 13, '10': 'year'},
  ],
};

/// Descriptor for `Date`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dateDescriptor = $convert.base64Decode('CgREYXRlEhIKBGRhdGUYASABKA1SBGRhdGUSFAoFbW9udGgYAiABKA1SBW1vbnRoEhIKBHllYXIYAyABKA1SBHllYXI=');
@$core.Deprecated('Use contactDescriptor instead')
const Contact$json = const {
  '1': 'Contact',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'email', '3': 2, '4': 1, '5': 9, '10': 'email'},
  ],
};

/// Descriptor for `Contact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactDescriptor = $convert.base64Decode('CgdDb250YWN0EhIKBG5hbWUYASABKAlSBG5hbWUSFAoFZW1haWwYAiABKAlSBWVtYWls');
@$core.Deprecated('Use publicationThemeDescriptor instead')
const PublicationTheme$json = const {
  '1': 'PublicationTheme',
  '2': const [
    const {'1': 'primaryColor', '3': 1, '4': 1, '5': 11, '6': '.mymgs.Color', '10': 'primaryColor'},
    const {'1': 'accentColor', '3': 2, '4': 1, '5': 11, '6': '.mymgs.Color', '10': 'accentColor'},
    const {'1': 'logo', '3': 3, '4': 1, '5': 11, '6': '.mymgs.Image', '9': 0, '10': 'logo', '17': true},
    const {'1': 'paragraphStyle', '3': 4, '4': 1, '5': 11, '6': '.mymgs.TextStyle', '10': 'paragraphStyle'},
    const {'1': 'headingStyle', '3': 5, '4': 1, '5': 11, '6': '.mymgs.TextStyle', '10': 'headingStyle'},
    const {'1': 'titleStyle', '3': 6, '4': 1, '5': 11, '6': '.mymgs.TextStyle', '10': 'titleStyle'},
    const {'1': 'subheadingStyle', '3': 7, '4': 1, '5': 11, '6': '.mymgs.TextStyle', '10': 'subheadingStyle'},
    const {'1': 'contentProtection', '3': 8, '4': 1, '5': 8, '10': 'contentProtection'},
  ],
  '8': const [
    const {'1': '_logo'},
  ],
};

/// Descriptor for `PublicationTheme`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicationThemeDescriptor = $convert.base64Decode('ChBQdWJsaWNhdGlvblRoZW1lEjAKDHByaW1hcnlDb2xvchgBIAEoCzIMLm15bWdzLkNvbG9yUgxwcmltYXJ5Q29sb3ISLgoLYWNjZW50Q29sb3IYAiABKAsyDC5teW1ncy5Db2xvclILYWNjZW50Q29sb3ISJQoEbG9nbxgDIAEoCzIMLm15bWdzLkltYWdlSABSBGxvZ2+IAQESOAoOcGFyYWdyYXBoU3R5bGUYBCABKAsyEC5teW1ncy5UZXh0U3R5bGVSDnBhcmFncmFwaFN0eWxlEjQKDGhlYWRpbmdTdHlsZRgFIAEoCzIQLm15bWdzLlRleHRTdHlsZVIMaGVhZGluZ1N0eWxlEjAKCnRpdGxlU3R5bGUYBiABKAsyEC5teW1ncy5UZXh0U3R5bGVSCnRpdGxlU3R5bGUSOgoPc3ViaGVhZGluZ1N0eWxlGAcgASgLMhAubXltZ3MuVGV4dFN0eWxlUg9zdWJoZWFkaW5nU3R5bGUSLAoRY29udGVudFByb3RlY3Rpb24YCCABKAhSEWNvbnRlbnRQcm90ZWN0aW9uQgcKBV9sb2dv');
@$core.Deprecated('Use publicationFrequencyDescriptor instead')
const PublicationFrequency$json = const {
  '1': 'PublicationFrequency',
  '2': const [
    const {'1': 'n', '3': 1, '4': 1, '5': 13, '10': 'n'},
    const {'1': 'every', '3': 2, '4': 1, '5': 14, '6': '.mymgs.PublicationFrequency.PublicationFrequencyType', '10': 'every'},
  ],
  '4': const [PublicationFrequency_PublicationFrequencyType$json],
};

@$core.Deprecated('Use publicationFrequencyDescriptor instead')
const PublicationFrequency_PublicationFrequencyType$json = const {
  '1': 'PublicationFrequencyType',
  '2': const [
    const {'1': 'DAY', '2': 0},
    const {'1': 'WEEK', '2': 1},
    const {'1': 'MONTH', '2': 2},
    const {'1': 'YEAR', '2': 3},
    const {'1': 'TERM', '2': 4},
    const {'1': 'HALF_TERM', '2': 5},
  ],
};

/// Descriptor for `PublicationFrequency`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicationFrequencyDescriptor = $convert.base64Decode('ChRQdWJsaWNhdGlvbkZyZXF1ZW5jeRIMCgFuGAEgASgNUgFuEkoKBWV2ZXJ5GAIgASgOMjQubXltZ3MuUHVibGljYXRpb25GcmVxdWVuY3kuUHVibGljYXRpb25GcmVxdWVuY3lUeXBlUgVldmVyeSJbChhQdWJsaWNhdGlvbkZyZXF1ZW5jeVR5cGUSBwoDREFZEAASCAoEV0VFSxABEgkKBU1PTlRIEAISCAoEWUVBUhADEggKBFRFUk0QBBINCglIQUxGX1RFUk0QBQ==');
@$core.Deprecated('Use publicationDescriptor instead')
const Publication$json = const {
  '1': 'Publication',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'theme', '3': 3, '4': 1, '5': 11, '6': '.mymgs.PublicationTheme', '10': 'theme'},
    const {'1': 'caption', '3': 4, '4': 1, '5': 9, '10': 'caption'},
    const {'1': 'description', '3': 5, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'frequency', '3': 6, '4': 1, '5': 11, '6': '.mymgs.PublicationFrequency', '10': 'frequency'},
  ],
};

/// Descriptor for `Publication`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List publicationDescriptor = $convert.base64Decode('CgtQdWJsaWNhdGlvbhIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdGxlEi0KBXRoZW1lGAMgASgLMhcubXltZ3MuUHVibGljYXRpb25UaGVtZVIFdGhlbWUSGAoHY2FwdGlvbhgEIAEoCVIHY2FwdGlvbhIgCgtkZXNjcmlwdGlvbhgFIAEoCVILZGVzY3JpcHRpb24SOQoJZnJlcXVlbmN5GAYgASgLMhsubXltZ3MuUHVibGljYXRpb25GcmVxdWVuY3lSCWZyZXF1ZW5jeQ==');
@$core.Deprecated('Use seasonDescriptor instead')
const Season$json = const {
  '1': 'Season',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'publicationId', '3': 2, '4': 1, '5': 9, '10': 'publicationId'},
    const {'1': 'sequenceNumber', '3': 3, '4': 1, '5': 13, '10': 'sequenceNumber'},
    const {'1': 'startDate', '3': 4, '4': 1, '5': 11, '6': '.mymgs.Date', '10': 'startDate'},
    const {'1': 'endDate', '3': 5, '4': 1, '5': 11, '6': '.mymgs.Date', '10': 'endDate'},
  ],
};

/// Descriptor for `Season`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List seasonDescriptor = $convert.base64Decode('CgZTZWFzb24SDgoCaWQYASABKAlSAmlkEiQKDXB1YmxpY2F0aW9uSWQYAiABKAlSDXB1YmxpY2F0aW9uSWQSJgoOc2VxdWVuY2VOdW1iZXIYAyABKA1SDnNlcXVlbmNlTnVtYmVyEikKCXN0YXJ0RGF0ZRgEIAEoCzILLm15bWdzLkRhdGVSCXN0YXJ0RGF0ZRIlCgdlbmREYXRlGAUgASgLMgsubXltZ3MuRGF0ZVIHZW5kRGF0ZQ==');
@$core.Deprecated('Use editionDescriptor instead')
const Edition$json = const {
  '1': 'Edition',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'publicationId', '3': 2, '4': 1, '5': 9, '10': 'publicationId'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'seasonId', '3': 4, '4': 1, '5': 9, '10': 'seasonId'},
    const {'1': 'sequenceNumber', '3': 5, '4': 1, '5': 13, '10': 'sequenceNumber'},
    const {'1': 'publishedDate', '3': 6, '4': 1, '5': 11, '6': '.mymgs.Date', '10': 'publishedDate'},
    const {'1': 'coverImage', '3': 7, '4': 1, '5': 11, '6': '.mymgs.Image', '10': 'coverImage'},
  ],
};

/// Descriptor for `Edition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editionDescriptor = $convert.base64Decode('CgdFZGl0aW9uEg4KAmlkGAEgASgJUgJpZBIkCg1wdWJsaWNhdGlvbklkGAIgASgJUg1wdWJsaWNhdGlvbklkEhQKBXRpdGxlGAMgASgJUgV0aXRsZRIaCghzZWFzb25JZBgEIAEoCVIIc2Vhc29uSWQSJgoOc2VxdWVuY2VOdW1iZXIYBSABKA1SDnNlcXVlbmNlTnVtYmVyEjEKDXB1Ymxpc2hlZERhdGUYBiABKAsyCy5teW1ncy5EYXRlUg1wdWJsaXNoZWREYXRlEiwKCmNvdmVySW1hZ2UYByABKAsyDC5teW1ncy5JbWFnZVIKY292ZXJJbWFnZQ==');
@$core.Deprecated('Use sectionDescriptor instead')
const Section$json = const {
  '1': 'Section',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'editionId', '3': 2, '4': 1, '5': 9, '10': 'editionId'},
    const {'1': 'sequenceNumber', '3': 8, '4': 1, '5': 13, '10': 'sequenceNumber'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'displayTitleInBanner', '3': 4, '4': 1, '5': 8, '10': 'displayTitleInBanner'},
    const {'1': 'bannerImage', '3': 5, '4': 1, '5': 11, '6': '.mymgs.Image', '9': 0, '10': 'bannerImage'},
    const {'1': 'bannerColor', '3': 6, '4': 1, '5': 11, '6': '.mymgs.Color', '9': 0, '10': 'bannerColor'},
    const {'1': 'headingStyle', '3': 7, '4': 1, '5': 11, '6': '.mymgs.TextStyle', '9': 1, '10': 'headingStyle', '17': true},
  ],
  '8': const [
    const {'1': 'banner_background'},
    const {'1': '_headingStyle'},
  ],
};

/// Descriptor for `Section`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sectionDescriptor = $convert.base64Decode('CgdTZWN0aW9uEg4KAmlkGAEgASgJUgJpZBIcCgllZGl0aW9uSWQYAiABKAlSCWVkaXRpb25JZBImCg5zZXF1ZW5jZU51bWJlchgIIAEoDVIOc2VxdWVuY2VOdW1iZXISFAoFdGl0bGUYAyABKAlSBXRpdGxlEjIKFGRpc3BsYXlUaXRsZUluQmFubmVyGAQgASgIUhRkaXNwbGF5VGl0bGVJbkJhbm5lchIwCgtiYW5uZXJJbWFnZRgFIAEoCzIMLm15bWdzLkltYWdlSABSC2Jhbm5lckltYWdlEjAKC2Jhbm5lckNvbG9yGAYgASgLMgwubXltZ3MuQ29sb3JIAFILYmFubmVyQ29sb3ISOQoMaGVhZGluZ1N0eWxlGAcgASgLMhAubXltZ3MuVGV4dFN0eWxlSAFSDGhlYWRpbmdTdHlsZYgBAUITChFiYW5uZXJfYmFja2dyb3VuZEIPCg1faGVhZGluZ1N0eWxl');
@$core.Deprecated('Use articleDescriptor instead')
const Article$json = const {
  '1': 'Article',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'sectionId', '3': 2, '4': 1, '5': 9, '10': 'sectionId'},
    const {'1': 'sequenceNumber', '3': 6, '4': 1, '5': 13, '10': 'sequenceNumber'},
    const {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    const {'1': 'authors', '3': 4, '4': 3, '5': 11, '6': '.mymgs.Contact', '10': 'authors'},
    const {'1': 'contents', '3': 5, '4': 3, '5': 11, '6': '.mymgs.Node', '10': 'contents'},
    const {'1': 'image', '3': 7, '4': 1, '5': 11, '6': '.mymgs.Image', '10': 'image'},
  ],
};

/// Descriptor for `Article`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List articleDescriptor = $convert.base64Decode('CgdBcnRpY2xlEg4KAmlkGAEgASgJUgJpZBIcCglzZWN0aW9uSWQYAiABKAlSCXNlY3Rpb25JZBImCg5zZXF1ZW5jZU51bWJlchgGIAEoDVIOc2VxdWVuY2VOdW1iZXISFAoFdGl0bGUYAyABKAlSBXRpdGxlEigKB2F1dGhvcnMYBCADKAsyDi5teW1ncy5Db250YWN0UgdhdXRob3JzEicKCGNvbnRlbnRzGAUgAygLMgsubXltZ3MuTm9kZVIIY29udGVudHMSIgoFaW1hZ2UYByABKAsyDC5teW1ncy5JbWFnZVIFaW1hZ2U=');
@$core.Deprecated('Use structuredRichTextDescriptor instead')
const StructuredRichText$json = const {
  '1': 'StructuredRichText',
};

/// Descriptor for `StructuredRichText`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List structuredRichTextDescriptor = $convert.base64Decode('ChJTdHJ1Y3R1cmVkUmljaFRleHQ=');
@$core.Deprecated('Use richTextNodeDescriptor instead')
const RichTextNode$json = const {
  '1': 'RichTextNode',
  '2': const [
    const {'1': 'markdown', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'markdown'},
    const {'1': 'richText', '3': 2, '4': 1, '5': 11, '6': '.mymgs.StructuredRichText', '9': 0, '10': 'richText'},
  ],
  '8': const [
    const {'1': 'renderer'},
  ],
};

/// Descriptor for `RichTextNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List richTextNodeDescriptor = $convert.base64Decode('CgxSaWNoVGV4dE5vZGUSHAoIbWFya2Rvd24YASABKAlIAFIIbWFya2Rvd24SNwoIcmljaFRleHQYAiABKAsyGS5teW1ncy5TdHJ1Y3R1cmVkUmljaFRleHRIAFIIcmljaFRleHRCCgoIcmVuZGVyZXI=');
@$core.Deprecated('Use imageNodeDescriptor instead')
const ImageNode$json = const {
  '1': 'ImageNode',
  '2': const [
    const {'1': 'value', '3': 1, '4': 1, '5': 11, '6': '.mymgs.Image', '10': 'value'},
  ],
};

/// Descriptor for `ImageNode`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageNodeDescriptor = $convert.base64Decode('CglJbWFnZU5vZGUSIgoFdmFsdWUYASABKAsyDC5teW1ncy5JbWFnZVIFdmFsdWU=');
@$core.Deprecated('Use nodeDescriptor instead')
const Node$json = const {
  '1': 'Node',
  '2': const [
    const {'1': 'text', '3': 1, '4': 1, '5': 11, '6': '.mymgs.RichTextNode', '9': 0, '10': 'text'},
    const {'1': 'image', '3': 2, '4': 1, '5': 11, '6': '.mymgs.ImageNode', '9': 0, '10': 'image'},
  ],
  '8': const [
    const {'1': 'node_content'},
  ],
};

/// Descriptor for `Node`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List nodeDescriptor = $convert.base64Decode('CgROb2RlEikKBHRleHQYASABKAsyEy5teW1ncy5SaWNoVGV4dE5vZGVIAFIEdGV4dBIoCgVpbWFnZRgCIAEoCzIQLm15bWdzLkltYWdlTm9kZUgAUgVpbWFnZUIOCgxub2RlX2NvbnRlbnQ=');
