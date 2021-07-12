import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linca/cards/college_student.dart';
import 'package:linca/main_drawer.dart';

class CollegeStudentForm extends StatefulWidget {
  @override
  _CollegeStudentFormState createState() => _CollegeStudentFormState();
}

class _CollegeStudentFormState extends State<CollegeStudentForm> {
  final _collegeStudentController = TextEditingController();
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
                    controller: _collegeStudentController,
                    decoration: InputDecoration(
                        labelText: 'Student_ID',
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
                        builder: (context) => CollegeStudent(student : _collegeStudentController.text),
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
