//
//  GlobalMethods.h
//  EnjoyFresh
//
//  Created by S Murali Krishna on 04/08/14.
//  Copyright (c) 2014 Murali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"

@interface GlobalMethods : NSObject


+(NSString*)getNibname:(NSString*)nibStr;
+(BOOL)isItValidEmail:(NSString *)checkString;
+(void)showAlertwithTitle:(NSString *)myTitle andMessage:(NSString *)myMessage;
+(void)showAlertwithTitle:(NSString *)myTitle ErrorCode:(NSInteger)myInteger;
//+(NSString*)getUDIDOfdevice;



+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize source:(UIImage*)sourceImages;



//+(UITextField*)setPlaceholdText:(NSString*)str forTxtFld:(UITextField*)txtFld;
//+(UIViewController*)checkNavigationexits:(Class )viewcontroller navigation:(UINavigationController*)navigation;
+ (NSString*)base64forData:(NSData*)theData;
+(NSDictionary*)barbuttonFont;

+(UIImage *)starImagewithRating:(NSInteger)myrating;
+(NSString *)convertDictionaryToJSONString:(NSMutableDictionary *)myDic;
+(NSArray *)sortArrayDictionaryInAscendingOrderWithArray:(NSArray *)myArray WithKey:(NSString *)myKey;
+(void)changeSegmentContrilTintColor:(UISegmentedControl *)sender;
+(NSString *)dateFormettForCell:(NSString *)mydateStg;

+(NSString *) stringByFilteringCharactersInSet:(NSCharacterSet*)charactersToRemove withTextStg:(NSString *)myStg;
+(NSString *)appendDollerToString:(NSString *)myStg;
+(BOOL)whiteSpacesAvailableForString:(NSString *)myStg;


@end
