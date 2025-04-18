// ignore_for_file: public_member_api_docs, sort_constructors_first
class Expense {
  final int? id;
  final String category;
  final String description;
  final double amount;
  final String date;

  Expense({
    this.id,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'] as int?,
      category: json['category'] as String,
      description: json['description'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: json['date'] as String,
    );
  }

  Expense copyWith({
    int? id,
    String? category,
    String? description,
    double? amount,
    String? date,
  }) {
    return Expense(
      id: id ?? this.id,
      category: category ?? this.category,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] != null ? map['id'] as int : null,
      category: map['category'] as String,
      description: map['description'] as String,
      amount: map['amount'] as double,
      date: map['date'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date, // Send as String
    };
  }

  @override
  String toString() {
    return 'Expense(id: $id, category: $category, description: $description, amount: $amount, date: $date)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.category == category &&
        other.description == description &&
        other.amount == amount &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        date.hashCode;
  }
}
