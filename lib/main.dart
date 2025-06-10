import 'package:flutter/material.dart';
import 'package:shubh_harde_portfolio/Landing/landing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shubh_harde_portfolio/Projects/projects.dart';
import 'package:shubh_harde_portfolio/Resume/resume.dart';
import 'package:shubh_harde_portfolio/bloc/theme/theme_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Portfolio());
}

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const Landing(),
          'Resume': (context) => const Resume(),
          'Projects': (context) => const Projects(),
        },
      ),
    );
  }
}
