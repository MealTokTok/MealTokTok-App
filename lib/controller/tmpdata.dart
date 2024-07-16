class MealMenu {
  String name;
  int price;
  List<String> memuList;
  List<String> menuUrlList;

  MealMenu(this.name, this.price, this.memuList, this.menuUrlList);
}


List<MealMenu> mealMenuList = [
  MealMenu('아침 콤보', 6000, [
    '팬케이크',
    '베이컨',
    '계란',
    '커피'
  ], [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ]),
  MealMenu('점심 스페셜', 6000, [
    '버거',
    '감자튀김',
    '샐러드',
    '탄산음료'
  ], [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ]),
  MealMenu('저녁 특선', 6000, [
    '스테이크',
    '매쉬드 포테이토',
    '구운 야채',
    '와인'
  ], [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ]),
  MealMenu('채식주의자 잔치', 6000, [
    '샐러드',
    '야채 수프',
    '구운 두부',
    '주스'
  ], [
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80',
    'https://picsum.photos/80/80'
  ])
];