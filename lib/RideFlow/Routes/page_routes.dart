import 'package:fixerking/RideFlow/BookRide/begin_ride.dart';
import 'package:fixerking/RideFlow/BookRide/ride_booked_page.dart';
import 'package:fixerking/RideFlow/DrawerPages/Home/offline_page.dart';
import 'package:fixerking/RideFlow/DrawerPages/Profile/my_profile.dart';
import 'package:fixerking/RideFlow/DrawerPages/Profile/reviews.dart';
import 'package:fixerking/RideFlow/DrawerPages/Rides/my_rides_page.dart';
import 'package:fixerking/RideFlow/DrawerPages/Settings/settings_page.dart';
import 'package:flutter/material.dart';
import '../DrawerPages/ContactUs/contact_us_page.dart';
import '../DrawerPages/Insight/insight_page.dart';
import '../DrawerPages/PromoCode/promo_code_page.dart';
import '../DrawerPages/Wallet/send_to_bank_page.dart';
import '../DrawerPages/Wallet/wallet_page.dart';
import '../DrawerPages/faq_page.dart';

class PageRoutes {
  static const String offlinePage = 'offline_page';
  static const String rideBookedPage = 'ride_booked_page';
  static const String beginRide = 'begin_ride';
  static const String insightPage = 'insight_page';
  static const String myRidesPage = 'my_ride_page';
  static const String rideInfoPage = 'ride_info_page';
  static const String sendToBank = 'send_to_bank';
  static const String walletPage = 'wallet_page';
  static const String reviewsPage = 'review_page';
  static const String myProfilePage = 'profile_page';
  static const String ReferEarn = 'Refer_Earn';
  static const String promoCode = 'promo_code';
  static const String contactUsPage = 'contact_us';
  static const String faqPage = 'faq_page';
  static const String settingsPage = 'settings_page';

  Map<String, WidgetBuilder> routes() {
    return {
      offlinePage: (context) => OfflinePage(""),
      rideBookedPage: (context) => RideBookedPage(),
      beginRide: (context) => BeginRide(),
      insightPage: (context) => InsightPage(),
      myRidesPage: (context) => MyRidesPage(),
      //rideInfoPage: (context) => RideInfoPage(null),
      // sendToBank: (context) => SendToBankPage("",""),
      // walletPage: (context) => WalletPage(),
      reviewsPage: (context) => ReviewsPage(),
      myProfilePage: (context) => MyProfilePage(),
      // promoCode: (context) => PromoCodePage(),
      contactUsPage: (context) => ContactUsPage(),
      // faqPage: (context) => FaqPage(),
      // settingsPage: (context) => SettingsPage(),
    };
  }
}
