//
//  GlobalMethods.m
//  EnjoyFresh
//
//  Created by S Murali Krishna on 04/08/14.
//  Copyright (c) 2014 Murali. All rights reserved.
//

#import "GlobalMethods.h"

@implementation GlobalMethods

+(UIViewController*)checkNavigationexits:(Class )viewcontroller navigation:(UINavigationController*)navigation;
{
    NSArray *arrayOfControllers=navigation.viewControllers;
    
    for (UIViewController *vc in arrayOfControllers) {
        
        if ([vc isKindOfClass:viewcontroller]) {
            return vc;
            break;
        }
    }
    return nil;
}

+(NSString*)getNibname:(NSString*)nibStr
{
    if (!IS_IPHONE5)
        nibStr=[NSString stringWithFormat:@"%@_iPhone4",nibStr];
    return nibStr;
}

+(BOOL)isItValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+(void)showAlertwithTitle:(NSString *)myTitle andMessage:(NSString *)myMessage{
    [[[UIAlertView alloc]initWithTitle:myTitle message:myMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil,nil]show];
}
+(void)showAlertwithTitle:(NSString *)myTitle ErrorCode:(NSInteger)myInteger{
    switch (myInteger) {
        case 001:
            [self showAlertwithTitle:myTitle andMessage:@"Connection error"];
            break;
        case 101:
            [self showAlertwithTitle:myTitle andMessage:@"Invalid AccessToken error!"];
            break;
        case 102:
            [self showAlertwithTitle:myTitle andMessage:@"Login failed"];
            break;
        case 103:
            [self showAlertwithTitle:myTitle andMessage:@"There was no restaurant!"];
            break;
        case 104:
            [self showAlertwithTitle:myTitle andMessage:@"There are no dishes!"];
            break;
        case 105:
            [self showAlertwithTitle:myTitle andMessage:@"There are no orders!"];
            break;
        case 106:
            [self showAlertwithTitle:myTitle andMessage:@"Orders Confirmed"];
            break;
        case 107:
            [self showAlertwithTitle:myTitle andMessage:@"Dish already exists"];
            break;
        case 108:
            [self showAlertwithTitle:myTitle andMessage:@"Dish added successfully"];
            break;
        case 109:
            [self showAlertwithTitle:myTitle andMessage:@"Dish details updated successfully"];
            break;
        case 110:
            [self showAlertwithTitle:myTitle andMessage:@"Sorry, this email already exists"];
            break;
        case 111:
            [self showAlertwithTitle:myTitle andMessage:@"Sorry, Owner with same restaurant name already exists in the db"];
            break;
        case 112:
            [self showAlertwithTitle:myTitle andMessage:@"User Created Successfully"];
            break;
        case 113:
            [self showAlertwithTitle:myTitle andMessage:@"Successfully updated!"];
            break;
        case 114:
            [self showAlertwithTitle:myTitle andMessage:@"Orders Went to Pending Status"];
            break;
        case 115:
            [self showAlertwithTitle:myTitle andMessage:@"Image updated successfully"];
            break;
        case 116:
            [self showAlertwithTitle:myTitle andMessage:@"Dish not existed"];
            break;
        case 117:
            [self showAlertwithTitle:myTitle andMessage:@"Restaurant doesn't have permission to upload images for this dish"];
            break;
        case 118:
            [self showAlertwithTitle:myTitle andMessage:@"There is no data for the selected date range."];
            break;
        case 122:
            [self showAlertwithTitle:myTitle andMessage:@"Cuisine type already exists"];

        default:
            break;
            
          
        

    }

}

/*
+(NSString*)getUDIDOfdevice
{
    NSString * devicetok = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return [devicetok stringByReplacingOccurrencesOfString:@"-" withString:@""];
#if TARGET_IPHONE_SIMULATOR
    NSString * devicetoken = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return [devicetoken stringByReplacingOccurrencesOfString:@"-" withString:@""];
#else
    // Device
    if([appDel.parse_ObjectId length])
    {
        NSString * devicetoken = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        return [devicetoken stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    return appDel.parse_ObjectId;
#endif
}
*/

