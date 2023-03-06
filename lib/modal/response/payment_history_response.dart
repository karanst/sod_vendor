class PaymentHistoryResponse {
  String? responseCode;
  String? message;
  String? status;
  List<Data>? data;

  PaymentHistoryResponse(
      {this.responseCode, this.message, this.status, this.data});

  PaymentHistoryResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? orderId;
  String? userId;
  String? total;
  String? items;
  String? paymentMode;
  String? address;
  String? number;
  String? date;
  String? datea;
  String? txnId;
  String? pStatus;
  String? pDate;
  String? orderStatus;
  String? productId;
  String? qty;
  String? price;

  Data(
      {this.id,
      this.orderId,
      this.userId,
      this.total,
      this.items,
      this.paymentMode,
      this.address,
      this.number,
      this.date,
      this.datea,
      this.txnId,
      this.pStatus,
      this.pDate,
      this.orderStatus,
      this.productId,
      this.qty,
      this.price});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    total = json['total'];
    items = json['items'];
    paymentMode = json['payment_mode'];
    address = json['address'];
    number = json['number'];
    date = json['date'];
    datea = json['datea'];
    txnId = json['txn_id'];
    pStatus = json['p_status'];
    pDate = json['p_date'];
    orderStatus = json['order_status'];
    productId = json['product_id'];
    qty = json['qty'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['total'] = this.total;
    data['items'] = this.items;
    data['payment_mode'] = this.paymentMode;
    data['address'] = this.address;
    data['number'] = this.number;
    data['date'] = this.date;
    data['datea'] = this.datea;
    data['txn_id'] = this.txnId;
    data['p_status'] = this.pStatus;
    data['p_date'] = this.pDate;
    data['order_status'] = this.orderStatus;
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    return data;
  }
}
