import 'package:e_commerce_app/Home%20Page/components/ProductProfile.dart';
import 'package:e_commerce_app/Others/ProductCards/StaggeredCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Models/common.dart';
import '../constants/constants.dart';
import '../constants/widgets.dart';
import 'SortPage.dart';

class ListviewDiscount extends StatefulWidget {
  _ListviewDiscountState createState() => _ListviewDiscountState();
}

class _ListviewDiscountState extends State<ListviewDiscount> {
  Widget hasError() {
    return SizedBox(
      height: 200,
      child: Center(
        child: IconButton(
          icon: Icon(
            Icons.refresh_outlined,
            size: 40,
            color: kPrimaryColor_1,
          ),
          onPressed: () {
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        listName(AppLocalizations.of(context).arzanladys, () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => SortPage(
                    name: AppLocalizations.of(context).arzanladys,
                  )));
        }, context),
        FutureBuilder<List<Product>>(
            future: Product().getAllProducts(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError)
                return hasError();
              else if (snapshot.hasData) {
                return Container(
                    height: 290,
                    margin: EdgeInsets.only(bottom: 20),
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (_) => ProductProfile(
                                        productId: snapshot.data[index].id,
                                      )));
                            },
                            child: Container(
                              width: 200,
                              height: 300,
                              child: StaggeredCard(
                                product: snapshot.data[index],
                              ),
                            ),
                          );
                        }));
              }
              return shimmerProduct();
            }),
      ],
    );
  }
}
