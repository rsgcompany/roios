//
//  LinksSocialprofileVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "LinksSocialprofileVC.h"
#import "ParserHClass.h"
#import "GlobalMethods.h"
#import "CustomTableViewH.h"
#import "MBProgressHUD.h"
@interface LinksSocialprofileVC ()<parserHDelegate,CustomTableViewHDelegate,MBProgressHUDDelegate>{
    
    ParserHClass *webParser;
    CustomTableViewH *dropDownV;
    MBProgressHUD *hud;
    

    NSMutableDictionary *paramDict;
}


@end

@implementation LinksSocialprofileVC
-(void)dismissKeyboard:(id)sender{
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [_scrollView addGestureRecognizer:tapGesture];

    
    [self setUpTextFieldPaging:YES];
    
    _scrollView.contentSize=CGSizeMake(320, 400);
    
}
-(void)setUpTextFieldPaging:(BOOL)mBool{
    _WebTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _WebTF.leftViewMode = UITextFieldViewModeAlways;
    
    _TwitterTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _TwitterTF.leftViewMode = UITextFieldViewModeAlways;
    
    _FbTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _FbTF.leftViewMode = UITextFieldViewModeAlways;
    
    _GooglePlusTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _GooglePlusTF.leftViewMode = UITextFieldViewModeAlways;
    
    _YLTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _YLTF.leftViewMode = UITextFieldViewModeAlways;
    
    _ULTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _ULTF.leftViewMode = UITextFieldViewModeAlways;

}
-(void)viewWillAppear:(BOOL)animated{
    _WebTF.text=appDel.CurrentOwnerDetails.owner_website_url;
    _TwitterTF.text=appDel.CurrentOwnerDetails.owner_twitter_url;
    _FbTF.text=appDel.CurrentOwnerDetails.owner_facebook_url;
    _GooglePlusTF.text= appDel.CurrentOwnerDetails.owner_gplus_url;
    _YLTF.text=appDel.CurrentOwnerDetails.owner_yelp_url;
    _ULTF.text=appDel.CurrentOwnerDetails.owner_urbanspoon_url;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _scrollView.contentSize=CGSizeMake(320, 500);
    
    if (textField == _WebTF) {
        [_scrollView setContentOffset:CGPointMake(0, 20) animated:YES];
    }else if (textField == _TwitterTF){
        [_scrollView setContentOffset:CGPointMake(0, 40) animated:YES];
    }else if(textField == _FbTF){
        [_scrollView setContentOffset:CGPointMake(0, 80) animated:YES];
    }else if(textField == _GooglePlusTF){
        [_scrollView setContentOffset:CGPointMake(0, 130) animated:YES];
    }else if(textField == _YLTF){
        [_scrollView setContentOffset:CGPointMake(0, 190) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake(0, 230) animated:YES];
    }
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _ULTF) {
        _scrollView.contentSize=CGSizeMake(320, 0);
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _WebTF) {
        [_TwitterTF becomeFirstResponder];
    }else if (textField == _TwitterTF) {
        [_FbTF becomeFirstResponder];
    }else if (textField == _FbTF) {
        [_GooglePlusTF becomeFirstResponder];
    }else if (textField == _GooglePlusTF) {
        [_YLTF becomeFirstResponder];
    }else if (textField == _YLTF) {
        [_ULTF becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}- (IBAction)backButtonAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)menuButtonAction:(id)sender {
    
    [self.view endEditing:YES];
    
    
    if(dropDownV==nil){
        [self menuViewShow:YES];
    }
    else{
        [self menuViewShow:NO];
    }
    
}


-(void)menuViewShow:(BOOL)myBool{
    [self.view endEditing:YES];
    
    if (myBool) {
        dropDownV = [[CustomTableViewH alloc] initWithStyle:UITableViewStylePlain];
        [dropDownV.view setFrame:CGRectMake(100, 55, 220, 0)];
        //        dropDownV.view.backgroundColor=[UIColor colorWithWhite:0.9f alpha:0.8f];
        dropDownV.view.backgroundColor=[UIColor whiteColor];
        
        dropDownV.delegate = self;
        
        
        [self.view addSubview:dropDownV.view];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [dropDownV.view setFrame:[dropDownV dropDownViewFrame]];
        [UIView commitAnimations];
        
        [_menuBtn setImage:[UIImage imageNamed:@"nf_close"] forState:UIControlStateNormal];

        
        //        _trasparentBlackView.hidden = NO;
        
    }else{
        [_menuBtn setImage:[UIImage imageNamed:@"HamburgerIcon"] forState:UIControlStateNormal];

        [UIView animateWithDuration:0.5
                         animations:^{
                             [dropDownV.view setFrame:CGRectMake(100, 55, 220, 0)];
                         }
                         completion:^(BOOL finished){
                             [dropDownV.view removeFromSuperview];
                             dropDownV=nil;
                             //                             _trasparentBlackView.hidden = YES;
                             
                         }
         ];
        
    }
}




