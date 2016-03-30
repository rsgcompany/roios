//
//  PaymentSettingsVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "PaymentSettingsVC.h"
#import "ParserHClass.h"
#import "GlobalMethods.h"
#import "MBProgressHUD.h"
#import "CustomTableViewH.h"

@interface PaymentSettingsVC ()<parserHDelegate,UITextFieldDelegate,MBProgressHUDDelegate,CustomTableViewHDelegate>{
    
    ParserHClass *webParser;
   
    BOOL isPaymentEnable;
    NSArray *paymentMetArray;
    int newHeight;

    CustomTableViewH *dropDownV;

    MBProgressHUD *hud;
    NSString *myString;
    
    
    NSString *ACHbankAccountNumbarStg,*ACHroutingNumberStg;
    
    /*
    NSString *str = @"123*abc";
    str = [str stringByReplacingOccurrencesOfString:@"*" withString:@""];
    */
    
    NSMutableDictionary *paramDict;
}



@end

@implementation PaymentSettingsVC

-(void)textFieldPagingSetUpInPayment{
    
    _PaymentmethodTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _PaymentmethodTF.leftViewMode = UITextFieldViewModeAlways;

    
    _bankACName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _bankACName.leftViewMode = UITextFieldViewModeAlways;
    
    _bankACNumber.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _bankACNumber.leftViewMode = UITextFieldViewModeAlways;
    
    _routingNumberTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _routingNumberTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    ////
    
    _FullNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _FullNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    _addressTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addressTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    _suiteTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _suiteTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    _cityTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _cityTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    _stateTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _stateTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    _zipCodeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _zipCodeTF.leftViewMode = UITextFieldViewModeAlways;
    //
    
    _paypalFullNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _paypalFullNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    _emailTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _emailTF.leftViewMode = UITextFieldViewModeAlways;
    
    
}

-(void)clickPaymentAction:(id)sender{
    [self.view endEditing:YES];
    
    _pickerViewH.tag = 1000031;

    [_pickerViewH reloadAllComponents];
    [self pickerViewPaymentShow:YES];
    
}
- (IBAction)stateInPaymentClicked:(id)sender {
    
    _pickerViewH.tag = 1000032;
    [_Scrollview setContentOffset:CGPointMake(0, 140) animated:YES];
    [self.view endEditing:YES];
    [_pickerViewH reloadAllComponents];
    [self pickerViewPaymentShow:YES];
    
}
-(void)pickerViewPaymentShow:(BOOL)myBool{
    [self.view endEditing:YES];
    if (!myBool) {
        [UIView animateWithDuration:0.3f animations:^{
            _transparentBlackView.hidden = YES;
            _pickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height, _pickerViewContainer.bounds.size.width, _pickerViewContainer.bounds.size.height);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            _transparentBlackView.hidden = NO;
            _pickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height-_pickerViewContainer.bounds.size.height, _pickerViewContainer.bounds.size.width, _pickerViewContainer.bounds.size.height);
        } completion:nil];
    }
}

#pragma mark
#pragma mark - CustomPickerView Datasource Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1000031) {
        return paymentMetArray.count;
    }else{
        return appDel.stateAry.count;
    }
    
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1000031) {
        return paymentMetArray[row];
    }else{
        return appDel.stateAry[row];
    }
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:Regular size:18]];
        [tView setTextAlignment:NSTextAlignmentCenter];
    }
    
    NSString *stg = nil;
    if (pickerView.tag == 1000031) {
        stg = paymentMetArray[row];
    }else{
        stg = appDel.stateAry[row];
    }
    
    tView.text = [NSString stringWithFormat:@"%@%@",[[stg substringToIndex:1] uppercaseString],[stg substringFromIndex:1] ];
    return tView;
}

-(void)tapGestureSetUp{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPaymentAction:)];
    [_paymentGesture addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *TransparectBlackVG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPickerViewAction:)];
    [_transparentBlackView addGestureRecognizer:TransparectBlackVG];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _Scrollview.contentSize=CGSizeMake(320, 300);
    self.navigationController.navigationBarHidden=YES;
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    
    [self tapGestureSetUp];
    
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"UserProfile"];
    _PaymentmethodTF.text = [dic valueForKey:@"payment_method"];
    
    [self textFieldPagingSetUpInPayment];
    
    _pickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height, _pickerViewContainer.bounds.size.width, _pickerViewContainer.bounds.size.height);
    [self.view addSubview:_pickerViewContainer];
    
