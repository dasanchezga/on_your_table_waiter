import 'dart:convert';

import 'package:equatable/equatable.dart';

class CheckWaiterResponse extends Equatable {
  factory CheckWaiterResponse.fromJson(String source) =>
      CheckWaiterResponse.fromMap(json.decode(source));

  factory CheckWaiterResponse.fromMap(Map<String, dynamic> map) {
    return CheckWaiterResponse(
      restaurantId: map['restaurantId'] ?? '',
    );
  }
  const CheckWaiterResponse({
    required this.restaurantId,
  });

  final String restaurantId;

  CheckWaiterResponse copyWith({
    String? restaurantId,
  }) {
    return CheckWaiterResponse(
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'restaurantId': restaurantId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CheckWaiterResponse(restaurantId: $restaurantId)';

  @override
  List<Object> get props => [restaurantId];
}

