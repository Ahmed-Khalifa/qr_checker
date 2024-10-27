class AnalysisIdModel {
  Data? _data;

  AnalysisIdModel({Data? data}) {
    if (data != null) {
      this._data = data;
    }
  }

  Data? get data => _data;
  set data(Data? data) => _data = data;

  AnalysisIdModel.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}

class Data {
  String? _type;
  String? _id;
  Links? _links;

  Data({String? type, String? id, Links? links}) {
    if (type != null) {
      this._type = type;
    }
    if (id != null) {
      this._id = id;
    }
    if (links != null) {
      this._links = links;
    }
  }

  String? get type => _type;
  set type(String? type) => _type = type;
  String? get id => _id;
  set id(String? id) => _id = id;
  Links? get links => _links;
  set links(Links? links) => _links = links;

  Data.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _id = json['id'];
    _links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this._type;
    data['id'] = this._id;
    if (this._links != null) {
      data['links'] = this._links!.toJson();
    }
    return data;
  }
}

class Links {
  String? _self;

  Links({String? self}) {
    if (self != null) {
      this._self = self;
    }
  }

  String? get self => _self;
  set self(String? self) => _self = self;

  Links.fromJson(Map<String, dynamic> json) {
    _self = json['self'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this._self;
    return data;
  }
}
