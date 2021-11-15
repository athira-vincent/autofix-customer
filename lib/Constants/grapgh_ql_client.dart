import 'dart:io';

import 'package:graphql/client.dart';
import 'package:http/io_client.dart';

class GqlClient {
  GqlClient._privateConstructor();
  static final GqlClient _instance = GqlClient._privateConstructor();
  static GqlClient get instance => _instance;
  static GqlClient get I => _instance;


  final HttpLink httpLink = HttpLink(
    "https://api-gateway.techlabz.in/autoconnect-be",
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      // cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      cache: GraphQLCache(store: HiveStore()),
      link: httpLink,
    );
  }

  GraphQLClient _graphClient = GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: HttpLink(
        "https://api-gateway.techlabz.in/autoconnect-be",
        defaultHeaders: <String, String>{
          'x-token': "",
        },
      ));

  GraphQLClient get graphQL => _graphClient;

  /// Methods
  Future<void> config({required String token}) async {
    if (token == "") {
      final HttpLink httpLink = HttpLink(
        "https://api-gateway.techlabz.in/autoconnect-be",
        defaultHeaders: <String, String>{
          'x-token': token,
        },
      );
      // final AuthLink tokenLink = AuthLink(getToken: () async => 'Bearer $token');
      _graphClient = GraphQLClient(
          cache: GraphQLCache(store: HiveStore()), link: httpLink);
    } else {
      final AuthLink authLink = AuthLink(
        getToken: () async => '{x-token: $token"}',
      );
      final HttpLink httpLink = HttpLink(
        "https://api-gateway.techlabz.in/autoconnect-be",
        defaultHeaders: <String, String>{
          'x-token': token,
        },
      );
      final Link link = authLink.concat(httpLink);
      // final AuthLink tokenLink = AuthLink(getToken: () async => 'Bearer $token');
      _graphClient =
          GraphQLClient(cache: GraphQLCache(store: HiveStore()), link: link);
    }
  }

  Future<dynamic> query(String query,
      {bool enableDebug = false, required bool isTokenThere}) async {
    try {
      if (enableDebug) {
        print('Query ===========> $query');
      }
      final QueryResult resp = await _graphClient
          .query(QueryOptions(
              fetchPolicy: FetchPolicy.networkOnly, document: gql(query)))
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw NetworkException(
            message: 'Request Timed out, Please check your connection',
            uri: null);
      });
      if (resp.exception != null && resp.data == null) {
        if (resp.exception!.graphqlErrors.isNotEmpty) {
          print(resp.exception);
          if (enableDebug) {
            _showDebugMessage(
                resp.exception!.graphqlErrors[0].message, 'GraphQL Errors ');
          }
          return <String, dynamic>{
            'status': 'error',
            'message': resp.exception!.graphqlErrors[0].message
          };
        } else {
          if (enableDebug) {
            _showDebugMessage(resp.exception!.linkException!.originalException,
                'GraphQL Errors ');
          }
          return <String, dynamic>{
            'status': 'error',
            'message': resp.exception!.linkException!.originalException ??
                'Something went wrong'
          };
        }
      }
      if (enableDebug) {
        _showDebugMessage(resp.data, 'GraphQL Response Data');
      }
      return resp.data;
    } catch (e) {
      if (enableDebug) {
        // _showDebugMessage(e, 'GraphQL Client Exception');
      }
      return <String, dynamic>{
        'status': 'error',
        'message': 'Something Went wrong'
      };
    }
  }

  Future<dynamic> mutation(String query,
      {bool enableDebug = false,
      required Map<String, dynamic> variables,
      required bool isTokenThere}) async {

    try {
      if (enableDebug) {
        _showDebugMessage(query, 'GraphQL Query');
      }

      // if (isTokenThere) {
      // } else {
      // _clientQuery = clientToQuery();
      // }

      // print("variables==========$variables");



      HttpClient _httpClient = new HttpClient();
      _httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      IOClient _ioClient = new IOClient(_httpClient);

      GraphQLClient _graphClient = GraphQLClient(
          cache: GraphQLCache(store: HiveStore()),
          link: HttpLink(
            "https://api-gateway.techlabz.in/autoconnect-be",
            defaultHeaders: <String, String>{
              'x-token': "",
            },
            httpClient: _ioClient
          ));


      final QueryResult resp = await _graphClient
          .mutate(MutationOptions(
              document: gql(query),
              fetchPolicy: FetchPolicy.networkOnly,
              //variables: variables,
              errorPolicy: ErrorPolicy.all))
          .timeout(const Duration(seconds: 600), onTimeout: () {
        throw NetworkException(
            message: 'Request Timed out, Please check your connection',
            uri: null);
      });

      if (resp.exception != null) {
        print("gojogj ${resp.exception}");
        if (resp.exception!.graphqlErrors.isNotEmpty) {
          print(resp.exception);
          if (enableDebug) {
            _showDebugMessage(
                resp.exception!.graphqlErrors[0].message, 'GraphQL Errors ');
          }
          return <String, dynamic>{
            'status': 'error',
            'message': resp.exception!.graphqlErrors[0].message
          };
        } else {
          if (enableDebug) {
            _showDebugMessage(resp.exception!.linkException!.originalException,
                'GraphQL Client Exception Errors ');
          }
          return <String, dynamic>{
            'status': 'error',
            'message':
                /*resp.exception.linkException.originalException ??*/ 'Something went wrong'
          };
        }
      }

      if (enableDebug) {
        _showDebugMessage(resp.data, 'GraphQL Response Data');
      }
      return resp.data;
    } catch (e) {
      if (enableDebug) {
        _showDebugMessage(e, 'GraphQL Client Exception');
      }
      return <String, dynamic>{
        'status': 'error',
        'message': 'Something Went wrong'
      };
    }
  }

  Future<dynamic> mutation01(String query,
      {bool enableDebug = false,
      required Map<String, dynamic> variables,
      required bool isTokenThere}) async {
    try {
      if (enableDebug) {
        _showDebugMessage(query, 'GraphQL Query');
      }

      // if (isTokenThere) {
      // } else {
      // _clientQuery = clientToQuery();
      // }

      // print("variables==========$variables");

      final QueryResult resp = await _graphClient
          .mutate(MutationOptions(
              document: gql(query),
              fetchPolicy: FetchPolicy.networkOnly,
              variables: variables,
              errorPolicy: ErrorPolicy.all))
          .timeout(const Duration(seconds: 600), onTimeout: () {
        throw NetworkException(
            message: 'Request Timed out, Please check your connection',
            uri: null);
      });

      if (resp.exception != null) {
        print("gojogj ${resp.exception}");
        if (resp.exception!.graphqlErrors.isNotEmpty) {
          print(resp.exception);
          if (enableDebug) {
            _showDebugMessage(
                resp.exception!.graphqlErrors[0].message, 'GraphQL Errors ');
          }
          return <String, dynamic>{
            'status': 'error',
            'message': resp.exception!.graphqlErrors[0].message
          };
        } else {
          if (enableDebug) {
            _showDebugMessage(resp.exception!.linkException!.originalException,
                'GraphQL Client Exception Errors ');
          }
          return <String, dynamic>{
            'status': 'error',
            'message':
                /*resp.exception.linkException.originalException ??*/ 'Something went wrong'
          };
        }
      }

      if (enableDebug) {
        _showDebugMessage(resp.data, 'GraphQL Response Data');
      }
      return resp.data;
    } catch (e) {
      if (enableDebug) {
        _showDebugMessage(e, 'GraphQL Client Exception');
      }
      return <String, dynamic>{
        'status': 'error',
        'message': 'Something Went wrong'
      };
    }
  }

  void _showDebugMessage(dynamic message, String messageType) {
    print(
        '****************************  $messageType  ************************************');
    print(message);
  }
}
