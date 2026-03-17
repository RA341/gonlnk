// This is a generated file - do not edit.
//
// Generated from library/v1/library.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'library.pb.dart' as $0;
import 'library.pbjson.dart';

export 'library.pb.dart';

abstract class LibraryServiceBase extends $pb.GeneratedService {
  $async.Future<$0.AddResponse> add(
      $pb.ServerContext ctx, $0.AddRequest request);
  $async.Future<$0.ListResponse> list(
      $pb.ServerContext ctx, $0.ListRequest request);
  $async.Future<$0.RetryResponse> retry(
      $pb.ServerContext ctx, $0.RetryRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'Add':
        return $0.AddRequest();
      case 'List':
        return $0.ListRequest();
      case 'Retry':
        return $0.RetryRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'Add':
        return add(ctx, request as $0.AddRequest);
      case 'List':
        return list(ctx, request as $0.ListRequest);
      case 'Retry':
        return retry(ctx, request as $0.RetryRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => LibraryServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => LibraryServiceBase$messageJson;
}
