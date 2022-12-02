import 'dart:core';

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class CvSHow extends StatefulWidget {
  final String cvUrl;
  const CvSHow({
  
    required this.cvUrl,
  }) : super();

  @override
  State<CvSHow> createState() => _CVState();
}

class _CVState extends State<CvSHow>
     {
  Uint8List? _documentBytes;

@override
void initState() {
getPdfBytes();
super.initState();
}
void getPdfBytes() async {
  
      HttpClient client = HttpClient();
      final Uri url = Uri.base.resolve(widget.cvUrl);
      final HttpClientRequest request = await client.getUrl(url);
      final HttpClientResponse response = await request.close();
      _documentBytes = await consolidateHttpClientResponseBytes(response);
      setState(() {});
    }

  @override
  Widget build(BuildContext context) {
    Widget child = const Center(child: CircularProgressIndicator());
    if (_documentBytes != null) {
      child = SfPdfViewer.memory(
        _documentBytes!,
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Freelancer Resume'),backgroundColor:Colors.white),
      body: child,
    );
  }
}
