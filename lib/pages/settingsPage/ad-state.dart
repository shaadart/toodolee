// // import 'dart:io';

// // import 'package:google_mobile_ads/google_mobile_ads.dart';

// // // class AdState {
// // //   AdState({
// // //     this.initialization,
// // //   });
// // //   Future<InitializationStatus> initialization;

// // //   String get bannerAdUnitId {
// // //     if (Platform.isAndroid) {
// // //       return "ca-app-pub-3388943164060824/1044548156";
// // //     } else if (Platform.isIOS) {
// // //       return "";
// // //     }

// // //   }

// // //   AdListener get adListener {
// // //     return _adListener;
// // //   }
// // //   AdListener _adListener = AdListener(
// // //     // Called when an ad is successfully received.
// // //     onAdLoaded: (Ad ad) => print('Ad loaded.'),
// // //     // Called when an ad request failed.
// // //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
// // //       // Dispose the ad here to free resources.
// // //       ad.dispose();
// // //       print('Ad failed to load: $error');
// // //     },
// // //     // Called when an ad opens an overlay that covers the screen.
// // //     onAdOpened: (Ad ad) => print('Ad opened.'),
// // //     // Called when an ad removes an overlay that covers the screen.
// // //     onAdClosed: (Ad ad) => print('Ad closed.'),
// // //     // Called when an impression occurs on the ad.
// // //     onAdImpression: (Ad ad) => print('Ad impression.'),
// // //   );
// // // }

// // class AdState {
// //   AdState({
// //      this.initialization,
// //   });
// //   Future<InitializationStatus> initialization;

// //   String get bannerAdUnitId {
// //     if (Platform.isAndroid) {
// //       return 'ca-app-pub-3940256099942544/6300978111';
// //     } else {
// //       return 'ca-app-pub-3940256099942544/2934735716';
// //     }
// //   }

// //   AdListener get adListener => _adListener;

// //   AdListener _adListener = AdListener(
// //     // Called when an ad is successfully received.
// //     onAdLoaded: (Ad ad) => print('Ad loaded.'),
// //     // Called when an ad request failed.
// //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
// //       ad.dispose();
// //       print('Ad failed to load: $error');
// //     },
// //     // Called when an ad opens an overlay that covers the screen.
// //     onAdOpened: (Ad ad) => print('Ad opened.'),
// //     // Called when an ad removes an overlay that covers the screen.
// //     onAdClosed: (Ad ad) => print('Ad closed.'),
// //     // Called when an ad is in the process of leaving the application.
// //     onApplicationExit: (Ad ad) => print('Left application.'),
// //   );
// // }
// import 'dart:io';

// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdMobService {
//   // static String get bannerAdUnitId {
//   //   if (Platform.isAndroid) {
//   //     return 'ca-app-pub-3940256099942544/6300978111';
//   //   } else if (Platform.isIOS) {
//   //     return '';
//   //   } else {
//   //     throw new UnsupportedError('Unsupported platform');
//   //   }
//   // }

//   static initialize() {
//     if (MobileAds.instance == null) {
//       MobileAds.instance.initialize();
//     }
//   }

//   static BannerAd createBannerAd() {
//     BannerAd myBanner = BannerAd(
//       adUnitId: "ca-app-pub-3940256099942544/6300978111",
//       size: AdSize.largeBanner,
//       request: AdRequest(),
//       listener: AdListener(
//         // Called when an ad is successfully received.
//         onAdLoaded: (Ad ad) {
//           print('Ad loaded.');
//         },
//         // Called when an ad request failed.
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           // Dispose the ad here to free resources.
//           ad.dispose();
//           print('Ad failed to load: $error');
//         },
//         // Called when an ad opens an overlay that covers the screen.
//         onAdOpened: (Ad ad) => print('A  d opened.'),
//         // Called when an ad removes an overlay that covers the screen.
//         onAdClosed: (Ad ad) => print('Ad closed.'),
//         // Called when an impression occurs on the ad.
//         //onAdImpression: (Ad ad) => print('Ad impression.'),
//       ),
//     );
//     return myBanner;
//   }
// }
