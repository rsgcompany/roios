//
//  RegisterVC2.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/6/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "RegisterVC2.h"
#import "GlobalMethods.h"

#import "MBProgressHUD.h"

@interface RegisterVC2 ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MBProgressHUDDelegate>{
    

    MBProgressHUD *hud;


    UIImagePickerController *imagePicker;
    UIAlertView *PhotoAlert;
    
    
    NSMutableDictionary *remainingCuisineDic;
    NSString *cityTax,*stateTax;
}


@end

@implementation RegisterVC2


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
    _ScrollV.contentSize=CGSizeMake(320, 500);
    
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    //
    [self textFieldPagingSetUpInreg2];
    [self allocateTapGestures];
    
    
    
    
    
    _PickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height, _PickerViewContainer.bounds.size.width, _PickerViewContainer.bounds.size.height);
    [self.view addSubview:_PickerViewContainer];
    
//    _PickerDoneButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:17.0f];
//    _pickerCancelButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:17.0f];
    
    
    remainingCuisineDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    
    _restImgV.image =[UIImage imageNamed:@"addphoto.png"];
    
    
    [self setRememberedValues];
    _ScrollV.contentSize=CGSizeMake(320, 500);
    [_ScrollV setContentOffset:CGPointMake(0, 0) animated:YES];

    

}

-(void)setRememberedValues{
    NSLog(@"diciii = %@",appDel.RegisterParameterDic);
    
    if ([[appDel.RegisterParameterDic objectForKey:@"address"] length] > 2) {
        _addressTF.text = [appDel.RegisterParameterDic objectForKey:@"address"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"suite"] length] > 2) {
        _suiteTF.text = [appDel.RegisterParameterDic objectForKey:@"suite"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"city"] length] > 2) {
        _cityTF.text = [appDel.RegisterParameterDic objectForKey:@"city"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"state"] length] > 1) {
        _stateTF.text = [appDel.RegisterParameterDic objectForKey:@"state"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"zipcode"] length] > 2) {
        _zipTF.text = [appDel.RegisterParameterDic objectForKey:@"zipcode"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"restaurantDescription"] length] > 2) {
        _restaurentDesTF.text = [appDel.RegisterParameterDic objectForKey:@"restaurantDescription"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"cityTax"] length] > 2) {
        _cityTaxTF.text = [appDel.RegisterParameterDic objectForKey:@"cityTax"];
        cityTax = [appDel.RegisterParameterDic objectForKey:@"cityTax"];
    }
    if ([[appDel.RegisterParameterDic objectForKey:@"stateTax"] length] > 2) {
        _stateTaxTF.text = [appDel.RegisterParameterDic objectForKey:@"stateTax"];
        stateTax = [appDel.RegisterParameterDic objectForKey:@"stateTax"];
    }
    
    if ([appDel.RegisterParameterDic objectForKey:@"RestaurentImageData"]) {
        _restImgV.image = [UIImage imageWithData:[appDel.RegisterParameterDic objectForKey:@"RestaurentImageData"]];
    }
    
    
    
    NSDictionary *dic = [appDel.RegisterParameterDic objectForKey:@"TempararyCuisineDictionary"];
    
    NSInteger count1 = dic.count;
    switch (count1) {
        case 1:
            
            [self gotoDisplayValueAtTextFieldWithKey:@"1" WithSelectedDictionary:[dic objectForKey:@"1"]];
            _typesCuisinesTF.text = [[dic objectForKey:@"1"] valueForKey:@"title"];
            break;
            
        case 2:
            [self gotoDisplayValueAtTextFieldWithKey:@"1" WithSelectedDictionary:[dic objectForKey:@"1"]];
            _typesCuisinesTF.text = [[dic objectForKey:@"1"] valueForKey:@"title"];
            [self performSelector:@selector(AddAnotherCuisine1Action:) withObject:nil];
            [self gotoDisplayValueAtTextFieldWithKey:@"2" WithSelectedDictionary:[dic objectForKey:@"2"]];
            _addAnotherCusine1TF.text = [[dic objectForKey:@"2"] valueForKey:@"title"];
            break;
        case 3:
            [self gotoDisplayValueAtTextFieldWithKey:@"1" WithSelectedDictionary:[dic objectForKey:@"1"]];
            _typesCuisinesTF.text = [[dic objectForKey:@"1"] valueForKey:@"title"];
            [self performSelector:@selector(AddAnotherCuisine1Action:) withObject:nil];
            [self gotoDisplayValueAtTextFieldWithKey:@"2" WithSelectedDictionary:[dic objectForKey:@"2"]];
            _addAnotherCusine1TF.text = [[dic objectForKey:@"2"] valueForKey:@"title"];
            [self gotoDisplayValueAtTextFieldWithKey:@"3" WithSelectedDictionary:[dic objectForKey:@"3"]];
            [self performSelector:@selector(AddAnotherCuisine2Action:) withObject:nil];
            _addAnotherCusine2TF.text = [[dic objectForKey:@"3"] valueForKey:@"title"];
            
            
            
            break;
        default:
            break;
    }
    
    
    
    if ([[appDel.RegisterParameterDic objectForKey:@"customCuisine"] length] > 1) {
        [self performSelector:@selector(AddCustomCuisineAction:) withObject:nil];
        _addCustomTF.text = [appDel.RegisterParameterDic objectForKey:@"customCuisine"];
    }
    
    
    

}

