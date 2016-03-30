//
//  RegisterVC3.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/6/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "RegisterVC3.h"
#import "GlobalMethods.h"
#import "AddDishVC.h"

@interface RegisterVC3 (){
     float newHeight;
    NSArray *paymentMetArray;
}

@end

@implementation RegisterVC3
-(void)textFieldPagingSetUpInreg2{
    
    _webSiteTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _webSiteTF.leftViewMode = UITextFieldViewModeAlways;

    _urbanSpponTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _urbanSpponTF.leftViewMode = UITextFieldViewModeAlways;

    _yepLinrTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _yepLinrTF.leftViewMode = UITextFieldViewModeAlways;
    
    _instagramTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _instagramTF.leftViewMode = UITextFieldViewModeAlways;
    
    _facebookTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _facebookTF.leftViewMode = UITextFieldViewModeAlways;
    
    _twitterTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _twitterTF.leftViewMode = UITextFieldViewModeAlways;

    _paymentTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _paymentTF.leftViewMode = UITextFieldViewModeAlways;

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




#pragma mark
#pragma mark - CustomPickerView Datasource Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1000011) {
        return paymentMetArray.count;
    }else{
        return appDel.stateAry.count;
    }
    
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1000011) {
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
    if (pickerView.tag == 1000011) {
        stg =  paymentMetArray[row];
    }else{
        stg =  appDel.stateAry[row];
    }
    
    
    tView.text = [NSString stringWithFormat:@"%@%@",[[stg substringToIndex:1] uppercaseString],[stg substringFromIndex:1] ];
    return tView;
}


- (IBAction)stateInPaymentClicked:(id)sender {
    
    _pickerViewR3.tag = 1000012;
    
    [self.view endEditing:YES];
    [_pickerViewR3 reloadAllComponents];
    [self pickerViewR3Show:YES];
    
}


-(void)pickerViewR3Show:(BOOL)myBool{
    [self.view endEditing:YES];

    if (!myBool) {
        [UIView animateWithDuration:0.3f animations:^{
            _transparentBlackView.hidden = YES;
            _pickerViewActionSheet.frame = CGRectMake(0, self.view.bounds.size.height, _pickerViewActionSheet.bounds.size.width, _pickerViewActionSheet.bounds.size.height);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            _transparentBlackView.hidden = NO;
            _pickerViewActionSheet.frame = CGRectMake(0, self.view.bounds.size.height-_pickerViewActionSheet.bounds.size.height, _pickerViewActionSheet.bounds.size.width, _pickerViewActionSheet.bounds.size.height);
        } completion:nil];
    }
}

