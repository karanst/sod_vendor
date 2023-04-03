class Apipath {

  static const String BASH_URL =
      "https://sodindia.com/api/";
      // "https://developmentalphawizz.com/SOD_New/api/";
      //"https://developmentalphawizz.com/new_ondemand/api/";
      //"https://alphawizztest.tk/ondemand/api/";
      static const String imagePath =
          //"https://sodindia.com/api/";
          "https://developmentalphawizz.com/SOD_New/";
      //"https://developmentalphawizz.com/new_ondemand/api/";


  static const String phone_login = BASH_URL + 'login_with_contact_vendor';
  static const String forgot_password = BASH_URL + 'vendor_forgot_pass';
  static const String get_vebdor_profile = BASH_URL + 'vendor_data';

  static const String addMoneyToWallet = BASH_URL + 'add_wallet';

  static const String get_services_type = BASH_URL + 'getservices';
  // static const String specilization_list = BASH_URL + 'get_service_type_specilization';
  static const String specilization_list = BASH_URL + 'get_service_subcategory';
  static const String sign_up = BASH_URL + 'vendor_register';
  static const String get_new_order = BASH_URL + 'get_bookings';
  static const String get_service_subCategory = BASH_URL + 'get_service_subcategory';
  static const String accept_reject_booking_status = BASH_URL + 'accept_booking';
  static const String booking_status_change_by_vendor = BASH_URL + 'booking_status_change_by_vendor';
  static const String completed_Work = BASH_URL + 'Completed_Work';
  static const String changePassword = BASH_URL + 'change_password';
  static const String notification = BASH_URL + 'order_notification_listing';
      //'vendor_notification_listing';
  static const String customer_support = BASH_URL + 'support';
  static const String get_faq = BASH_URL + 'get_faq';
  static const String payment_history = BASH_URL + 'get_payment_history';
  static const String get_payment_total = BASH_URL + 'get_payment_total';
  static const String request_for_payment = BASH_URL + 'request_send';
  static const String i_am_online = BASH_URL + 'change_status';
  static const String get_service_profile = BASH_URL + 'get_service_profile';
  static const String update_service_profile = BASH_URL + 'update_service_profile';
  static const String deliveryRegistrationUrl = BASH_URL + 'delivery_registeration';
  static const String labourRegistrationUrl = BASH_URL + 'labour_registeration';

  static const String updateFcmTokenUrl = BASH_URL + 'update_fcm_id';

  static const String getLabourRequest = BASH_URL + 'my_labour_requests';
  static const String getNearestDeliveryRequest = BASH_URL + 'nearest_request';
  static const String getDeliveryRequest = BASH_URL + 'my_labour_requests/delivery';
  static const String acceptRejectLabourUrl = BASH_URL + 'accept_labour_request';
  static const String acceptRejectDeliveryUrl = BASH_URL + 'accept_delivery_request';

///New Urls
  static const String vendorRegistrationUrl = BASH_URL + 'vendor_registration';
  static const String sendOtpUrl = BASH_URL + 'v_send_otp';
  static const String verifyOtpUrl = BASH_URL + 'v_verify_otp';
  static const String email_login = BASH_URL + 'vendor_login';
  static const String getProfileApi = BASH_URL + 'get_v_res';
  static const String accountDelete = BASH_URL + 'account_delete';

  static const String getVendorProducts = BASH_URL +'get_vendor_products';
  static const String getServicesUrl = BASH_URL +'get_vendor_services';

  static const String getVendorOrders = BASH_URL +'get_vendors_orders';
  static const String getBanners = BASH_URL +'get_all_banners';
  static const String profileUrl = BASH_URL + 'vendor_login';
  static const String getBannersUrls = BASH_URL +'get_all_banners';
  static const String buyVendorProductUrl = BASH_URL +'get_all_products_vendor';
  static const String getCategoriesUrl = BASH_URL +'get_vendor_categories_list';
  static const String getFoodVariantsUrl = BASH_URL +'get_varinat_product';
  static const String editProfile = BASH_URL + 'vendor_edit';

  static const String addProductUrl = BASH_URL +'add_product';
  static const String addServicesUrl = BASH_URL +'add_services';

  static const String editProductUrl = BASH_URL +'update_product_id';
  static const String editServicesUrl = BASH_URL +'udpate_vendor_services';

  static const String deleteProductUrl = BASH_URL +'delete_product';
  static const String deleteServicesUrl = BASH_URL +'delete_service';


  static const String getCitiesUrl = BASH_URL +'get_cities';
  static const String getEventCatUrl = BASH_URL +'get_categories_list';

  static const String getServiceBookingUrl = BASH_URL +'get_booking_by_vendor';
  static const String getDeliveryBooking = BASH_URL +'get_todayride';
  static const String getRideDeliveryBooking = BASH_URL +'get_booking_by_id';
  static const String getFoodDeliveryBooking = BASH_URL +'get_orders_id';
  static const String getFoodDeliveryOrdersUrl = BASH_URL +'get_vendors_orders1';
  static const String updateParcelStatusUrl = BASH_URL +'update_parcel_status';

  static const String acceptRejectFoodStatus = BASH_URL +'update_order_status';
  static const String acceptRejectDeliveryStatus = BASH_URL +'accept_reject_booking';
  static const String acceptRejectServiceStatus = BASH_URL +'update_booking_status';
  static const String onOffUrl = BASH_URL + 'update_vendor_status';
  static const String accRejFoodDeliveryUrl = BASH_URL +'driver_accept_reject_status';
  static const String completeRideUrl = BASH_URL +'complete_ride_booking';

  static const String getFoodReviewUrl = BASH_URL + 'get_review_by_customer';
  static const String getWalletTransUrl = BASH_URL + 'get_wallet_transactions';

  static const String getTicketsTypeApi = BASH_URL + 'get_ticket_types';
  static const String getTicketsApi = BASH_URL + 'get_tickets';
  static const String editTicketApi = BASH_URL + 'edit_ticket';
  static const String addTicketApi = BASH_URL + 'add_ticket';
  static const String sendMsgApi = BASH_URL + 'send_message';
  static const String getMsgApi = BASH_URL + 'get_messages';

  static const String checkOutVendorApi = BASH_URL + 'checkout_vendor';

  static const String getSettings = BASH_URL + 'general_setting';

  static const String getWalletHistory = BASH_URL + 'withdrawl_list';
  static const String withdrawRequestUrl = BASH_URL + 'withdrawl_request';

  static const String forgetPassUrl = BASH_URL + 'forgot_pass_vendor';



}

