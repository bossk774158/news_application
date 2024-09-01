abstract class NewsEvent {}

class GetNewsEvent extends NewsEvent {
  String? topic;
  GetNewsEvent({this.topic});
}