- (IBAction)pickerCancelAction:(id)sender {
    [self.view endEditing:YES];
    [self.view bringSubviewToFront:_finishBtn];

    [self pickerViewR3Show:NO];
}
- (IBAction)pickerDoneAction:(id)sender {
    [self.view endEditing:YES];
    [self.view bringSubviewToFront:_finishBtn];

    NSString *myString;
    if (_pickerViewR3.tag == 1000011) {
        myString = [paymentMetArray objectAtIndex:[_pickerViewR3 selectedRowInComponent:0]];
        _paymentTF.text = myString;
    }
    else{
        myString = [appDel.stateAry objectAtIndex:[_pickerViewR3 selectedRowInComponent:0]];
        _stateTF.text = myString;
    }
    [self pickerViewR3Show:NO];
    
    [appDel.RegisterParameterDic setObject:_paymentTF.text forKey:@"paymentMethod"];

    
    
    
    newHeight=0;
    if ([myString isEqualToString:@"ACH"]) {
        _BankPaymenyView.frame = CGRectMake(0, 500, _BankPaymenyView.bounds.size.width, _BankPaymenyView.bounds.size.height);
        [self setPAymentTypeValuesWithText:myString];
        [_scrollV addSubview:_BankPaymenyView];
        
        
        newHeight = _BankPaymenyView.bounds.size.height;
        
        [_PaypalView removeFromSuperview];
        [_ChequeView removeFromSuperview];
        
        UITapGestureRecognizer *paymentVGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboardReg3:)];
        [_BankPaymenyView addGestureRecognizer:paymentVGesture];
        
        
        
        
    }else if ([myString isEqualToString:@"Paypal"]){
        _PaypalView.frame = CGRectMake(0, 500, _PaypalView.bounds.size.width, _PaypalView.bounds.size.height);
        [self setPAymentTypeValuesWithText:myString];
        [_scrollV addSubview:_PaypalView];
        newHeight = _PaypalView.bounds.size.height;
        
        
        [_BankPaymenyView removeFromSuperview];
        [_ChequeView removeFromSuperview];
        
        UITapGestureRecognizer *paymentVGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboardReg3:)];
        [_PaypalView addGestureRecognizer:paymentVGesture];
        
        
    }else{
        _ChequeView.frame = CGRectMake(0, 500, _ChequeView.bounds.size.width, _ChequeView.bounds.size.height);
        [self setPAymentTypeValuesWithText:myString];
        [_scrollV addSubview:_ChequeView];
        newHeight = _ChequeView.bounds.size.height;
        
        
        [_PaypalView removeFromSuperview];
        [_BankPaymenyView removeFromSuperview];
        
        UITapGestureRecognizer *paymentVGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboardReg3:)];
        [_ChequeView addGestureRecognizer:paymentVGesture];
        
    }
    [_scrollV setContentSize:CGSizeMake(320, 500+newHeight)];
    
}
-(void)setPAymentTypeValuesWithText:(NSString *)myStg{
    
    NSString *stg = [NSString stringWithFormat:@"%@ %@",[appDel.RegisterParameterDic objectForKey:@"ownerFirstName"],[appDel.RegisterParameterDic objectForKey:@"ownerLastName"]];
    
    if ([myStg isEqualToString:@"ACH"]) {
        _bankACName.text = stg;
    }else if ([myStg isEqualToString:@"Paypal"]) {
        _paypalFullNameTF.text = stg;
        _emailTF.text = [appDel.RegisterParameterDic objectForKey:@"email"];
    }else{
        _FullNameTF.text = stg;
        @try {
            _addressTF.text =  [appDel.RegisterParameterDic objectForKey:@"address"];
        }
        @catch (NSException *exception) {}
        @try {
            _addressTF.text =  [appDel.RegisterParameterDic objectForKey:@"address"];
        }
        @catch (NSException *exception) {}
        @try {
            _suiteTF.text = [appDel.RegisterParameterDic objectForKey:@"suite"];
        }
        @catch (NSException *exception) {}
        @try {
            _cityTF.text = [appDel.RegisterParameterDic objectForKey:@"city"];
        }
        @catch (NSException *exception) {}
        @try {
            _stateTF.text = [appDel.RegisterParameterDic objectForKey:@"state"];
        }
        @catch (NSException *exception) {}
        @try {
            _zipCodeTF.text = [appDel.RegisterParameterDic objectForKey:@"zipcode"];
        }
        @catch (NSException *exception) {}
    }
}
-(void)paymentDropDownAction:(id)sender{
    _pickerViewR3.tag = 1000011;
    
    [self.view endEditing:YES];
    [_pickerViewR3 reloadAllComponents];
    [self pickerViewR3Show:YES];
}
-(void)setUpGestures{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardReg3:)];
    [_view1Gesture addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(paymentDropDownAction:)];
    [_patmebtGesture addGestureRecognizer:tapGesture1];
    
    UITapGestureRecognizer *transparentVGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerCancelAction:)];
    [_transparentBlackView addGestureRecognizer:transparentVGesture];
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];

    _scrollV.contentSize=CGSizeMake(320, 520);
    
    [self setUpGestures];
   
    
    
    [self textFieldPagingSetUpInreg2];
    
    
    _pickerViewActionSheet.frame = CGRectMake(0, self.view.bounds.size.height, _pickerViewActionSheet.bounds.size.width, _pickerViewActionSheet.bounds.size.height);
    [self.view addSubview:_pickerViewActionSheet];
    
