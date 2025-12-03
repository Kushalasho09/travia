import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start OTP Verification Group Code

class OTPVerificationGroup {
  static String getBaseUrl() => 'https://www.fast2sms.com/dev/';
  static Map<String, String> headers = {
    'authorization':
        'WE6DXGlIuwAQjs9e3Ft8GNCEfZ7nBNsJhCLw4NYnZ7YW7PSFl10VdY6gpKZO',
  };
  static SmsapiCall smsapiCall = SmsapiCall();
}

class SmsapiCall {
  Future<ApiCallResponse> call({
    String? variablesValues = '',
    String? numbers = '',
  }) async {
    final baseUrl = OTPVerificationGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'SMSAPI',
      apiUrl: '${baseUrl}bulkV2',
      callType: ApiCallType.POST,
      headers: {
        'authorization':
            'WE6DXGlIuwAQjs9e3Ft8GNCEfZ7nBNsJhCLw4NYnZ7YW7PSFl10VdY6gpKZO',
      },
      params: {
        'variables_values': variablesValues,
        'route': "otp",
        'numbers': numbers,
      },
      bodyType: BodyType.MULTIPART,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End OTP Verification Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
