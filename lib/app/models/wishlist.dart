class WishlistItem {
  final String id;
  final String title;
  final String posterPath;

  WishlistItem({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    return WishlistItem(
      id: json['id'].toString(),
      title: json['title'] ?? json['name'], // Assuming 'title' for movies and 'name' for TV shows
      posterPath: json['poster_path'] ?? '', // Replace 'poster_path' with your actual field
    );
  }
}
