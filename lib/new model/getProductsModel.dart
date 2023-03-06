/// status : "1"
/// message : "Products Found"
/// products : [{"product_id":"150","cat_id":"1","subcat_id":"4","product_name":"New product","product_description":"this is new description","product_price":"200","product_image":"https://developmentalphawizz.com/SOD_New//uploads/product_images/63ca41c335609.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"180","product_create_date":"2023-01-20 06:32:03","vendor_id":"29","other_image":["https://developmentalphawizz.com/SOD_New//uploads/product_images/"],"product_status":"0","variant_name":"","product_type":"","category_name":" fast Food","subcategory_name":"Plumber"},{"product_id":"145","cat_id":"26","subcat_id":"4","product_name":"demo gygft","product_description":"xiekxfghhbn","product_price":"500","product_image":"https://developmentalphawizz.com/SOD_New//uploads/product_images/63ca410fa199e.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"300","product_create_date":"2023-01-19 15:47:21","vendor_id":"29","other_image":["https://developmentalphawizz.com/SOD_New//uploads/product_images/"],"product_status":"0","variant_name":"","product_type":"","category_name":"south indian","subcategory_name":"Plumber"},{"product_id":"151","cat_id":"26","subcat_id":"4","product_name":"Latest Producthxhz","product_description":"fhsudhrjr","product_price":"300","product_image":"https://developmentalphawizz.com/SOD_New//uploads/product_images/63ca3cec86cae.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"200","product_create_date":"2023-01-20 07:04:12","vendor_id":"29","other_image":["https://developmentalphawizz.com/SOD_New//uploads/product_images/"],"product_status":"0","variant_name":"","product_type":"","category_name":"south indian","subcategory_name":"Plumber"},{"product_id":"161","cat_id":"26","subcat_id":"28","product_name":"Paneer Tikka","product_description":"this is ne description","product_price":"200","product_image":"https://developmentalphawizz.com/SOD_New//uploads/product_images/63cba08027d55.jpg","pro_ratings":"0.0","role_id":"0","selling_price":"150","product_create_date":"2023-01-21 08:21:20","vendor_id":"29","other_image":["https://developmentalphawizz.com/SOD_New//uploads/product_images/"],"product_status":"1","variant_name":"Half Plate","product_type":"","category_name":"south indian","subcategory_name":"food"},{"product_id":"167","cat_id":"1","subcat_id":"7","product_name":"gjdhz","product_description":"xyzyxifig","product_price":"200","product_image":"https://developmentalphawizz.com/SOD_New//uploads/product_images/","pro_ratings":"0.0","role_id":"0","selling_price":"150","product_create_date":"2023-01-22 07:01:42","vendor_id":"29","other_image":["https://developmentalphawizz.com/SOD_New//uploads/product_images/"],"product_status":"0","variant_name":"Half Plate","product_type":"Veg","category_name":" fast Food","subcategory_name":"Junk food"}]

class GetProductsModel {
  GetProductsModel({
      String? status, 
      String? message, 
      List<Products>? products,}){
    _status = status;
    _message = message;
    _products = products;
}

  GetProductsModel.fromJson(dynamic json) {
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
GetProductsModel copyWith({  String? status,
  String? message,
  List<Products>? products,
}) => GetProductsModel(  status: status ?? _status,
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

/// product_id : "150"
/// cat_id : "1"
/// subcat_id : "4"
/// product_name : "New product"
/// product_description : "this is new description"
/// product_price : "200"
/// product_image : "https://developmentalphawizz.com/SOD_New//uploads/product_images/63ca41c335609.jpg"
/// pro_ratings : "0.0"
/// role_id : "0"
/// selling_price : "180"
/// product_create_date : "2023-01-20 06:32:03"
/// vendor_id : "29"
/// other_image : ["https://developmentalphawizz.com/SOD_New//uploads/product_images/"]
/// product_status : "0"
/// variant_name : ""
/// product_type : ""
/// category_name : " fast Food"
/// subcategory_name : "Plumber"

class Products {
  Products({
      String? productId, 
      String? catId, 
      String? subcatId, 
      String? productName, 
      String? productDescription, 
      String? productPrice, 
      String? productImage, 
      String? proRatings, 
      String? roleId, 
      String? sellingPrice, 
      String? productCreateDate, 
      String? vendorId, 
      List<String>? otherImage, 
      String? productStatus, 
      String? variantName, 
      String? productType, 
      String? categoryName, 
      String? subcategoryName,}){
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
    _productStatus = productStatus;
    _variantName = variantName;
    _productType = productType;
    _categoryName = categoryName;
    _subcategoryName = subcategoryName;
}

  Products.fromJson(dynamic json) {
    _productId = json['product_id'];
    _catId = json['cat_id'];
    _subcatId = json['subcat_id'];
    _productName = json['product_name'];
    _productDescription = json['product_description'];
    _productPrice = json['product_price'];
    _productImage = json['product_image'];
    _proRatings = json['pro_ratings'];
    _roleId = json['role_id'];
    _sellingPrice = json['selling_price'];
    _productCreateDate = json['product_create_date'];
    _vendorId = json['vendor_id'];
    _otherImage = json['other_image'] != null ? json['other_image'].cast<String>() : [];
    _productStatus = json['product_status'];
    _variantName = json['variant_name'];
    _productType = json['product_type'];
    _categoryName = json['category_name'];
    _subcategoryName = json['subcategory_name'];
  }
  String? _productId;
  String? _catId;
  String? _subcatId;
  String? _productName;
  String? _productDescription;
  String? _productPrice;
  String? _productImage;
  String? _proRatings;
  String? _roleId;
  String? _sellingPrice;
  String? _productCreateDate;
  String? _vendorId;
  List<String>? _otherImage;
  String? _productStatus;
  String? _variantName;
  String? _productType;
  String? _categoryName;
  String? _subcategoryName;
Products copyWith({  String? productId,
  String? catId,
  String? subcatId,
  String? productName,
  String? productDescription,
  String? productPrice,
  String? productImage,
  String? proRatings,
  String? roleId,
  String? sellingPrice,
  String? productCreateDate,
  String? vendorId,
  List<String>? otherImage,
  String? productStatus,
  String? variantName,
  String? productType,
  String? categoryName,
  String? subcategoryName,
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
  productStatus: productStatus ?? _productStatus,
  variantName: variantName ?? _variantName,
  productType: productType ?? _productType,
  categoryName: categoryName ?? _categoryName,
  subcategoryName: subcategoryName ?? _subcategoryName,
);
  String? get productId => _productId;
  String? get catId => _catId;
  String? get subcatId => _subcatId;
  String? get productName => _productName;
  String? get productDescription => _productDescription;
  String? get productPrice => _productPrice;
  String? get productImage => _productImage;
  String? get proRatings => _proRatings;
  String? get roleId => _roleId;
  String? get sellingPrice => _sellingPrice;
  String? get productCreateDate => _productCreateDate;
  String? get vendorId => _vendorId;
  List<String>? get otherImage => _otherImage;
  String? get productStatus => _productStatus;
  String? get variantName => _variantName;
  String? get productType => _productType;
  String? get categoryName => _categoryName;
  String? get subcategoryName => _subcategoryName;

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
    map['product_status'] = _productStatus;
    map['variant_name'] = _variantName;
    map['product_type'] = _productType;
    map['category_name'] = _categoryName;
    map['subcategory_name'] = _subcategoryName;
    return map;
  }

}