class AnalysisReportModel {
  Data data;
  Meta meta;

  AnalysisReportModel({
    required this.data,
    required this.meta,
  });
}

class Data {
  String id;
  String type;
  Links links;
  Attributes attributes;

  Data({
    required this.id,
    required this.type,
    required this.links,
    required this.attributes,
  });
}

class Attributes {
  int date;
  String status;
  Stats stats;
  Map<String, ResultValue> results;

  Attributes({
    required this.date,
    required this.status,
    required this.stats,
    required this.results,
  });
}

class ResultValue {
  Method method;
  String engineName;
  Category category;
  ResultEnum result;

  ResultValue({
    required this.method,
    required this.engineName,
    required this.category,
    required this.result,
  });
}

enum Category { HARMLESS, MALICIOUS, SUSPICIOUS, UNDETECTED }

enum Method { BLACKLIST }

enum ResultEnum { CLEAN, PHISHING, SUSPICIOUS, UNRATED }

class Stats {
  int malicious;
  int suspicious;
  int undetected;
  int harmless;
  int timeout;

  Stats({
    required this.malicious,
    required this.suspicious,
    required this.undetected,
    required this.harmless,
    required this.timeout,
  });
}

class Links {
  String self;
  String item;

  Links({
    required this.self,
    required this.item,
  });
}

class Meta {
  UrlInfo urlInfo;

  Meta({
    required this.urlInfo,
  });
}

class UrlInfo {
  String id;
  String url;

  UrlInfo({
    required this.id,
    required this.url,
  });
}
