import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen(this.url, {super.key});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        centerTitle: true,
        title: const Text(
          "Recipe WebView Details",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',),),
      ),
      body: Stack(
        children: [
          WebView(
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.url,
            onPageStarted: (start) {
              setState(() {
                Future.delayed(
                    const Duration(seconds: 1,
                    ), () => null);
                isLoading = false;
              });
            },),
          if (isLoading)
            Center(
              child: GifView.asset(
                'assets/gifs/recipes_loading.gif',
                height: 140,
                width: 140,
                frameRate: 30,
                fadeDuration: const Duration(microseconds: 700),
                withOpacityAnimation: true,
              ),
            ),
        ],
      ),
    );
  }}