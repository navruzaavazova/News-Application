
abstract class NewsEvent {
  const NewsEvent();
}

class GetNewsEvent extends NewsEvent {
  final String country;
  final String category;

  const GetNewsEvent({required this.country, required this.category});
}

class GetSavedLocallyNews extends NewsEvent {
  final String category;

  const GetSavedLocallyNews({required this.category});
}
