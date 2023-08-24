import 'package:book/data/models/book.dart';
import 'package:book/presentation/blocs/theme/theme_bloc.dart';
import 'package:book/presentation/pages/book/book_reading_page.dart';
import 'package:book/presentation/pages/settings/settings_page.dart';
import 'package:book/presentation/widgets/media-widgets/image_builder.dart';
import 'package:flutter/material.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookHomePage extends StatelessWidget {
  final Book book;

  const BookHomePage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.colorScheme.background;
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    final themeState = themeBloc.state;
    final themeId = themeState.themeId + 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        width: .9.sw,
        child: BookReadingPage(book: book),
      ),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Añade esta línea
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  color: backgroundColor,
                  child: Padding(
                      padding: EdgeInsets.only(top: .1.sh),
                      child: ImageBuilder(
                        imageName: book.coverMedia!,
                        themeId: themeId.toString(),
                        width: .9.sw,
                      )),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  color: theme.colorScheme.background,
                  width: 1.sw,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: .05.sh),
                        child: Text(
                          book.title.toUpperCase(),
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: .01.sh),
                        child: Text(
                          book.subtitle.toUpperCase(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: .05.sh),
                        child: Text(
                          book.author.toUpperCase(),
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