-(void)viewWillAppear:(BOOL)animated{
}




-(void)dismissKeyboardR2:(id)sender{
    [self.view endEditing:YES];
    
//    _ScrollV.contentSize=CGSizeMake(320, 650);
//    _ScrollV.contentSize=CGSizeMake(320, _OrderTypesContainer.frame.origin.y+_OrderTypesContainer.frame.size.height);

}
-(void)textFieldPagingSetUpInreg2{
    
    _addressTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addressTF.leftViewMode = UITextFieldViewModeAlways;
    
    _suiteTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _suiteTF.leftViewMode = UITextFieldViewModeAlways;
    
    _cityTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _cityTF.leftViewMode = UITextFieldViewModeAlways;
    
    _stateTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _stateTF.leftViewMode = UITextFieldViewModeAlways;
    
    _zipTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _zipTF.leftViewMode = UITextFieldViewModeAlways;

    _restaurentDesTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _restaurentDesTF.leftViewMode = UITextFieldViewModeAlways;

    _cityTaxTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _cityTaxTF.leftViewMode = UITextFieldViewModeAlways;

    _stateTaxTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _stateTaxTF.leftViewMode = UITextFieldViewModeAlways;
    
    _typesCuisinesTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _typesCuisinesTF.leftViewMode = UITextFieldViewModeAlways;
    
    _addAnotherCusine1TF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addAnotherCusine1TF.leftViewMode = UITextFieldViewModeAlways;
    
    _addAnotherCusine2TF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addAnotherCusine2TF.leftViewMode = UITextFieldViewModeAlways;
    
    _addCustomTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addCustomTF.leftViewMode = UITextFieldViewModeAlways;


}
-(void)allocateTapGestures{
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardR2:)];
    [_view1Gesture addGestureRecognizer:tapGesture];
    
    //    UITapGestureRecognizer *stateGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateTFActionBlock:)];
    //    [_stateViewG addGestureRecognizer:stateGesture];
    UITapGestureRecognizer *stateGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateTFActionBlockPicker:)];
    [_stateViewG addGestureRecognizer:stateGesture];
    
    
    
    UITapGestureRecognizer *cityTaxGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityTaxTFActionBlockPicker:)];
    [_cityTaxG addGestureRecognizer:cityTaxGesture];
    
    
    UITapGestureRecognizer *stateTaxGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(stateTaxTFActionBlockPicker:)];
    [_statetaxViewG addGestureRecognizer:stateTaxGesture];
    
    
    
    UITapGestureRecognizer *typesCuisineGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(causindTFActionBlockGesture:)];
    [_typesCausineViewG addGestureRecognizer:typesCuisineGesture];
    
    
    UITapGestureRecognizer *AddCuisine1Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCuisine1ActionBlockGesture:)];
    [_addAnotherCuisine1G addGestureRecognizer:AddCuisine1Gesture];
    
    UITapGestureRecognizer *AddCuisine2Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCuisine2ActionBlockGesture:)];
    [_addAnotherCuisine2G addGestureRecognizer:AddCuisine2Gesture];
    
    UITapGestureRecognizer *AddCustomCuisineGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCustomeCuisineActionBlockGesture:)];
    [_addCustomCuisineG addGestureRecognizer:AddCustomCuisineGesture];
    
    
    UITapGestureRecognizer *transparentVGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerCancelAction:)];
    [_transparentBlackView addGestureRecognizer:transparentVGesture];

    
    
    
}



#pragma mark
#pragma mark - CustomPickerView Datasource Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag ==1000001) {
        return appDel.stateAry.count;
    }else if(_pickerViewH.tag == 1000002){
        return  appDel.cityTaxAray.count;
    }else if(_pickerViewH.tag == 1000003){
        return appDel.stateTaxAray.count;
    }else{
        return appDel.cuisineAry.count;
    }
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag ==1000001) {
        return appDel.stateAry[row];
    }else if(pickerView.tag == 1000002){
        return appDel.cityTaxAray[row];
    }else if(pickerView.tag == 1000003){
        return appDel.stateTaxAray[row];
    }else{
        return  [appDel.cuisineAry[row] valueForKey:@"title"];
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
    if (pickerView.tag ==1000001) {
        stg = appDel.stateAry[row];
    }else if(pickerView.tag == 1000002){
        stg = appDel.cityTaxAray[row];
    }else if(pickerView.tag == 1000003){
        stg = appDel.stateTaxAray[row];
    }else{
        stg =  [appDel.cuisineAry[row] valueForKey:@"title"];
    }

    
    tView.text = [NSString stringWithFormat:@"%@%@",[[stg substringToIndex:1] uppercaseString],[stg substringFromIndex:1] ];
    return tView;
}


-(void)pickerViewShow:(BOOL)myBool{
    [self.view endEditing:YES];
    if (!myBool) {
        [UIView animateWithDuration:0.3f animations:^{
            _transparentBlackView.hidden = YES;
            _PickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height, _PickerViewContainer.bounds.size.width, _PickerViewContainer.bounds.size.height);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            _transparentBlackView.hidden = NO;
            _PickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height-_PickerViewContainer.bounds.size.height, _PickerViewContainer.bounds.size.width, _PickerViewContainer.bounds.size.height);
        } completion:nil];
    }
}

- (IBAction)pickerDoneAction:(id)sender {
    [self.view endEditing:YES];
    [self.view bringSubviewToFront:_continueBtnContainer];


    if (_pickerViewH.tag == 1000001) {
        _stateTF.text = [appDel.stateAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        [_ScrollV setContentOffset:CGPointMake(0, 0) animated:YES];

    }else if(_pickerViewH.tag == 1000002){
        _cityTaxTF.text = [NSString stringWithFormat:@"%@%%",[appDel.cityTaxAray objectAtIndex:[_pickerViewH selectedRowInComponent:0]]];
        cityTax = [appDel.cityTaxAray objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        [_ScrollV setContentOffset:CGPointMake(0, 0) animated:YES];

    }else if(_pickerViewH.tag == 1000003){
        _stateTaxTF.text = [NSString stringWithFormat:@"%@%%",[appDel.stateTaxAray objectAtIndex:[_pickerViewH selectedRowInComponent:0]]];
        stateTax = [appDel.stateTaxAray objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        [_ScrollV setContentOffset:CGPointMake(0, 0) animated:YES];

    }else{
        if (_pickerViewH.tag == 1000004) {
            
           

            [self gotoDisplayValueAtTextFieldWithKey:@"1" WithSelectedDictionary:[ appDel.cuisineAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]]];

            
        }else if (_pickerViewH.tag == 1000005) {
            
            [self gotoDisplayValueAtTextFieldWithKey:@"2" WithSelectedDictionary:[ appDel.cuisineAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]]];

            
        }
        else {
            [self gotoDisplayValueAtTextFieldWithKey:@"3" WithSelectedDictionary:[ appDel.cuisineAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]]];

            
        }
        
        
    
    }
    
    [self pickerViewShow:NO];
}

