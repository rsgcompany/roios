//
//  SignInVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "SignInVC.h"
#import "ParserHClass.h"
#import "GlobalMethods.h"
#import "MBProgressHUD.h"
#import "OrdersVC.h"
#import <LocalAuthentication/LocalAuthentication.h>


@interface SignInVC ()<parserHDelegate,MBProgressHUDDelegate>{
    ParserHClass *webParser;
    MBProgressHUD *hud;
    
    NSString *isUpDating;

}

@property (nonatomic, strong)  UITextField *currentTextField;


@end

@implementation SignInVC



-(void)setUpTextFieldsPadding:(BOOL)myBool{
    _emailFld.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _emailFld.leftViewMode = UITextFieldViewModeAlways;
    
    _passwdFld.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _passwdFld.leftViewMode = UITextFieldViewModeAlways;
}
-(void)setUpScrollGesture:(BOOL)mBool{
    UITapGestureRecognizer *tapG= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scrollTapGestureAction:)];
    [_scrollV addGestureRecognizer:tapG];
}
-(void)setUpTextFieldlayers:(BOOL)myBool{
    _emailFld.layer.cornerRadius = 1.5f;
    _emailFld.layer.borderWidth = 0.5f;
    _emailFld.layer.borderColor = [UIColor lightGrayColor].CGColor;

    _passwdFld.layer.cornerRadius = 1.5f;
    _passwdFld.layer.borderWidth = 0.5f;
    _passwdFld.layer.borderColor = [UIColor lightGrayColor].CGColor;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    [self setUpTextFieldsPadding:YES];
    [self setUpTextFieldlayers:YES];
    [self setUpScrollGesture:YES];
    
    [self showActivityIndicatorInSignin:YES];
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    isUpDating = @"LoginDetails";
    [webParser parserJsonDataFromUrlString:RestaurentCategoriesUrl withIderntifier:@"categoryUrl"];
    [webParser parserJsonDataFromUrlString:RestaurentTaxesUrl withIderntifier:@"TaxesUrl"];
   
    //self.passwdFld.backgroundColor = [UIColor redColor];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LoginReminder"]) {
        _emailFld.text = [[[NSUserDefaults standardUserDefaults ] objectForKey:@"LoginReminder"] valueForKey:@"ownerEmailId"];
       // _passwdFld.text = [[[NSUserDefaults standardUserDefaults ] objectForKey:@"LoginReminder"] valueForKey:@"ownerPassword"];
    }
    

}
-(void)viewDidAppear:(BOOL)animated{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"LoginE_PProfile"]) {
        //  [self performSegueWithIdentifier:@"GoToOrdersView" sender:self];
        LAContext *context = [[LAContext alloc] init];
        
        NSError *error = nil;
        
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                    localizedReason:@"Please provide your authorised touch id to login to app"
                              reply:^(BOOL success, NSError *error) {
                                  
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      
                                      if (error) {
                                          //                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                          //                                                                                          message:@"There was a problem verifying your identity."
                                          //                                                                                         delegate:nil
                                          //                                                                                cancelButtonTitle:@"Ok"
                                          //                                                                                otherButtonTitles:nil];
                                          //                                          [alert show];
                                          // [self performSegueWithIdentifier:@"loginSegue" sender:self];
                                      }
                                      
                                      if (success) {
                                          [self performSegueWithIdentifier:@"GoToOrdersView" sender:self];
                                          [self showActivityIndicatorInSignin:NO];
                                          
                                      } else {
                                          
                                      }
                                      
                                  });
                                  
                              }];
            
        } else {
            [self performSegueWithIdentifier:@"GoToOrdersView" sender:self];
            
        }
        
        [self showActivityIndicatorInSignin:NO];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark
#pragma mark - TextField Delgates
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _currentTextField = textField;
    
//    if(!IS_IPHONE5)
        [_scrollV setContentOffset:CGPointMake(0, 100) animated:YES];
    
//    if (!emailImg.isHidden)
//    {
//        NSUInteger tag = [textField tag];
//        [self animateView:tag];
//        [self checkBarButton:tag];
//    }
//    else
//    {
//        NSUInteger tag = [textField tag];
//        [self animateView:tag];
//        [self checkBarButton:tag];
//    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [_scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    if(textField==zipFld)
//    {
//        if (textField.text.length >= 5 && range.length == 0)
//            return NO;
//    }
    return YES;
}

