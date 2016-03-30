//
//  OwnerProfileC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/24/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OwnerProfileC : NSObject




@property (nonatomic,retain) NSMutableArray *owner_profileImagesArray;


//@property (nonatomic,strong) UIImage *owner_image;
@property (strong, nonatomic) NSDictionary *owner_ProfilimageDic;
@property (nonatomic,retain) NSString *owner_accessToken;
@property (nonatomic,retain) NSString *owner_user_id;
@property (nonatomic,retain) NSString *owner_first_name;
@property (nonatomic,retain) NSString *owner_last_name;
@property (nonatomic,retain) NSString *owner_email;
@property (nonatomic,retain) NSString *owner_owns_restaurant_id;
@property (nonatomic,retain) NSString *owner_devicetoken;
@property (nonatomic,retain) NSString *owner_title;
@property (nonatomic,retain) NSString *owner_description;
@property (nonatomic,retain) NSString *owner_owner_name;
@property (nonatomic,retain) NSString *owner_phone;
@property (nonatomic,retain) NSString *owner_address;
@property (nonatomic,retain) NSString *owner_suite;
@property (nonatomic,retain) NSString *owner_city;
@property (nonatomic,retain) NSString *owner_state;
@property (nonatomic,retain) NSString *owner_zip;
@property (nonatomic,retain) NSString *owner_payment_method;
@property (nonatomic,retain) NSString *owner_ach_name;

@property (nonatomic,retain) NSString *owner_ach_account_number;
@property (nonatomic,retain) NSString *owner_ach_routing_number;

@property (nonatomic,retain) NSString *owner_paypal_name;
@property (nonatomic,retain) NSString *owner_paypal_email;
@property (nonatomic,retain) NSString *owner_check_name;
@property (nonatomic,retain) NSString *owner_check_address;
@property (nonatomic,retain) NSString *owner_check_suite;
@property (nonatomic,retain) NSString *owner_check_city;
@property (nonatomic,retain) NSString *owner_check_zip;
@property (nonatomic,retain) NSString *owner_check_state;
@property (nonatomic,retain) NSString *owner_city_tax;
@property (nonatomic,retain) NSString *owner_state_tax;


@property (nonatomic,retain) NSString *owner_website_url;
@property (nonatomic,retain) NSString *owner_gplus_url;
@property (nonatomic,retain) NSString *owner_facebook_url;
@property (nonatomic,retain) NSString *owner_twitter_url;
@property (nonatomic,retain) NSString *owner_urbanspoon_url;
@property (nonatomic,retain) NSString *owner_yelp_url;

@property (nonatomic) BOOL owner_email_ntfn;
@property (nonatomic) BOOL owner_txt_ntfn;
@property (nonatomic) BOOL owner_fax_ntfn;
@property (nonatomic) BOOL owner_dine_in;
@property (nonatomic) BOOL owner_pick_up;



@property (nonatomic,retain) NSString *owner_fax;
@property (nonatomic,retain) NSMutableArray *owner_cuisineArray;
@property (nonatomic,retain) NSString *owner_customCuisineStg;


@property (nonatomic,retain) NSArray *owner_cuisineDictionary;

@property (nonatomic,retain) NSString *owner_pdf_advt;



@end