-(void)gotoDisplayValueAtTextFieldWithKey:(NSString *)myKey WithSelectedDictionary:(NSDictionary *)myDic{
    if ([myKey isEqualToString:@"1"]) {
        
        
        
        if ([remainingCuisineDic valueForKey:@"1"]) {
            [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"1"]];
            [remainingCuisineDic removeObjectForKey:@"1"];
        }
//        NSDictionary *selDic = [ appDel.cuisineAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        _typesCuisinesTF.text = [myDic valueForKey:@"title"];
        [appDel.cuisineAry removeObject:myDic];
        [remainingCuisineDic setObject:myDic forKey:@"1"];
        
        [_ScrollV setContentOffset:CGPointMake(0, 100) animated:YES];
        
    }else if ([myKey isEqualToString:@"2"]) {
        
        if ([remainingCuisineDic valueForKey:@"2"]) {
            [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"2"]];
            [remainingCuisineDic removeObjectForKey:@"2"];
        }
        
//        NSDictionary *selDic = [ appDel.cuisineAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        _addAnotherCusine1TF.text = [myDic valueForKey:@"title"];
        [appDel.cuisineAry removeObject:myDic];
        [remainingCuisineDic setObject:myDic forKey:@"2"];
        
        
        [_ScrollV setContentOffset:CGPointMake(0, 130) animated:YES];
        
        
        

    }else{
        if ([remainingCuisineDic valueForKey:@"3"]) {
            [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"3"]];
            [remainingCuisineDic removeObjectForKey:@"3"];
        }
        
//        NSDictionary *selDic = [ appDel.cuisineAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        _addAnotherCusine2TF.text = [myDic valueForKey:@"title"];
        [appDel.cuisineAry removeObject:myDic];
        [remainingCuisineDic setObject:myDic forKey:@"3"];
        
        [_ScrollV setContentOffset:CGPointMake(0, 150) animated:YES];
        
        

    }
    
    NSArray *arr= [NSArray arrayWithArray:appDel.cuisineAry];
    NSArray *SortAry = [GlobalMethods sortArrayDictionaryInAscendingOrderWithArray:arr WithKey:@"title"];
    appDel.cuisineAry = [NSMutableArray arrayWithArray:SortAry];
    

}


