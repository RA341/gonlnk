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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class RetryRequest extends $pb.GeneratedMessage {
  factory RetryRequest({
    Link? link,
  }) {
    final result = create();
    if (link != null) result.link = link;
    return result;
  }

  RetryRequest._();

  factory RetryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RetryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RetryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'library.v1'),
      createEmptyInstance: create)
    ..aOM<Link>(1, _omitFieldNames ? '' : 'link', subBuilder: Link.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetryRequest clone() => RetryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetryRequest copyWith(void Function(RetryRequest) updates) =>
      super.copyWith((message) => updates(message as RetryRequest))
          as RetryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetryRequest create() => RetryRequest._();
  @$core.override
  RetryRequest createEmptyInstance() => create();
  static $pb.PbList<RetryRequest> createRepeated() =>
      $pb.PbList<RetryRequest>();
  @$core.pragma('dart2js:noInline')
  static RetryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RetryRequest>(create);
  static RetryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  Link get link => $_getN(0);
  @$pb.TagNumber(1)
  set link(Link value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLink() => $_has(0);
  @$pb.TagNumber(1)
  void clearLink() => $_clearField(1);
  @$pb.TagNumber(1)
  Link ensureLink() => $_ensure(0);
}

class RetryResponse extends $pb.GeneratedMessage {
  factory RetryResponse() => create();

  RetryResponse._();

  factory RetryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RetryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RetryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'library.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetryResponse clone() => RetryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RetryResponse copyWith(void Function(RetryResponse) updates) =>
      super.copyWith((message) => updates(message as RetryResponse))
          as RetryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RetryResponse create() => RetryResponse._();
  @$core.override
  RetryResponse createEmptyInstance() => create();
  static $pb.PbList<RetryResponse> createRepeated() =>
      $pb.PbList<RetryResponse>();
  @$core.pragma('dart2js:noInline')
  static RetryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RetryResponse>(create);
  static RetryResponse? _defaultInstance;
}

class ListRequest extends $pb.GeneratedMessage {
  factory ListRequest() => create();

  ListRequest._();

  factory ListRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'library.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRequest clone() => ListRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListRequest copyWith(void Function(ListRequest) updates) =>
      super.copyWith((message) => updates(message as ListRequest))
          as ListRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListRequest create() => ListRequest._();
  @$core.override
  ListRequest createEmptyInstance() => create();
  static $pb.PbList<ListRequest> createRepeated() => $pb.PbList<ListRequest>();
  @$core.pragma('dart2js:noInline')
  static ListRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListRequest>(create);
  static ListRequest? _defaultInstance;
}

class ListResponse extends $pb.GeneratedMessage {
  factory ListResponse({
    $core.Iterable<Link>? links,
  }) {
    final result = create();
    if (links != null) result.links.addAll(links);
    return result;
  }

  ListResponse._();

  factory ListResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'library.v1'),
      createEmptyInstance: create)
    ..pc<Link>(1, _omitFieldNames ? '' : 'links', $pb.PbFieldType.PM,
        subBuilder: Link.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListResponse clone() => ListResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListResponse copyWith(void Function(ListResponse) updates) =>
      super.copyWith((message) => updates(message as ListResponse))
          as ListResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListResponse create() => ListResponse._();
  @$core.override
  ListResponse createEmptyInstance() => create();
  static $pb.PbList<ListResponse> createRepeated() =>
      $pb.PbList<ListResponse>();
  @$core.pragma('dart2js:noInline')
  static ListResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListResponse>(create);
  static ListResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Link> get links => $_getList(0);
}

class Link extends $pb.GeneratedMessage {
  factory Link({
    $core.String? title,
    $core.String? url,
    $core.String? downloadPath,
    $core.String? status,
    $core.String? err,
    $fixnum.Int64? id,
  }) {
    final result = create();
    if (title != null) result.title = title;
    if (url != null) result.url = url;
    if (downloadPath != null) result.downloadPath = downloadPath;
    if (status != null) result.status = status;
    if (err != null) result.err = err;
    if (id != null) result.id = id;
    return result;
  }

