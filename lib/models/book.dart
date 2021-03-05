class Book {
  String id;
  String cover;
  String title;
  String author;
  bool isRead;
  int rate;
  String uid;

  // Transient
  String url;

  Book(
      {this.id,
      this.cover,
      this.title,
      this.author,
      this.isRead,
      this.rate,
      this.uid});

  @override
  String toString() {
    return 'Book(id: $id, cover: $cover, title: $title, author: $author, isRead: $isRead, rate: $rate, uid: $uid)';
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'] as String,
        cover: json['cover'] as String,
        title: json['title'] as String,
        author: json['author'] as String,
        isRead: json['isRead'] as bool,
        rate: json['rate']?.round(),
        uid: json['uid'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cover': cover,
      'title': title,
      'author': author,
      'isRead': isRead,
      'rate': rate,
      'uid': uid
    };
  }
}