- (IBAction)pickerCancelAction:(id)sender {
    [self.view bringSubviewToFront:_continueBtnContainer];

    
    if (_pickerViewH.tag == 1000004) {
        [_ScrollV setContentOffset:CGPointMake(0, 100) animated:YES];
    }else if (_pickerViewH.tag == 1000005) {
        [_ScrollV setContentOffset:CGPointMake(0, 130) animated:YES];
    }
    else {
        [_ScrollV setContentOffset:CGPointMake(0, 150) animated:YES];
    }
    
  
    [self.view endEditing:YES];
    [self pickerViewShow:NO];
}
-(void)stateTFActionBlockPicker:(id)sender{
    _pickerViewH.tag = 1000001;
 
    [_pickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
}
-(void)cityTaxTFActionBlockPicker:(id)sender{
    _pickerViewH.tag = 1000002;
    
    [_ScrollV setContentOffset:CGPointMake(0, 150) animated:YES];
    
    [_pickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
}
-(void)stateTaxTFActionBlockPicker:(id)sender{
    _pickerViewH.tag = 1000003;
    [_ScrollV setContentOffset:CGPointMake(0, 150) animated:YES];

    [_pickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
}
-(void)causindTFActionBlockGesture:(id)sender{
    _pickerViewH.tag = 1000004;
    
    [_ScrollV setContentOffset:CGPointMake(0, 220) animated:YES];

    [_pickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
}
-(void)addCuisine1ActionBlockGesture:(id)sender{
    _pickerViewH.tag = 1000005;
    
    [_ScrollV setContentOffset:CGPointMake(0, 250) animated:YES];

    [_pickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
}
-(void)addCuisine2ActionBlockGesture:(id)sender{
    _pickerViewH.tag = 1000006;
    [_ScrollV setContentOffset:CGPointMake(0, 290) animated:YES];

    
    [_pickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
}
-(void)addCustomeCuisineActionBlockGesture:(id)sender{
    _pickerViewH.tag = 1000007;
    
    [_pickerViewH reloadAllComponents];
    [self pickerViewShow:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - TextField Delgates
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == _addressTF) {
        [_suiteTF becomeFirstResponder];
    }else if (textField == _suiteTF){
        [_cityTF becomeFirstResponder];
    }else if (textField == _cityTF){
//        [self performSelector:@selector(stateTFActionBlock:) withObject:nil afterDelay:0.1f];
    }else if (textField == _zipTF){
        [_restaurentDesTF becomeFirstResponder];
    }
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    _ScrollV.contentSize=CGSizeMake(320, _OrderTypesContainer.frame.origin.y+_OrderTypesContainer.frame.size.height+250);
    

    if (textField ==_addressTF || textField ==_suiteTF){
        [_ScrollV setContentOffset:CGPointMake(0, 20) animated:YES];
    }else if (textField == _cityTF || textField == _zipTF){
        [_ScrollV setContentOffset:CGPointMake(0, 100) animated:YES];
    }else if (textField == _stateTF){
//        _ScrollV.contentSize=CGSizeMake(320, 900);
        [textField resignFirstResponder];
        [_ScrollV setContentOffset:CGPointMake(0, 100) animated:YES];
    }else if (textField == _restaurentDesTF){
//        _ScrollV.contentSize=CGSizeMake(320, 900);
        [_ScrollV setContentOffset:CGPointMake(0, 150) animated:YES];
    }else if (textField == _cityTaxTF || textField == _stateTaxTF){
//        _ScrollV.contentSize=CGSizeMake(320, 900);
        [textField resignFirstResponder];
        [_ScrollV setContentOffset:CGPointMake(0, 300) animated:YES];
    }else if (textField == _typesCuisinesTF){
//        _ScrollV.contentSize=CGSizeMake(320, 900);
        [textField resignFirstResponder];
        [_ScrollV setContentOffset:CGPointMake(0, 380) animated:YES];
    }else if (textField == _addCustomTF) {
        [_ScrollV setContentOffset:CGPointMake(0, 380) animated:YES];
    }
//        else if(textField == bTextfield) {
//        
//        [_ScrollV setContentOffset:CGPointMake(0, CustomCuisineView.frame.origin.y-50)];
//        
////        [_ScrollV setContentOffset:CGPointMake(0, 460) animated:YES];
//
//          //        [textField resignFirstResponder];
////        [self getDropDownWithTextFieldFrame:textField];
//    }
    
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    _ScrollV.contentSize=CGSizeMake(320, _OrderTypesContainer.frame.origin.y+_OrderTypesContainer.frame.size.height+20);
    [self.view endEditing:YES];
    if (textField == _addCustomTF) {
        [_ScrollV setContentOffset:CGPointMake(0, 90) animated:YES];
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField == _zipTF) {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 5) ? NO : YES;
    }else if (textField == _cityTF) {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:Alphabets] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    }
    return YES;
}


#pragma mark
#pragma mark - Button Actions

- (IBAction)StateButtonAction:(id)sender {
    [self performSelector:@selector(stateTFActionBlock:) withObject:self];
}

- (IBAction)cityTaxButtonAction:(id)sender {

    [self performSelector:@selector(cityTaxTFActionBlock:) withObject:self];
}

- (IBAction)stateTaxButtonAction:(id)sender {

    [self performSelector:@selector(stateTaxTFActionBlock:) withObject:self];
}

- (IBAction)TypesCuisineButtonAction:(id)sender {
    [self performSelector:@selector(causindTFActionBlock:) withObject:self];
}

- (IBAction)stateTFActionBlock:(id)sender {
}
- (IBAction)cityTaxTFActionBlock:(id)sender {
}
- (IBAction)stateTaxTFActionBlock:(id)sender {
}
- (IBAction)causindTFActionBlock:(id)sender {
}




- (IBAction)addPhotoButtonBlock:(id)sender {
    [self.view endEditing:YES];
    [self pickerViewShow:NO];
    
    PhotoAlert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Choose Photo",@"Take Photo", nil];
    [PhotoAlert show];
    
}
#pragma mark
#pragma mark - AlertView Delgates

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
#pragma mark
#pragma mark - ImagePicker Delgates

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage * profileImg = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(300,200) source:image];
    
    _restImgV.image = profileImg;
    

}



////It is For Dynamic DropDowns
- (IBAction)AddAnotherCuisine1Action:(id)sender {
    if (_typesCuisinesTF.text == (id)[NSNull null] || _typesCuisinesTF.text.length == 0 || [_typesCuisinesTF.text isEqualToString:@"Select a Cuisine"]) {
        return;
    }
    

    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect newFram = _addAnotherContainer2.frame;
        newFram.origin.y = _addAnothercontainer1.frame.origin.y + _addAnothercontainer1.bounds.size.height;
        _addAnotherContainer2.frame = newFram;
        
        _AddAnotherBtn1.hidden = YES;
        _AddAnother1TFContainer.hidden = NO;
        
    } completion:nil];
    
}
- (IBAction)addAnotherCuisine1RemoveAction:(id)sender {
    
//    _addAnotherCusine1TF.text = @"";

    NSLog(@"fext1=%@",_addAnotherCusine1TF.text);
    NSLog(@"fext1=%@",_addAnotherCusine2TF.text);
//    [_ScrollV bringSubviewToFront: _addAnotherContainer2];
    
    
    
    if (_addAnotherCusine2TF.text.length != 0) {
        
        //    if (_addAnotherCusine2TF.text.length != 0 ) {
        _addAnotherCusine1TF.text = _addAnotherCusine2TF.text;
        _addAnotherCusine2TF.text = @"";
        
        [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"2"]];
        [remainingCuisineDic setObject:[remainingCuisineDic valueForKey:@"3"] forKey:@"2"];
        //        [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"3"]];
        [remainingCuisineDic removeObjectForKey:@"3"];
        
        
        _AddAnother2TFContainer.hidden = YES;
        _AddAnotherBtn2.hidden = NO;
        
        
    }else if (_addAnotherCusine2TF.text.length == 0 && !_AddAnother2TFContainer.hidden){
        
        
        if (_addAnotherCusine1TF.text.length>1) {
            [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"2"]];
            [remainingCuisineDic removeObjectForKey:@"2"];
            _addAnotherCusine1TF.text = @"";
        }
        
        _AddAnother2TFContainer.hidden = YES;
        _AddAnotherBtn2.hidden = NO;
        
        
    }else{
        if (_addAnotherCusine1TF.text.length>1) {
            [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"2"]];
            [remainingCuisineDic removeObjectForKey:@"2"];
            _addAnotherCusine1TF.text = @"";
        }
        
        
        
        _AddAnotherBtn1.hidden = YES;
        _AddAnother1TFContainer.hidden = YES;
        
        [UIView animateWithDuration:0.3f animations:^{
            CGRect newFram = _addAnotherContainer2.frame;
            newFram.origin.y = _addAnothercontainer1.frame.origin.y ;
            _addAnotherContainer2.frame = newFram;
            
            
        }completion:^(BOOL finished){
            _AddAnotherBtn1.hidden = NO;
        }];
    }
    
    
    NSArray *arr= [NSArray arrayWithArray:appDel.cuisineAry];
    NSArray *SortAry = [GlobalMethods sortArrayDictionaryInAscendingOrderWithArray:arr WithKey:@"title"];
    appDel.cuisineAry = [NSMutableArray arrayWithArray:SortAry];
    
}
- (IBAction)AddAnotherCuisine2Action:(id)sender {
    
    if (_addAnotherCusine1TF.text == (id)[NSNull null] || _addAnotherCusine1TF.text.length == 0 || [_addAnotherCusine1TF.text isEqualToString:@"Select a Cuisine"]) {
        return;
    }

    
    _AddAnotherBtn2.hidden = YES;
    _AddAnother2TFContainer.hidden = NO;
}
- (IBAction)addAnotherCuisine2RemoveAction:(id)sender {
    if (_addAnotherCusine2TF.text.length>1) {
        [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"3"]];
        [remainingCuisineDic removeObjectForKey:@"3"];
    }
    _addAnotherCusine2TF.text = @"";
    
  
    
    //    if ([remainingCuisineDic valueForKey:@"3"]) {
    //        [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"3"]];
    //    }
    
    _AddAnotherBtn2.hidden = NO;
    _AddAnother2TFContainer.hidden = YES;
    
    
    
    NSArray *arr= [NSArray arrayWithArray:appDel.cuisineAry];
    NSArray *SortAry = [GlobalMethods sortArrayDictionaryInAscendingOrderWithArray:arr WithKey:@"title"];
    appDel.cuisineAry = [NSMutableArray arrayWithArray:SortAry];
    

}
- (IBAction)AddCustomCuisineAction:(id)sender {
//    if (_addAnotherCusine2TF.text == (id)[NSNull null] || _addAnotherCusine2TF.text.length == 0 || [_addAnotherCusine2TF.text isEqualToString:@"Select a Cuisine"]) {
//        return;
//    }

    _AddCustomBtn.hidden = YES;
    _AddCustomTFContainer.hidden = NO;
}
- (IBAction)addCustomRemoveAction:(id)sender {
    _addCustomTF.text = @"";
    
    _AddCustomBtn.hidden = NO;
    _AddCustomTFContainer.hidden = YES;
}






