import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'utils/get_material_state_colors.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  ResumePageState createState() {
    return ResumePageState();
  }
}

class ResumePageState extends State<ResumePage> {
  final GlobalKey _pdfViewerKey = GlobalKey();
  String pathToPDF = 'assets/documents/resume.pdf';

  late PdfController _pdfController;

  @override
  void initState() {
    _pdfController = PdfController(
      document: PdfDocument.openAsset(pathToPDF),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("[Babalola, Olufunmilola] Resume"),
          backgroundColor: getBackgroundColor(<MaterialState>{}, themeData, false),
          foregroundColor: getForegroundColor(<MaterialState>{}, themeData, false),
          actions: const <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: null,
            ),
          ],
        ),
        body: InteractiveViewer(
          maxScale: 4,
          child: PdfView(
              controller: _pdfController, key: _pdfViewerKey,
            )
          )
      )
    );
  }
}
