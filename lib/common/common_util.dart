import 'package:flutter/material.dart';

Container getBackgroundImage() {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/bg-red.png',
            ))),
  );
}

Widget getVersion(String version, double height, {Function? func}) {
  if (version != '') {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        getDownLogo(height / 2),
        GestureDetector(
          onTap: () {
            if (func != null) {
              func();
            }
          },
          child: Text(
            version,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  } else {
    return const SizedBox.shrink();
  }
}

Widget getTopLogo(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Image.asset(
            'assets/images/mobilonay.png',
            fit: BoxFit.contain,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(child: const FittedBox(fit: BoxFit.fitWidth, child: Text('MOBİL', style: TextStyle(color: Colors.white)))),
              ),
              Expanded(
                flex: 3,
                child: Container(
                    child: const FittedBox(
                        fit: BoxFit.fitWidth, child: Text('ONAY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget getDownLogo(double widgetHeight) {
  return SizedBox(
    height: widgetHeight,
    child: Image.asset(
      'assets/images/beyazlogo.png',
      fit: BoxFit.fitHeight,
    ),
  );
}
