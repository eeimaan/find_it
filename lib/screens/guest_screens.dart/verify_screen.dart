import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/app_colors.dart';
import 'package:finder_app/constants/app_images.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widgets/custom_profile_details_row.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/app_text.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => VerifyScreenState();
}

class VerifyScreenState extends State<VerifyScreen> {
  String? uid = FirebaseAuth.instance.currentUser?.uid;
  late CollectionReference collectionReference;

  @override
  void initState() {
    super.initState();
    collectionReference =
        FirebaseFirestore.instance.collection(AppText.userDataCollection);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const CustomText(
            text: 'Send Details',
            letterSpacing: 1,
            color: AppColors.black,
            size: 18,
            weight: FontWeight.w500,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: StreamBuilder(
                stream: collectionReference.doc(uid).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 152,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                snapshot.data![AppText.image],
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomUserInfoRow(
                          label: 'Name',
                          value: snapshot.data![AppText.name],
                        ),
                        Divider(
                          color: AppColors.grey,
                        ),
                        CustomUserInfoRow(
                          label: 'Phone no',
                          value: snapshot.data![AppText.phoneNumber],
                        ),
                        Divider(
                          color: AppColors.grey,
                        ),
                        CustomUserInfoRow(
                          label: 'Nationality',
                          value: snapshot.data![AppText.country],
                        ),
                        Divider(
                          color: AppColors.grey,
                        ),
                        CustomUserInfoRow(
                          label: 'ID/ Passport # ',
                          value: snapshot.data![AppText.address],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        const CustomText(
                          text: 'Select Payment Method',
                          letterSpacing: 1,
                          color: AppColors.black,
                          size: 18,
                          weight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Wallet',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Current balance ',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '\$67',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Icon(
                              size: 16,
                              Icons.arrow_forward_ios,
                              color: AppColors.grey,
                            ),
                            onTap: () {},
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        PaymentMethodItem(
                          title: 'Paypal',
                          subtitle: '',
                          leading: Image.asset(AppImages.paypal,
                              width: 30, height: 30),
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        PaymentMethodItem(
                          title: 'Visa',
                          subtitle: '**** **** 4987',
                          leading: Image.asset(AppImages.visa,
                              width: 30, height: 40),
                          onTap: () {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        PaymentMethodItem(
                          title: 'Add New Card',
                          subtitle: '',
                          leading: Image.asset(AppImages.addCard,
                              width: 40, height: 40),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.addNewCard);
                          },
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        CustomButton(
                          btnColor: AppColors.green,
                          textColor: Colors.white,
                          text: 'Submit',
                          onPressed: () async {},
                          width: MediaQuery.sizeOf(context).width,
                        ),
                      ],
                    );
                  } else {
                    return CupertinoActivityIndicator();
                  }
                }),
          ),
        ),
      ),
    );
  }
}
