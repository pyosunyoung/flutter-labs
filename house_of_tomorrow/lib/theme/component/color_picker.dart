import 'package:flutter/material.dart';
import 'package:house_of_tomorrow/src/service/theme_service.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
    required this.colorIndex,
    required this.colorList,
    required this.onColorSelected,
  });

  final int colorIndex;
  final List<Color> colorList;
  final void Function(int index) onColorSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // raw와 다르게 wrap도 가로로 정렬하는데 위젯이 넘쳐나면 다음줄로 이동시킴, row는 화면넘치면 에러 발생
      spacing: 16,
      alignment: WrapAlignment.center, // 위젯이 넘쳐도 가운데 정렬 되어지게 설정.
      children: colorList.asMap().entries.map((entry) {
        int index = entry.key;
        Color color = entry.value;
        bool isSelected = colorIndex == index;
        return GestureDetector(
          onTap: () => onColorSelected(index), // ? 이것을 추가했을 시 뭐가 달라지는 거지
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 222),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(color: context.color.primary, width: 3)
                  : null,
              borderRadius: BorderRadius.circular(99),
            ),
            padding: EdgeInsets.all(isSelected ? 1 : 4),
            child: Container(
              decoration: BoxDecoration(boxShadow: context.deco.shadow),
              child: CircleAvatar(backgroundColor: color, radius: 20),
            ),
          ),
        );
      }).toList(),
    ); // colorIndex에 즉 선택된 색상은 테두리를 형성시켜줄 것
    //이렇게 하면 entries로 변환시켜줄 수 있고 이건 키에 index 그리고 값에 Color가 들어가있는 엔트리임.
  }
}
