class OrderDetails {
  int? id;
  String? product;
  int? productPrice;
  String? voucher;
  int? voucherPrice;
  int? price;
  int? quantity;
  int? amount;
  int? discount;
  String? createdAt;
  String? updatedAt;

  OrderDetails(
      {this.id,
        this.product,
        this.productPrice,
        this.voucher,
        this.voucherPrice,
        this.price,
        this.quantity,
        this.amount,
        this.discount,
        this.createdAt,
        this.updatedAt});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    productPrice = json['product_price'];
    voucher = json['voucher'];
    voucherPrice = json['voucher_price'];
    price = json['price'];
    quantity = json['quantity'];
    amount = json['amount'];
    discount = json['discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product'] = this.product;
    data['product_price'] = this.productPrice;
    data['voucher'] = this.voucher;
    data['voucher_price'] = this.voucherPrice;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['discount'] = this.discount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}