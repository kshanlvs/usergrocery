class AddressModel {
  String? address;
  String? addressType;
  String? buildingApartmentName;
  String? city;
  bool? defaultAddress;
  String? flatHouseNo;
  String? landmartArea;
  int? pinCode;
  String? state;

  AddressModel(
      {this.address,
      this.addressType,
      this.buildingApartmentName,
      this.city,
      this.defaultAddress,
      this.flatHouseNo,
      this.landmartArea,
      this.pinCode,
      this.state});

  AddressModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressType = json['address_type'];
    buildingApartmentName = json['building_apartment_name'];
    city = json['city'];
    defaultAddress = json['default_address'];
    flatHouseNo = json['flat_house_no'];
    landmartArea = json['landmart_area'];
    pinCode = json['pin_code'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['address_type'] = this.addressType;
    data['building_apartment_name'] = this.buildingApartmentName;
    data['city'] = this.city;
    data['default_address'] = this.defaultAddress;
    data['flat_house_no'] = this.flatHouseNo;
    data['landmart_area'] = this.landmartArea;
    data['pin_code'] = this.pinCode;
    data['state'] = this.state;
    return data;
  }
}
