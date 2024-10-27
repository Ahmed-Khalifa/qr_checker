import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_checker/config/data.dart';
import 'package:qr_checker/models/analysis_id_model.dart';

class ResultsPage extends StatefulWidget {
  static const id = 'results_page';

  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
  Future<void> _scanUrl(Barcode? barcode) async {
    String? urlRaw = barcode?.rawValue;
    if (kDebugMode) {
      print(urlRaw);
    }
    String urlEncoded = Uri.encodeFull(urlRaw!);
    if (kDebugMode) {
      print(urlEncoded);
    }
    var url = Uri.parse('https://www.virustotal.com/api/v3/urls');

    var body = {'url': urlEncoded};

    var req = http.Request('POST', url);
    req.headers.addAll(scanUrlHeaders);
    req.bodyFields = body;

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (kDebugMode) {
        print(resBody);
      }
      dynamic resBodyJson = jsonDecode(resBody);
      AnalysisIdModel analysisIdModel = AnalysisIdModel.fromJson(resBodyJson);
      if (mounted) {
        Navigator.pushNamed(context, ResultsPage.id,
            arguments: analysisIdModel);
      }
    } else {
      print('ERROR: ${res.reasonPhrase}');
    }
  }

  _getAnalysisReport(String id) async {
    var url = Uri.parse('https://www.virustotal.com/api/v3/analyses/$id');

    var req = http.Request('GET', url);
    req.headers.addAll(getUrlAnalysisHeaders);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
    } else {
      print(res.reasonPhrase);
    }
  }


}
