import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_checker/config/data.dart';
import 'package:qr_checker/models/analysis_id_model.dart';
import 'package:qr_checker/models/analysis_report_model.dart';

class ResultsPage extends StatefulWidget {
  static const id = 'results_page';

  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: FutureBuilder(
              future: _scanUrl(arguments['barcode_data']),
              initialData: const Text('Loading',style: TextStyle(fontSize: 15.0),),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString(),style: const TextStyle(fontSize: 15.0),);
                  
                } else if (snapshot.hasError) {
                return const Text('Data Error.',style: TextStyle(fontSize: 15.0),);
        
                }
                return const Text('Loading');
              }),
        ),
      ),
    );
  }

  late AnalysisIdModel _analysisIdModel;
  late AnalysisReportModel _analysisReportModel;

  Future<dynamic>? _scanUrl(Barcode? barcode) async {
    String? urlRaw = barcode?.rawValue;

    String urlEncoded = Uri.encodeFull(urlRaw!);
    // if (kDebugMode) {
    //   print('URL Encoded: $urlEncoded');
    // }
    var url = Uri.parse('https://www.virustotal.com/api/v3/urls');

    var body = {'url': urlEncoded};

    var req = http.Request('POST', url);
    req.headers.addAll(scanUrlHeaders);
    req.bodyFields = body;

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // if (kDebugMode) {
      //   print(resBody);
      // }

      dynamic resBodyJson = jsonDecode(resBody);
      AnalysisIdModel analysisIdModel = AnalysisIdModel.fromJson(resBodyJson);
      _analysisIdModel = analysisIdModel;
      // if (kDebugMode) {
      //   print(_analysisIdModel.data!.id);
      // }
      _getAnalysisReport(_analysisIdModel.data!.id);
      return _analysisIdModel.data!.id;
    } else {
      if (kDebugMode) {
        print('ERROR: ${res.reasonPhrase}');
      }
      return null;
    }
  }

  _getAnalysisReport(String? id) async {
    var url = Uri.parse('https://www.virustotal.com/api/v3/analyses/$id');

    var req = http.Request('GET', url);
    req.headers.addAll(getUrlAnalysisHeaders);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      // print(resBody);
// var resBodyJsonDecoded = jsonDecode(resBody);
//       AnalysisReportModel analysisReportModel = AnalysisReportModel(data: resBodyJsonDecoded['data'], meta: resBodyJsonDecoded['meta']);
      print(jsonDecode(resBody)['meta']);
    } else {
      print(res.reasonPhrase);
    }
  }
}
