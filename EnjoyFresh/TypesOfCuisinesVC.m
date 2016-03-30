//
//  TypesOfCuisinesVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "TypesOfCuisinesVC.h"
#import "GlobalMethods.h"
#import "ParserHClass.h"
#import "MBProgressHUD.h"
#import "CustomTableViewH.h"
@interface TypesOfCuisinesVC ()<parserHDelegate,MBProgressHUDDelegate,CustomTableViewHDelegate>{
    ParserHClass *webParser;
    MBProgressHUD *hud;
    CustomTableViewH *dropDownV;
    
    NSMutableDictionary *remainingCuisineDic;
    
    NSMutableArray *cusAry;
    

}

@end

@implementation TypesOfCuisinesVC


-(void)textFieldPagingSetUpTyp{
    _mainCuisineTF1.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _mainCuisineTF1.leftViewMode = UITextFieldViewModeAlways;
    
    _addAnotherCusine1TF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addAnotherCusine1TF.leftViewMode = UITextFieldViewModeAlways;
    
    _addAnotherCusine2TF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addAnotherCusine2TF.leftViewMode = UITextFieldViewModeAlways;
    
    
    _addCustomTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addCustomTF.leftViewMode = UITextFieldViewModeAlways;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;
    
    _PickerViewContainer.frame = CGRectMake(0, self.view.bounds.size.height, _PickerViewContainer.bounds.size.width, _PickerViewContainer.bounds.size.height);
    [self.view addSubview:_PickerViewContainer];
    
//    _PickerDoneButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:17.0f];
//    _pickerCancelButton.titleLabel.font = [UIFont fontWithName:@"Raleway-Medium" size:17.0f];


    [self textFieldPagingSetUpTyp];
    
    [self setUpGesturesTy];
    
    
    remainingCuisineDic = [[NSMutableDictionary alloc]initWithCapacity:0];

    
    
    
}
-(void)setUpGesturesTy{
    
    UITapGestureRecognizer *MainGes=[[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(mainCuisineGAction:)];
    [_mainCuisineViewG addGestureRecognizer:MainGes];
    
    
    UITapGestureRecognizer *AddCuisine1Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCuisine1ActionBlockGesture:)];
    [_addAnotherCuisine1G addGestureRecognizer:AddCuisine1Gesture];
    
    
    UITapGestureRecognizer *AddCuisine2Gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCuisine2ActionBlockGesture:)];
    [_addAnotherCuisine2G addGestureRecognizer:AddCuisine2Gesture];
    
    
    UITapGestureRecognizer *transparentVGesturew = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerCancelAction:)];
    [_transparentBlackView addGestureRecognizer:transparentVGesturew];
    
    UITapGestureRecognizer *gest1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardHide:)];
    [_Scroller addGestureRecognizer:gest1];
}
-(void)keyBoardHide:(id)sender{
    [self.view endEditing:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"itis =%@",appDel.CurrentOwnerDetails.owner_cuisineArray);
    
    
    NSMutableArray *cuisinAr = [[NSMutableArray alloc]initWithCapacity:0];
    NSMutableArray *customCuisinAr = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (NSDictionary *dic in appDel.CurrentOwnerDetails.owner_cuisineArray) {
        if (![[dic valueForKey:@"is_custom"] boolValue]) {
            [cuisinAr addObject:dic];
        }else{
            [customCuisinAr addObject:dic];
        }
    }
    if (customCuisinAr.count > 0) {
        _addCustomTF.text = [customCuisinAr[0] valueForKey:@"cuisine_title"];
        _addCustomTF.enabled = NO;
        _customRemoveBtn.hidden = YES;
        _AddCustomBtn.hidden= YES;
        _AddCustomTFContainer.hidden = NO;
    }
    
    
    NSInteger count1 = cuisinAr.count;
    switch (count1) {
        case 0:
            _mainCuisineTFContainer.hidden = NO;
            _addAnotherContainer2.hidden = NO;
            _addAnothercontainer1.hidden = NO;

            break;
        case 1:
//            _mainCuisineTFContainer.hidden = YES;
            _mainCuisineTF1.text = [cuisinAr[0] valueForKey:@"cuisine_title"];
            _mainCuisineTF1.enabled = NO;
            _mainDownArrow.hidden = YES;
            
            [appDel.cuisineAry removeObject:cuisinAr[0]];
            [remainingCuisineDic setObject:cuisinAr[0] forKey:@"1"];
            

            break;
            
        case 2:
//            _mainCuisineTFContainer.hidden = YES;
            _mainCuisineTF1.text = [cuisinAr[0] valueForKey:@"cuisine_title"];
            _mainCuisineTF1.enabled = NO;
            _mainDownArrow.hidden = YES;

            [appDel.cuisineAry removeObject:cuisinAr[0]];
            [remainingCuisineDic setObject:cuisinAr[0] forKey:@"1"];

            
            _addAnotherCusine1TF.text = [cuisinAr[1] valueForKey:@"cuisine_title"];
            _addAnotherCusine1TF.enabled = NO;
            _CuisineRemove1Btn.hidden = YES;
            _AddAnother1TFContainer.hidden = NO;
            _AddAnotherBtn1.hidden = YES;
            _cuisineDownArrow1.hidden = YES;
            
            [appDel.cuisineAry removeObject:cuisinAr[1]];
            [remainingCuisineDic setObject:cuisinAr[1] forKey:@"2"];
            
            
            CGRect cont1Poss = _addAnotherContainer2.frame;
            cont1Poss.origin.y = _addAnothercontainer1.frame.origin.y+_addAnothercontainer1.frame.size.height;
            _addAnotherContainer2.frame = cont1Poss;
            
            

            break;
        case 3:
//            _mainCuisineTFContainer.hidden = YES;
            _mainCuisineTF1.text = [cuisinAr[0] valueForKey:@"cuisine_title"];
            _mainCuisineTF1.enabled = NO;
            _mainDownArrow.hidden = YES;
            
            [appDel.cuisineAry removeObject:cuisinAr[0]];
            [remainingCuisineDic setObject:cuisinAr[0] forKey:@"1"];

//            _addAnotherContainer2.hidden = YES;
            _addAnotherCusine1TF.text = [cuisinAr[1] valueForKey:@"cuisine_title"];
            _addAnotherCusine1TF.enabled = NO;
            _CuisineRemove1Btn.hidden = YES;
            _AddAnother1TFContainer.hidden = NO;
            _AddAnotherBtn1.hidden = YES;
            _cuisineDownArrow1.hidden = YES;
            
            [appDel.cuisineAry removeObject:cuisinAr[1]];
            [remainingCuisineDic setObject:cuisinAr[1] forKey:@"2"];

            
            CGRect cont2Posss = _addAnotherContainer2.frame;
            cont2Posss.origin.y = _addAnothercontainer1.frame.origin.y+_addAnothercontainer1.frame.size.height;
            _addAnotherContainer2.frame = cont2Posss;

            
            
            
//            _addAnothercontainer1.hidden = YES;
            _addAnotherCusine2TF.text = [cuisinAr[2] valueForKey:@"cuisine_title"];
            _cusineRemove2Btn.hidden = YES;
            _AddAnother2TFContainer.hidden = NO;
            _addAnotherCusine2TF.enabled = NO;
            _AddAnotherBtn2.hidden = YES;
            _cuisineDownarrow2.hidden = YES;
            
            [appDel.cuisineAry removeObject:cuisinAr[2]];
            [remainingCuisineDic setObject:cuisinAr[2] forKey:@"3"];


            break;
               default:
            break;
    }
    
    
}

