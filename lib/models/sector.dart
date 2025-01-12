import 'dart:ui';

class Sector {
  Sector({
    required this.id,
    required this.title,
    required this.factor,
    required this.color,
  });

  final int id;
  String title;
  double factor;
  final Color color;
}

List<Sector> sectorsList = [
  Sector(id: 1, title: 'x25', factor: 25, color: Color(0xff0d47d0)),
  Sector(id: 2, title: '-x2', factor: -2, color: Color(0xff2B2930)),
  Sector(id: 3, title: 'x2.5', factor: 2.5, color: Color(0xffFDBC17)),
  Sector(id: 4, title: 'x20', factor: 20, color: Color(0xff9ED4E9)),
  Sector(id: 5, title: 'x5', factor: 5, color: Color(0xff0d47d0)),
  Sector(id: 6, title: 'Lose', factor: 0, color: Color(0xff2B2930)),
  Sector(id: 7, title: 'x13', factor: 13, color: Color(0xffFDBC17)),
  Sector(id: 8, title: 'x1.5', factor: 1.5, color: Color(0xff9ED4E9)),
  Sector(id: 9, title: 'x15', factor: 15, color: Color(0xff0d47d0)),
  Sector(id: 10, title: '-x1.5', factor: -1.5, color: Color(0xff2B2930)),
  Sector(id: 11, title: 'x7', factor: 7, color: Color(0xffFDBC17)),
  Sector(id: 12, title: 'x1.7', factor: 1.7, color: Color(0xff9ED4E9)),
];

Sector emptySector = Sector(
  id: 0,
  title: '',
  factor: 0,
  color: Color(0xffffffff),
);
