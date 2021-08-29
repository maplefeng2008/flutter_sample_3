import 'package:flutter/material.dart';
import 'package:necproject/providers/user_provider.dart';
import '../../utils/G.dart';
// import '../../widgets/Footer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _phone = '';
  String _password = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户登录'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 40),
            Center(
              child: Image.asset(
                'assets/images/flutter.jpg',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 60),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      fillColor: Colors.deepPurple[100],
                      filled: true,
                      border: InputBorder.none,
                      hintText: '手机号'
                    ),
                    validator: (value) {
                      RegExp reg = new RegExp(r'^\d{11}$');
                      if (!reg.hasMatch(value!)) {
                        return '手机号非法';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      print('_phone onSaved');
                      _phone = value as String;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      fillColor: Colors.deepPurple[100],
                      filled: true,
                      border: InputBorder.none,
                      hintText: '密码'
                    ),
                    validator: (value) {
                      return value?.length as num < 6 ? "密码长度不够": null;
                    },
                    onSaved: (value) {
                      print('_password onSaved');
                      _password = value as String;
                    },
                  )
                ],
              )
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() as bool) {
                        _formKey.currentState?.save();
                        
                        // 调用登录接口
                        var res = await G.api.user.login(_phone, _password);
                        print('---------');
                        print(res);
                        if (res != false && res['code'] == 200) {
                          // 持久化存储
                          _saveUserToken(res['data']);

                          // 更新状态
                          Provider.of<UserProvider>(context, listen: false).initUser(res['data']);

                          // G.router.pop(context);
                          Future.delayed(Duration(milliseconds: 500), () { 
                            G.router.navigateTo(context, '/mine');
                          });
                        } else {
                          G.error('登录失败');
                          print('登录失败');
                          _formKey.currentState?.reset();
                        }
                      }
                    }, 
                    child: Text('登录'),
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                      // shape: MaterialStateProperty.all(StadiumBorder()),
                    )
                  ),
                ),
              ]
            ),

            // Footer(),
          ],
        ),
      ),
    );
  }

  _saveUserToken(Map res) async {
    // 获取保存实例
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', res['token']);
    await prefs.setInt('expires_time', res['expires_time']);
  }
}
  