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
import 'package:tintpin14_app/networks/endpoints.dart';

class DynamicScreen extends StatefulWidget {
  final String title;
  final String endpoint;
  const DynamicScreen({super.key, required this.title, required this.endpoint});

  @override
  State<DynamicScreen> createState() => _DynamicScreenState();
}

class _DynamicScreenState extends State<DynamicScreen> {
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
    getDynamicPageRx.fetch(
      dynamicEndpoint: Endpoints.getDynamicPage(widget.endpoint),
    );
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
