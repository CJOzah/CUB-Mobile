import 'package:cub_mobile/main.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../banking_screen.dart';

class TransferSuccessDialogue extends StatefulWidget {

  static String id = 'TransferSuccessDialogue';
  final String amount;
  final String name;

  const TransferSuccessDialogue({Key key, this.amount, this.name}) : super(key: key);

  @override
  _TransferSuccessDialogueState createState() =>
      _TransferSuccessDialogueState();
}

class _TransferSuccessDialogueState extends State<TransferSuccessDialogue>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controller1;
  Animation<Offset> _offsetAnimation;

  AnimationController _controller2;
  Animation<Offset> _offsetAnimation1;

  AnimationController _controller3;
  Animation<Offset> _offsetAnimation2;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
    );

    _controller1 = AnimationController(
      duration: const Duration(milliseconds: 1600),
      vsync: this,
    )..repeat(reverse: false);
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.5),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller1,
      curve: Curves.elasticInOut,
    ));
    Future.delayed(Duration(milliseconds: 1400), () {
      _controller1.stop();
    });

    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..repeat(reverse: false);
    _offsetAnimation1 = Tween<Offset>(
      begin: Offset(0.0, 1.7),
      end: const Offset(0.0, 0.1),
    ).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.elasticInOut,
    ));
    Future.delayed(Duration(milliseconds: 1600), () {
      _controller2.stop();
    });

    _controller3 = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: false);
    _offsetAnimation2 = Tween<Offset>(
      begin: Offset(0.0, 1.7),
      end: const Offset(0.0, 0.2),
    ).animate(CurvedAnimation(
      parent: _controller3,
      curve: Curves.elasticInOut,
    ));
    Future.delayed(Duration(milliseconds: 1800), () {
      _controller3.stop();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 400.0),
                child: Lottie.asset(
                  'images/success_animation.json',
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,
                  controller: _controller,
                  onLoaded: (composition) {
                    // Configure the AnimationController with the duration of the
                    // Lottie file and start the animation.
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SlideTransition(
                    position: _offsetAnimation,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 300.0),
                      child: Center(
                        child: Text(
                          "Congratulations!",
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _offsetAnimation1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 200.0),
                      child: Center(
                        child: Text(
                          "You have Successfully transferred the sum of ${widget.amount} to ${widget.name} you will receive a debit alert soon",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _offsetAnimation2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: FlatButton(
                        height: 50.0,
                        minWidth: double.infinity,
                        color: primaryRed,
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            {
                              _controller.reverse();
                              _controller1.reverse();
                              _controller2.reverse();
                              _controller3
                                  .reverse()
                                  .then((value) => Navigator.pushNamedAndRemoveUntil(context, BankingScreen.id, (route) => false));
                            }
                            // Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class TransferInsufficientFunds extends StatelessWidget {
//   final String accBal;
//   final String amount;
//   final String accountNumber;
//
//   const TransferInsufficientFunds({
//     Key key,
//     this.accBal,
//     this.accountNumber,
//     this.amount,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           margin: EdgeInsets.only(left: 60.0, right: 60.0),
//           elevation: 10.0,
//           child: Container(
//             height: 300.0,
//             width: double.infinity,
//             child: Padding(
//               padding:
//               const EdgeInsets.only(bottom: 15.0, left: 10.0, right: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(left: 230.0),
//                     child: iconButton(
//                       function: () => Navigator.pop(context),
//                       icon: Icons.close,
//                       color: Colors.black,
//                       size: 30,
//                     ),
//                   ),
//                   Text(
//                     "No enough balance?",
//                     style: TextStyle(
//                       fontSize: 22.0,
//                     ),
//                   ),
//                   HorizontalLine(
//                     color: primaryRed,
//                     height: 2.0,
//                     width: 115.0,
//                   ),
//                   SizedBox(
//                     height: 5.0,
//                   ),
//                   Text(
//                       "You have Insufficient balance in the selected amount. to  proceed. You need NGN $amount in your account."),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 28.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Bank account: $accountNumber",
//                         ),
//                         Text(
//                           "Balance: $accBal",
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                     child: RoundedRect(
//                       height: 40.0,
//                       width: double.infinity,
//                       color: primaryRed,
//                       fillColor: Colors.white,
//                       text: "Re-check Balance",
//                       onpressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           color: Colors.white,
//         )
//       ],
//     );
//   }
// }