import 'package:book/data/models/book.dart';
import 'package:book/presentation/pages/book/chapter_content_page.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BookReadingPage extends StatelessWidget {
  final Book book;

  BookReadingPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          book.subtitle.toUpperCase(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: ListView.separated(
        itemCount: book.chapters.length,
        itemBuilder: (context, index) {
          final chapter = book.chapters[index];
          return ChapterTile(
            chapter: chapter,
            onTap: () {
              // Navega a la página de contenido del capítulo
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChapterContentPage(chapter: chapter),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => SizedBox.shrink(),
      ),
    );
  }
}

class ChapterTitleWidget extends StatelessWidget {
  final String title;

  ChapterTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.titleMedium,
      textAlign: TextAlign.right,
    ); // Puedes agregar más estilos o lógica aquí si lo necesitas
  }
}

class ChapterImageWidget extends StatelessWidget {
  final String? imagePath;
  final double? number;

  ChapterImageWidget({super.key, this.imagePath, this.number});

  @override
  Widget build(BuildContext context) {
    if (number != null) {
      if (number == 0.1) {
        return Container(
          color: AppThemes.dimensionsColorsTheme1[0],
          height: 50,
          width: 50,
        );
      } else {
        return Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppThemes.dimensionsColorsTheme1[number!.toInt()],
            ));
      }
    }
    if (imagePath != null) {
      return Image.asset(imagePath!, width: 50);
    }
    return SizedBox.shrink(); // Retorna un widget vacío si no hay imagen
  }
}

class ChapterTile extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback onTap;

  ChapterTile({required this.chapter, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListTile(
        title: ChapterTitleWidget(title: chapter.pre),
        trailing: ChapterImageWidget(
          imagePath: chapter.preMedia,
          number: chapter.number,
        ),
        onTap: onTap,
      ),
    );
  }
}