const String ID = 'id';
const String TYPE = 'type';
const String TYPE_ID = 'type_id';
const String IMAGE = 'image';
const String IMGS = 'images[]';
const String ATTACH = 'attachments[]';
const String NAME = 'name';
const String SUBTITLE = 'subtitle';
const String TAX = 'tax';
const String SLUG = 'slug';
const String TITLE = 'title';
const String PRODUCT_DETAIL = 'product_details';
const String DESC = 'description';
const String SUB = 'subject';
const String CATID = 'category_id';
const String CAT_NAME = 'category_name';
const String OTHER_IMAGE = 'other_images_md';
const String PRODUCT_VARIENT = 'variants';
const String PRODUCT_ID = 'product_id';
const String VARIANT_ID = 'variant_id';
const String IS_DELIVERABLE = 'is_deliverable';
const String MONEY_TYPE = '₹';

const String ZIPCODE = 'zipcode';
const String PRICE = 'price';
const String MEASUREMENT = 'measurement';
const String MEAS_UNIT_ID = 'measurement_unit_id';
const String SERVE_FOR = 'serve_for';
const String SHORT_CODE = 'short_code';
const String STOCK = 'stock';
const String STOCK_UNIT_ID = 'stock_unit_id';
const String DIS_PRICE = 'special_price';
const String CURRENCY = 'currency';
const String SUB_ID = 'subcategory_id';
const String SORT = 'sort';
const String PSORT = 'p_sort';
const String ORDER = 'order';
const String SUB_CAT_ID = 'sub_category_id';
const String PORDER = 'p_order';
const String DEL_CHARGES = 'delivery_charges';
const String FREE_AMT = 'minimum_free_delivery_order_amount';

const String LIMIT = 'limit';
const String OFFSET = 'offset';
const String PRIVACY_POLLICY = 'privacy_policy';
const String TERM_COND = 'terms_conditions';
const String CONTACT_US = 'contact_us';
const String ABOUT_US = 'about_us';
const String BANNER = 'banner';
const String CAT_FILTER = 'has_child_or_item';
const String PRODUCT_FILTER = 'has_empty_products';
const String RATING = 'rating';
const String IDS = 'ids';
const String VALUE = 'value';
const String ATTRIBUTES = 'attributes';
const String ATTRIBUTE_VALUE_ID = 'attribute_value_ids';
const String IMAGES = 'images';
const String NO_OF_RATE = 'no_of_ratings';
const String ATTR_NAME = 'attr_name';
const String VARIENT_VALUE = 'variant_values';
const String COMMENT = 'comment';
const String MESSAGE = 'message';
const String DATE = 'date_sent';
const String TRN_DATE = 'transaction_date';
const String SEARCH = 'search';
const String PAYMENT_METHOD = 'payment_method';
const String ISWALLETBALUSED = "is_wallet_used";
const String WALLET_BAL_USED = 'wallet_balance_used';
const String USERDATA = 'user_data';
const String DATE_ADDED = 'date_added';
const String ORDER_ITEMS = 'order_items';
const String TOP_RETAED = 'top_rated_product';
const String WALLET = 'wallet';
const String CREDIT = 'credit';
const String REV_IMG = 'review_images';
const String NO_SELLER_FOUND = "Oops, We are unserviceable at your location. We will be there soon. Stick around.";

