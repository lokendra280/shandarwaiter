class TableModel {
  List<Tables>? tables;

  TableModel({this.tables});

  TableModel.fromJson(Map<String, dynamic> json) {
    if (json['tables'] != int) {
      tables = <Tables>[];
      json['tables'].forEach((v) {
        tables!.add(new Tables.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tables != int) {
      data['tables'] = this.tables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tables {
  int? id;
  int? number;
  int? capacity;
  int? branchId;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  List<Order>? order;

  Tables(
      {this.id,
      this.number,
      this.capacity,
      this.branchId,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.order});

  Tables.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    capacity = json['capacity'];
    branchId = json['branch_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['order'] != int) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['capacity'] = this.capacity;
    data['branch_id'] = this.branchId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.order != int) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? id;
  int? userId;
  int? orderAmount;
  int? couponDiscountAmount;
  int? couponDiscountTitle;
  String? paymentStatus;
  String? orderStatus;
  int? totalTaxAmount;
  int? paymentMethod;
  int? transactionReference;
  int? deliveryAddressId;
  String? createdAt;
  String? updatedAt;
  int? checked;
  int? deliveryManId;
  int? deliveryCharge;
  int? orderNote;
  int? couponCode;
  String? orderType;
  int? branchId;
  int? callback;
  String? deliveryDate;
  String? deliveryTime;
  String? extraDiscount;
  int? deliveryAddress;
  int? preparationTime;
  int? tableId;
  int? numberOfPeople;
  int? tableOrderId;

  Order(
      {this.id,
      this.userId,
      this.orderAmount,
      this.couponDiscountAmount,
      this.couponDiscountTitle,
      this.paymentStatus,
      this.orderStatus,
      this.totalTaxAmount,
      this.paymentMethod,
      this.transactionReference,
      this.deliveryAddressId,
      this.createdAt,
      this.updatedAt,
      this.checked,
      this.deliveryManId,
      this.deliveryCharge,
      this.orderNote,
      this.couponCode,
      this.orderType,
      this.branchId,
      this.callback,
      this.deliveryDate,
      this.deliveryTime,
      this.extraDiscount,
      this.deliveryAddress,
      this.preparationTime,
      this.tableId,
      this.numberOfPeople,
      this.tableOrderId});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderAmount = json['order_amount'];
    couponDiscountAmount = json['coupon_discount_amount'];
    couponDiscountTitle = json['coupon_discount_title'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    totalTaxAmount = json['total_tax_amount'];
    paymentMethod = json['payment_method'];
    transactionReference = json['transaction_reference'];
    deliveryAddressId = json['delivery_address_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    checked = json['checked'];
    deliveryManId = json['delivery_man_id'];
    deliveryCharge = json['delivery_charge'];
    orderNote = json['order_note'];
    couponCode = json['coupon_code'];
    orderType = json['order_type'];
    branchId = json['branch_id'];
    callback = json['callback'];
    deliveryDate = json['delivery_date'];
    deliveryTime = json['delivery_time'];
    extraDiscount = json['extra_discount'];
    deliveryAddress = json['delivery_address'];
    preparationTime = json['preparation_time'];
    tableId = json['table_id'];
    numberOfPeople = json['number_of_people'];
    tableOrderId = json['table_order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_amount'] = this.orderAmount;
    data['coupon_discount_amount'] = this.couponDiscountAmount;
    data['coupon_discount_title'] = this.couponDiscountTitle;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['total_tax_amount'] = this.totalTaxAmount;
    data['payment_method'] = this.paymentMethod;
    data['transaction_reference'] = this.transactionReference;
    data['delivery_address_id'] = this.deliveryAddressId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['checked'] = this.checked;
    data['delivery_man_id'] = this.deliveryManId;
    data['delivery_charge'] = this.deliveryCharge;
    data['order_note'] = this.orderNote;
    data['coupon_code'] = this.couponCode;
    data['order_type'] = this.orderType;
    data['branch_id'] = this.branchId;
    data['callback'] = this.callback;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_time'] = this.deliveryTime;
    data['extra_discount'] = this.extraDiscount;
    data['delivery_address'] = this.deliveryAddress;
    data['preparation_time'] = this.preparationTime;
    data['table_id'] = this.tableId;
    data['number_of_people'] = this.numberOfPeople;
    data['table_order_id'] = this.tableOrderId;
    return data;
  }
}