-(void)mainCuisineGAction:(id)sender{
    
    if ([[appDel.CurrentOwnerDetails.owner_cuisineArray valueForKey:@"cuisine_title"] containsObject:_mainCuisineTF1.text]) {
        return;
    }


    _pickerViewH.tag = 1000061;
    [_pickerViewH reloadAllComponents];
    [self pickerViewShowTy:YES];

}
-(void)addCuisine1ActionBlockGesture:(id)sender{
   

    if ([[appDel.CurrentOwnerDetails.owner_cuisineArray valueForKey:@"cuisine_title"] containsObject:_addAnotherCusine1TF.text]) {
        return;

    }
    
    
    _pickerViewH.tag = 1000062;
    [_pickerViewH reloadAllComponents];
    [self pickerViewShowTy:YES];
}

-(void)addCuisine2ActionBlockGesture:(id)sender{
    
    if ([[appDel.CurrentOwnerDetails.owner_cuisineArray valueForKey:@"cuisine_title"] containsObject:_addAnotherCusine2TF.text]) {
        return;
        
    }

    _pickerViewH.tag = 1000063;
    
    [_pickerViewH reloadAllComponents];
    [self pickerViewShowTy:YES];
}
- (IBAction)AddAnotherCuisine1Action:(id)sender{
    if (_mainCuisineTF1.text == (id)[NSNull null] || _mainCuisineTF1.text.length == 0 || [_mainCuisineTF1.text isEqualToString:@"Select a Cuisine"]) {
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
- (IBAction)addAnotherCuisine1RemoveAction:(id)sender{
    //    _addAnotherCusine1TF.text = @"";
    
    NSLog(@"fext1=%@",_addAnotherCusine1TF.text);
    NSLog(@"fext1=%@",_addAnotherCusine2TF.text);
    //    [_ScrollV bringSubviewToFront: _addAnotherContainer2];
    
//    if ([remainingCuisineDic valueForKey:@"2"]) {
//        [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"2"]];
//    }
    
    
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
- (IBAction)AddAnotherCuisine2Action:(id)sender{
    if (_addAnotherCusine1TF.text == (id)[NSNull null] || _addAnotherCusine1TF.text.length == 0 || [_addAnotherCusine1TF.text isEqualToString:@"Select a Cuisine"]) {
        return;
    }
    
    _AddAnotherBtn2.hidden = YES;
    _AddAnother2TFContainer.hidden = NO;

}
- (IBAction)addAnotherCuisine2RemoveAction:(id)sender{

    
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
- (IBAction)AddCustomCuisineAction:(id)sender{
    _AddCustomBtn.hidden = YES;
    _AddCustomTFContainer.hidden = NO;
}
- (IBAction)addCustomRemoveAction:(id)sender{
    _addCustomTF.text = @"";

    _AddCustomBtn.hidden = NO;
    _AddCustomTFContainer.hidden = YES;

}

-(void)StaticDropAction:(UIButton *)sender{
    
    NSLog(@"%ld",(long)sender.tag);
    
    currenttag=sender.tag;
    
//    if (isShowingDropDown==NO) {
//        
//        _DropDownTable.frame=CGRectMake(8, AnotherCuisineView.frame.origin.y+AnotherCuisineView.frame.size.height, 304, 250);
//        _DropDownTable.hidden=NO;
//        isShowingDropDown=YES;
//        
//        
//    }
//    
//    else{
//        
//        _DropDownTable.frame=CGRectMake(8, 66, 0, 0);
//        _DropDownTable.hidden=YES;
//        isShowingDropDown=NO;
//        
//        
//        
//    }
    
    
    [self dynamicTFActionSheetWithtag:sender.tag];
}
-(void)dynamicTFActionSheetWithtag:(NSInteger)tagg{
    _pickerViewH.tag = tagg;
    [_pickerViewH reloadAllComponents];
    [self pickerViewShowTy:YES];
}
-(void)pickerViewShowTy:(BOOL)myBool{
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


#pragma mark
#pragma mark - CustomPickerView Datasource Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return appDel.cuisineAry.count;
//    return appDel.cuisineDic.count;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  [appDel.cuisineAry[row] valueForKey:@"title"];
//    return [appDel.cuisineDic valueForKey:@"title"][row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:Regular size:18]];
        [tView setTextAlignment:NSTextAlignmentCenter];
    }
    
    NSString *stg = nil;
    stg =  [appDel.cuisineAry[row] valueForKey:@"title"];
    
    
    tView.text = [NSString stringWithFormat:@"%@%@",[[stg substringToIndex:1] uppercaseString],[stg substringFromIndex:1] ];
    return tView;
}

- (IBAction)pickerCancelAction:(id)sender {
    [self.view endEditing:YES];
    [self pickerViewShowTy:NO];
}
- (IBAction)pickerDoneAction:(id)sender {
    [self.view endEditing:YES];
    
    
        
    if(_pickerViewH.tag == 1000061){
        
        if ([remainingCuisineDic valueForKey:@"1"]) {
            [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"1"]];
            [remainingCuisineDic removeObjectForKey:@"1"];
        }
        NSDictionary *selDic = [ appDel.cuisineAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        _mainCuisineTF1.text = [selDic valueForKey:@"title"];
        [appDel.cuisineAry removeObject:selDic];
        [remainingCuisineDic setObject:selDic forKey:@"1"];
    
    }
    else if(_pickerViewH.tag == 1000062){
        if ([remainingCuisineDic valueForKey:@"2"]) {
            [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"2"]];
            [remainingCuisineDic removeObjectForKey:@"2"];
        }
        
        NSDictionary *selDic = [ appDel.cuisineAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        _addAnotherCusine1TF.text = [selDic valueForKey:@"title"];
        [appDel.cuisineAry removeObject:selDic];
        [remainingCuisineDic setObject:selDic forKey:@"2"];
        
    }
    else {
        if ([remainingCuisineDic valueForKey:@"3"]) {
            [appDel.cuisineAry addObject:[remainingCuisineDic valueForKey:@"3"]];
            [remainingCuisineDic removeObjectForKey:@"3"];
        }
        
        NSDictionary *selDic = [ appDel.cuisineAry objectAtIndex:[_pickerViewH selectedRowInComponent:0]];
        _addAnotherCusine2TF.text = [selDic valueForKey:@"title"];
        [appDel.cuisineAry removeObject:selDic];
        [remainingCuisineDic setObject:selDic forKey:@"3"];
        
    }
    
    NSArray *arr= [NSArray arrayWithArray:appDel.cuisineAry];
    NSArray *SortAry = [GlobalMethods sortArrayDictionaryInAscendingOrderWithArray:arr WithKey:@"title"];
    appDel.cuisineAry = [NSMutableArray arrayWithArray:SortAry];
    

    [self pickerViewShowTy:NO];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}



-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    [_Scroller setContentOffset:CGPointMake(0, 20) animated:YES];
    
//    
//    if(_CustomCuisineBtn.frame.origin.y+30 > 200){
//        [_Scroller setContentOffset:CGPointMake(0, _CustomCuisineBtn.frame.origin.y-100) animated:YES];
//    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    [_Scroller setContentOffset:CGPointMake(0, 0 ) animated:YES];

    return YES;
}


- (IBAction)backButtonAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)SaveSettingsAction:(id)sender {
    
    [self showActivityIndicatorInTypesCuisine:YES];
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    
    
    NSString *CuisinesString;
    _CuisinesDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];

    if (_mainCuisineTF1.text.length > 1 && ![_mainCuisineTF1.text isEqualToString:@"Select a Cuisine"]){
        @try {
            [_CuisinesDictionary setObject:[[remainingCuisineDic objectForKey:@"1"] valueForKey:@"cuisine_type_id"]forKey:@"1"];
        }
        @catch (NSException *exception) {
            [_CuisinesDictionary setObject:[[remainingCuisineDic objectForKey:@"1"] valueForKey:@"type_id"]forKey:@"1"];
        }
    }
    if (_addAnotherCusine1TF.text.length > 1 && ![_addAnotherCusine1TF.text isEqualToString:@"Select a Cuisine"]){
        @try {
            [_CuisinesDictionary setObject:[[remainingCuisineDic objectForKey:@"2"] valueForKey:@"cuisine_type_id"]forKey:@"2"];
        }
        @catch (NSException *exception) {
            [_CuisinesDictionary setObject:[[remainingCuisineDic objectForKey:@"2"] valueForKey:@"type_id"]forKey:@"2"];
        }
    }
    if (_addAnotherCusine2TF.text.length > 1 && ![_addAnotherCusine2TF.text isEqualToString:@"Select a Cuisine"]){
        @try {
            [_CuisinesDictionary setObject:[[remainingCuisineDic objectForKey:@"3"] valueForKey:@"cuisine_type_id"]forKey:@"3"];
        }
        @catch (NSException *exception) {
            [_CuisinesDictionary setObject:[[remainingCuisineDic objectForKey:@"3"] valueForKey:@"type_id"]forKey:@"3"];
        }
    }
    CuisinesString = [GlobalMethods convertDictionaryToJSONString:_CuisinesDictionary];


    
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    [paramDict setObject:CuisinesString forKey:@"cuisineTypes"];
    

    
    if (_addCustomTF.text.length > 1 && ![_addCustomTF.text isEqualToString:@"Enter Custom Cuisine"]) {
        [paramDict setObject:_addCustomTF.text forKey:@"customCuisine"];
    }
    
   
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];

}



-(void)showActivityIndicatorInTypesCuisine:(BOOL)myBool{
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

-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    NSLog(@"%@",result);
    
    if (![[result valueForKey:@"error"] boolValue]) {

        if ([[result valueForKey:@"code"] integerValue] != 113) {
            [self showActivityIndicatorInTypesCuisine:NO];
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
        }else{
            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
            [self performSelector:@selector(saveLoginDetailsInDB:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];
        }
    }else{
        [self showActivityIndicatorInTypesCuisine:NO];
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
    }
    
    
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showActivityIndicatorInTypesCuisine:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
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
    
   
    
    [self showActivityIndicatorInTypesCuisine:NO];
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
        
        [_mainBtn setImage:[UIImage imageNamed:@"nf_close"] forState:UIControlStateNormal];

        //        _trasparentBlackView.hidden = NO;
        
    }else{
        [_mainBtn setImage:[UIImage imageNamed:@"HamburgerIcon"] forState:UIControlStateNormal];

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
