//
//  Generated code. Do not modify.
//  source: library/v1/library.proto
//

import "package:connectrpc/connect.dart" as connect;
import "library.pb.dart" as libraryv1library;

abstract final class LibraryService {
  /// Fully-qualified name of the LibraryService service.
  static const name = 'library.v1.LibraryService';

  static const add = connect.Spec(
    '/$name/Add',
    connect.StreamType.unary,
    libraryv1library.AddRequest.new,
    libraryv1library.AddResponse.new,
  );

  static const list = connect.Spec(
    '/$name/List',
    connect.StreamType.unary,
    libraryv1library.ListRequest.new,
    libraryv1library.ListResponse.new,
  );

  static const retry = connect.Spec(
    '/$name/Retry',
    connect.StreamType.unary,
    libraryv1library.RetryRequest.new,
    libraryv1library.RetryResponse.new,
  );
}
