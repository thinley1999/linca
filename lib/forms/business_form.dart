import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/cards/business.dart';
import 'package:linca/main_drawer.dart';

class BusinessForm extends StatefulWidget {
  @override
  _BusinessFormState createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  final _businessController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212121),
      appBar: AppBar(
        backgroundColor: Color(0xFF212121),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      drawer: MainDrawer(),
      bottomNavigationBar: _getForm(),
    );
  }
  Widget _getForm() {
    return Container(
        padding: EdgeInsets.fromLTRB(20, 200, 20, 0),
        child: Column(children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.blue, Color(0xFF76FF03)]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: _businessController,
                    decoration: InputDecoration(
                        labelText: 'Business_ID',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      labelStyle: GoogleFonts.ptSerif(fontSize: 20, color: Colors.white),
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                        enabledBorder: InputBorder.none
                    ) ,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Business_Id is requires';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    if(!_formKey.currentState.validate()){
                      return ;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Business(business : _businessController.text),
                      ),
                    );
                  },
                  child: Text("Enter",style: GoogleFonts.ptSerif(fontSize: 15),),
                )
              ],
            ),
          ),
        ]));
  }
}
