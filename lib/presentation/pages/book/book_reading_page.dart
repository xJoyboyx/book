import 'package:book/data/models/book.dart';
import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:book/presentation/pages/book/chapter_content_page.dart';
import 'package:book/presentation/widgets/media-widgets/image_builder.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BookReadingPage extends StatelessWidget {
  final Book book;

  BookReadingPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    final themeState = themeBloc.state;
    final themeId = themeState.themeId + 1;

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
            themeId: themeId,
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
  final int themeId;

  ChapterImageWidget(
      {super.key, this.imagePath, this.number, required this.themeId});

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return ImageBuilder(
          imageName: imagePath!, themeId: themeId.toString(), width: 40.0);
    }
    return SizedBox.shrink(); // Retorna un widget vacío si no hay imagen
  }
}

class ChapterTile extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback onTap;
  final int themeId;
  ChapterTile(
      {required this.chapter, required this.onTap, required this.themeId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: ListTile(
        title: ChapterTitleWidget(title: chapter.pre),
        trailing: ChapterImageWidget(
          imagePath: chapter.preMedia,
          number: chapter.number,
          themeId: themeId,
        ),
        onTap: onTap,
      ),
    );
  }
}
