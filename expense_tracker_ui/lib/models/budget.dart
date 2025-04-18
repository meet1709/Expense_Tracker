// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Budget {
  int? month;
  double? budget;

  Budget({
    this.month,
    this.budget,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'budget': budget,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      month: map['month'] != null ? map['month'] as int : null,
      budget: map['budget'] != null ? map['budget'] as double : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'month': month, 'budget': budget};
  }

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      month: json['month'] as int?,
      budget: json['budget'] as double,
    );
  }
}
