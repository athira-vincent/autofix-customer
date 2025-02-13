import 'dart:io';

import 'package:auto_fix/Constants/shared_pref_keys.dart';
import 'package:graphql/client.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GqlClient {
  //int lanCode = 0;
  Future<String> getLanguage() async {
    SharedPreferences shdPre = await SharedPreferences.getInstance();
    String? lan = shdPre.getString(SharedPrefKeys.userLanguageCode) ?? 'en';
    print(">>>>lan : $lan");
    /*if(lan == "ig"){
      lanCode = 1;
    }else if(lan == "en"){
      lanCode = 2;
    }else if(lan == "ha"){
      lanCode = 3;
    }else if(lan == "yo"){
      lanCode = 4;
    }else{
      lanCode = 2;
    }*/
    return lan.toString();
  }

  GqlClient._privateConstructor();
  static final GqlClient _instance = GqlClient._privateConstructor();
  static GqlClient get instance => _instance;
  static GqlClient get I => _instance;

  final HttpLink httpLink = HttpLink(
    "https://api-gateway.techlabz.in/autoconnect-be",
  );
  /*final HttpLink httpLink = HttpLink(
    "https://athiras-82.workspace.techwarelab.com/graphql",
  );*/

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
        //"https://athiras-82.workspace.techwarelab.com/graphql",
        defaultHeaders: <String, String>{
          'x-token': "",
        },
      ));

  GraphQLClient get graphQL => _graphClient;

  /// Methods
  Future<void> config({required String token}) async {
    String langCode01 = await getLanguage();
    if (token == "") {
      HttpClient _httpClient = HttpClient();
      _httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      IOClient _ioClient = IOClient(_httpClient);
      final HttpLink httpLink = HttpLink(
        "https://api-gateway.techlabz.in/autoconnect-be",
        //"https://athiras-82.workspace.techwarelab.com/graphql",
        defaultHeaders: <String, String>{
          'x-token': token,
          'language' : "$langCode01"
        },
        httpClient: _ioClient,
      );
      // final AuthLink tokenLink = AuthLink(getToken: () async => 'Bearer $token');
      _graphClient = GraphQLClient(
          cache: GraphQLCache(store: HiveStore()), link: httpLink);
    } else {
      final AuthLink authLink = AuthLink(
        getToken: () async => '{x-token: $token"}',
      );
      HttpClient _httpClient = HttpClient();
      _httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      IOClient _ioClient = IOClient(_httpClient);
      final HttpLink httpLink = HttpLink(
        "https://api-gateway.techlabz.in/autoconnect-be",
        //"https://athiras-82.workspace.techwarelab.com/graphql",
        defaultHeaders: <String, String>{
          'x-token': token,
          'language' : "$langCode01"
        },
        httpClient: _ioClient,
      );
      final Link link = authLink.concat(httpLink);
      // final AuthLink tokenLink = AuthLink(getToken: () async => 'Bearer $token');
      _graphClient =
          GraphQLClient(cache: GraphQLCache(store: HiveStore()), link: link);
    }
  }

  Future<dynamic> query(String query,
      {bool enableDebug = false, required bool isTokenThere}) async {
    String langCode01 = await getLanguage();
    try {
      if (enableDebug) {
        print('Query ===========> $query');
      }
      HttpClient _httpClient = HttpClient();
      _httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      IOClient _ioClient = IOClient(_httpClient);

      GraphQLClient _graphClient = GraphQLClient(
          cache: GraphQLCache(store: HiveStore()),
          link: HttpLink("https://api-gateway.techlabz.in/autoconnect-be",
              //"https://athiras-82.workspace.techwarelab.com/graphql",
              defaultHeaders: <String, String>{
                'x-token': "",
                'language' : "$langCode01"
              },
              httpClient: _ioClient));
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

  Future<dynamic> query01(String query, String token,
      {bool enableDebug = false, required bool isTokenThere}) async {
    String langCode01 = await getLanguage();
    try {
      if (enableDebug) {
        print('Query ===========> $query');
      }
      HttpClient _httpClient = HttpClient();
      _httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      IOClient _ioClient = IOClient(_httpClient);

      GraphQLClient _graphClient = GraphQLClient(
          cache: GraphQLCache(store: HiveStore()),
          link: HttpLink("https://api-gateway.techlabz.in/autoconnect-be",
              //"https://athiras-82.workspace.techwarelab.com/graphql",
              defaultHeaders: <String, String>{
                'x-token': token,
                'language' : "$langCode01"
              },
              httpClient: _ioClient));
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
    String langCode01 = await getLanguage();
    try {
      if (enableDebug) {
        _showDebugMessage(query, 'GraphQL Query');
      }

      // if (isTokenThere) {
      // } else {
      // _clientQuery = clientToQuery();
      // }

      // print("variables==========$variables");

      HttpClient _httpClient = HttpClient();
      _httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      IOClient _ioClient = IOClient(_httpClient);

      GraphQLClient _graphClient = GraphQLClient(
          cache: GraphQLCache(store: HiveStore()),
          link: HttpLink("https://api-gateway.techlabz.in/autoconnect-be",
              //"https://athiras-82.workspace.techwarelab.com/graphql",
              defaultHeaders: <String, String>{
                'x-token': "",
                'language' : "$langCode01"
              },
              httpClient: _ioClient));

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
      print("hghffkjjk $resp");
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

  Future<dynamic> mutation11(String query,
      {bool enableDebug = false,
        required Map<String, dynamic> variables,
        required String token,
        required bool isTokenThere}) async {
    String langCode01 = await getLanguage();
    try {
      if (enableDebug) {
        _showDebugMessage(query, 'GraphQL Query');
      }

      // if (isTokenThere) {
      // } else {
      // _clientQuery = clientToQuery();
      // }

      // print("variables==========$variables");

      HttpClient _httpClient = HttpClient();
      _httpClient.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      IOClient _ioClient = IOClient(_httpClient);

      GraphQLClient _graphClient = GraphQLClient(
          cache: GraphQLCache(store: HiveStore()),
          link: HttpLink("https://api-gateway.techlabz.in/autoconnect-be",
              //"https://athiras-82.workspace.techwarelab.com/graphql",
              defaultHeaders: <String, String>{
                'x-token': token,
                'language' : "$langCode01"
              },
              httpClient: _ioClient));

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
      print("hghffkjjk $resp");
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
    String langCode01 = await getLanguage();
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
    print(">>>message : $message");
    print(">>>messageType : $messageType");
  }
}
