// This is a generated file - do not edit.
//
// Generated from library/v1/library.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use retryRequestDescriptor instead')
const RetryRequest$json = {
  '1': 'RetryRequest',
  '2': [
    {
      '1': 'link',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.library.v1.Link',
      '10': 'link'
    },
  ],
};

/// Descriptor for `RetryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List retryRequestDescriptor = $convert.base64Decode(
    'CgxSZXRyeVJlcXVlc3QSJAoEbGluaxgBIAEoCzIQLmxpYnJhcnkudjEuTGlua1IEbGluaw==');

@$core.Deprecated('Use retryResponseDescriptor instead')
const RetryResponse$json = {
  '1': 'RetryResponse',
};

/// Descriptor for `RetryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List retryResponseDescriptor =
    $convert.base64Decode('Cg1SZXRyeVJlc3BvbnNl');

@$core.Deprecated('Use listRequestDescriptor instead')
const ListRequest$json = {
  '1': 'ListRequest',
};

/// Descriptor for `ListRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listRequestDescriptor =
    $convert.base64Decode('CgtMaXN0UmVxdWVzdA==');

@$core.Deprecated('Use listResponseDescriptor instead')
const ListResponse$json = {
  '1': 'ListResponse',
  '2': [
    {
      '1': 'links',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.library.v1.Link',
      '10': 'links'
    },
  ],
};

/// Descriptor for `ListResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listResponseDescriptor = $convert.base64Decode(
    'CgxMaXN0UmVzcG9uc2USJgoFbGlua3MYASADKAsyEC5saWJyYXJ5LnYxLkxpbmtSBWxpbmtz');

@$core.Deprecated('Use linkDescriptor instead')
const Link$json = {
  '1': 'Link',
  '2': [
    {'1': 'id', '3': 6, '4': 1, '5': 3, '10': 'id'},
    {'1': 'Title', '3': 1, '4': 1, '5': 9, '10': 'Title'},
    {'1': 'Url', '3': 2, '4': 1, '5': 9, '10': 'Url'},
    {'1': 'DownloadPath', '3': 3, '4': 1, '5': 9, '10': 'DownloadPath'},
    {'1': 'Status', '3': 4, '4': 1, '5': 9, '10': 'Status'},
    {'1': 'Err', '3': 5, '4': 1, '5': 9, '10': 'Err'},
  ],
};

/// Descriptor for `Link`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List linkDescriptor = $convert.base64Decode(
    'CgRMaW5rEg4KAmlkGAYgASgDUgJpZBIUCgVUaXRsZRgBIAEoCVIFVGl0bGUSEAoDVXJsGAIgAS'
    'gJUgNVcmwSIgoMRG93bmxvYWRQYXRoGAMgASgJUgxEb3dubG9hZFBhdGgSFgoGU3RhdHVzGAQg'
    'ASgJUgZTdGF0dXMSEAoDRXJyGAUgASgJUgNFcnI=');

@$core.Deprecated('Use addRequestDescriptor instead')
const AddRequest$json = {
  '1': 'AddRequest',
  '2': [
    {'1': 'link', '3': 1, '4': 3, '5': 9, '10': 'link'},
  ],
};

/// Descriptor for `AddRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addRequestDescriptor =
    $convert.base64Decode('CgpBZGRSZXF1ZXN0EhIKBGxpbmsYASADKAlSBGxpbms=');

@$core.Deprecated('Use addResponseDescriptor instead')
const AddResponse$json = {
  '1': 'AddResponse',
};

/// Descriptor for `AddResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addResponseDescriptor =
    $convert.base64Decode('CgtBZGRSZXNwb25zZQ==');

const $core.Map<$core.String, $core.dynamic> LibraryServiceBase$json = {
  '1': 'LibraryService',
  '2': [
    {
      '1': 'Add',
      '2': '.library.v1.AddRequest',
      '3': '.library.v1.AddResponse',
      '4': {}
    },
    {
      '1': 'List',
      '2': '.library.v1.ListRequest',
      '3': '.library.v1.ListResponse',
      '4': {}
    },
    {
      '1': 'Retry',
      '2': '.library.v1.RetryRequest',
      '3': '.library.v1.RetryResponse',
      '4': {}
    },
  ],
};

@$core.Deprecated('Use libraryServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    LibraryServiceBase$messageJson = {
  '.library.v1.AddRequest': AddRequest$json,
  '.library.v1.AddResponse': AddResponse$json,
  '.library.v1.ListRequest': ListRequest$json,
  '.library.v1.ListResponse': ListResponse$json,
  '.library.v1.Link': Link$json,
  '.library.v1.RetryRequest': RetryRequest$json,
  '.library.v1.RetryResponse': RetryResponse$json,
};

/// Descriptor for `LibraryService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List libraryServiceDescriptor = $convert.base64Decode(
    'Cg5MaWJyYXJ5U2VydmljZRI4CgNBZGQSFi5saWJyYXJ5LnYxLkFkZFJlcXVlc3QaFy5saWJyYX'
    'J5LnYxLkFkZFJlc3BvbnNlIgASOwoETGlzdBIXLmxpYnJhcnkudjEuTGlzdFJlcXVlc3QaGC5s'
    'aWJyYXJ5LnYxLkxpc3RSZXNwb25zZSIAEj4KBVJldHJ5EhgubGlicmFyeS52MS5SZXRyeVJlcX'
    'Vlc3QaGS5saWJyYXJ5LnYxLlJldHJ5UmVzcG9uc2UiAA==');
