
import 'package:fixerking/api/api_path.dart';

class SectionModel {
  var id,
      title,
      varientId,
      qty,
      productId,
      perItemTotal,
      perItemPrice,
      style,
      shortDesc;
  List<Product>? productList;
  List<Promo>? promoList;
  List<Filter>? filterList;
  List<String>? selectedId = [];
  int? offset, totalItem;

  SectionModel(
      {this.id,
      this.title,
      this.shortDesc,
      this.productList,
      this.varientId,
      this.qty,
      this.productId,
      this.perItemTotal,
      this.perItemPrice,
      this.style,
      this.totalItem,
      this.offset,
      this.selectedId,
      this.filterList,
      this.promoList});

  factory SectionModel.fromJson(Map<String, dynamic> parsedJson) {
    List<Product> productList = (parsedJson[PRODUCT_DETAIL] as List)
        .map((data) => new Product.fromJson(data))
        .toList();

    var flist = (parsedJson[FILTERS] as List?);
    List<Filter> filterList = [];
    if (flist == null || flist.isEmpty)
      filterList = [];
    else
      filterList = flist.map((data) => new Filter.fromJson(data)).toList();
    List<String> selected = [];
    return SectionModel(
        id: parsedJson[ID],
        title: parsedJson[TITLE],
        shortDesc: parsedJson[SHORT_DESC],
        style: parsedJson[STYLE],
        productList: productList,
        offset: 0,
        totalItem: 0,
        filterList: filterList,
        selectedId: selected);
  }

  factory SectionModel.fromCart(Map<String, dynamic> parsedJson) {
    List<Product> productList = (parsedJson[PRODUCT_DETAIL] as List)
        .map((data) => new Product.fromJson(data))
        .toList();

    return SectionModel(
      id: parsedJson[ID],
      varientId: parsedJson[PRODUCT_VARIENT_ID],
      qty: parsedJson[QTY],
      perItemTotal: "0",
      perItemPrice: "0",
      productList: productList,
    );
  }

  factory SectionModel.fromFav(Map<String, dynamic> parsedJson) {
    List<Product> productList = (parsedJson[PRODUCT_DETAIL] as List)
        .map((data) => new Product.fromJson(data))
        .toList();

    return SectionModel(
        id: parsedJson[ID],
        productId: parsedJson[PRODUCT_ID],
        productList: productList);
  }
}

class Product {
  String? id,
      name,
      desc,
      next_available_text,
      image,
      catName,
      type,
      rating,
      noOfRating,
      attrIds,
      tax,
      categoryId,
      sub_category_id,
      shortDescription,
      time_left,
      qtyStepSize;
  List<String>? itemsCounter;
  List<String>? otherImage;
  List<Product_Varient>? prVarientList;
  List<Attribute>? attributeList;
  List<String>? selectedId = [];
  List<String>? tagList = [];
  int? minOrderQuntity;
  Map? min_max_price;
  String? isFav,
      isReturnable,
      isCancelable,
      isPurchased,
      availability,
      product_time,
      madein,
      indicator,
      stockType,
      cancleTill,
      total,
      banner,
      totalAllow,
      totalSpecialPrice,
      video,
      videType,
      warranty,
      gurantee,
  breakfast_start_product_time,
      breakfast_end_product_time,
      lunch_start_product_time,
      lunch_end_product_time,
  dinner_start_product_time,
  dinner_end_product_time,quantity_step_size;

  String? minPrice, maxPrice;
  String? totalImg;
  // List<ReviewImg>? reviewList;

  bool? isFavLoading = false, isFromProd = false;
  int? offset, totalItem, selVarient;

  List<Product>? subList;
  List<Filter>? filterList;
  bool? history = false;
  String? store_description,
      seller_rating,
      seller_profile,
      seller_name,
      seller_id,
      store_name,
      estimated_time,
      food_person,
      open_close_status,
      address,
      coverImage,veg_nonveg;
  String? packing_charge;
  String? home_cat;
  String? km;
  // String historyList;

