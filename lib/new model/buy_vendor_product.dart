/// status : "1"
/// message : "Products Found"
/// products : [{"product_id":"1","cat_id":"1","subcat_id":"0","product_name":"Outcast Orange","product_description":"outcast orange","product_price":"400","product_image":["https://developmentalphawizz.com/SOD_New//uploads/product_images/63aeb49e5c9cc.jpg"],"pro_ratings":"2.17","role_id":"1","selling_price":"350","product_create_date":"2021-06-19 18:41:47","vendor_id":"0","other_image":""}]

class BuyVendorProduct {
  BuyVendorProduct({
      String? status, 
      String? message, 
      List<Products>? products,}){
    _status = status;
    _message = message;
    _products = products;
}

  BuyVendorProduct.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(Products.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<Products>? _products;
BuyVendorProduct copyWith({  String? status,
  String? message,
  List<Products>? products,
}) => BuyVendorProduct(  status: status ?? _status,
  message: message ?? _message,
  products: products ?? _products,
);
  String? get status => _status;
  String? get message => _message;
  List<Products>? get products => _products;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_id : "1"
/// cat_id : "1"
/// subcat_id : "0"
/// product_name : "Outcast Orange"
/// product_description : "outcast orange"
/// product_price : "400"
/// product_image : ["https://developmentalphawizz.com/SOD_New//uploads/product_images/63aeb49e5c9cc.jpg"]
/// pro_ratings : "2.17"
/// role_id : "1"
/// selling_price : "350"
/// product_create_date : "2021-06-19 18:41:47"
/// vendor_id : "0"
/// other_image : ""

class Products {
  Products({
      String? productId, 
      String? catId, 
      String? subcatId, 
      String? productName, 
      String? productDescription, 
      String? productPrice, 
      List<String>? productImage, 
      String? proRatings, 
      String? roleId, 
      String? sellingPrice, 
      String? productCreateDate, 
      String? vendorId, 
      String? otherImage,}){
    _productId = productId;
    _catId = catId;
    _subcatId = subcatId;
    _productName = productName;
    _productDescription = productDescription;
    _productPrice = productPrice;
    _productImage = productImage;
    _proRatings = proRatings;
    _roleId = roleId;
    _sellingPrice = sellingPrice;
    _productCreateDate = productCreateDate;
    _vendorId = vendorId;
    _otherImage = otherImage;
}

  Products.fromJson(dynamic json) {
    _productId = json['product_id'];
    _catId = json['cat_id'];
    _subcatId = json['subcat_id'];
    _productName = json['product_name'];
    _productDescription = json['product_description'];
    _productPrice = json['product_price'];
    _productImage = json['product_image'] != null ? json['product_image'].cast<String>() : [];
    _proRatings = json['pro_ratings'];
    _roleId = json['role_id'];
    _sellingPrice = json['selling_price'];
    _productCreateDate = json['product_create_date'];
    _vendorId = json['vendor_id'];
    _otherImage = json['other_image'];
  }
  String? _productId;
  String? _catId;
  String? _subcatId;
  String? _productName;
  String? _productDescription;
  String? _productPrice;
  List<String>? _productImage;
  String? _proRatings;
  String? _roleId;
  String? _sellingPrice;
  String? _productCreateDate;
  String? _vendorId;
  String? _otherImage;
Products copyWith({  String? productId,
  String? catId,
  String? subcatId,
  String? productName,
  String? productDescription,
  String? productPrice,
  List<String>? productImage,
  String? proRatings,
  String? roleId,
  String? sellingPrice,
  String? productCreateDate,
  String? vendorId,
  String? otherImage,
}) => Products(  productId: productId ?? _productId,
  catId: catId ?? _catId,
  subcatId: subcatId ?? _subcatId,
  productName: productName ?? _productName,
  productDescription: productDescription ?? _productDescription,
  productPrice: productPrice ?? _productPrice,
  productImage: productImage ?? _productImage,
  proRatings: proRatings ?? _proRatings,
  roleId: roleId ?? _roleId,
  sellingPrice: sellingPrice ?? _sellingPrice,
  productCreateDate: productCreateDate ?? _productCreateDate,
  vendorId: vendorId ?? _vendorId,
  otherImage: otherImage ?? _otherImage,
);
  String? get productId => _productId;
  String? get catId => _catId;
  String? get subcatId => _subcatId;
  String? get productName => _productName;
  String? get productDescription => _productDescription;
  String? get productPrice => _productPrice;
  List<String>? get productImage => _productImage;
  String? get proRatings => _proRatings;
  String? get roleId => _roleId;
  String? get sellingPrice => _sellingPrice;
  String? get productCreateDate => _productCreateDate;
  String? get vendorId => _vendorId;
  String? get otherImage => _otherImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['cat_id'] = _catId;
    map['subcat_id'] = _subcatId;
    map['product_name'] = _productName;
    map['product_description'] = _productDescription;
    map['product_price'] = _productPrice;
    map['product_image'] = _productImage;
    map['pro_ratings'] = _proRatings;
    map['role_id'] = _roleId;
    map['selling_price'] = _sellingPrice;
    map['product_create_date'] = _productCreateDate;
    map['vendor_id'] = _vendorId;
    map['other_image'] = _otherImage;
    return map;
  }

}