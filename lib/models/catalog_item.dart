class CatalogItem {
  final String title;
  final int duration;
  final String assetName;
  final CatalogType type;
  final DateTime date;

  CatalogItem(
    this.title,
    this.duration,
    this.assetName, {
    this.type = CatalogType.Ready,
    this.date,
  });
}

enum CatalogType { Ready, Locked, Future ,NotReady,EarlyPhase}
