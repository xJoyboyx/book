import 'package:book/domain/entities/language.dart';
import 'package:book/presentation/blocs/language/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final List<Language> languages = [
  Language(code: 'en', name: 'I speak english'),
  Language(code: 'es', name: 'Hablo español'),
  Language(code: 'fr', name: 'Je parle français'),
  // ... puedes agregar más idiomas según lo necesites
];

class LanguageSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(top: .1.sh),
            child: ListView.builder(
              itemCount: languages
                  .length, // Asumiendo que 'languages' es una lista de todos los idiomas disponibles
              itemBuilder: (context, index) {
                final language = languages[index];
                return ListTile(
                  title: Text(
                    language.name.toUpperCase(),
                    style: Theme.of(context).textTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ), // Asumiendo que el objeto 'Language' tiene un atributo 'name'
                  onTap: () {
                    BlocProvider.of<LanguageBloc>(context)
                        .add(SelectLanguageEvent(language));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
