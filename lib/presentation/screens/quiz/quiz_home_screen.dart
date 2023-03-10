import 'package:assignment/logic/cubit/app_theme_cubit.dart';
import 'package:assignment/presentation/utils/custom_print.dart';
import 'package:assignment/presentation/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/quizQuestions.dart';
import '../../../logic/bloc/quiz_bloc.dart';
import '../../router/app_router.dart';
import '../../utils/custom_button.dart';
import '../../utils/custom_text_field.dart';

class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({Key? key}) : super(key: key);

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  bool navigated = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizBloc, QuizState>(
      listener: (context, quizState) {
        // TODO: implement listener
      },
      builder: (context, quizState) {
        return BlocBuilder<AppThemeCubit, AppThemeState>(
          builder: (context, themeState) {
            return SafeArea(
              child: Scaffold(
                backgroundColor: (themeState as AppThemeSet).themeClass
                    .quizBackgroundColor,
                body: Column(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          textString: 'Quiz Blitz'.toUpperCase(),
                          textFontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          textColor: themeState.themeClass.white,
                        ),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText(
                          textString: 'Do you have what it takes to be the ultimate quiz master!!?',
                          textFontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          textColor: themeState.themeClass.white,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),


                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: CustomButton(
                        buttonColor: themeState.themeClass.buttonBackgroundColor2,
                        buttonText: 'Let\'s go!'.toUpperCase(),
                        buttonSize: 90.w,
                        borderRadius: 15,
                        fontWeight: FontWeight.bold,
                        onTapEvent: () {
                          if(quizState is QuizInitial || quizState is QuizStarted){
                            BlocProvider.of<QuizBloc>(context).add(QuizInitialise(context: context));
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
