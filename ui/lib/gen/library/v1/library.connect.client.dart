//
//  Generated code. Do not modify.
//  source: library/v1/library.proto
//

import "package:connectrpc/connect.dart" as connect;
import "library.pb.dart" as libraryv1library;
import "library.connect.spec.dart" as specs;

extension type LibraryServiceClient (connect.Transport _transport) {
  Future<libraryv1library.AddResponse> add(
    libraryv1library.AddRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.LibraryService.add,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<libraryv1library.ListResponse> list(
    libraryv1library.ListRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.LibraryService.list,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }

  Future<libraryv1library.RetryResponse> retry(
    libraryv1library.RetryRequest input, {
    connect.Headers? headers,
    connect.AbortSignal? signal,
    Function(connect.Headers)? onHeader,
    Function(connect.Headers)? onTrailer,
  }) {
    return connect.Client(_transport).unary(
      specs.LibraryService.retry,
      input,
      signal: signal,
      headers: headers,
      onHeader: onHeader,
      onTrailer: onTrailer,
    );
  }
}
