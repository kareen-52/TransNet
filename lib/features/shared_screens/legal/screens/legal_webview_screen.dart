// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class LegalWebViewScreen extends StatefulWidget {
//   final String title;
//   final String htmlAssetPath;

//   const LegalWebViewScreen({
//     super.key,
//     required this.title,
//     required this.htmlAssetPath,
//   });

//   @override
//   State<LegalWebViewScreen> createState() => _LegalWebViewScreenState();
// }

// class _LegalWebViewScreenState extends State<LegalWebViewScreen> {
//   late final WebViewController _controller;
//   bool _isLoading = true;
//   bool _didSetBackground = false;

//   @override
//   void initState() {
//     super.initState();
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.disabled)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (_) {
//             if (mounted) setState(() => _isLoading = false);
//           },
//         ),
//       )
//       ..loadFlutterAsset(widget.htmlAssetPath);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_didSetBackground) {
//       _didSetBackground = true;
//       _controller.setBackgroundColor(Theme.of(context).scaffoldBackgroundColor);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       backgroundColor: theme.scaffoldBackgroundColor,
//       appBar: AppBar(title: Text(widget.title), centerTitle: true),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),
//           if (_isLoading)
//             Center(
//               child: CircularProgressIndicator(
//                 color: theme.colorScheme.primary,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }