import 'package:balanced_meal/views/order/place_order_screen.dart';
import 'package:balanced_meal/controllers/calorie_controller.dart';
import 'package:balanced_meal/views/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class userInfoScreen extends StatefulWidget {
  const userInfoScreen({super.key});

  @override
  State<userInfoScreen> createState() => _userInfoScreenState();
}

class _userInfoScreenState extends State<userInfoScreen> {
  bool isFormValid = false;
  String? gender;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    weightController.addListener(_validateForm);
    heightController.addListener(_validateForm);
    ageController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid =
        gender != null &&
        weightController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        ageController.text.isNotEmpty;

    if (isValid != isFormValid) {
      setState(() {
        isFormValid = isValid;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      int UserCalories = CalorieService().Calories_Calculation(
        age: int.parse(ageController.text),
        gender: gender!,
        height: int.parse(heightController.text),
        weight: int.parse(weightController.text),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (context) => placeOrder_screen(userTotalCalories: UserCalories),
        ),
      );
    }
  }

  @override
  void dispose() {
    weightController.dispose();
    heightController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appBar_Widget(title: 'Enter your details'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 51.h),
                  child: Column(
                    spacing: 24.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gender Section
                      Column(
                        spacing: 10.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF474747),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            value: gender,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Choose your gender',
                            ),
                            items:
                                ['Male', 'Female']
                                    .map(
                                      (g) => DropdownMenuItem<String>(
                                        value: g,
                                        child: Text(g),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (String? val) {
                              setState(() {
                                gender = val;
                                _validateForm();
                              });
                            },
                            validator:
                                (value) =>
                                    value == null
                                        ? 'Please select your gender'
                                        : null,
                          ),
                        ],
                      ),

                      // Weight Section
                      Column(
                        spacing: 10.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Weight',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF474747),
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          TextFormField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your weight',
                              suffixText: 'kg',
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.parse(value) <= 0 ||
                                  int.parse(value) > 635) {
                                return 'Please enter your real weight';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),

                      // Height Section
                      Column(
                        spacing: 10.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Height',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF474747),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextFormField(
                            controller: heightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your height',
                              suffixText: 'cm',
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.parse(value) <= 0 ||
                                  int.parse(value) > 251) {
                                return 'Please enter your real height';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),

                      // Age Section
                      Column(
                        spacing: 10.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Age',
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF474747),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextFormField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your age',
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  int.parse(value) <= 0 ||
                                  int.parse(value) > 116) {
                                return 'Please enter your real age';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Next Button
                Padding(
                  padding: EdgeInsets.only(top: 70.h),
                  child: SizedBox(
                    width: 372.w,
                    height: 60.h,
                    child: ElevatedButton(
                      onPressed: isFormValid ? _submitForm : null,
                      child: const Text('Next'),
                      style: Theme.of(context).elevatedButtonTheme.style,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
