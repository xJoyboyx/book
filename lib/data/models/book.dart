// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  final String title;
  final String author;
  final String subtitle;
  final String? coverMedia;
  final List<Chapter> chapters;

  Book({
    required this.title,
    required this.author,
    required this.subtitle,
    this.coverMedia,
    required this.chapters,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        subtitle: json["subtitle"],
        coverMedia: json["coverMedia"],
        chapters: List<Chapter>.from(
            json["chapters"]!.map((x) => Chapter.fromJson(x))),
        author: json["author"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "coverMedia": coverMedia,
        "author": author,
        "chapters": List<dynamic>.from(chapters!.map((x) => x.toJson())),
      };
}

class Chapter {
  final String title;
  final String? coverMedia;
  final String content;
  final String preMedia;
  final String pre;
  final double number;

  Chapter({
    required this.pre,
    required this.title,
    required this.preMedia,
    this.coverMedia,
    required this.content,
    required this.number,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        title: json["title"],
        pre: json["pre"],
        preMedia: json["preMedia"],
        coverMedia: json["coverMedia"],
        content: json["content"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "pre": pre,
        "preMedia": preMedia,
        "coverMedia": coverMedia,
        "content": content,
        "number": number
      };
}
