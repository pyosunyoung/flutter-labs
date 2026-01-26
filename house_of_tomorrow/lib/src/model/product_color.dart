import 'package:flutter/material.dart';

class ProductColor {
  final String imageUrl;
  final Color color;

  const ProductColor({required this.imageUrl, required this.color});

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      imageUrl: json['imageUrl'] ?? '',
      color: Color(int.tryParse(json['hexColor']) ?? 0xFF000000),//Color는 반환값이 int라 int로 변환
      // int type으로 변경이 불가능한 경우 디폴트값 0x~~
    );
  }
}