+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize source:(UIImage*)sourceImages
{
	UIImage *sourceImage = sourceImages;
	UIImage *newImage = nil;
	CGSize imageSize = sourceImage.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;
	CGFloat targetWidth = targetSize.width;
	CGFloat targetHeight = targetSize.height;
	CGFloat scaleFactor = 0.0;
	CGFloat scaledWidth = targetWidth;
	CGFloat scaledHeight = targetHeight;
	CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
	
	if (CGSizeEqualToSize(imageSize, targetSize) == NO)
	{
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
		
        if (widthFactor > heightFactor)
			scaleFactor = widthFactor; // scale to fit height
        else
			scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
		
        // center the image
        if (widthFactor > heightFactor)
		{
			thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
		}
        else
			if (widthFactor < heightFactor)
			{
				thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
			}
	}
	
	UIGraphicsBeginImageContext(targetSize); // this will crop
	
	CGRect thumbnailRect = CGRectZero;
	thumbnailRect.origin = thumbnailPoint;
	thumbnailRect.size.width  = scaledWidth;
	thumbnailRect.size.height = scaledHeight;
	
	[sourceImage drawInRect:thumbnailRect];
	
	newImage = UIGraphicsGetImageFromCurrentImageContext();
	if(newImage == nil)
        NSLog(@"could not scale image");
	
	//pop the context to get back to the default
	UIGraphicsEndImageContext();
	return newImage;
}
+(UITextField*)setPlaceholdText:(NSString*)str forTxtFld:(UITextField*)txtFld
{
    if ([txtFld respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor colorWithRed:212/255.0f green:56/255.0f blue:49/255.0f alpha:1.0f];
        txtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    [txtFld setFont:[UIFont fontWithName:Regular size:16.0f]];
    
    txtFld.clearButtonMode = UITextFieldViewModeWhileEditing;
    return txtFld;
}
#pragma mark -
#pragma mark - Base64Conversion
+ (NSString*)base64forData:(NSData*)theData {
    
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}
+(NSDictionary*)barbuttonFont
{
return  @{NSFontAttributeName:[UIFont fontWithName:Regular size:16.0f]};
}

+(UIImage *)starImagewithRating:(NSInteger)myrating{
    UIImage *img;
    switch (myrating) {
        case 9:
            img = [UIImage imageNamed:@"star.png"];
            break;
        case 1:
            img = [UIImage imageNamed:@"star1.png"];
            break;
        case 2:
            img = [UIImage imageNamed:@"star2.png"];
            break;
        case 3:
            img = [UIImage imageNamed:@"star3.png"];
            break;
        case 4:
            img = [UIImage imageNamed:@"star4.png"];
            break;
        case 5:
            img = [UIImage imageNamed:@"star5.png"];
            break;
            
            
        default:
            break;
    }
    return img;
}


+(NSString *)convertDictionaryToJSONString:(NSMutableDictionary *)myDic{
    NSData *CuisinesData = [NSJSONSerialization dataWithJSONObject:myDic options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:CuisinesData encoding:NSUTF8StringEncoding];
}

+(NSArray *)sortArrayDictionaryInAscendingOrderWithArray:(NSArray *)myArray WithKey:(NSString *)myKey{
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:myKey ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortByName];
    return [myArray sortedArrayUsingDescriptors:sortDescriptors];
}
+(NSDictionary *)SegmentAttributes{
    return  @{NSForegroundColorAttributeName:green_Color,NSFontAttributeName:[UIFont fontWithName:Medium size:Buttonfont]};
}
+(void)changeSegmentContrilTintColor:(UISegmentedControl *)sender{
    for (int i=0; i<[sender.subviews count]; i++){
        if ([[sender.subviews objectAtIndex:i]isSelected] ){
            [[sender.subviews objectAtIndex:i] setTintColor:green_Color];
        }
        else {
            [[sender.subviews objectAtIndex:i] setTintColor:light_gray_color];
            
        }
    }
    [sender setTitleTextAttributes:[self SegmentAttributes] forState:UIControlStateNormal];
}


+(NSString *)dateFormettForCell:(NSString *)mydateStg{
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc] init];

    [df1 setFormatterBehavior:NSDateFormatterBehavior10_4];
    [df1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [df1 dateFromString:mydateStg];
    [df1 setDateFormat:@"EEEE, MMMM, d.  yyyy"];
    NSString *stg = [df1 stringFromDate:date];
    
    [df1 setDateFormat:@"d"];
    int date_day = [[df1 stringFromDate:date] intValue];
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
    NSString *suffix = [suffixes objectAtIndex:date_day];
    
    stg = [stg stringByReplacingOccurrencesOfString:@"." withString:suffix];
    
    
    
    return stg;
}
+ (NSString *) stringByRemovingCharactersInSet:(NSCharacterSet*)charactersToRemove withTextStg:(NSString *)myStg{
    return [[myStg componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
}

+(NSString *) stringByFilteringCharactersInSet:(NSCharacterSet*)charactersToKeep withTextStg:(NSString *)myStg{
    NSCharacterSet *charactersToRemove = [charactersToKeep invertedSet] ;
    return [self stringByRemovingCharactersInSet:charactersToRemove withTextStg:myStg];
}
+(NSString *)appendDollerToString:(NSString *)myStg{
    return [NSString stringWithFormat:@"$%@",myStg];
}
+(BOOL)whiteSpacesAvailableForString:(NSString *)myStg{
    NSCharacterSet *whitespacePh = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedPh = [myStg stringByTrimmingCharactersInSet:whitespacePh];
    if ([trimmedPh length] == 0) {
        // Text was empty or only whitespace.
        return YES;
    }else{
        return NO;
    }
    return YES;
}
@end
