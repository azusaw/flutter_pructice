import 'package:flutter/material.dart';
import 'package:flutter_sample/components/steps/billing_details_step.dart';
import 'package:flutter_sample/components/steps/event_info_step.dart';
import 'package:flutter_sample/components/steps/pay_off_step.dart';
import 'home_screen.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int _currentStep = 0;

  tapped(int step) => setState(() => _currentStep = step);

  continued() => _currentStep < 2 ? setState(() => _currentStep += 1) : null;

  cancel() => _currentStep > 0 ? setState(() => _currentStep -= 1) : null;

  finish() => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: StepperType.horizontal,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: Text('イベント'),
                      content: EventInfoStep(),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text('明細'),
                      content: BillingDetailsStep(),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: Text('清算'),
                      content: PayOffStep(),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                  controlsBuilder: (BuildContext context,
                      {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                    return Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed:
                                  _currentStep > 0 ? onStepCancel : finish,
                              child: const Text('前へ'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.cyan),
                            ),
                            ElevatedButton(
                              onPressed:
                                  _currentStep < 2 ? onStepContinue : finish,
                              child: const Text('次へ'),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.cyan),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
