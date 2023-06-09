import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPageState extends StatefulWidget {
  const MainPageState({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPageState> {
  int currentStep = 0;

  late TextEditingController realStateStartDate;
  late TextEditingController realStateName;
  late TextEditingController realStateDescription;
  late TextEditingController realStateDueDate;

  @override
  void initState() {
    super.initState();
    realStateStartDate = TextEditingController();
    realStateName = TextEditingController();
    realStateDescription = TextEditingController();
    realStateDueDate = TextEditingController();
  }

  @override
  void dispose() {
    realStateStartDate.dispose();
    realStateName.dispose();
    realStateDescription.dispose();
    realStateDueDate.dispose();
    super.dispose();
  }

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
              ? null
              : () {
                  setState(() => currentStep -= 1);
                },
        ),
      );

  List<Step> getSteps() => [
        Step(
          isActive: currentStep >= 0,
          title: const Text('1'),
          content: Column(
            children: <Widget>[
              TextFormField(
                  controller: realStateName,
                  decoration: const InputDecoration(labelText: 'Nome')),
              TextFormField(
                  controller: realStateDescription,
                  decoration: const InputDecoration(labelText: 'Descrição')),
              TextFormField(
                controller: realStateStartDate,
                decoration: const InputDecoration(
                    labelText: 'Data de início',
                    suffixIcon: Icon(Icons.calendar_today)),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat("dd/MM/yyyy").format(pickedDate);
                    setState(() {
                      realStateStartDate.text = formattedDate.toString();
                    });
                  } else {
                    print("Date not selected");
                  }
                },
              ),
              TextFormField(
                controller: realStateDueDate,
                decoration: const InputDecoration(
                    labelText: 'Estimativa de entrega',
                    suffixIcon: Icon(Icons.calendar_today)),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat("dd/MM/yyyy").format(pickedDate);
                    setState(() {
                      realStateDueDate.text = formattedDate.toString();
                    });
                  } else {
                    print("Date not selected");
                  }
                },
              ),
            ],
          ),
        ),
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
