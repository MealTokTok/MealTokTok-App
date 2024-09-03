import 'package:hankkitoktok/models/base_model.dart';

class Pending extends BaseModel {
  final int pending;

  Pending({
    required this.pending,
  });

  factory Pending.fromJson(Map<String, dynamic> json) {
    return Pending(
      pending: json['pending'] ?? 0,
    );
  }

  @override
  Pending fromMap(Map<String, dynamic> map) {
    return Pending.fromJson(map);
  }

  Map<String, dynamic> toJson() {
    return {
      'pending': pending,
    };
  }
}

class DeliveryRequested extends BaseModel {
  final int deliveryRequested;

  DeliveryRequested({
    required this.deliveryRequested,
  });

  factory DeliveryRequested.fromJson(Map<String, dynamic> json) {
    return DeliveryRequested(
      deliveryRequested: json['deliveryRequested'] ?? 0,
    );
  }

  @override
  DeliveryRequested fromMap(Map<String, dynamic> map) {
    return DeliveryRequested.fromJson(map);
  }

  Map<String, dynamic> toJson() {
    return {
      'deliveryRequested': deliveryRequested,
    };
  }
}

class Delivering extends BaseModel {
  final int delivering;

  Delivering({
    required this.delivering,
  });

  factory Delivering.fromJson(Map<String, dynamic> json) {
    return Delivering(
      delivering: json['delivering'] ?? 0,
    );
  }

  @override
  Delivering fromMap(Map<String, dynamic> map) {
    return Delivering.fromJson(map);
  }

  Map<String, dynamic> toJson() {
    return {
      'delivering': delivering,
    };
  }
}

class Delivered extends BaseModel {
  final int delivered;

  Delivered({
    required this.delivered,
  });

  factory Delivered.fromJson(Map<String, dynamic> json) {
    return Delivered(
      delivered: json['delivered'] ?? 0,
    );
  }

  @override
  Delivered fromMap(Map<String, dynamic> map) {
    return Delivered.fromJson(map);
  }

  Map<String, dynamic> toJson() {
    return {
      'delivered': delivered,
    };
  }
}