- (IBAction)ContinueButtonAction:(id)sender {
    [self showCustomActivityIndicatorR2:YES];
    if ([GlobalMethods whiteSpacesAvailableForString:_addressTF.text] && _addressTF.text.length>1) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Address cannot be blank"];
        [_addressTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
        
    }
    
    if (_addressTF.text.length < 2 && _addressTF.text.length != 0) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Address cannot be less than 2 characters"];
        [_addressTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
    }
    if ([GlobalMethods whiteSpacesAvailableForString:_suiteTF.text] && _suiteTF.text.length >1) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Suite cannot be blank"];
        [_suiteTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
        
    }
    
    if (_suiteTF.text.length < 2 && _suiteTF.text.length != 0 ) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Suite cannot be less than 2 characters"];
        [_suiteTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
    }
   
    if ([GlobalMethods whiteSpacesAvailableForString:_cityTF.text] && _cityTF.text.length >1) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"City cannot be blank"];
        [_cityTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
        
    }
    
    if (_cityTF.text.length < 2 && _cityTF.text.length != 0 ) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"City cannot be less than 2 characters"];
        [_cityTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
    }
    if ([GlobalMethods whiteSpacesAvailableForString:_restaurentDesTF.text] && _restaurentDesTF.text.length >1) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Restaurant Description cannot be blank"];
        [_restaurentDesTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
        
    }
    if (_restaurentDesTF.text.length < 2 && _restaurentDesTF.text.length != 0 ) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Restaurant Description cannot be less than 2 characters"];
        [_restaurentDesTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
    }
    
    if ([GlobalMethods whiteSpacesAvailableForString:_zipTF.text] && _zipTF.text.length >1) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Zipcode cannot be blank"];
        [_zipTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
        
    }
    if (_zipTF.text.length > 1 && _zipTF.text.length != 5 ) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Zipcode cannot be less than 5 characters"];
        [_zipTF becomeFirstResponder];
        [self showCustomActivityIndicatorR2:NO];
        return;
    }
    
    
    
    
    
    [self continueToNextView];
}

