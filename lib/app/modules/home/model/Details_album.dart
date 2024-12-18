class DetailsAlbum {
  DetailsAlbum({
    this.dId,
    this.fileName,
    this.description,
  });

  DetailsAlbum.fromJson(dynamic json) {
    dId = json['dId'];
    fileName = json['fileName'];
    description = json['description'];
  }

  int? dId;
  String? fileName;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dId'] = dId;
    map['fileName'] = fileName;
    map['description'] = description;
    return map;
  }
}
