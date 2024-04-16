import 'package:findword/base/base_c.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebC extends BaseC{
  late WebViewController webViewController;
  @override
  void onInit() {
    super.onInit();
    webViewController=WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
// ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(RoutersUtils.getParams()["url"]));
  }
}