  Product(
      {this.id,
      this.name,
        this.min_max_price,
        this.sub_category_id,
        this.next_available_text,
      this.desc,
        this.time_left,
      this.image,
      this.catName,
        this.quantity_step_size,
      this.type,
      this.otherImage,
      this.prVarientList,
      this.attributeList,
      this.isFav,
        this.home_cat,
      this.isCancelable,
      this.isReturnable,
      this.isPurchased,
      this.availability,
      this.noOfRating,
      this.attrIds,
      this.selectedId,
      this.rating,
      this.isFavLoading,
      this.indicator,
      this.madein,
        this.product_time,
      this.tax,
      this.shortDescription,
      this.total,
      this.categoryId,
      this.subList,
      this.filterList,
      this.stockType,
      this.isFromProd,
      this.cancleTill,
      this.totalItem,
      this.offset,
      this.totalAllow,
        this.totalSpecialPrice,
      this.banner,
      this.selVarient,
      this.video,
      this.videType,
      this.tagList,
      this.warranty,
      this.qtyStepSize,
      this.minOrderQuntity,
      this.itemsCounter,
      // this.reviewList,
      this.history,
      this.minPrice,
      this.maxPrice,
      //  this.historyList,
      this.gurantee,
      this.store_description,
      this.seller_rating,
      this.seller_profile,
      this.seller_name,
      this.seller_id,
      this.store_name,
      this.estimated_time,
      this.food_person,
      this.open_close_status,
      this.address,
        this.packing_charge,
        this.breakfast_end_product_time,
        this.breakfast_start_product_time,
        this.lunch_end_product_time,
        this.lunch_start_product_time,
        this.dinner_end_product_time,
        this.dinner_start_product_time,
        this.veg_nonveg,
        this.km,
      });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<Product_Varient> varientList = (json[PRODUCT_VARIENT] as List)
        .map((data) => new Product_Varient.fromJson(data))
        .toList();

    List<Attribute> attList = (json[ATTRIBUTES] as List)
        .map((data) => new Attribute.fromJson(data))
        .toList();

    var flist = (json[FILTERS] as List?);
    List<Filter> filterList = [];
    if (flist == null || flist.isEmpty)
      filterList = [];
    else
      filterList = flist.map((data) => new Filter.fromJson(data)).toList();

    List<String> other_image = List<String>.from(json[OTHER_IMAGE]);
    List<String> selected = [];

    List<String> tags = List<String>.from(json[TAG]);

    List<String> items = new List<String>.generate(
        json[TOTALALOOW] != null ? int.parse(json[TOTALALOOW]) : 10, (i) {
      return ((i + 1) * int.parse(json[QTYSTEP])).toString();
    });

    var reviewImg = (json[REV_IMG] as List?);
    // List<ReviewImg> reviewList = [];
    // if (reviewImg == null || reviewImg.isEmpty)
    //   reviewList = [];
    // else
    //   reviewList =
    //       reviewImg.map((data) => new ReviewImg.fromJson(data)).toList();

    return new Product(
      id: json[ID],
      name: json[NAME],
      desc: json[DESC],
      image: json[IMAGE],
      catName: json[CAT_NAME],
      sub_category_id: json['sub_category_id'],
      rating: json[RATING],
      min_max_price: json['min_max_price'],
      next_available_text: json['next_available_text'],
        quantity_step_size: json['quantity_step_size'],
      noOfRating: json[NO_OF_RATE],
      type: json[TYPE],
      time_left: json['time_left'],
      isFav: json[FAV].toString(),
      isCancelable: json[ISCANCLEABLE],
      availability: json[AVAILABILITY].toString(),
      isPurchased: json[ISPURCHASED].toString(),
      isReturnable: json[ISRETURNABLE],
      otherImage: other_image,
      prVarientList: varientList,
      attributeList: attList,
      filterList: filterList,
      isFavLoading: false,
      selVarient: 0,
      attrIds: json[ATTR_VALUE],
      madein: json[MADEIN],
      product_time: json["product_time"],
      shortDescription: json[SHORT],
      indicator: json[INDICATOR].toString(),
      stockType: json[STOCKTYPE].toString(),
      tax: json[TAX_PER],
      total: json[TOTAL],
      categoryId: json[CATID],
      selectedId: selected,
      totalAllow: json[TOTALALOOW],
      totalSpecialPrice: json[TOTALSPECIALPRICE].toString(),
      cancleTill: json[CANCLE_TILL],
      video: json[VIDEO],
      videType: json[VIDEO_TYPE],
      tagList: tags,
      itemsCounter: items,
      warranty: json[WARRANTY],
      minOrderQuntity: int.parse(json[MINORDERQTY]),
      qtyStepSize: json[QTYSTEP],
      gurantee: json[GAURANTEE],
      // reviewList: reviewList,
      history: false,
      minPrice: json[MINPRICE],
      maxPrice: json[MAXPRICE],
      seller_name: json[SELLER_NAME],
      seller_profile: json[SELLER_PROFILE],
      seller_rating: json[SELLER_RATING],
      store_description: json[STORE_DESC],
      store_name: json[STORE_NAME],
      seller_id: json[SELLER_ID],
      estimated_time: json["estimated_time"],
      food_person: json["food_person"],
      address: json["address"],
      open_close_status: json["open_close_status"],
      packing_charge: json["packing_charge"],
      breakfast_start_product_time: json["breakfast_start_product_time"],
      breakfast_end_product_time: json["breakfast_end_product_time"],
      lunch_start_product_time: json["lunch_start_product_time"],
      lunch_end_product_time: json["lunch_end_product_time"],
      dinner_start_product_time: json["dinner_start_product_time"],
      dinner_end_product_time: json["dinner_end_product_time"]

      // totalImg: tImg,
      // totalReviewImg: json[REV_IMG][TOTALIMGREVIEW],
      // productRating: reviewList
    );
  }

  factory Product.all(String name, String img, cat) {
    return new Product(name: name, catName: cat, image: img, history: false);
  }

  factory Product.history(String history) {
    return new Product(name: history, history: true);
  }

  factory Product.fromSeller(Map<String, dynamic> json) {
    return new Product(
      seller_name: json[SELLER_NAME],
      seller_profile: json[SELLER_PROFILE],
      seller_rating: json[SELLER_RATING],
      store_description: json[STORE_DESC],
      store_name: json[STORE_NAME],
      seller_id: json[SELLER_ID],
      estimated_time: json["estimated_time"],
      food_person: json["food_person"],
      address: json["address"],
      open_close_status: json["open_close_status"],
      veg_nonveg: json["veg_nonveg"],
      km : json['distance'],
    );
  }

  factory Product.fromCat(Map<String, dynamic> parsedJson) {
   // print(parsedJson['home_cat']);
    return new Product(
      id: parsedJson[ID],
      name: parsedJson[NAME],
      image: parsedJson[IMAGE],
      banner: parsedJson[BANNER],
      home_cat: parsedJson['home_cat'],
      isFromProd: false,
      offset: 0,
      totalItem: 0,
      tax: parsedJson[TAX],
      subList: createSubList(parsedJson["children"]),
    );
  }

  factory Product.popular(String name, String image) {
    return new Product(name: name, image: image);
  }

  static List<Product>? createSubList(List? parsedJson) {
    if (parsedJson == null || parsedJson.isEmpty) return null;

    return parsedJson.map((data) => new Product.fromCat(data)).toList();
  }
}

