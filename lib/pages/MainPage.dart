import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final formKey = GlobalKey<FormState>();
  int currentStep = 0;
  bool isInvalidData = false;
  static const primaryColor = Color(0xff058B36);
  static const secondaryColor = Color(0xff2670B9);
  static const tertiaryColor = Color(0xff2670B9);
  static const grey = Color(0xffC2C2C2);
  static const errorColor = Color(0xff880808);

  late TextEditingController realStateStartDate;
  late TextEditingController realStateName;
  late TextEditingController realStateDescription;
  late TextEditingController realStateDueDate;
  late TextEditingController realStateCEP;
  late TextEditingController realStateAddress;
  late TextEditingController realStateNumber;

  late TextEditingController realStateFloors;
  late TextEditingController realStatePoolsQuantity;
  late TextEditingController realStateTennisCourtsQuantity;
  late TextEditingController realStateFootballCourtsQuantity;
  late TextEditingController realStateSaunasQuantity;
  late TextEditingController realStatePartyRoomsQuantity;
  late TextEditingController realStateOutdoorGrillsQuantity;
  late TextEditingController realStatePlaygroundsQuantity;
  late TextEditingController realStateUnitsCount;
  late TextEditingController realStateVisitorParkingSpotsQuantity;

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

    realStateFloors = TextEditingController();
    realStatePoolsQuantity = TextEditingController();
    realStateTennisCourtsQuantity = TextEditingController();
    realStateFootballCourtsQuantity = TextEditingController();
    realStateSaunasQuantity = TextEditingController();
    realStatePartyRoomsQuantity = TextEditingController();
    realStateOutdoorGrillsQuantity = TextEditingController();
    realStatePlaygroundsQuantity = TextEditingController();
    realStateUnitsCount = TextEditingController();
    realStateVisitorParkingSpotsQuantity = TextEditingController();
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

    realStateFloors.dispose();
    realStatePoolsQuantity.dispose();
    realStateTennisCourtsQuantity.dispose();
    realStateFootballCourtsQuantity.dispose();
    realStateSaunasQuantity.dispose();
    realStatePartyRoomsQuantity.dispose();
    realStateOutdoorGrillsQuantity.dispose();
    realStatePlaygroundsQuantity.dispose();
    realStateUnitsCount.dispose();
    realStateVisitorParkingSpotsQuantity.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Empreendimento'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: Theme(
          data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                  primary: primaryColor,
                  onPrimary: Colors.white,
                  secondary: primaryColor,
                  onSecondary: primaryColor,
                  error: errorColor,
                  onError: errorColor,
                  background: primaryColor,
                  onBackground: primaryColor,
                  surface: primaryColor,
                  onSurface: primaryColor)),
          child: Form(
            key: formKey,
            child: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepTapped: (step) => setState(() => currentStep = step),
              controlsBuilder:
                  (BuildContext context, ControlsDetails controls) {
                final isLastStep = currentStep == getSteps().length - 1;
                return Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controls.onStepContinue,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Text(
                            isLastStep ? 'Cadastrar' : 'Próximo',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      if (currentStep != 0) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: controls.onStepCancel,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 24),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Text(
                              'Voltar',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
              onStepContinue: () {
                final isLastStep = currentStep == getSteps().length - 1;
                if (isLastStep) {
                  final isValid = formKey.currentState?.validate();
                  if (isValid == false) {
                    setState(() => currentStep = 0);
                    setState(() => isInvalidData = true);
                  } else {
                    setState(() => isInvalidData = false);
                    // send data to server
                  }
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
          )));

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: const Text('Geral'),
          content: Column(
            children: <Widget>[
              if (isInvalidData)
                const Text(
                  'Notamos uma inconsistência nos dados, por favor, revise o formulário.',
                  style: TextStyle(color: errorColor),
                ),
              TextFormField(
                controller: realStateName,
                decoration: const InputDecoration(labelText: 'Nome *'),
                validator: (value) {
                  if (value!.length < 4) {
                    return 'Digite pelo menos 4 caracteres';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: realStateDescription,
                decoration: const InputDecoration(labelText: 'Descrição *'),
                validator: (value) {
                  if (value!.length < 10) {
                    return 'Digite pelo menos 10 caracteres';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: realStateStartDate,
                decoration: const InputDecoration(
                    labelText: 'Data de início *',
                    suffixIcon: Icon(Icons.calendar_today)),
                readOnly: true,
                validator: (value) {
                  if (value!.length < 2) {
                    return 'Selecione uma data';
                  } else {
                    return null;
                  }
                },
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
                    labelText: 'Estimativa de entrega *',
                    suffixIcon: Icon(Icons.calendar_today)),
                readOnly: true,
                validator: (value) {
                  if (value!.length < 2) {
                    return 'Selecione uma data';
                  } else {
                    return null;
                  }
                },
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
              const SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                        'Foto da capa*',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Dotted square tapped!');
                },
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: DottedBorder(
                      color: Colors.grey,
                      strokeWidth: 1.5,
                      dashPattern: const [10, 4],
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                        'Planta baixa',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  print('Dotted square tapped!');
                },
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: DottedBorder(
                      color: Colors.grey,
                      strokeWidth: 1.5,
                      dashPattern: const [10, 4],
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: const Text('Endereço'),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: realStateCEP,
                decoration: const InputDecoration(labelText: 'CEP *'),
                validator: (value) {
                  if (value!.length < 5) {
                    return 'Por favor, informe o CEP';
                  } else {
                    return null;
                  }
                },
              ),
              TextFormField(
                controller: realStateAddress,
                decoration: const InputDecoration(labelText: 'Endereço *'),
                readOnly: true,
              ),
              TextFormField(
                controller: realStateNumber,
                decoration: const InputDecoration(labelText: 'Número *'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, informe o número';
                  } else {
                    return null;
                  }
                },
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: const Text('Especificações'),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: realStateFloors,
                decoration: const InputDecoration(labelText: 'Andares'),
              ),
              TextFormField(
                controller: realStatePoolsQuantity,
                decoration:
                    const InputDecoration(labelText: 'Quantidade de piscinas'),
              ),
              TextFormField(
                controller: realStateTennisCourtsQuantity,
                decoration: const InputDecoration(
                    labelText: 'Quantidade de quadras de tênis'),
              ),
              TextFormField(
                controller: realStateFootballCourtsQuantity,
                decoration: const InputDecoration(
                    labelText: 'Quantidade de quadras de futebol'),
              ),
              TextFormField(
                controller: realStateSaunasQuantity,
                decoration:
                    const InputDecoration(labelText: 'Quantidade de saunas'),
              ),
              TextFormField(
                controller: realStatePartyRoomsQuantity,
                decoration: const InputDecoration(
                    labelText: 'Quantidade de salões de festas'),
              ),
              TextFormField(
                controller: realStateOutdoorGrillsQuantity,
                decoration: const InputDecoration(
                    labelText: 'Quantidade de churrasqueiras externas'),
              ),
              TextFormField(
                controller: realStatePlaygroundsQuantity,
                decoration: const InputDecoration(
                    labelText: 'Quantidade de playgrounds'),
              ),
              TextFormField(
                controller: realStateUnitsCount,
                decoration:
                    const InputDecoration(labelText: 'Contagem de unidades'),
              ),
              TextFormField(
                controller: realStateVisitorParkingSpotsQuantity,
                decoration: const InputDecoration(
                    labelText:
                        'Quantidade de vagas de estacionamento para visitantes'),
              ),
            ],
          ),
        ),
      ];
}