//    _pickerCancelButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:17.0f];
//    _pickerDoneButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:17.0f];
    
    
    
    _pickerViewR3.tag = 1000011;

    
    paymentMetArray=[[NSArray alloc]initWithObjects:@"ACH",@"Paypal",@"Check",nil];
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    newHeight=0;
    
    
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self setRememberedValues];
}

-(void)setRememberedValues{
  
    
    if([[appDel.RegisterParameterDic objectForKey:@"website_url"] length] >1 ) {
        _webSiteTF.text = [appDel.RegisterParameterDic objectForKey:@"website_url"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"urbanspoon_url"] length] > 1) {
        _urbanSpponTF.text =  [appDel.RegisterParameterDic objectForKey:@"urbanspoon_url"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"yelp_url"] length] > 1) {
        _yepLinrTF.text =  [appDel.RegisterParameterDic objectForKey:@"yelp_url"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"gplus_url"] length] > 1) {
        _instagramTF.text =  [appDel.RegisterParameterDic objectForKey:@"gplus_url"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"facebook_url"] length] > 1) {
        _facebookTF.text =  [appDel.RegisterParameterDic objectForKey:@"facebook_url"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"twitter_url"] length] > 1) {
        _twitterTF.text =  [appDel.RegisterParameterDic objectForKey:@"twitter_url"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"paymentMethod"] length] > 1) {
        _paymentTF.text =  [appDel.RegisterParameterDic objectForKey:@"paymentMethod"];
        [self setPAymentTypeValuesWithText:_paymentTF.text];

    }
    if ([[appDel.RegisterParameterDic objectForKey:@"accountName"] length] > 1) {
        _bankACName.text =  [appDel.RegisterParameterDic objectForKey:@"accountName"];
    }
    
    
    
    if ([[appDel.RegisterParameterDic objectForKey:@"accountNumber"] length] > 1) {
        _bankACNumber.text =  [appDel.RegisterParameterDic objectForKey:@"accountNumber"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"accountRoutingNumber"] length] > 1) {
        _routingNumberTF.text =  [appDel.RegisterParameterDic objectForKey:@"accountRoutingNumber"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"paypalName"] length] > 1) {
        _paypalFullNameTF.text =  [appDel.RegisterParameterDic objectForKey:@"paypalName"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"paypalEmail"] length] > 1) {
        _emailTF.text =  [appDel.RegisterParameterDic objectForKey:@"paypalEmail"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"checkName"] length] > 1) {
        _FullNameTF.text =  [appDel.RegisterParameterDic objectForKey:@"checkName"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"checkAddress"] length] > 1) {
        _addressTF.text =  [appDel.RegisterParameterDic objectForKey:@"checkAddress"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"checkSuite"] length] > 1) {
        _suiteTF.text =  [appDel.RegisterParameterDic objectForKey:@"checkSuite"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"checkCity"] length] > 1) {
        _cityTF.text =  [appDel.RegisterParameterDic objectForKey:@"checkCity"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"checkZip"] length] > 2) {
        _zipCodeTF.text =  [appDel.RegisterParameterDic objectForKey:@"checkZip"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"checkState"] length] > 1) {
        _stateTF.text =  [appDel.RegisterParameterDic objectForKey:@"checkState"];
    }

}

-(void)dismissKeyboardReg3:(id)sender{
    
    if (![GlobalMethods whiteSpacesAvailableForString:_webSiteTF.text] && _webSiteTF.text.length>1 ) {
        [self rememberTextFieldValue:_webSiteTF.text WithKey:@"website_url"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_yepLinrTF.text] && _yepLinrTF.text.length>1 ){
        [self rememberTextFieldValue:_yepLinrTF.text WithKey:@"yelp_url"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_instagramTF.text] && _instagramTF.text.length>1 ){
        [self rememberTextFieldValue:_instagramTF.text WithKey:@"gplus_url"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_facebookTF.text] && _facebookTF.text.length>1 ){
        [self rememberTextFieldValue:_facebookTF.text WithKey:@"facebook_url"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_twitterTF.text] && _twitterTF.text.length>1 ) {
        [self rememberTextFieldValue:_twitterTF.text WithKey:@"twitter_url"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_bankACName.text] && _bankACName.text.length>1 ){
        [self rememberTextFieldValue:_bankACName.text WithKey:@"accountName"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_bankACNumber.text] && _bankACNumber.text.length>1 ){
        [self rememberTextFieldValue:_bankACNumber.text WithKey:@"accountNumber"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_routingNumberTF.text] && _routingNumberTF.text.length>1 ) {
        [self rememberTextFieldValue:_routingNumberTF.text WithKey:@"accountRoutingNumber"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_paypalFullNameTF.text] && _paypalFullNameTF.text.length>1 ){
        [self rememberTextFieldValue:_paypalFullNameTF.text WithKey:@"paypalName"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_FullNameTF.text] && _FullNameTF.text.length>1 ){
        [self rememberTextFieldValue:_FullNameTF.text WithKey:@"checkName"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_addressTF.text] && _addressTF.text.length>1 ){
        [self rememberTextFieldValue:_addressTF.text WithKey:@"checkAddress"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_suiteTF.text] && _suiteTF.text.length>1 ){
        [self rememberTextFieldValue:_suiteTF.text WithKey:@"checkSuite"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_urbanSpponTF.text] && _urbanSpponTF.text.length>1 ){
        [self rememberTextFieldValue:_urbanSpponTF.text WithKey:@"urbanspoon_url"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_emailTF.text] && _emailTF.text.length>1 ){
        [self rememberTextFieldValue:_emailTF.text WithKey:@"paypalEmail"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_cityTF.text] && _cityTF.text.length>1 ){
        [self rememberTextFieldValue:_cityTF.text WithKey:@"checkCity"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_zipCodeTF.text] && _zipCodeTF.text.length>1 ){
        [self rememberTextFieldValue:_zipCodeTF.text WithKey:@"checkZip"];
    }
    if (![GlobalMethods whiteSpacesAvailableForString:_stateTF.text] && _stateTF.text.length>1 ){
        [self rememberTextFieldValue:_stateTF.text WithKey:@"checkState"];
    }

    
    
    [self.view endEditing:YES];
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

- (IBAction)PaymentMethodTextFAction:(id)sender {
    
    _pickerViewR3.tag = 1000011;
   
    [self.view endEditing:YES];
    [_pickerViewR3 reloadAllComponents];
    [self pickerViewR3Show:YES];

}

- (IBAction)PaymentMethodButtonAction:(id)sender {
    [self performSelector:@selector(PaymentMethodTextFAction:) withObject:self];
}

- (IBAction)BackBtnClicked:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark
#pragma mark - TextField Delgates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _scrollV.contentSize=CGSizeMake(320, 590+newHeight);

    if (textField ==_webSiteTF)
        [_scrollV setContentOffset:CGPointMake(0, 30) animated:YES];
    else if (textField == _yepLinrTF)
        [_scrollV setContentOffset:CGPointMake(0, 100) animated:YES];
    else if (textField == _instagramTF)
        [_scrollV setContentOffset:CGPointMake(0, 170) animated:YES];
    else if (textField == _facebookTF)
        [_scrollV setContentOffset:CGPointMake(0, 240) animated:YES];
    else if (textField == _twitterTF)
        [_scrollV setContentOffset:CGPointMake(0, 300) animated:YES];
    else if (textField == _urbanSpponTF)
        [_scrollV setContentOffset:CGPointMake(0, 350) animated:YES];
    else if (textField == _paymentTF){
        [_paymentTF resignFirstResponder];
        [_scrollV setContentOffset:CGPointMake(0, 430) animated:YES];
    }else if (textField==_bankACName || textField == _paypalFullNameTF || textField == _FullNameTF) {
        [_scrollV setContentOffset:CGPointMake(0, 430) animated:YES];
    }
    else if (textField==_bankACNumber || textField == _emailTF || textField==_addressTF || textField == _suiteTF){
        [_scrollV setContentOffset:CGPointMake(0, 480) animated:YES];
    }
    else if (textField==_cityTF || textField==_stateTF || textField == _routingNumberTF){
        [_scrollV setContentOffset:CGPointMake(0, 500) animated:YES];
    }
    else{
        [_scrollV setContentOffset:CGPointMake(0, 570) animated:YES ];
    }

    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    [_scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.view endEditing:YES];
//    [_scrollV setContentOffset:CGPointMake(0, 0)];
    
    if (textField == _zipCodeTF || textField == _emailTF || textField == _routingNumberTF) {
        [_scrollV setContentOffset:CGPointMake(0, 120) animated:YES];
    }
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
-(void)rememberTextFieldValue:(NSString *)myString WithKey:(NSString *)myKey{
    if (myString.length > 1 && ![GlobalMethods whiteSpacesAvailableForString:myString]) {
        [appDel.RegisterParameterDic setObject:myString forKey:myKey];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _webSiteTF) {
        [self rememberTextFieldValue:_webSiteTF.text WithKey:@"website_url"];
        [_yepLinrTF becomeFirstResponder];
    }else if (textField == _yepLinrTF){
        [self rememberTextFieldValue:_yepLinrTF.text WithKey:@"yelp_url"];
        [_instagramTF becomeFirstResponder];
    }else if (textField == _instagramTF){
        [self rememberTextFieldValue:_instagramTF.text WithKey:@"gplus_url"];
        [_facebookTF becomeFirstResponder];
    }else if (textField == _facebookTF){
        [self rememberTextFieldValue:_facebookTF.text WithKey:@"facebook_url"];
        [_twitterTF becomeFirstResponder];
    }else if (textField == _twitterTF) {
        [self rememberTextFieldValue:_twitterTF.text WithKey:@"twitter_url"];
        [_urbanSpponTF becomeFirstResponder];
    }else if (textField == _bankACName){
        [self rememberTextFieldValue:_bankACName.text WithKey:@"accountName"];
        [_bankACNumber becomeFirstResponder];
    }else if (textField == _bankACNumber){
        [self rememberTextFieldValue:_bankACNumber.text WithKey:@"accountNumber"];
        [_routingNumberTF becomeFirstResponder];
    }else if (textField == _paypalFullNameTF){
        [self rememberTextFieldValue:_paypalFullNameTF.text WithKey:@"paypalName"];
        [_emailTF becomeFirstResponder];
    }else if (textField == _FullNameTF){
        [self rememberTextFieldValue:_FullNameTF.text WithKey:@"checkName"];
        [_addressTF becomeFirstResponder];
    }else if (textField == _addressTF){
        [self rememberTextFieldValue:_addressTF.text WithKey:@"checkAddress"];
        [_suiteTF becomeFirstResponder];
    }else if (textField == _suiteTF){
        [self rememberTextFieldValue:_suiteTF.text WithKey:@"checkSuite"];
        [_cityTF becomeFirstResponder];
    }else{
        
        if (textField == _urbanSpponTF) {
            [self rememberTextFieldValue:_urbanSpponTF.text WithKey:@"urbanspoon_url"];
        }else if (textField == _routingNumberTF) {
            [self rememberTextFieldValue:_routingNumberTF.text WithKey:@"accountRoutingNumber"];
        }else if (textField == _emailTF) {
            [self rememberTextFieldValue:_emailTF.text WithKey:@"paypalEmail"];
        }else if (textField == _cityTF) {
            [self rememberTextFieldValue:_cityTF.text WithKey:@"checkCity"];
        }else if (textField == _zipCodeTF) {
            [self rememberTextFieldValue:_zipCodeTF.text WithKey:@"checkZip"];
        }else if (textField == _stateTF) {
            [self rememberTextFieldValue:_stateTF.text WithKey:@"checkState"];
        }
        
        
        
        [textField resignFirstResponder];
    }
    
   
    
    return YES;
}



#pragma mark
#pragma mark - HUD Delegtes
- (void)hudWasHidden:(MBProgressHUD *)huda {
    
    // Remove HUD from screen when the HUD was hidded
    [hud removeFromSuperview];
    hud = nil;
}

#pragma mark
#pragma mark - CustomActivityIndicator delegatw
-(void)showCustomActivityIndicatorInRegister:(BOOL)mybool{
    if (mybool) {
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
        
    }else{
        [hud hide:YES];
    }
    
    
    
}



- (IBAction)RegistrationFinishButton:(id)sender {
    [self showCustomActivityIndicatorInRegister:YES];
  /*
    
    if (_webSiteTF.text.length > 0) {
        if ([_webSiteTF.text rangeOfString:@"http://www."].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Official Website must be a valid url."];
            [_webSiteTF becomeFirstResponder];
            [self showCustomActivityIndicatorInRegister:NO];
            return;
        }
    }
    if (_yepLinrTF.text.length > 0) {
        if ([_yepLinrTF.text rangeOfString:@"http://www.yelp.com/biz/"].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Yelp Line must be a valid url."];
            [_yepLinrTF becomeFirstResponder];
            [self showCustomActivityIndicatorInRegister:NO];
            return;
        }
    }
    if (_instagramTF.text.length > 0) {
        if ([_instagramTF.text rangeOfString:@"http://plus.google.com/"].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Google Plus must be a valid url."];
            [_instagramTF becomeFirstResponder];
            [self showCustomActivityIndicatorInRegister:NO];
            return;
        }
    }
    
    if (_facebookTF.text.length > 0) {
        if ([_facebookTF.text rangeOfString:@"http://www.facebook.com/"].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Facebook Page must be a valid url."];
            [_facebookTF becomeFirstResponder];
            [self showCustomActivityIndicatorInRegister:NO];
            return;
        }
    }
    
    if (_twitterTF.text.length > 0) {
        if ([_twitterTF.text rangeOfString:@"http://www.twitter.com/"].location==NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Twitter Profile must be a valid url."];
            [_twitterTF becomeFirstResponder];
            [self showCustomActivityIndicatorInRegister:NO];
            return;
        }
    }
    

  
   
    
    if (_urbanSpponTF.text.length > 0) {
        if ([_urbanSpponTF.text rangeOfString:@"http://www.urbanspoon.com/"].location == NSNotFound) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Urbanspoon Link must be a valid url."];
            [_urbanSpponTF becomeFirstResponder];
            [self showCustomActivityIndicatorInRegister:NO];
            return;
        }
    }
*/
    
    
    

    if (_webSiteTF.text.length>=1 && _webSiteTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"WebSite cannot be less than 2 characters"];
        [_webSiteTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }

    if (_yepLinrTF.text.length>=1 && _yepLinrTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"YelpLine cannot be less than 2 characters"];
        [_yepLinrTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }

    if (_instagramTF.text.length>=1 && _instagramTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Instagram cannot be less than 2 characters"];
        [_instagramTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    
    if (_facebookTF.text.length>=1 && _facebookTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Facebook cannot be less than 2 characters"];
        [_facebookTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }

    if (_twitterTF.text.length>=1 && _twitterTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Facebook cannot be less than 2 characters"];
        [_twitterTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    
    if (_bankACName.text.length>=1 && _bankACName.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Bank Account Name cannot be less than 2 characters"];
        [_bankACName becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }



    if (_paypalFullNameTF.text.length>=1 && _paypalFullNameTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Paypal Account Name cannot be less than 2 characters"];
        [_paypalFullNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }

    
    if (_emailTF.text.length>=1 && _emailTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Paypal Email cannot be less than 2 characters"];
        [_emailTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }

    if (_FullNameTF.text.length>=1 && _FullNameTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Check FullName cannot be less than 2 characters"];
        [_FullNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }

    
    if (_addressTF.text.length>=1 && _addressTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Check Address cannot be less than 2 characters"];
        [_addressTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }


    if (_suiteTF.text.length>=1 && _suiteTF.text.length<2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Check Suite cannot be less than 2 characters"];
        [_suiteTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    
    if (_cityTF.text.length>=1 && _cityTF.text.length<=1) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Check City cannot be less than 2 characters"];
        [_cityTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    
    if (_zipCodeTF.text.length>=1 && _zipCodeTF.text.length !=5) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"ZipCode cannot lessthan 5 Letters"];
        [_zipCodeTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_webSiteTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_webSiteTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Website Url cannot be blank"];
        [_webSiteTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_yepLinrTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_yepLinrTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"YelpLink Url cannot be blank"];
        [_yepLinrTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_instagramTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_instagramTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"GooglePlus Url cannot be blank"];
        [_instagramTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_facebookTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_facebookTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Facebook Url cannot be blank"];
        [_facebookTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_twitterTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_twitterTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Twitter Url cannot be blank"];
        [_twitterTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_urbanSpponTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_urbanSpponTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Urbanspoon Url cannot be blank"];
        [_urbanSpponTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_bankACName.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_bankACName.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Bank Account Name cannot be blank"];
        [_bankACName becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_bankACNumber.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_bankACNumber.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Bank Account Number cannot be blank"];
        [_bankACNumber becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_routingNumberTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_routingNumberTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Routing Number cannot be blank"];
        [_routingNumberTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_paypalFullNameTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_paypalFullNameTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Paypal Account Name cannot be blank"];
        [_paypalFullNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_emailTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_emailTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Paypal e-mail cannot be blank"];
        [_emailTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_FullNameTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_FullNameTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Ckeck Full Name cannot be blank"];
        [_FullNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_addressTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_addressTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Check Address cannot be blank"];
        [_addressTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_suiteTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_suiteTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Check Suite cannot be blank"];
        [_suiteTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_cityTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_cityTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Check City cannot be blank"];
        [_cityTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    if (_zipCodeTF.text.length>1 && [GlobalMethods whiteSpacesAvailableForString:_zipCodeTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Check ZipCode cannot be blank"];
        [_zipCodeTF becomeFirstResponder];
        [self showCustomActivityIndicatorInRegister:NO];
        return;
    }
    
    
    

    
    
    [self SendForRegister];
}

-(void)SendForRegister{
    
    /*
     
     * optional - restaurantFax,restaurantImages,customCuisine, website, yelplink, instagram, facebook, twitter, paymentMethod, accountName, accountNumber, accountRoutingNumber, paypalName, paypalEmail, checkName, checkAddress, checkSuite, checkCity, checkZip, checkState
     
     
     */
    
  
    if (_urbanSpponTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_urbanSpponTF.text forKey:@"urbanspoon_url"];
        }
        @catch (NSException *exception) {}
    }
    

    if (_webSiteTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_webSiteTF.text forKey:@"website_url"];
        }
        @catch (NSException *exception) {}
    }
    if (_yepLinrTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_yepLinrTF.text forKey:@"yelp_url"];
        }
        @catch (NSException *exception) {}
    }
    if (_instagramTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_instagramTF.text forKey:@"gplus_url"];
        }
        @catch (NSException *exception) {}
    }
    if (_facebookTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_facebookTF.text forKey:@"facebook_url"];
        }
        @catch (NSException *exception) {}
    }
    if (_twitterTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_twitterTF.text forKey:@"twitter_url"];
        }
        @catch (NSException *exception) {}
    }
    if (_paymentTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_paymentTF.text forKey:@"paymentMethod"];
        }
        @catch (NSException *exception) {}
    }
    if (_bankACName.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_bankACName.text forKey:@"accountName"];
        }
        @catch (NSException *exception) {}
    }
    if (_bankACNumber.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_bankACNumber.text forKey:@"accountNumber"];
        }
        @catch (NSException *exception) {}
    }
    if (_routingNumberTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_routingNumberTF.text forKey:@"accountRoutingNumber"];
        }
        @catch (NSException *exception) {}
    }
    if (_paypalFullNameTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_paypalFullNameTF.text forKey:@"paypalName"];
        }
        @catch (NSException *exception) {}
    }
    if (_emailTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_emailTF.text forKey:@"paypalEmail"];
        }
        @catch (NSException *exception) {}
    }
    if (_FullNameTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_FullNameTF.text forKey:@"checkName"];
        }
        @catch (NSException *exception) {}
    }
    if (_addressTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_addressTF.text forKey:@"checkAddress"];
        }
        @catch (NSException *exception) {}
    }
    if (_suiteTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_suiteTF.text forKey:@"checkSuite"];
        }
        @catch (NSException *exception) {}
    }
    if (_cityTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_cityTF.text forKey:@"checkCity"];
        }
        @catch (NSException *exception) {}
    }
    if (_zipCodeTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_zipCodeTF.text forKey:@"checkZip"];
        }
        @catch (NSException *exception) {}
    }
    if (_stateTF.text.length > 1) {
        @try {
            [appDel.RegisterParameterDic setObject:_stateTF.text forKey:@"checkState"];
        }
        @catch (NSException *exception) {}
    }
    
    //    [appDel.RegisterParameterDic setObject:appDel.CurrentOwnerDetails.owner_image forKey:@"restaurantImages"];
    @try {
        [appDel.RegisterParameterDic setObject:[appDel.deviceToken length]?appDel.deviceToken:@"" forKey:@"apn_device_token"];
    }
    @catch (NSException *exception) {}
    
    NSLog(@"appParameters = %@",appDel.RegisterParameterDic);
    
    
    NSLog(@"appDel = %@",appDel.RegisterParameterDic);
    
    [webParser parserPostMethodWithParameters:appDel.RegisterParameterDic andExtendUrl:@"restaurantRegister"];
    
    
  
}



