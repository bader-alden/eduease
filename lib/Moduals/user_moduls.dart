import 'dart:convert';

class user_moduls{
  String? name;
  String? number;
  String? type;
  String? image;
  String? school;
  String? classe;
  List dst = [];
  user_moduls.fromjson(jsona){
    print(json.decode(jsona['Dst']));
    dst.addAll(json.decode(jsona['Dst']));
    school= json.decode(jsona['school'])[0];
    classe= json.decode(jsona['school'])[1];
    name = json.decode(jsona['name']);
    number = json.decode(jsona['number']);
    type = json.decode(jsona['type']);
    image = json.decode(jsona['image']);
  }
}