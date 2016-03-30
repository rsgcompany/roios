//
//  LoginSettingsVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "LoginSettingsVC.h"
#import "ParserHClass.h"
#import "GlobalMethods.h"

#import "MBProgressHUD.h"
#import "CustomTableViewH.h"

@interface LoginSettingsVC ()<parserHDelegate,MBProgressHUDDelegate,CustomTableViewHDelegate>{
    
    ParserHClass *webParser;
    MBProgressHUD *hud;
    NSMutableDictionary *FDic;
    CustomTableViewH *dropDownV;

}


@end

@implementation LoginSettingsVC
-(void)dismissKeyboard:(id)sender{
    [self.view endEditing:YES];
}
-(void)textFieldPagingSetUpInreg2{
    
    _EmailTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _EmailTF.leftViewMode = UITextFieldViewModeAlways;
    
    _PasswordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _PasswordTF.leftViewMode = UITextFieldViewModeAlways;
    
    _ConfirmPasswordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _ConfirmPasswordTF.leftViewMode = UITextFieldViewModeAlways;
    
}
-(void)viewWillAppear:(BOOL)animated{
    

    
    _EmailTF.text = appDel.CurrentOwnerDetails.owner_email;
    _PasswordTF.text = [[[NSUserDefaults standardUserDefaults ] objectForKey:@"LoginReminder"] valueForKey:@"ownerPassword"];
    _ConfirmPasswordTF.text = @"";
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden=YES;
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    _scrollView.contentSize = CGSizeMake(320, 400);
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [_scrollView addGestureRecognizer:tapGesture];

    [self textFieldPagingSetUpInreg2];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _EmailTF) {
        [_scrollView setContentOffset:CGPointMake(0, 20) animated:YES];
    }else if (textField == _PasswordTF){
        [_scrollView setContentOffset:CGPointMake(0, 30) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake(0, 40) animated:YES];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [_scrollView setContentOffset:CGPointMake(0, 5) animated:YES];

    if (textField == _PasswordTF) {
        NSUInteger newLength = [textField.text length];
        if (newLength<8) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Password must be atleast 8 characters"];
            [_PasswordTF becomeFirstResponder];
            _PasswordTF.text=@"";
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)SaveSettings:(id)sender {
    
    if (_EmailTF.text.length==0 || _PasswordTF.text.length==0 || _ConfirmPasswordTF.text.length==0) {
        [[[UIAlertView alloc] initWithTitle:AppTitle message:@"Empty fields are not allowed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
    }
    
    else if (![_PasswordTF.text isEqualToString:_ConfirmPasswordTF.text]) {
        
        [[[UIAlertView alloc] initWithTitle:AppTitle message:@"Confirm password does not match" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        
        _ConfirmPasswordTF.text=@"";
        [_ConfirmPasswordTF becomeFirstResponder];
        
    }else if([_PasswordTF.text length]<8){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Password must be atleast 8 characters"];
       
    }
    
    else if(![GlobalMethods isItValidEmail:_EmailTF.text]){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter a valid Email"];
        
       
    }else{
               
//        NSMutableDictionary *prof=[[NSUserDefaults standardUserDefaults ] objectForKey:@"LoginReminder"];
//        [prof setObject:_PasswordTF.text forKey:@"ownerPassword"];
//        [[NSUserDefaults standardUserDefaults ]  setObject:prof forKey:@"LoginReminder"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self showActivityIndicatorInSignin:YES];
        NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
        [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
        [paramDict setObject:_EmailTF.text forKey:@"email"];
        [paramDict setObject:_PasswordTF.text forKey:@"password"];
        [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];
        
        
    }
    
    
        
    
}
-(void)showActivityIndicatorInSignin:(BOOL)myBool{
    if (myBool) {
        if(hud != nil){
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    [self showActivityIndicatorInSignin:NO];
 
    if (![[result valueForKey:@"error"] boolValue]) {
        if ([[result valueForKey:@"code"] integerValue] != 113) {
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
            _PasswordTF.text = @"";
            _ConfirmPasswordTF.text = @"";
        }else{
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
            [self performSelector:@selector(saveLoginDetailsInDB:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];
        }
    }else{
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
        [_EmailTF becomeFirstResponder];
    }
  
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showActivityIndicatorInSignin:NO];
    
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
    _PasswordTF.text = @"";
    _ConfirmPasswordTF.text = @"";
    
}
-(void)saveLoginDetailsInDB:(NSDictionary *)result{
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:[result valueForKey:@"profile"]];
    [dict setObject:[result valueForKey:@"accessToken"] forKey:@"accessToken"];
    
    
    for (NSString * key in [dict allKeys])
    {
        if ([[dict objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:@"" forKey:key];
    }
    
    [appDel ownerProfileUpDateWithResult:dict];
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"OwnerProfile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    //    [GlobalMethods showAlertwithTitle:@"EnjoyFresh!" andMessage:@"Welcome to EnjoyFresh!\n\n HAppy New Year my OWNER!"];
    
    
    
//    [self viewWillAppear:YES];
    [self performSelector:@selector(backButtonAction:) withObject:nil];
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

- (IBAction)backButtonAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"goToAddDishView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrdersView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReviewsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]) {
        [segue destinationViewController];
    }

    
}



@end