-(void)continueToNextView{
    if (_addressTF.text.length >1 ) {
        @try {
            [appDel.RegisterParameterDic setObject:_addressTF.text forKey:@"address"];
        }
        @catch (NSException *exception) {}
    }
    if (_suiteTF.text.length > 1){
        @try {
            [appDel.RegisterParameterDic setObject:_suiteTF.text forKey:@"suite"];
        }
        @catch (NSException *exception) {}
    }
    if (_cityTF.text.length > 1){
        @try {
            [appDel.RegisterParameterDic setObject:_cityTF.text forKey:@"city"];
        }
        @catch (NSException *exception) {}
    }
    if (_stateTF.text.length > 1){
        @try {
            [appDel.RegisterParameterDic setObject:_stateTF.text forKey:@"state"];
        }
        @catch (NSException *exception) {}
    }
    if (_zipTF.text.length > 1){
        @try {
            [appDel.RegisterParameterDic setObject:_zipTF.text forKey:@"zipcode"];
        }
        @catch (NSException *exception) {}
    }
    if (_restaurentDesTF.text.length > 1){
        @try {
            [appDel.RegisterParameterDic setObject:_restaurentDesTF.text forKey:@"restaurantDescription"];
        }
        @catch (NSException *exception) {}
    }
    if (_cityTaxTF.text.length > 1 && ![_cityTaxTF.text isEqualToString:@"Select City Tax"]){
        @try {
            [appDel.RegisterParameterDic setObject:cityTax forKey:@"cityTax"];
        }
        @catch (NSException *exception) {}
    }
    if (_stateTaxTF.text.length > 1 && ![_stateTaxTF.text isEqualToString:@"Select State Tax"]){
        @try {
            [appDel.RegisterParameterDic setObject:stateTax forKey:@"stateTax"];
        }
        @catch (NSException *exception) {}
    }
    
    if (_typesCuisinesTF.text.length > 1 && ![_typesCuisinesTF.text isEqualToString:@"Select a Cuisine"]){
        _CuisinesDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
        [appDel.RegisterParameterDic setObject:remainingCuisineDic forKey:@"TempararyCuisineDictionary"];

        NSArray *keys = [remainingCuisineDic allKeys];
        
        for (NSString *key in keys) {
            [_CuisinesDictionary setObject:[[remainingCuisineDic objectForKey:key] valueForKey:@"type_id"] forKey:key];
        }
        NSString *CuisinesString = [GlobalMethods convertDictionaryToJSONString:_CuisinesDictionary];
        @try {
            [appDel.RegisterParameterDic setObject:CuisinesString forKey:@"cuisineTypes"];
        }
        @catch (NSException *exception) {}
        
    }
    
    if (_addCustomTF.text.length > 1 && ![_addCustomTF.text isEqualToString:@"Enter Custom Cuisine"]) {
        @try {
            [appDel.RegisterParameterDic setObject:_addCustomTF.text forKey:@"customCuisine"];
        }
        @catch (NSException *exception) {}
        
    }else{
        [appDel.RegisterParameterDic removeObjectForKey:@"customCuisine"];
    }
    
    if (![_restImgV.image isEqual:[UIImage imageNamed:@"addphoto.png"]]) {
        NSData *imageData = UIImageJPEGRepresentation(_restImgV.image, 0.5);
        [appDel.RegisterParameterDic setObject:imageData forKey:@"RestaurentImageData"];

        NSString *Str=[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
        [appDel.RegisterParameterDic setObject:Str forKey:@"restaurantImage"];
        [appDel.RegisterParameterDic setObject:@"jpeg" forKey:@"imageExt"];
        [appDel.RegisterParameterDic setObject:[NSNumber numberWithInt:1] forKey:@"default"];
    }

    
    
    
    [self showCustomActivityIndicatorR2:NO];

    [self performSegueWithIdentifier:@"goToRegister3" sender:self];

}

-(void)showCustomActivityIndicatorR2:(BOOL)mybool{
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



- (IBAction)SkipTheStepButtonAction:(id)sender {
    [self.view endEditing:YES];
    
    [self performSegueWithIdentifier:@"goToRegister3" sender:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"goToRegister3"]) {
        
        [segue destinationViewController];
    }
}
- (IBAction)BackBtnClicked:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
