class Document {
  // 내용
  //_바로 시작되는 것은 다 private 함수, 클래스이다. 외부에서 접근할 수 없다.
  // 파일 내부에서만 접근 가능.
  String _content;

  String get content {
    _readCount += 1;
    return _content;
  }

  set content(String value) {
    //setter는 content에 새로운 값이 할당되었을 떄 사용.
    _content = value;
    _updateCount += 1;
  }

  // 읽은 횟수
  int _readCount = 0;

  // 수정 횟수
  int _updateCount = 0;

  // 통계
  // late statistic = "readCount : $readCount / updateCount : $updateCount";
  // static은 다른 속성을 초기값으로 사용하려면 앞에 late 키워드를 붙여야 한다.
  //late 키워드가 붙은 변수는 해당 변수를 처음 호출할 때 값 할당이 이뤄집니다.
  //   - `late`는 **“처음 접근할 때 단 한 번 초기화”**
  // - 그 시점의 `readCount`, `updateCount` 값이 문자열로 **고정**됨
  // - 이후 `readCount`, `updateCount`가 바뀌어도

  //     => `statistic`은 **다시 계산되지 않음**
  String get statistic => "readCount : $_readCount / updateCount : $_updateCount";
  //getter를 통해서 이 오류 현상을 해결해줄 수 있음. 매번 get을 통해서 새로 초기화 시킴

  Document(this._content);
}
