import 'dart:io';

import 'package:book/data/models/term.dart';
import 'package:book/data/models/translations.dart';
import 'package:book/presentation/blocs/authentication/auth_bloc.dart';
import 'package:book/presentation/blocs/language/language_bloc.dart';
import 'package:book/presentation/pages/settings/settings_page.dart';
import 'package:book/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageState = context.watch<LanguageBloc>().state;
    final translations = languageState is LanguageSelectedState
        ? languageState.translations
        : null;

    List<Term> userTermsEN = [
      Term(
          number: '1',
          title: 'Acceptance of Terms',
          content:
              'By accessing and using Espiral I, users agree to comply with the Terms and Conditions outlined herein.'),
      Term(
          number: '2',
          title: 'Registration',
          content:
              'Users must provide a valid email address to manage purchases within the app.'),
      Term(
          number: '3',
          title: 'In-App Purchases',
          content:
              'Espiral I offers in-app purchases for themes. All sales are final and non-refundable."'),
      Term(
          number: '4',
          title: 'Age Requirement',
          content: 'Users must be 10 years of age or older to use Espiral I.'),
      Term(
          number: '5',
          title: 'Intellectual Property',
          content:
              'All content within Espiral I, excluding typography, is owned by the app’s creator. Redistribution or reuse of any content is prohibited.'),
      Term(
          number: '6',
          title: 'Content Warning',
          content:
              'Some content within Espiral I may not be suitable for all audiences. User discretion is advised.'),
      Term(
          number: '7',
          title: 'Emotional Disclaimer',
          content:
              'The creator of Espiral I is not responsible for any emotional distress, discomfort, or other harm that may result from reading the content within the app. Users should engage with the content at their own risk and discretion.'),
      Term(
          number: '8',
          title: 'Dispute Resolution',
          content:
              'Any disputes arising from the use of Espiral I will be resolved through arbitration in Mexico, unless otherwise required by law.'),
      Term(
          number: '9',
          title: 'Changes to Terms',
          content:
              'Espiral I reserves the right to modify these Terms and Conditions at any time. Users are advised to review this policy periodically.'),
      Term(
          number: '10',
          title: 'Indemnification',
          content:
              'You agree to defend, indemnify, and hold harmless Espiral I, its directors, partners, officers, employees, and agents, and their affiliates from and against any claims, liabilities, damages, losses, and expenses, including, without limitation, reasonable legal and accounting fees, arising out of or in any way connected with your access to or use of the app, your transmission of any message, content, information, software or other materials through the app, or your breach or violation of the law or of these Terms and Conditions. Espiral I reserves the right, at its own expense, to assume the exclusive defense and control of any matter otherwise subject to indemnification by you, and in such case, you agree to cooperate with Espiral I’s defense of such claim.'),
      Term(
          number: '11',
          title: 'Photosensitive Seizure Warning',
          content:
              'A very small percentage of individuals may experience a seizure when exposed to certain visual images, including flashing lights or patterns that may appear in video games or other electronic or online content. Even individuals who have no history of seizures or epilepsy may have an undiagnosed condition that can cause “photosensitive epileptic seizures” while watching video games or other electronic content. These seizures have a variety of symptoms, including lightheadedness, disorientation, confusion, momentary loss of awareness, eye or face twitching, altered vision, or jerking or shaking of arms or legs. If you experience any of the aforementioned symptoms, or if you or your family have a history of seizures or epilepsy, you should immediately stop using the app and consult a doctor.'),
      Term(
          number: '12',
          title: 'Applicable Laws',
          content:
              'We control and operate the App from our offices within the United Mexican States. We do not represent that materials in the App are appropriate or available for use in other locations. Persons who choose to access the App from other locations do so on their own initiative and are responsible for compliance with local laws, if and to the extent local laws are applicable. All parties subject to these terms and conditions waive their respective rights to a trial by jury.'),
      Term(
          number: '13',
          title: 'Limitation of Liability',
          content:
              'In no event, including but not limited to negligence, shall Espiral I, or any of its directors, officers, employees, agents, or content or service providers (collectively, the "Protected Entities") be liable for any direct, indirect, special, incidental, consequential, exemplary, or punitive damages arising from, or directly or indirectly related to, the use of, or the inability to use, the App or the content, materials, and functions related thereto, your provision of information via the App, lost business, or lost sales, even if such Protected Entity has been advised of the possibility of such damages. Some jurisdictions do not allow the limitation or exclusion of liability for incidental or consequential damages, so some of the above limitations may not apply to certain users. In no event shall the Protected Entities be liable for or in connection with any content posted, transmitted, exchanged, or received by or on behalf of any user or other person on or through the App. In no event shall the total liability of the Protected Entities to you for all damages, losses, and causes of action (whether in contract or tort, including, but not limited to, negligence or otherwise) arising from the terms and conditions or your use of the App exceed, in the aggregate, the amount, if any, paid by you to Espiral I for your use of the App or for purchasing products via the App.'),
      Term(
          number: '14',
          title: "Collection of Primary Account Information",
          content:
              'For the purpose of connecting users with their in-app purchases, Espiral I collects specific primary account information, namely the user\'s email and external ID. This data is securely transmitted to https://api.spiraldimensions.com. We do not use this information for any other purpose, nor do we share it with third parties. Our aim is to ensure a seamless user experience by linking users to their respective purchases.'),
      Term(
          number: '15',
          title: 'Security of Transmitted Data',
          content:
              'We employ robust security measures to protect the data transmitted to our servers. Any data, including primary account information, is encrypted during transmission to safeguard user privacy.'),
    ];
    List<Term> userTerms = [
      Term(
          number: '1',
          title: 'Aceptación de Términos',
          content:
              'Al acceder y utilizar Espiral I, los usuarios aceptan cumplir con los Términos y Condiciones aquí descritos.'),
      Term(
          number: '2',
          title: 'Registro',
          content:
              'Los usuarios deben proporcionar una dirección de correo electrónico válida para gestionar compras dentro de la aplicación.'),
      Term(
          number: '3',
          title: 'Compras Dentro de la Aplicación',
          content:
              'Espiral I ofrece compras dentro de la aplicación para temas. Todas las ventas son finales y no reembolsables.'),
      Term(
          number: '4',
          title: 'Requisito de Edad',
          content:
              'Los usuarios deben tener 10 años de edad o más para usar Espiral I.'),
      Term(
          number: '5',
          title: 'Propiedad Intelectual',
          content:
              'Todo el contenido dentro de Espiral I, excluyendo la tipografía, es propiedad del creador de la aplicación. Está prohibida la redistribución o reutilización de cualquier contenido.'),
      Term(
          number: '6',
          title: 'Advertencia de Contenido',
          content:
              'Algunos contenidos dentro de Espiral I pueden no ser adecuados para todos los públicos. Se aconseja discreción por parte del usuario.'),
      Term(
          number: '7',
          title: 'Descargo de Responsabilidad Emocional',
          content:
              'El creador de Espiral I no es responsable de ningún daño emocional, incomodidad u otro daño que pueda resultar de leer el contenido dentro de la aplicación. Los usuarios deben interactuar con el contenido bajo su propio riesgo y discreción.'),
      Term(
          number: '8',
          title: 'Resolución de Disputas',
          content:
              'Cualquier disputa que surja del uso de Espiral I se resolverá a través de arbitraje en México, a menos que la ley requiera lo contrario.'),
      Term(
          number: '9',
          title: 'Cambios a los Términos',
          content:
              'Espiral I se reserva el derecho de modificar estos Términos y Condiciones en cualquier momento.'),
      Term(
          number: '10',
          title: 'Indemnización',
          content:
              'Usted acepta defender, indemnizar y mantener indemne a Espiral I, sus directores, socios, oficiales, empleados y agentes, y sus afiliados contra cualquier reclamo, responsabilidad, daño, pérdida y gasto, incluyendo, sin limitación, honorarios legales y contables razonables, que surjan de o estén de alguna manera conectados con su acceso o uso de la aplicación, su transmisión de cualquier mensaje, contenido, información, software u otros materiales a través de la aplicación, o su violación o incumplimiento de la ley o de estos Términos y Condiciones. Espiral I se reserva el derecho, a su propio costo, de asumir la defensa y control exclusivos de cualquier asunto sujeto a indemnización por su parte, y en tal caso, usted acepta cooperar con la defensa de Espiral I de dicho reclamo.'),
      Term(
          number: '11',
          title: 'Advertencia de Ataques Fotosensibles',
          content:
              'Un porcentaje muy pequeño de individuos puede experimentar un ataque cuando están expuestos a ciertas imágenes visuales, incluidas luces intermitentes o patrones que pueden aparecer en videojuegos u otro contenido electrónico o en línea. Incluso los individuos que no tienen antecedentes de ataques o epilepsia pueden tener una condición no diagnosticada que puede causar \'ataques epilépticos fotosensibles\' mientras ven videojuegos u otro contenido electrónico. Estos ataques tienen una variedad de síntomas, incluidos mareos, desorientación, confusión, pérdida momentánea de la conciencia, contracciones en los ojos o la cara, visión alterada, o sacudidas o temblores de brazos o piernas. Si experimenta alguno de los síntomas mencionados, o si usted o su familia tienen antecedentes de ataques o epilepsia, debe dejar de usar la aplicación de inmediato y consultar a un médico.'),
      Term(
          number: '12',
          title: 'Leyes Aplicables',
          content:
              'Controlamos y operamos la Aplicación desde nuestras oficinas dentro de los Estados Unidos Mexicanos. No representamos que los materiales en la Aplicación sean apropiados o estén disponibles para su uso en otros lugares. Las personas que elijan acceder a la Aplicación desde otros lugares lo hacen por iniciativa propia y son responsables de cumplir con las leyes locales, si y en la medida en que las leyes locales sean aplicables. Todas las partes sujetas a estos términos y condiciones renuncian a sus respectivos derechos a un juicio por jurado.'),
      Term(
          number: '13',
          title: 'Limitación de Responsabilidad',
          content:
              'En ningún caso, incluida la negligencia, Espiral I, o cualquiera de sus directores, oficiales, empleados, agentes o proveedores de contenido o servicios (colectivamente, las \'Entidades Protegidas\') serán responsables de ningún daño directo, indirecto, especial, incidental, consecuente, ejemplar o punitivo que surja de, o esté directa o indirectamente relacionado con, el uso de, o la incapacidad para usar, la Aplicación o el contenido, materiales y funciones relacionados con la misma, su provisión de información a través de la Aplicación, negocios perdidos, o ventas perdidas, incluso si dicha Entidad Protegida ha sido advertida de la posibilidad de dichos daños. Algunas jurisdicciones no permiten la limitación o exclusión de responsabilidad por daños incidentales o consecuentes, por lo que algunas de las limitaciones anteriores pueden no aplicarse a ciertos usuarios. En ningún caso, las Entidades Protegidas serán responsables de o en conexión con cualquier contenido publicado, transmitido, intercambiado o recibido por o en nombre de cualquier usuario u otra persona en o a través de la Aplicación. En ningún caso, la responsabilidad total de las Entidades Protegidas hacia usted por todos los daños, pérdidas y causas de acción (ya sea por contrato o agravio, incluida, pero no limitada a, negligencia o de otro modo) que surjan de los términos y condiciones o de su uso de la Aplicación excederá, en conjunto, la cantidad, si la hay, pagada por usted a Espiral I por su uso de la Aplicación o por la compra de productos a través de la Aplicación.'),
      Term(
          number: '14',
          title: "Recolección de Información de la Cuenta Principal",
          content:
              'Para el propósito de conectar a los usuarios con sus compras dentro de la aplicación, Espiral I recopila información específica de la cuenta principal, a saber, el correo electrónico del usuario y la ID externa. Esta información se transmite de manera segura a https://api.spiraldimensions.com. No utilizamos esta información para ningún otro propósito, ni la compartimos con terceros. Nuestro objetivo es garantizar una experiencia de usuario fluida al vincular a los usuarios con sus respectivas compras.'),
      Term(
          number: '15',
          title: 'Seguridad de los Datos Transmitidos',
          content:
              'Empleamos medidas de seguridad robustas para proteger los datos transmitidos a nuestros servidores. Cualquier dato, incluyendo la información de la cuenta principal, se encripta durante la transmisión para salvaguardar la privacidad del usuario.'),
    ];
    List<Term> terms = userTermsEN;

    if (languageState is LanguageSelectedState) {
      terms = languageState.language.code == 'en' ? userTermsEN : userTerms;
    }

    return Scaffold(
      body: Center(
        child: Container(
          color: AppThemes.backgroundColorTheme1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: .1.sh),
                  child: Image.asset(
                    'assets/media/theme1/portrait.png',
                    height: .4.sh,
                  ),
                ),
                SizedBox(height: .05.sh),
                Text(
                  translations!
                      .getCopy('session', 'welcome')
                      .toUpperCase()
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: AppThemes.displayMedium1.copyWith(fontSize: 26),
                ),
                Spacer(),
                GoogleLoginBtn(translations: translations),
                SizedBox(height: .01.sh),
                if (Platform.isIOS) AppleLoginBttn(translations: translations),
                SizedBox(height: .1.sh),
                TermsAndConditionButton(
                    terms: terms, translations: translations),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleLoginBtn extends StatelessWidget {
  const GoogleLoginBtn({
    super.key,
    required this.translations,
  });

  final Translations? translations;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(SignInWithGoogle());
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(AppThemes.backgroundColorTheme1),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      icon: Image.asset('assets/media/session/google_logo.png', height: 18.0),
      label: Text(
        translations!.getCopy('session', 'login_google'),
        style: AppThemes.displayMedium1,
      ),
    );
  }
}

class AppleLoginBttn extends StatelessWidget {
  const AppleLoginBttn({
    super.key,
    required this.translations,
  });

  final Translations? translations;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        BlocProvider.of<AuthBloc>(context).add(SignInWithApple());
      },
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(AppThemes.backgroundColorTheme1),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      icon: Image.asset('assets/media/session/apple_logo.png', height: 18.0),
      label: Text(
        translations!.getCopy('session', 'login_apple'),
        style: AppThemes.displayMedium1,
      ),
    );
  }
}

class TermsAndConditionButton extends StatelessWidget {
  const TermsAndConditionButton(
      {super.key, required this.translations, required this.terms});

  final List<Term> terms;
  final Translations? translations;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: .02.sh),
      child: TermsButton(terms: terms, translations: translations),
    );
  }
}
