import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:pay/pay.dart';
import 'package:purs_spring_24/src/test/payment_configurations.dart';
import 'package:share_plus/share_plus.dart';

int temp = 0;

class PageViewExample extends StatefulWidget {
  const PageViewExample({super.key});

  @override
  State<PageViewExample> createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  String defaultApplePayConfigString = defaultApplePay;
  String defaultGooglePayConfigString = defaultGooglePay;

  int _selectedPayment = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
    NfcManager.instance.startSession(onDiscovered: _NFCDiscovered);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
    NfcManager.instance.stopSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Photo"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            /// [PageView.scrollDirection] defaults to [Axis.horizontal].
            /// Use [Axis.vertical] to scroll vertically.
            controller: _pageViewController,
            onPageChanged: _handlePageViewChanged,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      "Step 1. Pet Info",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                      textScaler: TextScaler.linear(2),
                    ),
                  ),
                  const Divider(),
                  FutureBuilder(
                    future: NfcManager.instance.isAvailable(),
                    builder: (context, snapshot) {
                      if (snapshot.data == false) {
                        return Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                const Text("NFC unavailable"),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text("MOCKED"),
                                    ),
                                  ),
                                  child: const Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Enter their information manually",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return const Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                                child: Text(
                                    "Scan the NFC tag on the animal's kennel"),
                              ),
                              Icon(Icons.nfc_rounded, size: 100),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Text(
                        "Step 2. Share",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        textScaler: TextScaler.linear(2),
                      ),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: Center(
                      child: TextButton(
                        onPressed: _sharePressed,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.share),
                            Text(
                                "Share your picture on social media to earn points!"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  const Expanded(
                    child: Center(
                        child: Flexible(
                            child: Text(
                                "Upload your photo to the animal's profile on our website"))),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FloatingActionButton.extended(
                        onPressed: () =>
                            ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("MOCKED"),
                          ),
                        ),
                        label: const Row(
                          children: [Icon(Icons.upload), Text("Upload")],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      "Sponsor",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                      textScaler: TextScaler.linear(2),
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(child: SizedBox()),
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75),
                            child: const Text(
                              "Sponsoring an animal helps your favorite Heartland pet to get adopted.",
                              overflow: TextOverflow.visible,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SegmentedButton(
                            segments: const [
                              ButtonSegment(
                                value: 0,
                                label: Text("\$"),
                              ),
                              ButtonSegment(
                                value: 1,
                                label: Text("\$\$"),
                              ),
                              ButtonSegment(
                                value: 2,
                                label: Text("\$\$\$"),
                              ),
                            ],
                            selected: <int>{_selectedPayment},
                            onSelectionChanged: (newSelection) => {
                              setState(() {
                                _selectedPayment = newSelection.first;
                              })
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            switch (_selectedPayment) {
                              0 => "\$35",
                              1 => "\$50",
                              2 => "\$150",
                              _ => "0",
                            },
                          ),
                          const Expanded(child: SizedBox()),
                          GooglePayButton(
                            paymentConfiguration:
                                PaymentConfiguration.fromJsonString(
                                    defaultGooglePayConfigString),
                            paymentItems: [
                              PaymentItem(
                                label: 'Sponsor Total',
                                amount: switch (_selectedPayment) {
                                  0 => "35",
                                  1 => "50",
                                  2 => "150",
                                  _ => "0",
                                },
                                status: PaymentItemStatus.final_price,
                              )
                            ],
                            type: GooglePayButtonType.pay,
                            margin: const EdgeInsets.only(top: 15.0),
                            onPaymentResult: _onGooglePayResult,
                            loadingIndicator: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          PageIndicator(
            tabController: _tabController,
            currentPageIndex: _currentPageIndex,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            isOnDesktopAndWeb: _isOnDesktopAndWeb,
          ),
        ],
      ),
    );
  }

  void _sharePressed() async {
    final result = await Share.shareWithResult(
        'Share your photo to social media with #HeartlandHumaneSociety!',
        subject: "#HeartlandHumaneSociety");

    if (result.status == ShareResultStatus.success) {
      print("success: $result");
    }
  }

  void _onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }

  void _handlePageViewChanged(int currentPageIndex) {
    if (!_isOnDesktopAndWeb) {
      return;
    }
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  // https://medium.com/@antonioneus/reading-and-writing-nfc-using-nfcmanager-in-flutter-dc5420991967
  Future<void> _NFCDiscovered(NfcTag badge) async {
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   content: Text("NFC Discovered"),
    // ));
    var ndef = Ndef.from(badge);

    if (ndef != null && ndef.cachedMessage != null) {
      String tempRecord = "";

      for (var record in ndef.cachedMessage!.records) {
        tempRecord =
            "$tempRecord ${String.fromCharCodes(record.payload.sublist(record.payload[0] + 1))}";
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(tempRecord),
      ));

      // setState(() {
      //   _nfcData = tempRecord;
      // });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("bad NFC tag"),
        ),
      );
    }
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }
}

/// Page indicator for desktop and web platforms.
///
/// On Desktop and Web, drag gesture for horizontal scrolling in a PageView is disabled by default.
/// You can defined a custom scroll behavior to activate drag gestures,
/// see https://docs.flutter.dev/release/breaking-changes/default-scroll-behavior-drag.
///
/// In this sample, we use a TabPageSelector to navigate between pages,
/// in order to build natural behavior similar to other desktop applications.
class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.isOnDesktopAndWeb,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final bool isOnDesktopAndWeb;

  @override
  Widget build(BuildContext context) {
    if (!isOnDesktopAndWeb) {
      return const SizedBox.shrink();
    }
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
            icon: const Icon(
              Icons.arrow_left_rounded,
              size: 32.0,
            ),
          ),
          TabPageSelector(
            controller: tabController,
            color: colorScheme.background,
            selectedColor: colorScheme.primary,
          ),
          IconButton(
            splashRadius: 16.0,
            padding: EdgeInsets.zero,
            onPressed: () {
              if (currentPageIndex == 2) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
            icon: const Icon(
              Icons.arrow_right_rounded,
              size: 32.0,
            ),
          ),
        ],
      ),
    );
  }
}
