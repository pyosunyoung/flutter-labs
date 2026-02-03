import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:house_of_tomorrow/src/model/product.dart';
import 'package:house_of_tomorrow/util/helper/network_helper.dart';

class ProductRepository {
  ProductRepository({
    Dio? dio, // 이렇게 하면 dio를 선택적으로 변경할 수 있음 전달해도 ㄱㅊ 안해도 ㄱㅊ
  }): dio = dio ?? NetworkHelper.dio; //외부에서 dio 객체를 받아서 할당해서 활용해주면 됨. 
  //이렇게하면 외부에서 전달받은 dio를 dio에 들어가는 어떠한 네트워크 모듈(networkHelper.dio 같은것들)에 따라 사용하는 모듈이 달라지게 됨.

  final Dio dio;
  final String searchProductListUrl = 'https://gist.githubusercontent.com/nero-angela/d16a5078c7959bf5abf6a9e0f8c2851a/raw/04fb4d21ddd1ba06f0349a890f5e5347d94d677e/ikeaSofaDataIBB.json';
  //이 url을 또 사용할 곳이 있어서 변수로 분리
  Future<List<Product>> searchProductList(String keyword) async {
    try {
      final res = await dio.get(
       searchProductListUrl
      );

      //product list의 값이 바뀌었기 떄문에 화면 갱신
      return jsonDecode(res.data)
          .map<Product>((json) {
            return Product.fromJson(json);
          })
          .where((product) {
            /// 키워드가 비어있는 경우 모두 반환
            if (keyword.isEmpty) return true;

            /// name이나 brand에 키워드 포함 여부 확인
            return "${product.name}${product.brand}".toLowerCase().contains(
              keyword.toLowerCase(),
            );
          })
          .toList(); //json type의 문제열을 dart의 배열이 map으로 변경
    } catch (e, s) {
      log(
        'Failed to searchProductList',
        error: e,
        stackTrace: s,
      ); //stackTrace는 어떤 파일 몇번째 줄에서 오류가 발생했는지 알 수 있음.
      return [];
    }
  }
}
