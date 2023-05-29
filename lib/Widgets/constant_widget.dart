import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:urban_hive_test/Helpers/constants.dart';

import '../Helpers/colors.dart';

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: Theme.of(context).textTheme.displaySmall,
            )));
  }
}

class BodyText extends StatelessWidget {
  final String title;
  Color? color;
  BodyText({
    required this.title,
    this.color = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 14, fontWeight: FontWeight.normal, color: color),
            )));
  }
}

class SubTitleText extends StatelessWidget {
  final String title;
  final double size;
  FontWeight? fontWeight;
  SubTitleText({
    required this.title,
    this.size = 21,
    this.fontWeight = FontWeight.w900,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: size, fontWeight: fontWeight),
            )));
  }
}

class CustomSubTitleText extends StatelessWidget {
  final String title;
  final double size;
  final Color? color;
  final bool align;
  FontWeight? fontWeight;
  CustomSubTitleText({
    required this.title,
    required this.color,
    this.size = 21,
    this.align = false,
    this.fontWeight = FontWeight.bold,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: align
          ? Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontSize: size, fontWeight: fontWeight, color: color)))
          : Align(
              //alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: size, fontWeight: fontWeight, color: color),
              ),
            ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final onTap;
  final Color color;
  final Color textcolor;

  const CustomButton({
    required this.title,
    this.onTap,
    this.color = Colors.black,
    this.textcolor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap == null) ? () {} : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        width: double.infinity,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: textcolor),
          ),
        ),
      ),
    );
  }
}

class SmallCustomButton extends StatelessWidget {
  final String title;

  const SmallCustomButton({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 5, offset: Offset(0, 5), color: Colors.grey),
          BoxShadow(offset: Offset(-5, 0), color: Colors.black),
          BoxShadow(color: Colors.black, offset: Offset(5, 0)),
        ],
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      //width: ,
      // height: 20,
      child: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
    );
  }
}

class SmallCustomRowButton extends StatelessWidget {
  final String title;

  final IconData? icon;

  const SmallCustomRowButton({
    required this.title,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(blurRadius: 5, offset: Offset(0, 5), color: Colors.grey),
            BoxShadow(offset: Offset(-5, 0), color: Colors.white),
            BoxShadow(color: Colors.white, offset: Offset(5, 0)),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        //width: ,
        // height: 20,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey,
              size: 17,
            ),
            horizontalSpacer(9),
            CustomSubTitleText(
              fontWeight: FontWeight.w100,
              title: title,
              color: Colors.black,
              size: 18,
            ),
          ],
        ));
  }
}

class SmallCustomAcceptButton extends StatelessWidget {
  final String title;
  final bool isaccept;
  final IconData? icon;
  void Function()? onTap;

  SmallCustomAcceptButton({
    required this.title,
    required this.isaccept,
    this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                  blurRadius: 5, offset: Offset(0, 5), color: Colors.grey),
              BoxShadow(
                  offset: const Offset(-5, 0),
                  color: isaccept ? Yellow : Colors.white),
              BoxShadow(
                  color: isaccept ? Yellow : Colors.white,
                  offset: const Offset(5, 0)),
            ],
            color: isaccept ? Yellow : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          //width: ,
          // height: 20,
          child: Row(
            children: [
              Icon(
                icon,
                color: isaccept ? Colors.grey : Colors.red,
                size: 17,
              ),
              horizontalSpacer(9),
              CustomSubTitleText(
                fontWeight: FontWeight.w100,
                title: title,
                color: isaccept ? Colors.white : Colors.grey,
                size: 18,
              ),
            ],
          )),
    );
  }
}

class SmallCustomButton1 extends StatelessWidget {
  final String title;
  final bool isaccept;
  final IconData? icon;
  void Function()? onTap;

  SmallCustomButton1({
    required this.title,
    required this.isaccept,
    this.onTap,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          decoration: BoxDecoration(
            boxShadow: [
              const BoxShadow(
                  blurRadius: 5,
                  offset: Offset(0, 5),
                  color: Color(0xfff4a50c)),
              BoxShadow(
                  offset: const Offset(-5, 0),
                  color: isaccept ? Colors.black : Colors.black),
              BoxShadow(
                  color: isaccept ? Colors.black : Colors.black,
                  offset: const Offset(5, 0)),
            ],
            color: isaccept ? Colors.black : Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          //width: ,
          // height: 20,
          child: Row(
            children: [
              Icon(
                icon,
                color: isaccept ? Colors.grey : Colors.red,
                size: 17,
              ),
              horizontalSpacer(9),
              CustomSubTitleText(
                fontWeight: FontWeight.w100,
                title: title,
                color: isaccept ? Colors.white : Colors.white,
                size: 18,
              ),
            ],
          )),
    );
  }
}

Future<dynamic> showdialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          elevation: 0,
          contentPadding: const EdgeInsets.all(90),
          backgroundColor: Colors.transparent,
          children: [loader()],
        );
      });
}

Widget loader({
  double size = 50,
}) {
  return SpinKitWave(
    color: Yellow,
  );
}

Widget loaderWhite({
  double size = 50,
}) {
  return SpinKitWave(
    color: Colors.white,
    size: size,
  );
}

Widget loaderBlack({
  double size = 50,
}) {
  return SpinKitWave(
    color: Colors.black,
    size: size,
  );
}

Widget blackLoader({
  double size = 50,
}) {
  return const SpinKitWave(
    color: Colors.black,
  );
}

class CustomButton1 extends StatelessWidget {
  final String title;
  final onTap;
  final Color color;
  final Color textcolor;

  const CustomButton1({
    required this.title,
    this.onTap,
    this.color = Colors.black,
    this.textcolor = Colors.black,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap == null) ? () {} : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        width: double.infinity,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: textcolor),
          ),
        ),
      ),
    );
  }
}

class CustomBioText extends StatelessWidget {
  final String title;
  final double size;
  final Color? color;
  final bool align;
  FontWeight? fontWeight;
  CustomBioText({
    required this.title,
    required this.color,
    this.size = 17,
    this.align = false,
    this.fontWeight = FontWeight.bold,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: align
          ? Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: size, fontWeight: fontWeight, color: color),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ))
          : Align(
              //alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontSize: size, fontWeight: fontWeight, color: color),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
    );
  }
}

class ClickableSmallCustomButton extends StatelessWidget {
  final String title;
  void Function()? onTap;

  ClickableSmallCustomButton({
    required this.title,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(blurRadius: 5, offset: Offset(0, 5), color: Colors.grey),
            BoxShadow(offset: Offset(-5, 0), color: Colors.black),
            BoxShadow(color: Colors.black, offset: Offset(5, 0)),
          ],
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        //width: ,
        // height: 20,
        child: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