const String USER_NAME = 'user_name';
const String USERNAME = 'username';
const String ADDRESS = 'address';
const String EMAIL = 'email';
const String MOBILE = 'mobile';
const String CITY = 'city';
const String DOB = 'dob';
const String AREA = 'area';
const String PASSWORD = 'password';
const String STREET = 'street';
const String PINCODE = 'pincode';
const String FCM_ID = 'fcm_id';
const String LATITUDE = 'latitude';
const String LONGITUDE = 'longitude';
const String USER_ID = 'user_id';
const String FAV = 'is_favorite';
const String ISRETURNABLE = 'is_returnable';
const String ISCANCLEABLE = 'is_cancelable';
const String ISPURCHASED = 'is_purchased';
const String ISOUTOFSTOCK = 'out_of_stock';
const String PRODUCT_VARIENT_ID = 'product_variant_id';
const String QTY = 'qty';
const String CART_COUNT = 'cart_count';
const String DEL_CHARGE = 'delivery_charge';
const String EXTRA_DEL_CHARGE = 'extra_delivery_charge';
const String SUB_TOTAL = 'sub_total';
const String TAX_AMT = 'tax_amount';
const String TAX_PER = 'tax_percentage';
const String CANCLE_TILL = 'cancelable_till';
const String ALT_MOBNO = 'alternate_mobile';
const String STATE = 'state';
const String COUNTRY = 'country';
const String ISDEFAULT = 'is_default';
const String LANDMARK = 'landmark';
const String CITY_ID = 'city_id';
const String AREA_ID = 'area_id';
const String HOME = 'Home';
const String OFFICE = 'Office';
const String OTHER = 'Other';
const String FINAL_TOTAL = 'final_total';
const String PROMOCODE = 'promo_code';
const String NEWPASS = 'new';
const String OLDPASS = 'old';
const String MOBILENO = 'mobile_no';
const String DELIVERY_TIME = 'delivery_time';
const String DELIVERY_DATE = 'delivery_date';
const String QUANTITY = "quantity";
const String PROMO_DIS = 'promo_discount';
const String WAL_BAL = 'wallet_balance';
const String TOTAL = 'total';
const String TOTAL_PAYABLE = 'total_payable';
const String STATUS = 'status';
const String TOTAL_TAX_PER = 'total_tax_percent';
const String TOTAL_TAX_AMT = 'total_tax_amount';
const String PRODUCT_LIMIT = "p_limit";
const String PRODUCT_OFFSET = "p_offset";
const String SEC_ID = 'section_id';
const String COUNTRY_CODE = 'country_code';
const String ATTR_VALUE = 'attr_value_ids';
const String MSG = 'message';
const String ORDER_ID = 'order_id';
const String IS_SIMILAR = 'is_similar_products';
const String ALL = 'all';

///Status
const String PLACED = 'received';
const String CONFIRMED = 'confirmed';
const String ASSIGN = 'assign';
const String ARRIVED = 'arrived';
const String PICKED = 'picked up';

