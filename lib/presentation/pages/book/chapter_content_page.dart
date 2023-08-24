import 'package:book/data/models/book.dart';
import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:book/presentation/widgets/media-widgets/image_builder.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChapterContentPage extends StatelessWidget {
  final Chapter chapter;

  ChapterContentPage({required this.chapter});

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    final themeState = themeBloc.state;
    final themeId = themeState.themeId + 1;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          chapter.pre.toUpperCase(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: ChapterItem(
          chapter: chapter,
          themeId: themeId,
        ),
      ),
    );
  }
}

class ChapterItem extends StatelessWidget {
  final Chapter chapter;
  final int themeId;
  ChapterItem({required this.chapter, required this.themeId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          ChapterTitleWidget(
              title: chapter.title, chapterNumber: chapter.number),
          ChapterImageWidget(
            imagePath: chapter.coverMedia,
            themeId: themeId,
          ),
          ChapterContentWidget(content: chapter.content)
        ],
      ),
    );
  }
}

class ChapterTitleWidget extends StatelessWidget {
  final String title;
  final double chapterNumber;

  ChapterTitleWidget({required this.title, required this.chapterNumber});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.titleLarge, // Estilo base
          children: interpretText(title, chapterNumber, context),
        )); // Puedes agregar más estilos o lógica aquí si lo necesitas
  }
}

class ChapterImageWidget extends StatelessWidget {
  final String? imagePath;
  final int themeId;
  ChapterImageWidget({super.key, this.imagePath, required this.themeId});

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      try {
        return Padding(
          padding: EdgeInsets.only(
            top: .1.sh,
            bottom: .1.sh,
          ),
          child: ImageBuilder(
            imageName: imagePath!,
            themeId: themeId.toString(),
            width: .8.sw,
          ),
        );
      } catch (e) {
        return Padding(
          padding: EdgeInsets.only(
            top: .1.sh,
            bottom: .1.sh,
          ),
          child: ImageBuilder(
            imageName: imagePath!,
            themeId: themeId.toString(),
            width: .8.sw,
          ),
        );
      }
    }
    return SizedBox.shrink(); // Retorna un widget vacío si no hay imagen
  }
}

class ChapterContentWidget extends StatelessWidget {
  final String content;

  ChapterContentWidget({required this.content});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium, // Estilo base
          children: interpretText(content, 0.1, context),
        )); // Puedes agregar más estilos o lógica aquí si lo necesitas
  }
}

List<InlineSpan> interpretText(
    String text, double number, BuildContext context) {
  final spans = <InlineSpan>[];

  final regex =
      RegExp(r'<\s*(hm\d|hl\d|tl\d)\s*>(.*?)<\/\s*\1\s*>', dotAll: true);
  text.splitMapJoin(
    regex,
    onMatch: (match) {
      TextStyle? style;
      var text = match.group(2);
      switch (match.group(1)) {
        case 'tl1':
          style = Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppThemes.dimensionsColorsTheme1[number.toInt()]);
          text = text!.toUpperCase();
          break;
        case 'tl2':
          style = Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: AppThemes.accentColorTheme1);
          text = text!.toUpperCase();
          break;
        case 'hm1':
          style = Theme.of(context).textTheme.headlineMedium;
          break;
      }
      spans.add(TextSpan(text: text, style: style));
      return '';
    },
    onNonMatch: (nonMatch) {
      spans.add(TextSpan(text: nonMatch));
      return '';
    },
  );

  return spans;
}
