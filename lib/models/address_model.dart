class AddressModel {
  String? addressName;
  String? addressCity;
  String? addressStreet;
  double? addressLat;
  double? addressLong;

  AddressModel({
        this.addressName,
        this.addressCity,
        this.addressStreet,
        this.addressLat,
        this.addressLong
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    addressName = json['address_name'];
    addressCity = json['address_city'];
    addressStreet = json['address_street'];
    addressLat =double.parse(json['address_lat'].toString());
    addressLong = double.parse(json['address_long'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_name'] = this.addressName;
    data['address_city'] = this.addressCity;
    data['address_street'] = this.addressStreet;
    data['address_lat'] = this.addressLat;
    data['address_long'] = this.addressLong;
    return data;
  }
}