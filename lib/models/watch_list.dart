class WatchList {
  final String poster;
  final String title;
  final String date;
  final int id;

  WatchList({required this.poster, required this.title,required this.date,required this.id, });

  factory WatchList.fromJson(json) {
    return WatchList(
      poster: json['poster_path'],
      id: json['id'],
      title: json['title'],
      date: json['date'],
    );
  }
}