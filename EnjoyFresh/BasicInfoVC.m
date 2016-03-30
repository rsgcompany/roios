//
//  BasicInfoVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "BasicInfoVC.h"
#import "ParserHClass.h"
#import "GlobalMethods.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "CustomTableViewH.h"

#import "UIImageView+WebCache.h"



@interface BasicInfoVC ()<parserHDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,MBProgressHUDDelegate,CustomTableViewHDelegate>{
    
    ParserHClass *webParser;
    UIAlertView *PhotoAlert;
    UIImagePickerController *imagePicker;
    
    
   
    CustomTableViewH *dropDownV;

    MBProgressHUD *hud;
    
    NSString *stateTaxTxt;
    NSString *cityTaxTxt;
    
    
    BOOL isProfilePicChanged;
    BOOL isProfilePicAvaliableInWeb;

    NSMutableDictionary *paramDict;
    
    NSString *phNoStg,*faxNoStg;
    
    

}





@end

@implementation BasicInfoVC


-(void)textFieldPagingSetUpInreg2{
    
    _FirstNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _FirstNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    _LastNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _LastNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    _RestaurentNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _RestaurentNameTF.leftViewMode = UITextFieldViewModeAlways;

    _RestaurentMobileTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _RestaurentMobileTF.leftViewMode = UITextFieldViewModeAlways;

    _RestaurentFaxnoTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _RestaurentFaxnoTF.leftViewMode = UITextFieldViewModeAlways;

  
    _AddressTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _AddressTF.leftViewMode = UITextFieldViewModeAlways;

    _SuiteTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _SuiteTF.leftViewMode = UITextFieldViewModeAlways;

    _CityTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _CityTF.leftViewMode = UITextFieldViewModeAlways;

    _StateTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _StateTF.leftViewMode = UITextFieldViewModeAlways;

    _ZipCodeTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _ZipCodeTF.leftViewMode = UITextFieldViewModeAlways;
    
    _CityTaxTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _CityTaxTF.leftViewMode = UITextFieldViewModeAlways;
    
    _StateTaxTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _StateTaxTF.leftViewMode = UITextFieldViewModeAlways;

}
-(void)dismissKeyboard:(id)sender{
    [self.view endEditing:YES];
}
-(void)addGestures{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [_view1 addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *StateGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(StateListTapped:)];
    [_stateGestureV addGestureRecognizer:StateGesture];
    
    UITapGestureRecognizer *statetaxesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(StateTaxListTapped:)];
    [_stateTaxGesture addGestureRecognizer:statetaxesture];
    
    UITapGestureRecognizer *cityTaxGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CityTaxListTapped:)];
    [_cityTaxGesture addGestureRecognizer:cityTaxGesture];
    
    UITapGestureRecognizer *TransparectBlackVG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelPickerViewAction:)];
    [_TransparentBlackView addGestureRecognizer:TransparectBlackVG];
    

    

}
-(void)viewWillAppear:(BOOL)animated{
    [_ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}
-(NSString *)changeToPhoneFormetString:(NSString *)myStg{
    NSMutableString *returnstg = [NSMutableString stringWithString:myStg];
    [returnstg insertString:@"(" atIndex:0];
    [returnstg insertString:@")" atIndex:4];
    [returnstg insertString:@"-" atIndex:8];
    return returnstg;
}
-(void)enterServiceValues{
    NSLog(@"AccessToken = %@", appDel.CurrentOwnerDetails.owner_accessToken);
    _FirstNameTF.text = appDel.CurrentOwnerDetails.owner_first_name;
    _LastNameTF.text = appDel.CurrentOwnerDetails.owner_last_name;
    _RestaurentNameTF.text = appDel.CurrentOwnerDetails.owner_title;
    if (appDel.CurrentOwnerDetails.owner_phone.length > 8) {
        _RestaurentMobileTF.text = [self changeToPhoneFormetString:appDel.CurrentOwnerDetails.owner_phone];
    }
    if (appDel.CurrentOwnerDetails.owner_fax.length > 8) {
        _RestaurentFaxnoTF.text = [self changeToPhoneFormetString:appDel.CurrentOwnerDetails.owner_fax];
    }
    _DescriptionTV.text = appDel.CurrentOwnerDetails.owner_description;
    _AddressTF.text = appDel.CurrentOwnerDetails.owner_address;
    _SuiteTF.text = appDel.CurrentOwnerDetails.owner_suite;
    _CityTF.text = appDel.CurrentOwnerDetails.owner_city;
    _StateTF.text = [appDel.CurrentOwnerDetails.owner_state uppercaseString];
    _ZipCodeTF.text = appDel.CurrentOwnerDetails.owner_zip;
    
    
    if (appDel.CurrentOwnerDetails.owner_city_tax.length > 1) {
        _CityTaxTF.text = [NSString stringWithFormat:@"%@%%",appDel.CurrentOwnerDetails.owner_city_tax];
    }
    if (appDel.CurrentOwnerDetails.owner_state_tax.length > 1) {
        _StateTaxTF.text = [NSString stringWithFormat:@"%@%%",appDel.CurrentOwnerDetails.owner_state_tax];
    }
    cityTaxTxt = appDel.CurrentOwnerDetails.owner_city_tax;
    stateTaxTxt = appDel.CurrentOwnerDetails.owner_state_tax;
    
    
    _profilePicImg.image = [UIImage imageNamed:@"addphoto.png"];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    isProfilePicAvaliableInWeb = NO;
    
    if (appDel.CurrentOwnerDetails.owner_ProfilimageDic.count > 0){
        NSString *imgUrl = [appDel.CurrentOwnerDetails.owner_ProfilimageDic valueForKey:@"path_lg"];
        NSString *disturlStr=[NSString stringWithFormat:@"%@%@",RestaurentImageUrl,imgUrl];
        NSLog(@"url = %@",disturlStr);
            
        [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:disturlStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
            [_imageActIndV startAnimating];
        } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
            if (image && finished) {
                _profilePicImg.image = image;
                isProfilePicAvaliableInWeb = YES;
                [_imageActIndV stopAnimating];
            }
        }];
    }else{
        [_imageActIndV stopAnimating];
        isProfilePicAvaliableInWeb = NO;
        _profilePicImg.image = [UIImage imageNamed:@"addphoto.png"];
    }
    
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    [_ScrollView setContentSize:CGSizeMake(320, 760)];
    [self addGestures];
    
    
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    
    [self textFieldPagingSetUpInreg2];
    
    
    _PickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height, _PickerViewContainer.bounds.size.width, _PickerViewContainer.bounds.size.height);
    [self.view addSubview:_PickerViewContainer];
    
    [self enterServiceValues];
    
    isProfilePicChanged = NO;
    
   
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _ScrollView.contentSize=CGSizeMake(320, 850);

    if (textField == _FirstNameTF) {
        [_ScrollView setContentOffset:CGPointMake(0, 20) animated:YES];
    }else if (textField == _LastNameTF){
        [_ScrollView setContentOffset:CGPointMake(0, 50) animated:YES];
    }else if(textField == _RestaurentNameTF){
        [_ScrollView setContentOffset:CGPointMake(0, 90) animated:YES];
    }else if(textField == _RestaurentMobileTF){
        [_ScrollView setContentOffset:CGPointMake(0, 140) animated:YES];
    }else if(textField == _RestaurentFaxnoTF){
        [_ScrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    }else if(textField == _AddressTF || textField == _SuiteTF){
        [_ScrollView setContentOffset:CGPointMake(0, 390) animated:YES];
    }else if(textField == _CityTF || textField == _StateTF){
        [_ScrollView setContentOffset:CGPointMake(0, 440) animated:YES];
    }else if(textField == _ZipCodeTF){
        [_ScrollView setContentOffset:CGPointMake(0, 500) animated:YES];
    }else if(textField == _CityTaxTF){
        [_ScrollView setContentOffset:CGPointMake(0, 500) animated:YES];
    }else{
        [_ScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    _ScrollView.contentSize=CGSizeMake(320, 760);
}
/*
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
 // Prevent crashing undo bug – see note below.
 if (textField == _RestaurentPhNoTF || textField == _RestaurentFaxNoTF) {
 if(range.length + range.location > textField.text.length){
 return NO;
 }
 
 NSUInteger newLength = [textField.text length] + [string length] - range.length;
 return (newLength > 10) ? NO : YES;
 }else if (textField == _OwnerNameTF || textField == _OwnerLastNameTF) {
 NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:AlphaNumarics] invertedSet];
 NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
 return [string isEqualToString:filtered];
 }
 return YES;
 }
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField == _RestaurentMobileTF || textField == _RestaurentFaxnoTF) {
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
     
    }else if (textField == _ZipCodeTF) {
        if(range.length + range.location > textField.text.length){
            return NO;
        }
            
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 5) ? NO : YES;

    }else if (textField == _FirstNameTF || textField == _LastNameTF) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:AlphaNumarics] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }else if (textField == _CityTF) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:Alphabets] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    
    return YES;
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
-(void)textViewDidBeginEditing:(UITextView *)textView{
    _ScrollView.contentSize=CGSizeMake(320, 850);
    [_ScrollView setContentOffset:CGPointMake(0, 280) animated:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    _ScrollView.contentSize=CGSizeMake(320, 760);
    [_ScrollView setContentOffset:CGPointMake(0, 250) animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    _ScrollView.contentSize=CGSizeMake(320, 760);
    
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        _ScrollView.contentSize=CGSizeMake(320, 760);
        
        return NO;
    }
    
    else{
        return YES;
    }
}

- (IBAction)SaveSettings:(id)sender {
    [self showActivityIndicatorInBasicInfo:YES];
    
    phNoStg = [self formatNumber:_RestaurentMobileTF.text];
    faxNoStg = [self formatNumber:_RestaurentFaxnoTF.text];
    
    
    if (_FirstNameTF.text == (id)[NSNull null] || _FirstNameTF.text.length == 0 ){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Owner FirstName"];
        [_FirstNameTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    if ((_FirstNameTF.text != (id)[NSNull null] && _FirstNameTF.text.length >=1 ) && _FirstNameTF.text.length <2){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Owner FirstName cannot be less than 2 characters"];
        [_FirstNameTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [_FirstNameTF.text stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Owner FirstName cannot be blank"];
        [_FirstNameTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }

///
    
    
    if (_LastNameTF.text == (id)[NSNull null] || _LastNameTF.text.length == 0 ){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Owner LastName"];
        [_LastNameTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    NSCharacterSet *whitespaceOl = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedOl = [_LastNameTF.text stringByTrimmingCharactersInSet:whitespaceOl];
    if ([trimmedOl length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Owner LastName cannot be blank"];
        [_LastNameTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    if ((_LastNameTF.text != (id)[NSNull null] && _LastNameTF.text.length >= 1 ) && _LastNameTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Owner LastName cannot be less than 2 characters"];
        [_LastNameTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    
 ///
    if (_RestaurentNameTF.text == (id)[NSNull null] || _RestaurentNameTF.text.length == 0 ){
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Restaurant Name"];
        [_RestaurentNameTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmeds = [_RestaurentNameTF.text stringByTrimmingCharactersInSet:whitespaces];
    if ([trimmeds length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"RestaurantName cannot be blank"];
        [_RestaurentNameTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    if ((_RestaurentNameTF.text != (id)[NSNull null] && _RestaurentNameTF.text.length >=1  ) && _RestaurentNameTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"RestaurantName cannot be less than 2 characters"];
        [_RestaurentNameTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
///
    if ((phNoStg != (id)[NSNull null] && phNoStg.length >= 1) && phNoStg.length <10) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Invalid Phone Number"];
        [_RestaurentMobileTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    
///
    NSLog(@"myFaxNo = %@",_RestaurentFaxnoTF.text);
    if ((faxNoStg != (id)[NSNull null] && faxNoStg.length >= 1 ) && faxNoStg.length <10) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Invalid Fax Number"];
        [_RestaurentFaxnoTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    
 ///
    
    if ((_DescriptionTV.text != (id)[NSNull null] && _DescriptionTV.text.length >= 1 ) && _DescriptionTV.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Description cannot be less than 2 characters"];
        [_DescriptionTV becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    
    
///
    
    if ((_AddressTF.text != (id)[NSNull null] && _AddressTF.text.length >= 1 ) && _AddressTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Address cannot be less than 2 characters"];
        [_AddressTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    
    /////
    if ((_SuiteTF.text != (id)[NSNull null] && _SuiteTF.text.length >= 1 ) && _SuiteTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Suite cannot be less than 2 characters"];
        [_SuiteTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
///
    if ((_CityTF.text != (id)[NSNull null] && _CityTF.text.length >= 1 ) && _CityTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"City cannot be less than 2 characters"];
        [_CityTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
///
    if ((_StateTF.text != (id)[NSNull null] && _StateTF.text.length >= 1 ) && _StateTF.text.length <2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"State cannot be less than 2 characters"];
        [_StateTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }

 ///
    if ((_ZipCodeTF.text != (id)[NSNull null] && _ZipCodeTF.text.length >= 1 ) && _ZipCodeTF.text.length <5) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter valid Zipcode"];
        [_ZipCodeTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
///
    if ((_ZipCodeTF.text != (id)[NSNull null] && _ZipCodeTF.text.length >= 1 ) && _ZipCodeTF.text.length <5) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter valid Zipcode"];
        [_ZipCodeTF becomeFirstResponder];
        [self showActivityIndicatorInBasicInfo:NO];
        return;
    }
    [self nowSaveBasicInfo];
    
    
    
   
    
}
-(void)addValueToSendingDictionary:(NSString *)myString andKey:(NSString *)myKey{
    if (myKey.length >= 1) {
        [paramDict setObject:myString forKey:myKey];
    }else{
        [paramDict setObject:@"" forKey:myKey];
    }
}
-(void)nowSaveBasicInfo{
    
    paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    
    [self addValueToSendingDictionary:_FirstNameTF.text andKey:@"firstname"];
    [self addValueToSendingDictionary:_LastNameTF.text andKey:@"lastname"];
    [self addValueToSendingDictionary:_RestaurentNameTF.text andKey:@"title"];
    [self addValueToSendingDictionary:phNoStg andKey:@"mobile"];
    [self addValueToSendingDictionary:faxNoStg andKey:@"fax"];
    [self addValueToSendingDictionary:_DescriptionTV.text andKey:@"description"];
    [self addValueToSendingDictionary:_AddressTF.text andKey:@"address"];
    [self addValueToSendingDictionary:_SuiteTF.text andKey:@"suite"];
    [self addValueToSendingDictionary:_CityTF.text andKey:@"city"];
    [self addValueToSendingDictionary:_StateTF.text andKey:@"state"];
    [self addValueToSendingDictionary:cityTaxTxt andKey:@"city_tax"];
    [self addValueToSendingDictionary:stateTaxTxt andKey:@"state_tax"];
    [self addValueToSendingDictionary:_ZipCodeTF.text andKey:@"zipcode"];
    
    
    
    
    if (![_profilePicImg.image isEqual:[UIImage imageNamed:@"addphoto.png"]]) {
        NSData *imageData = UIImageJPEGRepresentation(_profilePicImg.image, 0.5);
        NSString *Str=[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        
        [paramDict setObject:@"jpeg" forKey:@"imageExt"];
        [paramDict setObject:[NSNumber numberWithInt:1] forKey:@"default"];
        
        if (isProfilePicChanged && isProfilePicAvaliableInWeb) {
            [paramDict setObject:[appDel.CurrentOwnerDetails.owner_ProfilimageDic valueForKey:@"photo_id"] forKey:@"photo_id"];
        }
        [paramDict setObject:Str forKey:@"restaurantImage"];
        
    }
    
    
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];
  
}

-(void)showActivityIndicatorInBasicInfo:(BOOL)myBool{
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backbuttonAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}





- (IBAction)addButtonAction:(id)sender {
    PhotoAlert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Choose Photo",@"Take Photo", nil];
    [PhotoAlert show];
    

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == PhotoAlert) {
        if (buttonIndex == 1){
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
            return;
        }
        else if (buttonIndex ==2){
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:imagePicker animated:YES completion:nil];
            return;
        }
        
        else
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        
        
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage *profileImg = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(300,200) source:image];
    _profilePicImg.image = profileImg;
    
    isProfilePicChanged = YES;

}

-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    [self showActivityIndicatorInBasicInfo:NO];

    NSLog(@"%@",result);
    if (![[result valueForKey:@"error"] boolValue]) {
        if ([[result valueForKey:@"code"] integerValue] != 113) {
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
        }else{
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
            [self performSelector:@selector(saveLoginDetailsInDBasic:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];
        }
    }
    
    
    
    
    
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showActivityIndicatorInBasicInfo:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}


-(void)saveLoginDetailsInDBasic:(NSDictionary *)result{
    
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
    [self performSelector:@selector(backbuttonAction:)  withObject:nil];
    
}



- (IBAction)StateListTapped:(id)sender {
    [self.view endEditing:YES];
    // State
    _PickerViewH.tag = 1000021;
    [_PickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
    [_ScrollView setContentOffset:CGPointMake(0, 400) animated:YES];
    
}
- (IBAction)CityTaxListTapped:(id)sender {
    [self.view endEditing:YES];
    
    _PickerViewH.tag = 1000022;
    [_PickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
    [_ScrollView setContentOffset:CGPointMake(0, 500) animated:YES];

}
- (IBAction)StateTaxListTapped:(id)sender {
    [self.view endEditing:YES];
    _PickerViewH.tag = 1000023;
    [_PickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
    [_ScrollView setContentOffset:CGPointMake(0, 560) animated:YES];

    
    
}


#pragma mark
#pragma mark - CustomPickerView Datasource Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag ==1000021) {
        return appDel.stateAry.count;
    }else if(pickerView.tag == 1000022){
        return  appDel.cityTaxAray.count;
    }else{
        return appDel.stateTaxAray.count;
    }
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag ==1000021) {
        return appDel.stateAry[row];
    }else if(pickerView.tag == 1000022){
        return appDel.cityTaxAray[row];
    }else{
        return appDel.stateTaxAray[row];
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
    if (pickerView.tag ==1000021) {
        stg =  appDel.stateAry[row];
    }else if(pickerView.tag == 1000022){
        stg = appDel.cityTaxAray[row];
    }else{
        stg = appDel.stateTaxAray[row];
    }
    
    
    tView.text = [NSString stringWithFormat:@"%@%@",[[stg substringToIndex:1] uppercaseString],[stg substringFromIndex:1] ];
    return tView;
}

-(void)pickerViewShow:(BOOL)myBool{
    [self.view endEditing:YES];
    if (!myBool) {
        [UIView animateWithDuration:0.3f animations:^{
            _TransparentBlackView.hidden = YES;
            _PickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height, _PickerViewContainer.bounds.size.width, _PickerViewContainer.bounds.size.height);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            _TransparentBlackView.hidden = NO;
            _PickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height-_PickerViewContainer.bounds.size.height, _PickerViewContainer.bounds.size.width, _PickerViewContainer.bounds.size.height);
        } completion:nil];
    }
}

- (IBAction)donePickerViewAction:(id)sender {
    [self.view endEditing:YES];
    
    if (_PickerViewH.tag == 1000021) {
        _StateTF.text = [appDel.stateAry objectAtIndex:[_PickerViewH selectedRowInComponent:0]];
        [_ScrollView setContentOffset:CGPointMake(0, 370) animated:YES];

    }else if(_PickerViewH.tag == 1000022){
        _CityTaxTF.text = [NSString stringWithFormat:@"%@%%",[appDel.cityTaxAray objectAtIndex:[_PickerViewH selectedRowInComponent:0]]];
        cityTaxTxt = [appDel.cityTaxAray objectAtIndex:[_PickerViewH selectedRowInComponent:0]];
        [_ScrollView setContentOffset:CGPointMake(0, 370) animated:YES];

    }else{
        _StateTaxTF.text = [NSString stringWithFormat:@"%@%%",[appDel.stateTaxAray objectAtIndex:[_PickerViewH selectedRowInComponent:0]]];
        stateTaxTxt = [appDel.stateTaxAray objectAtIndex:[_PickerViewH selectedRowInComponent:0]];
        [_ScrollView setContentOffset:CGPointMake(0, 370) animated:YES];

    }
    [self pickerViewShow:NO];
}
- (IBAction)cancelPickerViewAction:(id)sender {
    [self.view endEditing:YES];
    [self pickerViewShow:NO];
    [_ScrollView setContentOffset:CGPointMake(0, 370) animated:YES];
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


@end
