// To parse this JSON data, do
//
//     final loanModel = loanModelFromJson(jsonString);

import 'dart:convert';

LoanModel loanModelFromJson(String str) => LoanModel.fromJson(json.decode(str));

String loanModelToJson(LoanModel data) => json.encode(data.toJson());

class LoanModel {
  String loan;

  LoanModel({
    required this.loan,
  });

  factory LoanModel.fromJson(Map<String, dynamic> json) => LoanModel(
    loan: json["loan"],
  );

  Map<String, dynamic> toJson() => {
    "loan": loan,
  };
}
