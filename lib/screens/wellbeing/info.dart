import 'package:flutter/material.dart';
import 'package:mymgs/data_classes/identifiable.dart';
import 'package:mymgs/widgets/page_layouts/info.dart';

class WellbeingInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoScreen(
      identifier: customIdentifiable("safeguarding_help"),
      title: "Getting help",
      markdownContent: """
If you have any worries or concerns about anything at school or at home, staff at
School are here to help. Remember that you can always share any concerns with your
tutor, one of your teachers, your Head of Year, or the school nurses.

Safeguarding and promoting the welfare of pupils are the School's highest priorities.
The member of staff with overall responsibility for ensuring that support is provided
to any pupil who is in need or at risk of harm is the Pastoral Deputy Head, Mr A.
N. Smith ([a.n.smith@mgs.org](mailto:a.n.smith@mgs.org)). He is the Designated
Safeguarding Lead for the School, responsible for child protection.

You can read the School's 
[Safeguarding and Child Protection policy](https://mymgs.link/safeguarding-child-protection-2020)
on our [website](https://mgs.org).

Remember that there are other organisations which can provide support, with websites
and confidential phone lines.
      """,
    );
  }
}