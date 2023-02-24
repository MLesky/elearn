import 'package:graphql_flutter/graphql_flutter.dart';

/// Graph QL
///
/// Creating a Graphql client and
/// Connecting to the graphql's api

final GraphQLClient gqlClient = GraphQLClient(
  /// url for graphql
  link: HttpLink('http://rich-jade-bat-wig.cyclic.app/api'),
  cache: GraphQLCache(
    /// Store the cache data
    store: HiveStore(),
  ),
);
