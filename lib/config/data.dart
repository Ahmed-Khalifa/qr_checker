import 'package:qr_checker/private/x_api_key.dart';

Map<String, String> scanUrlHeaders = {
  'Accept': 'application/json',
  'X-Apikey': xApiKey,
  'Content-Type': 'application/x-www-form-urlencoded',
  'Host': 'www.virustotal.com',
};

Map<String, String> getUrlAnalysisHeaders = {
  'Accept': 'application/json',
  'X-Apikey': xApiKey,
  'Host': 'www.virustotal.com',
};