#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    
    [self showCustomActivityIndicatorInRegister:NO];
    BOOL errMsg=[[result valueForKey:@"error"] boolValue];
    
    if (!errMsg) {
        if ([[result valueForKey:@"code"] integerValue] != 112) {
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
            return;
        }else{
                        
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:appDel.ownerEmailId, @"ownerEmailId", appDel.ownerPassword, @"ownerPassword",[[result valueForKey:@"data"] valueForKey:@"accessToken"],@"accessToken",nil];
            [[NSUserDefaults standardUserDefaults] setObject:params forKey:@"LoginE_PProfile"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            NSString *welcomeString = @"Thank you for becoming an EnjoyFresh member! We are excited to connect you to a community of food lovers! Check your inbox for a confirmation e-mail, if you don't see it make sure it didn't wind up in your spam folder.";
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:welcomeString];
            
            [self performSelector:@selector(goToNextView:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];
        }
    }else{
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
    }
    
   
}
-(void)goToNextView:(NSDictionary *)result{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[appDel.RegisterParameterDic objectForKey:@"email"], @"ownerEmailId", [appDel.RegisterParameterDic objectForKey:@"password"], @"ownerPassword",[result valueForKey:@"accessToken"],@"accessToken",nil];
    [[NSUserDefaults standardUserDefaults] setObject:params forKey:@"LoginE_PProfile"];
    [[NSUserDefaults standardUserDefaults] setObject:params forKey:@"LoginReminder"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
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
    

        
    [self performSegueWithIdentifier:@"goToAddDishView" sender:self];
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showCustomActivityIndicatorInRegister:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"goToAddDishView"]) {
        AddDishVC *dest = [segue destinationViewController];
        dest.isFromView = @"Register3";
    }
}



@end
