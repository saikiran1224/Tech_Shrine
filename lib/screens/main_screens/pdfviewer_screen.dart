import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../res/custom_colors.dart';
import '../../widgets/app_bar_title.dart';

class PDFViewerScreen extends StatefulWidget {
  
  const PDFViewerScreen({Key? key, required String fileName,required String url}) :
        _fileName = fileName,
        _url = url,
        super(key: key);

  final String _url;
  final String _fileName;

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {

  late String _url;
  late String _fileName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _url = widget._url;
    _fileName = widget._fileName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.firebaseNavy,
        title: AppBarTitle(
          sectionName: _fileName,
        ),
      ),
      body: SfPdfViewer.network(_url),
    );
  }
}
