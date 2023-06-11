import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int currentStep = 0;

  late TextEditingController realStateStartDate;
  late TextEditingController realStateName;
  late TextEditingController realStateDescription;
  late TextEditingController realStateDueDate;
  late TextEditingController realStateCEP;
  late TextEditingController realStateAddress;
  late TextEditingController realStateNumber;

  @override
  void initState() {
    super.initState();
    realStateStartDate = TextEditingController();
    realStateName = TextEditingController();
    realStateDescription = TextEditingController();
    realStateDueDate = TextEditingController();
    realStateCEP = TextEditingController();
    realStateAddress = TextEditingController();
    realStateNumber = TextEditingController();
  }

  @override
  void dispose() {
    realStateStartDate.dispose();
    realStateName.dispose();
    realStateDescription.dispose();
    realStateDueDate.dispose();
    realStateCEP.dispose();
    realStateAddress.dispose();
    realStateNumber.dispose();
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
                  }
                },
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: const Text('2'),
          content: Column(
            children: <Widget>[
              TextFormField(
                  controller: realStateCEP,
                  decoration: const InputDecoration(labelText: 'CEP')),
              TextFormField(
                controller: realStateAddress,
                decoration: const InputDecoration(labelText: 'Endereço'),
                readOnly: true,
              ),
              TextFormField(
                  controller: realStateNumber,
                  decoration: const InputDecoration(labelText: 'Número')),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text('3'),
          content: Column(
            children: <Widget>[
              TextFormField(
                  controller: realStateCEP,
                  decoration: const InputDecoration(labelText: 'CEP')),
              TextFormField(
                controller: realStateAddress,
                decoration: const InputDecoration(labelText: 'Endereço'),
                readOnly: true,
              ),
              TextFormField(
                  controller: realStateNumber,
                  decoration: const InputDecoration(labelText: 'Número')),
            ],
          ),
        ),
      ];
}
