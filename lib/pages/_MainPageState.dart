import 'dart:html';

import 'package:flutter/material.dart';

class MainPageState extends StatefulWidget {
  const MainPageState({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPageState> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Stepper'),
          centerTitle: true,
        ),
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              print('Completed');
              // send data to server
            } else {
              setState(() => currentStep += 1);
            }
          },
          onStepCancel: currentStep == 0
              ? null : () {
            setState(() => currentStep -= 1);
          },
        ),
      );

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: const Text('1'),
            content: Container()),
        Step(
            isActive: currentStep >= 1,
            title: const Text('2'),
            content: Container()),
        Step(
            isActive: currentStep >= 2,
            title: const Text('3'),
            content: Container())
      ];
}
