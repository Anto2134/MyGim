// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {
  final String title;
  final String url;

  ArticlePage({required this.title, required this.url});

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  late WebViewController _controller;
  bool _isLoading = true;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    // Abilita la visualizzazione virtuale su Android
    WebView.platform = SurfaceAndroidWebView();
  }

  void _refreshPage() {
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
              _controller.loadUrl(widget.url);
            },
            onPageStarted: (url) {
              setState(() {
                _isLoading = true;
                _isError = false;
              });
            },
            onPageFinished: (url) {
              setState(() {
                _isLoading = false;
              });
            },
            onWebResourceError: (error) {
              setState(() {
                _isError = true;
                _isLoading = false;
              });
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (_isError)
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 50,
                    color: Colors.red,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Failed to load page',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshPage,
        backgroundColor: Colors.black,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