  Link._();

  factory Link.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Link.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Link',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'library.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'Title', protoName: 'Title')
    ..aOS(2, _omitFieldNames ? '' : 'Url', protoName: 'Url')
    ..aOS(3, _omitFieldNames ? '' : 'DownloadPath', protoName: 'DownloadPath')
    ..aOS(4, _omitFieldNames ? '' : 'Status', protoName: 'Status')
    ..aOS(5, _omitFieldNames ? '' : 'Err', protoName: 'Err')
    ..aInt64(6, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Link clone() => Link()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Link copyWith(void Function(Link) updates) =>
      super.copyWith((message) => updates(message as Link)) as Link;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Link create() => Link._();
  @$core.override
  Link createEmptyInstance() => create();
  static $pb.PbList<Link> createRepeated() => $pb.PbList<Link>();
  @$core.pragma('dart2js:noInline')
  static Link getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Link>(create);
  static Link? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get downloadPath => $_getSZ(2);
  @$pb.TagNumber(3)
  set downloadPath($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDownloadPath() => $_has(2);
  @$pb.TagNumber(3)
  void clearDownloadPath() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get status => $_getSZ(3);
  @$pb.TagNumber(4)
  set status($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearStatus() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get err => $_getSZ(4);
  @$pb.TagNumber(5)
  set err($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasErr() => $_has(4);
  @$pb.TagNumber(5)
  void clearErr() => $_clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get id => $_getI64(5);
  @$pb.TagNumber(6)
  set id($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasId() => $_has(5);
  @$pb.TagNumber(6)
  void clearId() => $_clearField(6);
}

class AddRequest extends $pb.GeneratedMessage {
  factory AddRequest({
    $core.Iterable<$core.String>? link,
  }) {
    final result = create();
    if (link != null) result.link.addAll(link);
    return result;
  }

  AddRequest._();

  factory AddRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'library.v1'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'link')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddRequest clone() => AddRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddRequest copyWith(void Function(AddRequest) updates) =>
      super.copyWith((message) => updates(message as AddRequest)) as AddRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddRequest create() => AddRequest._();
  @$core.override
  AddRequest createEmptyInstance() => create();
  static $pb.PbList<AddRequest> createRepeated() => $pb.PbList<AddRequest>();
  @$core.pragma('dart2js:noInline')
  static AddRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddRequest>(create);
  static AddRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get link => $_getList(0);
}

class AddResponse extends $pb.GeneratedMessage {
  factory AddResponse() => create();

  AddResponse._();

  factory AddResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory AddResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'library.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddResponse clone() => AddResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddResponse copyWith(void Function(AddResponse) updates) =>
      super.copyWith((message) => updates(message as AddResponse))
          as AddResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AddResponse create() => AddResponse._();
  @$core.override
  AddResponse createEmptyInstance() => create();
  static $pb.PbList<AddResponse> createRepeated() => $pb.PbList<AddResponse>();
  @$core.pragma('dart2js:noInline')
  static AddResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddResponse>(create);
  static AddResponse? _defaultInstance;
}

class LibraryServiceApi {
  final $pb.RpcClient _client;

  LibraryServiceApi(this._client);

  $async.Future<AddResponse> add($pb.ClientContext? ctx, AddRequest request) =>
      _client.invoke<AddResponse>(
          ctx, 'LibraryService', 'Add', request, AddResponse());
  $async.Future<ListResponse> list(
          $pb.ClientContext? ctx, ListRequest request) =>
      _client.invoke<ListResponse>(
          ctx, 'LibraryService', 'List', request, ListResponse());
  $async.Future<RetryResponse> retry(
          $pb.ClientContext? ctx, RetryRequest request) =>
      _client.invoke<RetryResponse>(
          ctx, 'LibraryService', 'Retry', request, RetryResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