class Product_Varient {
  String? id,
      productId,
      attribute_value_ids,
      price,
      disPrice,
      type,
      attr_name,
      varient_value,
      availability,
      cartCount;
  List<String>? images;

  Product_Varient(
      {this.id,
      this.productId,
      this.attr_name,
      this.varient_value,
      this.price,
      this.disPrice,
      this.attribute_value_ids,
      this.availability,
      this.cartCount,
      this.images});

  factory Product_Varient.fromJson(Map<String, dynamic> json) {
    List<String> images = List<String>.from(json[IMAGES]);

    return new Product_Varient(
        id: json[ID],
        attribute_value_ids: json[ATTRIBUTE_VALUE_ID],
        productId: json[PRODUCT_ID],
        attr_name: json[ATTR_NAME],
        varient_value: json[VARIENT_VALUE],
        disPrice: json[DIS_PRICE],
        price: json[PRICE],
        availability: json[AVAILABILITY].toString(),
        cartCount: json[CART_COUNT],
        images: images);
  }
}

class Attribute {
  String? id, value, name, sType, sValue;

  Attribute({this.id, this.value, this.name, this.sType, this.sValue});

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return new Attribute(
        id: json[IDS],
        name: json[NAME],
        value: json[VALUE],
        sType: json[STYPE],
        sValue: json[SVALUE]);
  }
}

class Filter {
  String? attributeValues, attributeValId, name, swatchType, swatchValue;

  Filter(
      {this.attributeValues,
      this.attributeValId,
      this.name,
      this.swatchType,
      this.swatchValue});

  factory Filter.fromJson(Map<String, dynamic> json) {
    return new Filter(
        attributeValId: json[ATT_VAL_ID],
        name: json[NAME],
        attributeValues: json[ATT_VAL],
        swatchType: json[STYPE],
        swatchValue: json[SVALUE]);
  }
}

// class ReviewImg {
//   String? totalImg;
//   List<User>? productRating;
//
//   ReviewImg({this.totalImg, this.productRating});
//
//   factory ReviewImg.fromJson(Map<String, dynamic> json) {
//     var reviewImg = (json[PRODUCTRATING] as List?);
//     List<User> reviewList = [];
//     if (reviewImg == null || reviewImg.isEmpty)
//       reviewList = [];
//     else
//       reviewList = reviewImg.map((data) => new User.forReview(data)).toList();
//
//     return new ReviewImg(totalImg: json[TOTALIMG], productRating: reviewList);
//   }
// }

class Promo {
  String? id, promoCode, msg, image, day;

  Promo({this.id, this.promoCode, this.msg, this.image, this.day});

  factory Promo.fromJson(Map<String, dynamic> json) {
    return new Promo(
        id: json[ID],
        promoCode: json[PROMO_CODE],
        msg: json[MESSAGE],
        image: json[IMAGE],
        day: json[REMAIN_DAY]);
  }
}
