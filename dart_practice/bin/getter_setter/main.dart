import 'document.dart';

void main() {
  final doc = Document("1"); // content에 1 넣어줌.

  // 조회
  String content = doc.content;
  // doc.readCount += 1; // doc의 content를 읽었을 시 readCount를 1만큼 증가 시킴, getter 설정 시 이것들은 필요가 없어짐.
  print(doc.statistic);

  // 수정
  doc.content = "2"; // content를 2로 수정 후 count를 1만큼 증가시킴
  // doc.updateCount += 1; // setter 설정 시 이것들은 필요가 없어짐.
  print(doc.statistic);
}
