import 'package:flutter/material.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/Signup_Page/login_tab.dart';
import 'package:project_mealman/app/screens/Signup_Page/signup_tab.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/signuppage_images/signupPageBackground.png"),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 42,
                vertical: 155,
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40), color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        elevation: 5,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              //border: Border.all(),
                              color: Colors.white,
                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.mainColor,
                              ),
                              controller: tabController,
                              isScrollable: true,
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              unselectedLabelColor: AppColors.mainColor,
                              tabs: const [
                                Tab(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Jua',
                                    ),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    'Signup',
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'Jua'),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            //LoginTab(),
                            ListView.builder(
                              itemCount: 1,
                              itemBuilder: (_,index){
                              return Container(
                                //height: 300,
                                //width: 200,
                                child: LoginTab(),
                              );
                            }),
                            SignupTab(),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

// Widget _getEmailInputField() {
//   return Container(
//     margin: const EdgeInsets.symmetric(horizontal: 10.0),
//     child: TextField(
//       decoration: const InputDecoration(
//           suffix: Icon(Icons.email_outlined), hintText: "Enter email"),
//       keyboardType: TextInputType.emailAddress,
//       onChanged: (String value) {},
//     ),
//   );
// }