-(void)showActivityIndicatorInSignin:(BOOL)myBool{
    if (myBool) {
        if(hud != nil)
        {
            [self.view addSubview:hud];
            hud = nil;
        }
        
        
        if(hud==nil)
        {
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


- (IBAction)loginBtnClicked:(id)sender {
    [self.view endEditing:YES];
    
    if([_emailFld.text length]){
        if ([_passwdFld.text length]){
            if([GlobalMethods isItValidEmail:_emailFld.text])
            {
                
                [self showActivityIndicatorInSignin:YES];
                /*
                parseInt=1;
                NSString *devicetoken=[GlobalMethods getUDIDOfdevice];
                NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:emailFld.text, @"email",
                                        passwdFld.text, @"password", appDel.parseObjectID,@"devicetoken",nil];
                [parser parseAndGetDataForPostMethod:params withUlr:@"customerLogin"];
                */
//                NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
//                [paramDict setObject:@"harikrishnaelakanti@gmail.com" forKey:@"email"];
//                [paramDict setObject:@"sandyasatyam" forKey:@"password"];
//                [paramDict setObject:@"222222222222222222222222222222222222222" forKey:@"devicetoken"];
                
                NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
                [paramDict setObject:_emailFld.text forKey:@"email"];
                [paramDict setObject:_passwdFld.text forKey:@"password"];
                [paramDict setObject:@"12345678910" forKey:@"devicetoken"];
                [paramDict setObject:[appDel.deviceToken length]?appDel.deviceToken:@"" forKey:@"apn_device_token"];
                isUpDating = @"LoginDetails";
                [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"restaurantLogin"];
            }
            else
                [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter a valid Email"];
        }
        else
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter your password"];
    }
    else
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter your Email"];
}

#pragma mark -
#pragma mark - AlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==111) {
        if (buttonIndex==1) {
            NSString *emStr= [alertView textFieldAtIndex:0].text;
            if (![emStr length])
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Forgot password" message:@"Please enter your Email" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                alert.tag=111;
                [alert show];
            }
            
            else if(![GlobalMethods isItValidEmail:emStr])
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Forgot password" message:@"Please enter a valid Email" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                alert.alertViewStyle = UIAlertViewStylePlainTextInput;
                alert.tag=111;
                [alert show];
            }
            else
            {
                [self showActivityIndicatorInSignin:YES];
                NSMutableDictionary *paramDict = [[NSMutableDictionary alloc]initWithCapacity:0];
                [paramDict setObject:emStr forKey:@"email"];
                [paramDict setObject:@"restaurant" forKey:@"type"];
                isUpDating = @"FogotPassword";

                [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"forgotPassword"];
            }
        }
    }
}

- (IBAction)forgotPasswordButtonAction:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Forgot password" message:@"Please enter your Email" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag=111;
    [alert show];
    
    [self.view endEditing:YES];
}
-(void)scrollTapGestureAction:(id)sender{
    [self.view endEditing:YES];
}

#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    [self showActivityIndicatorInSignin:NO];
    
  
    if ([isUpDating isEqualToString:@"LoginDetails"]) {
        if (![[result valueForKey:@"error"] boolValue] ) {
            [self performSelector:@selector(saveLoginDetailsInDBS:) withObject:result afterDelay:0.1f];
        }else{
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
        }
    }else{
        if (![[result valueForKey:@"error"] boolValue]  ){
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:[result valueForKey:@"message"]];
        }else{
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:[result valueForKey:@"message"]];
        }
    }
    
    
 
}

-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showActivityIndicatorInSignin:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result withIdentifier:(NSString *)myIdentifier{
    [self showActivityIndicatorInSignin:NO];

    if ([myIdentifier isEqualToString:@"TaxesUrl"]) {
        [appDel setUpState_TaxAndCity_TaxWithDictionary:result];
    }
    if ([myIdentifier isEqualToString:@"categoryUrl"] && ![[result valueForKey:@"error"] boolValue]) {
        NSArray *SortAry = [GlobalMethods sortArrayDictionaryInAscendingOrderWithArray:[result valueForKey:@"message"] WithKey:@"title"];
        appDel.cuisineAry = [NSMutableArray arrayWithArray:SortAry];
        [appDel removeCusinesFromCusineArray:appDel.cuisineAry WithComparingArray:appDel.CurrentOwnerDetails.owner_cuisineArray];
    }
}

-(void)saveLoginDetailsInDBS:(NSDictionary *)result{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_emailFld.text, @"ownerEmailId", _passwdFld.text, @"ownerPassword",[result valueForKey:@"accessToken"],@"accessToken",[[result valueForKey:@"profile"] valueForKey:@"owns_restaurant_id"],@"restaurant_id" ,nil];
    
    [[NSUserDefaults standardUserDefaults] setObject:params forKey:@"LoginE_PProfile"];
    [[NSUserDefaults standardUserDefaults] setObject:params forKey:@"LoginReminder"];
    [[NSUserDefaults standardUserDefaults] synchronize];
        
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:[result valueForKey:@"profile"]];
    [dict setObject:[result valueForKey:@"accessToken"] forKey:@"accessToken"];
    
    for (NSString * key in [dict allKeys]) {
        if ([[dict objectForKey:key] isKindOfClass:[NSNull class]]) {
            [dict setObject:@"" forKey:key];
        }
        
    }
    
    [appDel ownerProfileUpDateWithResult:dict];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"OwnerProfile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
        

    
    //For removin
    [appDel removeCusinesFromCusineArray:appDel.cuisineAry WithComparingArray:appDel.CurrentOwnerDetails.owner_cuisineArray];


    [self goToNextVoewS];

}

-(void)goToNextVoewS{
    [self performSegueWithIdentifier:@"GoToOrdersView" sender:self];
}

-(void)setBoolvalues{
    
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"GoToOrdersView"]) {
        OrdersVC *VC =[segue destinationViewController];
        VC.isFrom = @"SignInView";
    }
}
- (IBAction)BackBtnClicked:(id)sender {
    [self.view endEditing:YES];

    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
