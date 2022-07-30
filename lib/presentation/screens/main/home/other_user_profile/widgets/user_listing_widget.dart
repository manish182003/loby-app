import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../../../../widgets/drop_down.dart';
import '../../widgets/ItemList.dart';

class UserListingWidget extends StatelessWidget {
  const UserListingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return _buildWidget(textTheme);
  }

  _buildWidget(TextTheme textTheme) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const MyDropDownWidget(),
              const SizedBox(height: 16),
              const MyDropDownWidget(),
              const SizedBox(height: 8),
              _buildGames(textTheme)

            ],
          ),
        ),
      ],
    );
  }

  _buildGames(TextTheme textTheme) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6.0 / 9,
        mainAxisSpacing: 0.h,
        crossAxisSpacing: 3.h,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ItemList(name: 'hello $index');
      },
    );
  }
}
