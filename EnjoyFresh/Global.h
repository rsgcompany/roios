//
//  Global.h
//  EnjoyFresh
//   
//  Created by S Murali Krishna on 04/08/14.
//  Copyright (c) 2014 Murali. All rights reserved.
//

#ifndef EnjoyFresh_Global_h
#define EnjoyFresh_Global_h

#import "AppDelegate.h"
#define appDel ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define AppTitle @"EnjoyFresh!"

///////////****** api QA *****////////////////
#define RestaurentTaxesUrl @"http://www.qa.enjoyfresh.com/mobile/api/v1/getTaxes"
#define RestaurentImageUrl @"http://www.qa.enjoyfresh.com/public/upload/restaurant/"

#define baseUrl @"http://www.qa.enjoyfresh.com/mobile/api/v1/"
#define RestaurentCategoriesUrl @"http://www.qa.enjoyfresh.com/mobile/api/v1/getCategories"
#define DishImageUrl @"http://www.qa.enjoyfresh.com/public/upload/restaurant/dish/"
#define ReviewImageUrl @"http://www.qa.enjoyfresh.com/public/upload/user/"

////////////////////////

#define Bold @"Raleway-Bold"
#define ExtraBold @"Raleway-ExtraBold"
#define ExtraLight @"Raleway-ExtraLight"
#define Light @"Raleway-Light"
#define Medium @"Raleway-Medium"
#define Regular @"Raleway-Regular"
#define SemiBold @"Raleway-SemiBold"

#define green_Color [UIColor colorWithRed:99.0f/255.0f green:157.0f/255.0f blue:88.0f/255.0f alpha:1.0f]
#define red_Color [UIColor colorWithRed:212.0f/255.0f green:56.0f/255.0f blue:49.0f/255.0f alpha:1.0f]
#define light_gray_color [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1.0]

#define Buttonfont 13.0f
#define dropdownCount 8
#define TermsConditionsUrl @"http://www.enjoyfresh.com/ef/tos"

#define  homeStr1 @"Connecting food lovers to inspired chefs\n"
#define  homeStr2 @"Explore off-menu items\n"
#define  homeStr3 @"Rethink dining out\n"
#define  homeStr4 @"BECOME AN ENJOY FRESH MEMBER \n"



#define IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height > 568)
#define MainWidth [[UIScreen mainScreen] bounds].size.width
#define MainHeight [[UIScreen mainScreen] bounds].size.height

#define AlphaNumarics @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
#define Alphabets @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ,."

#define Numarics @"1234567890"

 //#define RestaurentTaxesUrl @"http://enjoyfresh.com/mobile/api_v2_ro/v1/getTaxes"
 //#define RestaurentImageUrl @"http://enjoyfresh.com/public/upload/restaurant/"

 //#define baseUrl @"http://enjoyfresh.com/mobile/api_v2_ro/v1/"
//#define BaseURLImage @"http://enjoyfresh.com/public/upload/restaurant/dish/"
//#define UserURlImge @"http://enjoyfresh.com/public/upload/user/"
//#define BaseURLRestaurant @"http://enjoyfresh.com/public/upload/restaurant/"
 //#define ReviewImageUrl @"http://enjoyfresh.com/public/upload/user/"
 //#define DishImageUrl @"http://enjoyfresh.com/public/upload/restaurant/dish/"
 //#define RestaurentCategoriesUrl @"http://enjoyfresh.com/mobile/api_v2_ro/v1/getCategories"



#define gmail @"outbox@enjoyfresh.com"

//#define BaseURL @"http://enjoyfresh.com/mobile/api/v1/"
////#define BaseURL @"http://www.qa.enjoyfresh.com/mobile/api/v1/"
//#define BaseURLImage @"http://enjoyfresh.com/public/upload/restaurant/dish/"
//#define UserURlImge @"http://enjoyfresh.com/public/upload/user/"
//#define BaseURLRestaurant @"http://enjoyfresh.com/public/upload/restaurant/"
//#define gmail @"outbox@enjoyfresh.com"


#endif





