import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NiSdk {
  static MethodChannel niSDK = const MethodChannel('ni_sdk');

  void dispose() {
    niSDK.setMethodCallHandler(null);
  }

  Future<String> makeCardPayment() async {
    try {
      final String result = await niSDK.invokeMethod('makeCardPayment', {
        "authUrl":
            "https://api-gateway.sandbox.ngenius-payments.com/transactions/paymentAuthorization",
        "payPageUrl":
            "https://paypage.sandbox.ngenius-payments.com/?code=676f13c0375b49b7",
      });

      return result;
    } on PlatformException catch (e) {
      return "Failed to make payment: '${e.message}'.";
    }
  }

  Future<String> makeSamsungPay() async {
    try {
      final String result = await niSDK.invokeMethod('makeSamsungPay', {
        "order": {
          "_id": "urn:order:03fa436e-dc8f-4e25-95a9-7d4fafbca89c",
          // "_links": {
          //   "cancel": {
          //     "href": "https://api-gateway.sandbox.ngenius-payments.com/transactions/outlets/7ba80441-4745-4ab3-b3c7-689a48de6fd1/orders/03fa436e-dc8f-4e25-95a9-7d4fafbca89c/cancel"
          //   },
          //   "cnp:payment-link": {
          //     "href": "https://api-gateway.sandbox.ngenius-payments.com/transactions/outlets/7ba80441-4745-4ab3-b3c7-689a48de6fd1/orders/03fa436e-dc8f-4e25-95a9-7d4fafbca89c/payment-link"
          //   },
          //   "payment-authorization": {
          //     "href": "https://api-gateway.sandbox.ngenius-payments.com/transactions/paymentAuthorization"
          //   },
          //   "self": {
          //     "href": "https://api-gateway.sandbox.ngenius-payments.com/transactions/outlets/7ba80441-4745-4ab3-b3c7-689a48de6fd1/orders/03fa436e-dc8f-4e25-95a9-7d4fafbca89c"
          //   },
          //   "tenant-brand": {
          //     "href": "http://config-service/config/outlets/7ba80441-4745-4ab3-b3c7-689a48de6fd1/configs/tenant-brand"
          //   },
          //   "payment": {
          //     "href": "https://paypage.sandbox.ngenius-payments.com/?code=51312a2d2868f4a1"
          //   },
          //   "merchant-brand": {
          //     "href": "http://config-service/config/outlets/7ba80441-4745-4ab3-b3c7-689a48de6fd1/configs/merchant-brand"
          //   }
          // },
          // "type": "SINGLE",
          // "merchantDefinedData": {},
          // "action": "SALE",
          "amount": {"currencyCode": "AED", "value": 1000},
          "language": "en",
          // "merchantAttributes": {},
          "emailAddress": "user@domain.com",
          "reference": "03fa436e-dc8f-4e25-95a9-7d4fafbca89c",
          "outletId": "7ba80441-4745-4ab3-b3c7-689a48de6fd1",
          // "createDateTime": "2025-01-20T08:08:43.701668119Z",
          "paymentMethods": {
            "card": ["DINERS_CLUB_INTERNATIONAL", "MASTERCARD", "VISA"]
          },
          // "referrer": "urn:Ecom:03fa436e-dc8f-4e25-95a9-7d4fafbca89c",
          // "merchantDetails": {
          //   "reference": "5c19a6af-df28-4be2-9e7a-3ef50c399256",
          //   "name": "New Albayan Foods LLC",
          //   "companyUrl": "https://www.chickinguae.com"
          // },
          // "isSplitPayment": false,
          // "formattedAmount": "د.إ.‏ 10",
          "formattedOriginalAmount": "",
          "formattedOrderSummary": {},
          "_embedded": {
            "payment": [
              {
                "_id": "urn:payment:b024fa83-1017-47ca-bf3c-ea0adba28f28",
                "_links": {
                  "self": {
                    "href":
                        "https://api-gateway.sandbox.ngenius-payments.com/transactions/outlets/7ba80441-4745-4ab3-b3c7-689a48de6fd1/orders/03fa436e-dc8f-4e25-95a9-7d4fafbca89c/payments/b024fa83-1017-47ca-bf3c-ea0adba28f28"
                  },
                  "payment:card": {
                    "href":
                        "https://api-gateway.sandbox.ngenius-payments.com/transactions/outlets/7ba80441-4745-4ab3-b3c7-689a48de6fd1/orders/03fa436e-dc8f-4e25-95a9-7d4fafbca89c/payments/b024fa83-1017-47ca-bf3c-ea0adba28f28/card"
                  },
                  "curies": [
                    {
                      "name": "cnp",
                      "href":
                          "https://api-gateway.sandbox.ngenius-payments.com/docs/rels/{rel}",
                      "templated": true
                    }
                  ]
                },
                "reference": "b024fa83-1017-47ca-bf3c-ea0adba28f28",
                "state": "STARTED",
                "amount": {"currencyCode": "AED", "value": 1000},
                "updateDateTime": "2025-01-20T08:08:43.701668119Z",
                "outletId": "7ba80441-4745-4ab3-b3c7-689a48de6fd1",
                "orderReference": "03fa436e-dc8f-4e25-95a9-7d4fafbca89c"
              }
            ]
          }
        },
      });

      return result;
    } on PlatformException catch (e) {
      return "Failed to make payment: '${e.message}'.";
    }
  }

  StatefulWidget hyperSdkView(
      Map<String, dynamic> params, void Function(MethodCall) processHandler) {
    // Wrapper function to eliminate redundant Future<dynamic> return value
    Future<dynamic> callbackFunction(MethodCall methodCall) {
      processHandler(methodCall);
      return Future.value(0);
    }

    niSDK.setMethodCallHandler(callbackFunction);

    return Platform.isAndroid
        ? AndroidView(
            viewType: 'NiSdkViewGroup',
            onPlatformViewCreated: (id) async {
              var viewChannel = MethodChannel('ni_view_$id');
              Future<dynamic> viewIdCallback(MethodCall methodCall) async {
                print(
                    'Method Channel triggered for platform view ${methodCall.method}, ${methodCall.arguments}');
                if (methodCall.method == 'niViewCreated') {
                  var viewId = methodCall.arguments as int;

                  await niSDK.invokeMethod('processWithView', <String, dynamic>{
                    'viewId': viewId,
                    'params': params,
                  });
                }
                return Future.value(0);
              }

              viewChannel.setMethodCallHandler(viewIdCallback);
            },
          )
        : UiKitView(
            viewType: 'NiSdkViewGroup',
            onPlatformViewCreated: (id) async {
              var viewChannel = MethodChannel('ni_view_$id');
              Future<dynamic> viewIdCallback(MethodCall methodCall) async {
                if (methodCall.method == 'niViewCreated') {
                  var viewId = methodCall.arguments as int;

                  await niSDK.invokeMethod('processWithView', <String, dynamic>{
                    'viewId': viewId,
                    'params': params,
                  });
                }
                return Future.value(0);
              }

              viewChannel.setMethodCallHandler(viewIdCallback);
            },
          );
  }

  Future<String?> getPlatformVersion() async {
    return '';
  }
}
