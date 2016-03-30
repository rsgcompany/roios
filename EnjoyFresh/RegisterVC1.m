//
//  RegisterVC1.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "RegisterVC1.h"
#import "MBProgressHUD.h"
#import "GlobalMethods.h"
#import "ParserHClass.h"

@interface RegisterVC1 ()<UITextFieldDelegate,MBProgressHUDDelegate,parserHDelegate>{
    MBProgressHUD *hud;
    ParserHClass *webParser;
    NSString *phNoStg;
    NSString *faxNoStg;

}

@end

@implementation RegisterVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];

    
    _scrollV.contentSize = CGSizeMake(320, 440);
    
    
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [_scrollV addGestureRecognizer:tapGesture];
    
    
    UITapGestureRecognizer *aggriment = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aggrimentHyperLink:)];
    [_aggrimentHyperLinkView addGestureRecognizer:aggriment];
    
    
    [_checkMarkBtn setImage:[UIImage imageNamed:@"tc_checkmark.png"] forState:UIControlStateNormal];
    [_checkMarkBtn2 setImage:[UIImage imageNamed:@"tc_checkmark.png"] forState:UIControlStateNormal];
    _checkMarkBtn.tag = 1;
    _checkMarkBtn2.tag = 10;
    
    
    [self.view bringSubviewToFront:_continueBtn];
    
    
}
-(void)aggrimentHyperLink:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:TermsConditionsUrl]];
}
-(void)viewDidAppear:(BOOL)animated{
    [self showCustomActivityIndicatorR1:YES];
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    [webParser parserJsonDataFromUrlString:RestaurentCategoriesUrl withIderntifier:@"categoriesUpdating"];
    

}
-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - TextField Delgates
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _scrollV.contentSize = CGSizeMake(320, 520);

    if (textField == _OwnerLastNameTF)
        [_scrollV setContentOffset:CGPointMake(0, 50) animated:YES];
    else if (textField == _OwnerEmailTF)
        [_scrollV setContentOffset:CGPointMake(0, 100) animated:YES];
    else if (textField == _OwnerPasswordTF)
        [_scrollV setContentOffset:CGPointMake(0, 140) animated:YES];
    else if (textField == _RestaurentPhNoTF)
        [_scrollV setContentOffset:CGPointMake(0, 200) animated:YES];
    else if (textField == _RestaurentFaxNoTF)
        [_scrollV setContentOffset:CGPointMake(0, 250) animated:YES];
    else{
//        [_scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
    }
 
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    // Prevent crashing undo bug – see note below.
    if (textField == _OwnerNameTF || textField == _OwnerLastNameTF) {
        NSCharacterSet *cs = [[NSCharacterSet letterCharacterSet] invertedSet];
       // NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return ([string rangeOfCharacterFromSet:cs].location == NSNotFound);
    }
    /*! Phone Number Formetting */
    else if (textField == _RestaurentPhNoTF || textField == _RestaurentFaxNoTF) {
        int length = [self getLength:textField.text];
        if(length == 10) {
            if(range.length == 0)
                return NO;
        }
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:AlphaNumarics] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        if (![string isEqualToString:filtered]) {
            return NO;
        }
        
        if(length == 3) {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) ",num];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6) {
            NSString *num = [self formatNumber:textField.text];
            textField.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            if(range.length > 0)
                textField.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }


        
      
    }
    else if (textField==_OwnerPasswordTF){
        
    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _OwnerPasswordTF) {
        NSUInteger newLength = [textField.text length];
        if (newLength<8) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Password must be atleast 8 characters"];
        }
    }
}


- (NSString *)formatNumber:(NSString*)mobileNumber {
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    if(length > 10) {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
    }
    return mobileNumber;
}


- (int)getLength:(NSString*)mobileNumber {
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = [mobileNumber length];
    return length;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    
    if (textField == _RestaurentNameTF)
        [_OwnerNameTF becomeFirstResponder];
    else if(textField == _OwnerNameTF)
        [_OwnerLastNameTF becomeFirstResponder];
    else if (textField == _OwnerLastNameTF)
        [_OwnerEmailTF becomeFirstResponder];
    else if (textField == _OwnerEmailTF)
        [_OwnerPasswordTF becomeFirstResponder];
    else if (textField == _OwnerPasswordTF)
        [_RestaurentPhNoTF becomeFirstResponder];
    else if (textField == _RestaurentPhNoTF)
        [_RestaurentFaxNoTF becomeFirstResponder];
    else
        [textField resignFirstResponder];
    
    
    return YES;
}