#pragma mark
#pragma mark - CustomTableview Datasource Delegate
-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath{
    
    [self menuViewShow:NO];

    
    
    if (myIndexPath.row == 1) {
        [self performSegueWithIdentifier:@"goToAddDishView" sender:self];
    }else if (myIndexPath.row == 2){
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3){
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4) {
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5) {
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
    }else if (myIndexPath.row == 6){
        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    }else if (myIndexPath.row == 7) {
        [self performSegueWithIdentifier:@"goToNotificationsView" sender:self];
    }else if (myIndexPath.row == 8){
        [self goToSignInViewLogout];
    }
    
    
    
}
-(void)goToSignInViewLogout{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginE_PProfile"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OwnerProfile"];
    [appDel clearOwnerProfileClass];
    
    [self performSegueWithIdentifier:@"goToSignInV" sender:self];
    
}
#pragma mark
#pragma mark - CustomActivityIndicator Delegate
-(void)showActivityIndicatorInLinks:(BOOL)myBool{
    if (myBool) {
        if(hud != nil){
            [self.view addSubview:hud];
            hud = nil;
        }
        
        if(hud==nil){
            hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            hud.delegate = self;
            [hud show:YES];
            [self.view addSubview:hud];
        }
    }
    else{
        [hud hide:YES];
    }
}



- (IBAction)SaveSettings:(id)sender {
    
    [self showActivityIndicatorInLinks:YES];
    
/*
    Website url: http://www.
    Facebook url: http://www.facebook.com/
    Twitter Url: http://www.twitter.com/
    Yelp Url: http://www.yelp.com/biz/
    Urbanspoon URL: http://www.urbanspoon.com/
    GPlus URL: http://plus.google.com/
    Instagram URL: http://instagram/
 */
    /*
    if (_WebTF.text.length > 0) {
        if ([_WebTF.text rangeOfString:@"http://www."].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Official Website must be a valid url."];
            [_WebTF becomeFirstResponder];
            [self showActivityIndicatorInLinks:NO];
            return;
        }
    }
    
    
    if (_TwitterTF.text.length > 0) {
        if ([_TwitterTF.text rangeOfString:@"http://www.twitter.com/"].location==NSNotFound) {
                [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Twitter Profile must be a valid url."];
                [_TwitterTF becomeFirstResponder];
                [self showActivityIndicatorInLinks:NO];
                return;
        }
    }

    if (_FbTF.text.length > 0) {
        if ([_FbTF.text rangeOfString:@"http://www.facebook.com/"].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Facebook Page must be a valid url."];
            [_FbTF becomeFirstResponder];
            [self showActivityIndicatorInLinks:NO];
            return;
        }
    }
    
    if (_GooglePlusTF.text.length > 0) {
        if ([_GooglePlusTF.text rangeOfString:@"http://plus.google.com/"].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Google Plus must be a valid url."];
            [_GooglePlusTF becomeFirstResponder];
            [self showActivityIndicatorInLinks:NO];
            return;
        }
    }
    if (_YLTF.text.length > 0) {
        if ([_YLTF.text rangeOfString:@"http://www.yelp.com/biz/"].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Yelp Line must be a valid url."];
            [_YLTF becomeFirstResponder];
            [self showActivityIndicatorInLinks:NO];
            return;
        }
    }
    
    if (_ULTF.text.length > 0) {
        if ([_ULTF.text rangeOfString:@"http://www.urbanspoon.com/"].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Urbanspoon Link must be a valid url."];
            [_ULTF becomeFirstResponder];
            [self showActivityIndicatorInLinks:NO];
            return;
        }
    }
    */

    
    [self continueForParsing:YES];
   
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
-(void)addValueToSendingDictionary:(NSString *)myString andKey:(NSString *)myKey{
    if (myKey.length >= 1) {
        [paramDict setObject:myString forKey:myKey];
    }else{
        [paramDict setObject:@"" forKey:myKey];
    }
}
-(void)continueForParsing:(BOOL)myBool{
    paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    
    [self addValueToSendingDictionary:_WebTF.text andKey:@"website_url"];
    [self addValueToSendingDictionary:_TwitterTF.text andKey:@"twitter_url"];
    [self addValueToSendingDictionary:_FbTF.text andKey:@"facebook_url"];
    [self addValueToSendingDictionary:_GooglePlusTF.text andKey:@"gplus_url"];
    [self addValueToSendingDictionary:_YLTF.text andKey:@"yelp_url"];
    [self addValueToSendingDictionary:_ULTF.text andKey:@"urbanspoon_url"];
    
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];
}

#pragma mark
#pragma mark - Web Parser Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    NSLog(@"%@",result);
    [self showActivityIndicatorInLinks:NO];
    
    if (![[result valueForKey:@"error"] boolValue]) {
        if ([[result valueForKey:@"code"] integerValue] != 113) {
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
        }else{
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
            [self performSelector:@selector(saveLoginDetailsInDBL:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];
        }
    }
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showActivityIndicatorInLinks:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}

-(void)saveLoginDetailsInDBL:(NSDictionary *)result{
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:[result valueForKey:@"profile"]];
    [dict setObject:[result valueForKey:@"accessToken"] forKey:@"accessToken"];
    
    
    for (NSString * key in [dict allKeys]){
        if ([[dict objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:@"" forKey:key];
    }
    
    [appDel ownerProfileUpDateWithResult:dict];
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"OwnerProfile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [self performSelector:@selector(backButtonAction:) withObject:nil];
    
    
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"goToAddDishView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrdersView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReviewsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]){
        [segue destinationViewController];
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