//    _cancelPickerView.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:17.0f];
//    _donePickerview.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:17.0f];
    
    _pickerViewH.tag = 1000031;
    paymentMetArray=[[NSArray alloc]initWithObjects:@"ach",@"paypal",@"Check",nil];
    newHeight = 0;

}
-(void)viewWillAppear:(BOOL)animated{
    _PaymentmethodTF.text = appDel.CurrentOwnerDetails.owner_payment_method;
    
    
    NSLog(@"Dic = %@",appDel.CurrentOwnerDetails.owner_payment_method);
    
    if (appDel.CurrentOwnerDetails.owner_payment_method.length > 0 ) {
        [self paymentViewSetUpWithPamentMethod:appDel.CurrentOwnerDetails.owner_payment_method];
        [self reloadInputsWithString:appDel.CurrentOwnerDetails.owner_payment_method];
    }
}
-(void)reloadInputsWithString:(NSString *)myString1{
    if ([myString1 isEqualToString:@"ach"]) {
        _bankACName.text = appDel.CurrentOwnerDetails.owner_ach_name;
        
        ACHbankAccountNumbarStg = [self changeTextToSecureString:appDel.CurrentOwnerDetails.owner_ach_account_number];
        ACHroutingNumberStg = [self changeTextToSecureString:appDel.CurrentOwnerDetails.owner_ach_routing_number];
       
        _bankACNumber.text = [self changeTextToSecureString:appDel.CurrentOwnerDetails.owner_ach_account_number];
        _routingNumberTF.text = [self changeTextToSecureString:appDel.CurrentOwnerDetails.owner_ach_routing_number];
        
    }else if ([myString1 isEqualToString:@"paypal"]){
        _paypalFullNameTF.text = appDel.CurrentOwnerDetails.owner_paypal_name;
        _emailTF.text = appDel.CurrentOwnerDetails.owner_paypal_email;
    }else if ([myString1 isEqualToString:@"check"]){
        _FullNameTF.text = appDel.CurrentOwnerDetails.owner_check_name;
        _addressTF.text = appDel.CurrentOwnerDetails.owner_check_address;
        _suiteTF.text = appDel.CurrentOwnerDetails.owner_check_suite;
        _cityTF.text = appDel.CurrentOwnerDetails.owner_check_city;
        _stateTF.text = appDel.CurrentOwnerDetails.owner_check_state;
        _zipCodeTF.text = appDel.CurrentOwnerDetails.owner_check_zip;
    }
    
}



