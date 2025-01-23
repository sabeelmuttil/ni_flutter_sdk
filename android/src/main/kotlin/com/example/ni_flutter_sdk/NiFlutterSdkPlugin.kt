package com.example.ni_flutter_sdk

import com.google.gson.Gson
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import payment.sdk.android.PaymentClient
import payment.sdk.android.core.Order
import payment.sdk.android.payments.PaymentsLauncher
import payment.sdk.android.payments.PaymentsRequest
import payment.sdk.android.samsungpay.SamsungPayResponse

/** NiFlutterSdkPlugin */
class NiFlutterSdkPlugin: FlutterFragmentActivity(), SamsungPayResponse {
  private val channel = "ni_sdk"
  private lateinit var paymentClient: PaymentClient
  private lateinit var paymentsLauncher: PaymentsLauncher
  private val gson = Gson()

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)

    paymentClient = PaymentClient(this, "DEMO_VAL")
    paymentsLauncher = PaymentsLauncher(this) { result ->
      // Handle payment result
    }

    val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)

    methodChannel.setMethodCallHandler { call, result ->
      when (call.method) {
        "makeCardPayment" -> {
          kotlin.io.println("makeCardPayment called")
          val authUrl = call.argument<String>("authUrl").orEmpty()
          val payPageUrl = call.argument<String>("payPageUrl").orEmpty()
          makeCardPayment(authUrl, payPageUrl, result)
        }
        "makeSamsungPay" -> {
          val orderMap = call.argument<Map<String, Any>>("order").orEmpty()
          val jsonString = gson.toJson(orderMap)
          val order = gson.fromJson(jsonString, Order::class.java)
          makeSamsungPay(order, result)
        }
        else -> {
          result.notImplemented()
        }
      }
    }
  }

  private fun makeCardPayment(authUrl: String, payPageUrl: String, result: MethodChannel.Result) {
    CoroutineScope(Dispatchers.Main).launch {
      try {
        paymentsLauncher.launch(
          PaymentsRequest.builder()
            .gatewayAuthorizationUrl(authUrl)
            .payPageUrl(payPageUrl)
            .build()
        )
        result.success("Card payment launched successfully")
      } catch (e: Exception) {
        result.error("ERROR", "Failed to launch card payment: ${e.message}", null)
      }
    }
  }

  private fun makeSamsungPay(order: Order, result: MethodChannel.Result) {
    CoroutineScope(Dispatchers.Main).launch {
      try {
        paymentClient.launchSamsungPay(order, "Test Data Sabeel", this@NiFlutterSdkPlugin)
        result.success("Samsung Pay launched successfully")
      } catch (e: Exception) {
        result.error("ERROR", "Failed to launch Samsung Pay: ${e.message}", null)
      }
    }
  }

  override fun onSuccess() {
    println("onSuccess")
    TODO("Not yet implemented")
  }

  override fun onFailure(error: String) {
    println("error $error")
    TODO("Not yet implemented")
  }

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  //  private lateinit var channel : MethodChannel
  //
  //  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
  //    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ni_sdk")
  //    channel.setMethodCallHandler(this)
  //  }
  //
  //  override fun onMethodCall(call: MethodCall, result: Result) {
  //    if (call.method == "getPlatformVersion") {
  //      result.success("Android ${android.os.Build.VERSION.RELEASE}")
  //    } else {
  //      result.notImplemented()
  //    }
  //  }
  //
  //  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
  //    channel.setMethodCallHandler(null)
  //  }
}
