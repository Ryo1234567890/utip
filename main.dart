import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:utip/widgets/bill_amount_field.dart';
import 'package:utip/widgets/person_counter.dart';
import 'package:utip/widgets/tip_slider.dart';
import 'package:utip/widgets/total_per_person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(context.widget);
    return MaterialApp(
      title: 'UTip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UTip(),
    );
  }
}

class UTip extends StatefulWidget {
  const UTip({super.key});

  @override
  State<UTip> createState() => _UTipState();
}

class _UTipState extends State<UTip> {
  int _personCount = 1;
  double _tipPercentage = 0.0;
  double _billTotal = 0.0;

  double totalPerperson(){
    return((_billTotal * _tipPercentage) + (_billTotal)) / _personCount;
  }

  double totalTip(){
    return(_billTotal * _tipPercentage);
  }


  void increment(){
    setState(() {
      _personCount = _personCount + 1;
    });
  }

  void decrement(){
    setState(() {
      if(_personCount>1){
        _personCount--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(context.widget);
    var theme = Theme.of(context);
    double total = totalPerperson();
    double totalT = totalTip();
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('UTip'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TotalPerPerson(style: style, total: total, theme: theme),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: 
                    Border.all(color: theme.colorScheme.primary,width: 2)),
                    child: Column(
                      children: [
                        BillAmountField(
                          billAmount: _billTotal.toString(),
                          onChanged: (value){
                            setState(() {
                              _billTotal = double.parse(value);
                            });
                            // print("Amount: $value");
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Split',
                            style: theme.textTheme.titleMedium,
                            ),
                            PersonCounter(
                              theme: theme,
                              personCount: _personCount,
                              onDecrement: decrement,
                              onIncrement: increment,
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tip',
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              totalT.toStringAsFixed(2),
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),

                        Text('${(_tipPercentage*100).round()}%'),

                        TipSlider(
                          tipPercentage: _tipPercentage,
                          onChanged: (double value) { 
                          setState(() {
                            _tipPercentage = value;
                          });
                         },)
                        
                      ],
                    )
              ),
            )
        ],
      )
    );
  }
}