-(void)saveLoginDetailsInDB:(NSDictionary *)result{
    [_Scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    
    
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
    
    [self performSelector:@selector(backbuttonAction:) withObject:nil];
//    [self reloadInputsWithString:appDel.CurrentOwnerDetails.owner_payment_method];
    
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
//     _Scrollview.contentSize=CGSizeMake(320, 100+newHeight);
    
    if (textField == _bankACName){
        [_bankACNumber becomeFirstResponder];
    }else if (textField == _bankACNumber){
        [_routingNumberTF becomeFirstResponder];
    }else if (textField == _paypalFullNameTF){
        [_emailTF becomeFirstResponder];
    }else if (textField == _FullNameTF){
        [_addressTF becomeFirstResponder];
    }else if (textField == _addressTF){
        [_suiteTF becomeFirstResponder];
    }else if (textField == _suiteTF){
        [_cityTF becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField == _zipCodeTF) {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 5) ? NO : YES;
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.view endEditing:YES];
    
    if (textField == _routingNumberTF || textField == _emailTF || textField == _zipCodeTF) {
        [_Scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
//    [_Scrollview setContentOffset:CGPointMake(0, 0)];

//    _Scrollview.contentSize=CGSizeMake(320, 100+newHeight);
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    _Scrollview.contentSize=CGSizeMake(320, 100+newHeight);
    
    
    if (textField==_bankACName || textField == _paypalFullNameTF || textField == _FullNameTF) {
        [_Scrollview setContentOffset:CGPointMake(0, 60) animated:YES];
    }
    else if (textField==_bankACNumber || textField == _emailTF || textField==_addressTF || textField == _suiteTF){
        [_Scrollview setContentOffset:CGPointMake(0, 120) animated:YES];
    }
    else if (textField==_cityTF || textField==_stateTF || textField == _routingNumberTF){
        [_Scrollview setContentOffset:CGPointMake(0, 180) animated:YES];
    }
    else{
        [_Scrollview setContentOffset:CGPointMake(0, 250) animated:YES];
    }
    
}

-(void)addValueToSendingDictionary:(NSString *)myString1 andKey:(NSString *)myKey{
    if (myKey.length >= 1) {
        [paramDict setObject:myString1 forKey:myKey];
    }else{
        [paramDict setObject:@"" forKey:myKey];
    }
}

- (IBAction)SaveSettings:(id)sender {
    [self showActivityIndicatorInPaymentSt:YES];

    
    paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    
    [self addValueToSendingDictionary:_PaymentmethodTF.text andKey:@"payment_method"];
    [self addValueToSendingDictionary:_bankACName.text andKey:@"ach_name"];
    [self addValueToSendingDictionary:_bankACNumber.text andKey:@"ach_account_number"];
    [self addValueToSendingDictionary:_routingNumberTF.text andKey:@"ach_routing_number"];
    [self addValueToSendingDictionary:_paypalFullNameTF.text andKey:@"paypal_name"];
    [self addValueToSendingDictionary:_emailTF.text andKey:@"paypal_email"];
    [self addValueToSendingDictionary:_FullNameTF.text andKey:@"check_name"];
    [self addValueToSendingDictionary:_addressTF.text andKey:@"check_address"];
    [self addValueToSendingDictionary:_suiteTF.text andKey:@"check_suite"];
    [self addValueToSendingDictionary:_cityTF.text andKey:@"check_city"];
    [self addValueToSendingDictionary:_stateTF.text andKey:@"check_state"];
    [self addValueToSendingDictionary:_zipCodeTF.text andKey:@"check_zip"];
    


    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];
    
}

- (IBAction)backbuttonAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)dismissKeyboardPayment:(id)sender{
    [_Scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.view endEditing:YES];
    [self pickerViewPaymentShow:NO];
}
- (IBAction)cancelPickerViewAction:(id)sender {
    [_Scrollview setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.view endEditing:YES];
    [self pickerViewPaymentShow:NO];

}
- (IBAction)donePickerAction:(id)sender {
    [self.view endEditing:YES];
    

    if (_pickerViewH.tag == 1000031) {
        myString = [paymentMetArray objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        _PaymentmethodTF.text = myString;
    }
    else{
        myString = [appDel.stateAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        _stateTF.text = myString;
    }
    [self pickerViewPaymentShow:NO];
    
    [_Scrollview setContentOffset:CGPointMake(0, 0) animated:YES];

    [self paymentViewSetUpWithPamentMethod:myString];
    


}
-(void)paymentViewSetUpWithPamentMethod:(NSString *)myString1{
    newHeight=0;
    if ([myString1 isEqualToString:@"ach"]) {
        _BankPaymenyView.frame = CGRectMake(0, 100, _BankPaymenyView.bounds.size.width, _BankPaymenyView.bounds.size.height);
        [self setPaymentTypeValuesWithText:myString1];
        [_Scrollview addSubview:_BankPaymenyView];
        
        
        newHeight = _BankPaymenyView.bounds.size.height;
        
        [_PaypalView removeFromSuperview];
        [_ChequeView removeFromSuperview];
        
        UITapGestureRecognizer *paymentVGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboardPayment:)];
        [_BankPaymenyView addGestureRecognizer:paymentVGesture];
        
        
        
        
    }else if ([myString1 isEqualToString:@"paypal"]){
        _PaypalView.frame = CGRectMake(0, 100, _PaypalView.bounds.size.width, _PaypalView.bounds.size.height);
        [self setPaymentTypeValuesWithText:myString1];
        [_Scrollview addSubview:_PaypalView];
        newHeight = _PaypalView.bounds.size.height;
        
        
        [_BankPaymenyView removeFromSuperview];
        [_ChequeView removeFromSuperview];
        
        UITapGestureRecognizer *paymentVGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboardPayment:)];
        [_PaypalView addGestureRecognizer:paymentVGesture];
        
        
    }else{
        _ChequeView.frame = CGRectMake(0, 100, _ChequeView.bounds.size.width, _ChequeView.bounds.size.height);
        [self setPaymentTypeValuesWithText:myString1];
        [_Scrollview addSubview:_ChequeView];
        newHeight = _ChequeView.bounds.size.height;
        
        
        [_PaypalView removeFromSuperview];
        [_BankPaymenyView removeFromSuperview];
        
        UITapGestureRecognizer *paymentVGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboardPayment:)];
        [_ChequeView addGestureRecognizer:paymentVGesture];
        
    }
    [_Scrollview setContentSize:CGSizeMake(320, 100+newHeight)];
}
-(NSString *)changeTextToSecureString:(NSString *)myStg{
    
    
    
    if(myStg.length>4){
        for (int i=0; i<myStg.length-4; i++) {
            NSRange range = NSMakeRange(i,1);
            NSString *newText = [myStg stringByReplacingCharactersInRange:range withString:@"X"];
            myStg = newText;
        }
    }
    
    return  myStg;
}
-(void)setPaymentTypeValuesWithText:(NSString *)myStg{
    
  
    NSString *stg= [NSString stringWithFormat:@"%@ %@",appDel.CurrentOwnerDetails.owner_first_name,appDel.CurrentOwnerDetails.owner_last_name];

    if ([myStg isEqualToString:@"ACH"]) {
        
        _bankACName.text = stg;
        ACHbankAccountNumbarStg = appDel.CurrentOwnerDetails.owner_ach_account_number;
        ACHroutingNumberStg = appDel.CurrentOwnerDetails.owner_ach_routing_number;
        
        
        ACHbankAccountNumbarStg = [self changeTextToSecureString:appDel.CurrentOwnerDetails.owner_ach_account_number];
        ACHroutingNumberStg = [self changeTextToSecureString:appDel.CurrentOwnerDetails.owner_ach_routing_number];
        
        _bankACNumber.text = [self changeTextToSecureString:appDel.CurrentOwnerDetails.owner_ach_account_number];
        _routingNumberTF.text = [self changeTextToSecureString:appDel.CurrentOwnerDetails.owner_ach_routing_number];
        
        
        
        
    }else if ([myStg isEqualToString:@"Paypal"]) {
        _paypalFullNameTF.text = stg;
        _emailTF.text = appDel.CurrentOwnerDetails.owner_email;
    }else{
        _FullNameTF.text = stg;
        @try {
            _addressTF.text =  appDel.CurrentOwnerDetails.owner_address;
        }
        @catch (NSException *exception) {}
        
        @try {
            _suiteTF.text = appDel.CurrentOwnerDetails.owner_suite;
        }
        @catch (NSException *exception) {}
        @try {
            _cityTF.text = appDel.CurrentOwnerDetails.owner_city;
        }
        @catch (NSException *exception) {}
        @try {
            _stateTF.text = appDel.CurrentOwnerDetails.owner_state;
        }
        @catch (NSException *exception) {}
        @try {
            _zipCodeTF.text = appDel.CurrentOwnerDetails.owner_zip;
        }
        @catch (NSException *exception) {}
    }
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
#pragma mark - CustomActivityIndicator Delegate
-(void)showActivityIndicatorInPaymentSt:(BOOL)myBool{
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




-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    NSLog(@"%@",result);
    [self showActivityIndicatorInPaymentSt:NO];
    
    NSLog(@"%@",result);
    if (![[result valueForKey:@"error"] boolValue]) {
        if ([[result valueForKey:@"code"] integerValue] != 113) {
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
        }else{
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
            [self performSelector:@selector(saveLoginDetailsInDB:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];
        }
    }
    
    
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showActivityIndicatorInPaymentSt:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}



-(void)goToSignInViewLogout{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginE_PProfile"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OwnerProfile"];
    [appDel clearOwnerProfileClass];
    
    [self performSegueWithIdentifier:@"goToSignInV" sender:self];
    
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
