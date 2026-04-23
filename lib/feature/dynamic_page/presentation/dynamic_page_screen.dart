import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tintpin14_app/common_widgets/auth_common_text_form_field.dart';
import 'package:tintpin14_app/common_widgets/custom_app_bar.dart';
import 'package:tintpin14_app/common_widgets/glow_background.dart';
import 'package:tintpin14_app/common_widgets/waiting_widget.dart';
import 'package:tintpin14_app/constants/text_font_style.dart';
import 'package:tintpin14_app/feature/faqAndTermsOfService/model/faq_screen_model.dart';
import 'package:tintpin14_app/gen/colors.gen.dart';
import 'package:tintpin14_app/networks/api_access.dart';

class FaqScreen extends StatefulWidget {
  final String title;
  const FaqScreen({super.key, required this.title});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  int selectedTab = 0;
  FaqScreenModel? faqData;
  String searchQuery = '';
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    _fetchFaqData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchFaqData() {
    getFaqRx.fetch();
    getFaqRx.dataFetcher.stream.listen((data) {
      setState(() {
        faqData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlowBackground(
      appBar: CustomAppBar(
        title: widget.title,
        backgroundColor: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(child: Column(children: [
            

            ],
          )),
      ),
    );
  }
}