- (IBAction)aggrimentCheckMarkBlock:(id)sender {
    
    if (_checkMarkBtn.tag == 2) {
        [_checkMarkBtn setImage:[UIImage imageNamed:@"tc_checkmark.png"] forState:UIControlStateNormal];
        _checkMarkBtn.tag = 1;
    }else{
        [_checkMarkBtn setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        _checkMarkBtn.tag = 2;
    }
}
- (IBAction)CheckMark2Button:(id)sender {
    if (_checkMarkBtn2.tag == 12) {
        [_checkMarkBtn2 setImage:[UIImage imageNamed:@"tc_checkmark.png"] forState:UIControlStateNormal];
        _checkMarkBtn2.tag = 11;
    }else{
        [_checkMarkBtn2 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        _checkMarkBtn2.tag = 12;
    }
}
- (IBAction)continueButtonAction:(id)sender {
    
    phNoStg = [self formatNumber:_RestaurentPhNoTF.text];
    faxNoStg = [self formatNumber:_RestaurentFaxNoTF.text];
    
    [_scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
    [self showCustomActivityIndicatorR1:YES];
    
    if (_RestaurentNameTF.text == (id)[NSNull null] || _RestaurentNameTF.text.length == 0 ){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Restaurant Name"];
        [_RestaurentNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [_RestaurentNameTF.text stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"RestaurantName cannot be blank"];
        [_RestaurentNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    if (_RestaurentNameTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"RestaurantName cannot be less than 2 characters"];
        [_RestaurentNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    
    
    if (_OwnerNameTF.text == (id)[NSNull null] || _OwnerNameTF.text.length == 0 ){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Owner FirstName"];
        [_OwnerNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    NSCharacterSet *whitespaceON = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedON = [_OwnerNameTF.text stringByTrimmingCharactersInSet:whitespaceON];
    if ([trimmedON length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Owner FirstName cannot be blank"];
        [_OwnerNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    if (_OwnerNameTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Owner FirstName cannot be less than 2 characters"];
        [_OwnerNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }

    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:_OwnerNameTF.text];
    if ([alphaNums isSupersetOfSet:inStringSet]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"FirstName Should not be numarics"];
        [_OwnerNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    
    if (_OwnerLastNameTF.text == (id)[NSNull null] || _OwnerLastNameTF.text.length == 0 ){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Owner LastName"];
        [_OwnerLastNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    NSCharacterSet *whitespaceOl = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedOl = [_OwnerLastNameTF.text stringByTrimmingCharactersInSet:whitespaceOl];
    if ([trimmedOl length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Owner LastName cannot be blank"];
        [_OwnerLastNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    if (_OwnerLastNameTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Owner LastName cannot be less than 2 characters"];
        [_OwnerLastNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    NSCharacterSet *inStringSet1 = [NSCharacterSet characterSetWithCharactersInString:_OwnerLastNameTF.text];
    if ([alphaNums isSupersetOfSet:inStringSet1]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"LastName Should not be numarics"];
        [_OwnerLastNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }

    
    
    if (_OwnerEmailTF.text == (id)[NSNull null] || _OwnerEmailTF.text.length == 0 ){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter E-Mail Address"];
        [_OwnerEmailTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    NSCharacterSet *whitespaceE = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedE = [_OwnerEmailTF.text stringByTrimmingCharactersInSet:whitespaceE];
    if ([trimmedE length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"E-Mail Address cannot be blank"];
        [_OwnerEmailTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    if (_OwnerEmailTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"E-Mail Address cannot be less than 2 characters"];
        [_OwnerEmailTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    if (![GlobalMethods isItValidEmail:_OwnerEmailTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Valid Email ID"];
        [_OwnerEmailTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    if (_OwnerPasswordTF.text == (id)[NSNull null] || _OwnerPasswordTF.text.length == 0 ){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Password"];
        [_OwnerPasswordTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    
    NSCharacterSet *whitespacePw = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedPw = [_OwnerPasswordTF.text stringByTrimmingCharactersInSet:whitespacePw];
    if ([trimmedPw length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Password cannot be blank"];
        [_OwnerPasswordTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    if (_OwnerPasswordTF.text.length < 8) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Password cannot be less than 8 Characters"];
        [_OwnerPasswordTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    
    if (phNoStg == (id)[NSNull null] || phNoStg.length == 0 ){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Restaurant Phone Number"];
        [_RestaurentPhNoTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    if (phNoStg.length < 10){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Invalid Phone Number"];
        [_RestaurentPhNoTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    NSCharacterSet *whitespacePh = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedPh = [phNoStg stringByTrimmingCharactersInSet:whitespacePh];
    if ([trimmedPh length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Phone Number cannot be blank"];
        [_RestaurentPhNoTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }

    
    ///
    
    if (faxNoStg.length > 0 && faxNoStg.length < 10){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Invalid Fax Number"];
        [_RestaurentFaxNoTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
   
    NSCharacterSet *whitespaceFax = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedFax = [faxNoStg stringByTrimmingCharactersInSet:whitespaceFax];
    if ([trimmedFax length] == 0 && faxNoStg.length > 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Fax Number cannot be blank"];
        [_RestaurentFaxNoTF becomeFirstResponder];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    
    
    
    if (_checkMarkBtn.tag != 2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please Accept Terms&Conditions"];
        [self showCustomActivityIndicatorR1:NO];
        return;
    }
    
    
    
    
    
    
    [self performSelector:@selector(getMethodActionBlock) withObject:nil];



}


-(void)showCustomActivityIndicatorR1:(BOOL)mybool{
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

-(void)dismissKeyboard:(id)sender{
    [self.view endEditing:YES];
    _scrollV.contentSize = CGSizeMake(320, 440);
}
-(void)getMethodActionBlock{
    
    appDel.ownerEmailId = _OwnerEmailTF.text;
    appDel.ownerPassword = _OwnerPasswordTF.text;
    
    
    @try {
        [appDel.RegisterParameterDic setObject:_RestaurentNameTF.text forKey:@"restaurantName"];
    }
    @catch (NSException *exception) {}
    @try {
        [appDel.RegisterParameterDic setObject:_OwnerNameTF.text forKey:@"ownerFirstName"];
    }
    @catch (NSException *exception) {}
    @try {
        [appDel.RegisterParameterDic setObject:_OwnerLastNameTF.text forKey:@"ownerLastName"];
    }
    @catch (NSException *exception) {}
    @try {
        [appDel.RegisterParameterDic setObject:_OwnerEmailTF.text forKey:@"email"];
    }
    @catch (NSException *exception) {}
    @try {
        [appDel.RegisterParameterDic setObject:_OwnerPasswordTF.text forKey:@"password"];
    }
    @catch (NSException *exception) {}
    @try {
        [appDel.RegisterParameterDic setObject:phNoStg forKey:@"restaurantPhone"];
    }
    @catch (NSException *exception) {}
    @try {
        [appDel.RegisterParameterDic setObject:@"12345678910" forKey:@"devicetoken"];
    }
    @catch (NSException *exception) {}
    
    


    if (_RestaurentFaxNoTF.text.length > 0) {
        @try {
            [appDel.RegisterParameterDic setObject:faxNoStg forKey:@"restaurantFax"];
        }
        @catch (NSException *exception) {}
    }
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    @try {
        [paramDict setObject:_OwnerEmailTF.text forKey:@"email"];
    }
    @catch (NSException *exception) {}
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"checkMail"];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self showCustomActivityIndicatorR1:NO];

    [self.view endEditing:YES];
    _scrollV.contentSize = CGSizeMake(320, 440);
    
    if ([segue.identifier isEqualToString:@"goToSettings2"]) {
        [segue destinationViewController];
    }
}



#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    [self showCustomActivityIndicatorR1:NO];
    if (![[result valueForKey:@"error"] boolValue]){
        [self performSegueWithIdentifier:@"goToSettings2" sender:self];
    }else{
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Email-ID Already Exist"];
    }
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    NSLog(@"Error Occuresd  = %@",errorH);
    [self showCustomActivityIndicatorR1:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result withIdentifier:(NSString *)myIdentifier{
    [self showCustomActivityIndicatorR1:NO];

    if ([myIdentifier isEqualToString:@"categoriesUpdating"] && ![[result valueForKey:@"error"] boolValue]) {
        NSArray *SortAry = [GlobalMethods sortArrayDictionaryInAscendingOrderWithArray:[result valueForKey:@"message"] WithKey:@"title"];
        appDel.cuisineAry = [NSMutableArray arrayWithArray:SortAry];
        [appDel removeCusinesFromCusineArray:appDel.cuisineAry WithComparingArray:appDel.CurrentOwnerDetails.owner_cuisineArray];
    }
}


- (IBAction)BackBtnClicked:(id)sender {
    [self.view endEditing:YES];
    _scrollV.contentSize = CGSizeMake(320, 440);
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
