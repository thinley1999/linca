import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/cards/civil_servant.dart';
import 'package:linca/main_drawer.dart';

class CivilServantForm extends StatefulWidget {
  @override
  _CivilServantFormState createState() => _CivilServantFormState();
}

class _CivilServantFormState extends State<CivilServantForm> {
  final _civilServantController = TextEditingController();
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
                    controller: _civilServantController,
                    decoration: InputDecoration(
                        labelText: 'Civil_Servant_ID',
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
                        builder: (context) => CivilServant(civilServant : _civilServantController.text ),
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
