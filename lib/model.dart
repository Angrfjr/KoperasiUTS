class Koperasi {
  late String? id;
  late String? Nama;
  late String? Image;
  late int? Harga;

  Koperasi({this.id, this.Nama, this.Image, this.Harga});

  Koperasi.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    Nama = json["Nama"];
    Image = json["Image"];
    Harga = json["Harga"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data["_id"] = id;
    _data["Nama"] = Nama;
    _data["Image"] = Image;
    _data["Harga"] = Harga;

    return _data;
  }
}
