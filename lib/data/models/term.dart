class Term {
  final String number;
  final String title;
  final String content;

  Term({required this.number, required this.title, required this.content});

  factory Term.fromJson(Map<String, dynamic> json) {
    return Term(
      number: json['number'],
      title: json['title'],
      content: json['content'],
    );
  }
}
