class Sector {
  Sector({
    required this.id,
    required this.title,
    required this.factor,
  });

  final int id;
  String title;
  double factor;
}

List<Sector> sectorsList = [
  Sector(id: 3, title: 'x25', factor: 25),
  Sector(id: 15, title: '-x2', factor: -2),
  Sector(id: 2, title: 'x2.5', factor: 2.5),
  Sector(id: 8, title: 'x20', factor: 20),
  Sector(id: 20, title: 'x5', factor: 5),
  Sector(id: 13, title: 'Lose', factor: 0),
  Sector(id: 19, title: 'x13', factor: 13),
  Sector(id: 12, title: 'x1.5', factor: 1.5),
  Sector(id: 9, title: 'x15', factor: 15),
  Sector(id: 11, title: '-x1.5', factor: -1.5),
  Sector(id: 4, title: 'x7', factor: 7),
  Sector(id: 10, title: 'x1.7', factor: 1.7),
];

Sector emptySector = Sector(id: 0, title: '', factor: 0);