const String SHIPED = 'shipped';
const String PROCESSED = 'processed';
const String DELIVERD = 'delivered';
const String CANCLED = 'cancelled';
const String RETURNED = 'returned';
const String awaitingPayment = 'Awaiting Payment';
const String ITEM_RETURN = 'Item Return';
const String ITEM_CANCEL = 'Item Cancel';
const String ADD_ID = 'address_id';
const String STYLE = 'style';
const String SHORT_DESC = 'short_description';
const String DEFAULT = 'default';
const String STYLE1 = 'style_1';
const String STYLE2 = 'style_2';
const String STYLE3 = 'style_3';
const String STYLE4 = 'style_4';
const String ORDERID = 'order_id';
const String OTP = "otp";
const String TRACKING_ID = "tracking_id";
const String TRACKING_URL = "url";
const String COURIER_AGENCY = "courier_agency";
const String DELIVERY_BOY_ID = 'delivery_boy_id';
const String ISALRCANCLE = 'is_already_cancelled';
const String ISALRRETURN = 'is_already_returned';
const String ISRTNREQSUBMITTED = 'return_request_submitted';
const String OVERALL = 'overall_amount';
const String AVAILABILITY = 'availability';
const String MADEIN = 'made_in';
const String INDICATOR = 'indicator';
const String STOCKTYPE = 'stock_type';
const String SAVE_LATER = 'is_saved_for_later';
const String ATT_VAL = 'attribute_values';
const String ATT_VAL_ID = 'attribute_values_id';
const String FILTERS = 'filters';
const String TOTALALOOW = 'total_allowed_quantity';
const String TOTALSPECIALPRICE = 'total_special_price';
const String KEY = 'key';
const String AMOUNT = 'amount';
const String CONTACT = 'contact';
const String TXNID = 'txn_id';
const String SUCCESS = 'Success';
const String ACTIVE_STATUS = 'active_status';
const String WAITING = 'awaiting';
const String TRANS_TYPE = 'transaction_type';
const String QUESTION = "question";
const String ANSWER = "answer";
const String INVOICE = "invoice_html";
const String APP_THEME = "App Theme";
const String SHORT = "short_description";
const String FROMTIME = 'from_time';
const String TOTIME = 'last_order_time';
const String REFERCODE = 'referral_code';
const String FRNDCODE = 'friends_code';
const String VIDEO = 'video';
const String VIDEO_TYPE = 'video_type';
const String WARRANTY = 'warranty_period';
const String GAURANTEE = "guarantee_period";
const String TAG = 'tags';
const String CITYNAME = "cityName";
const String AREANAME = "areaName";
const String LAGUAGE_CODE = 'languageCode';
const String MINORDERQTY = 'minimum_order_quantity';
const String QTYSTEP = 'quantity_step_size';
const String DEL_DATE = 'delivery_date';
const String DEL_TIME = 'delivery_time';
const String TOTALIMG = 'total_images';
const String TOTALIMGREVIEW = 'total_reviews_with_images';
const String PRODUCTRATING = 'product_rating';
const String TICKET_TYPE = 'ticket_type_id';
const String DATE_CREATED = 'date_created';
const String DEFAULT_SYSTEM = "System default";
const String LIGHT = "Light";
const String DARK = "Dark";
const String TIC_TYPE = 'ticket_type';
const String TICKET_ID = 'ticket_id';
const String USER_TYPE = 'user_type';
const String USER = 'user';
const String MEDIA = 'media';
const String ICON = 'type';
const String STYPE = 'swatche_type';
const String SVALUE = 'swatche_value';

const String MINPRICE = 'min_price';
const String MAXPRICE = 'max_price';
const String ZIPCODEID = 'zipcode_id';
const String PROMO_CODE = 'promo_code';
const String REMAIN_DAY = 'remaining_day';
const String PROMO_CODES = 'promo_codes';
const String DISCOUNT = 'discount';
const String ORDER_NOTE = 'order_note';

const String SELLER_ID = 'seller_id';
const String SELLER_NAME = 'seller_name';
const String SELLER_PROFILE = 'seller_profile';
const String SELLER_RATING = 'seller_rating';
const String STORE_DESC = 'store_description';
const String STORE_NAME = 'store_name';

const String MIN_CART_AMT = 'minimum_cart_amt';

const String ATTACHMENTS = 'attachments';

const String ATTACHMENT = 'attachment';
const String BANK_STATUS = 'banktransfer_status';
const String mylatitude = 'mylatitude';
const String mylongitude = 'mylongitude';
const String sellerlatitude = 'sellerlatitude';
const String sellerlongitude = 'sellerlongitude';
const String cartAmount = 'cartAmount';
const String sellerName = 'sellerName';
const String sellerProfile = 'sellerProfile';
String ISDARK = "";

String? CUR_CURRENCY = '';

String? CUR_USERID;

String? RETURN_DAYS = '';
String? MAX_ITEMS = '';
String? REFER_CODE = '';
String? MIN_AMT = '';
String? CUR_DEL_CHR = '';
String? MIN_ALLOW_CART_AMT = '';
String? MAX_AMOUNT = '0';
String? GST_SERVICE_CHARGES = '';
String? msgRain;
String? CUR_TICK_ID = '';

bool ISFLAT_DEL = true;
bool extendImg = true;
bool cartBtnList = true;
bool refer = true;

double? deviceHeight;
double? deviceWidth;
