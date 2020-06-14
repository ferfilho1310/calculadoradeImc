import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _info = "IMC";
  TextEditingController peso = TextEditingController();
  TextEditingController altura = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void calcularImc() {
    setState(() {
      double pesoinformado = double.parse(peso.text);
      double alturainformada = double.parse(altura.text) / 100;
      double imc = pesoinformado / (alturainformada * alturainformada);
      print(imc);
      if (imc < 18.6) {
        _info = "Abaixo do peso " + imc.toStringAsPrecision(3).toString();
      }
    });
  }

  void resetfileds() {
    setState(() {
      _info = "IMC";
    });
    peso.text = "";
    altura.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              resetfileds();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outline, size: 250, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 15),
                  controller: peso,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira seu peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (Cm)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 15),
                  controller: altura,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Insira sua Altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Container(
                      height: 50,
                      child: RaisedButton(
                        onPressed: () {
                          if(_formkey.currentState.validate()){
                            calcularImc();
                          }
                        },
                        child: Text("Calcular",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                        color: Colors.green,
                      )),
                ),
                Text(
                  _info,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                )
              ],
            ),
          )),
    );
  }
}
