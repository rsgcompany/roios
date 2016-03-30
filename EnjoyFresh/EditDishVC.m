//
//  EditDishVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 2/7/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import "EditDishVC.h"
#import "GlobalMethods.h"
#import "ParserHClass.h"
#import "CustomTableViewH.h"
#import "UIImageView+WebCache.h"

#import "TableViewCellH.h"



@interface EditDishVC ()<parserHDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate,CustomTableViewHDelegate,UITableViewDataSource,UITableViewDelegate,IBActionSheetDelegate>{
    UIImagePickerController *imagePicker;
    UIImage *profileImg;
    ParserHClass *webParser;
    
    
    
    CustomTableViewH *dropDownV;
    
    
    NSString *orderByDate,*orderByHr,*orderByMin,*orderByAmpm;
    NSString *availByDate,*availByHr,*availByMin,*availByAmpm;
    NSString *availUntilDate,*availUntilHr,*availUntilMin,*availUntilAmpm;
    
    
    NSString *scrollHelpingString;
    
    
    UIAlertView *PhotoAlert;
    NSDateFormatter *dateFormatter;
    
    
    UITextField *Golbaltf;
    NSInteger globalTFTag;
    
    NSString *PhotoString;
    
    
    NSInteger categoryTyype_Id;
    
    
    NSMutableArray *gallaryArray;
    
    
    
    NSMutableArray *ingredientsArray;
    
    NSInteger ingTableRows;
    
    
    NSMutableArray *IImagesArray;
    NSInteger selectedIndex;
    
    
    NSInteger totalCount,responceCount;
    
    
    NSString *isUpDating;
    BOOL isIngredientsEditing;

}



@end

@implementation EditDishVC



-(void)textFieldPagingSetUpInAddDish{
    
    _dishNameTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _dishNameTF.leftViewMode = UITextFieldViewModeAlways;
    
    _dishPriceTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _dishPriceTF.leftViewMode = UITextFieldViewModeAlways;
    
    _dishQuantityTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _dishQuantityTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    _addressTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addressTF.leftViewMode = UITextFieldViewModeAlways;
    
    _cityTaxTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _cityTaxTF.leftViewMode = UITextFieldViewModeAlways;
    
    _stateTaxTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _stateTaxTF.leftViewMode = UITextFieldViewModeAlways;
    
    _addCuisineTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _addCuisineTF.leftViewMode = UITextFieldViewModeAlways;
    
}
-(void)allocateGestures{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAddDish:)];
    [_touchableView addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAddDish:)];
    [_scrollview addGestureRecognizer:tapGesture1];
//    _touchableView.hidden=YES;
//    _touchableView1.hidden=YES;
    
    
    UITapGestureRecognizer *cityTaxG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CityTaxTFGesTureAction:)];
    [_cityTaxGestureView addGestureRecognizer:cityTaxG];
    
    
    UITapGestureRecognizer *StateTaxG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(StateTaxTFGesTureAction:)];
    [_stateTaxGestureView addGestureRecognizer:StateTaxG];
    
    
    UITapGestureRecognizer *AddCusineG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addCuisineTFGesTureAction:)];
    [_AddCuisineGestureView addGestureRecognizer:AddCusineG];
    
    
    UITapGestureRecognizer *AdditionalG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboardAddDish:)];
    [_additionalContainerView addGestureRecognizer:AdditionalG];
    
    UITapGestureRecognizer *TransparectBlackVG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionSheetHide:)];
    [_trasparentBlackView addGestureRecognizer:TransparectBlackVG];
    
    
    
}
-(void)CityTaxTFGesTureAction:(id)sender{
    [self.view endEditing:YES];
    _textPickerH.tag = 1000055;
    [_textPickerH reloadAllComponents];
    
    [self TextactionSheetShows:YES];
    
    
}
-(void)StateTaxTFGesTureAction:(id)sender{
    [self.view endEditing:YES];
    _textPickerH.tag = 1000056;
    [_textPickerH reloadAllComponents];
    [self TextactionSheetShows:YES];
    
    
}
-(void)addCuisineTFGesTureAction:(id)sender{
    [self.view endEditing:YES];
    _textPickerH.tag = 1000057;
    [_textPickerH reloadAllComponents];
    [self TextactionSheetShows:YES];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    _scrollview.contentSize=CGSizeMake(320, 850);
    
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    globalTFTag = 1;
    
    
    [self allocateGestures];
    
    
    _actionSheetView.frame = CGRectMake(0, self.view.bounds.size.height, _actionSheetView.bounds.size.width, _actionSheetView.bounds.size.height);
    [self.view addSubview:_actionSheetView];
    _textActionSheet.frame = CGRectMake(0, self.view.bounds.size.height, _textActionSheet.bounds.size.width, _textActionSheet.bounds.size.height);
    [self.view addSubview:_textActionSheet];
    
    
    [self textFieldPagingSetUpInAddDish];
    
  
    dateFormatter = [[NSDateFormatter alloc] init];
  //  [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
  //  [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"edi"]];
//    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
//    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM dd yyyy hh mm a"];

    [_localDatePicker setDate:[NSDate date]];
   // [_localDatePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
   // [_localDatePicker setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
    [_localDatePicker setMinimumDate:[NSDate date]];
    [_localDatePicker setMaximumDate:[self maXDateFromDate:[NSDate date]]];
    [_localDatePicker setDate:[NSDate date] animated:YES];
    [_localDatePicker setMinuteInterval:15];
    //    NSCalendar *cal = [NSCalendar currentCalendar];
    //    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"US/Pacific"];
    //    [cal setTimeZone:zone];
    //    [_localDatePicker setTimeZone:[NSTimeZone timeZoneWithName: @"PST"]];
    //    [_localDatePicker setTimeZone:[NSTimeZone timeZoneWithName:@"US/Pacific"]];
    
    gallaryArray = [[NSMutableArray alloc]initWithCapacity:0];
    responceCount = 0;
    totalCount = 0;
    
    isIngredientsEditing = NO;
    
    
    ingredientsArray = [[NSMutableArray alloc]initWithCapacity:0];
    ingTableRows = 1;
    
    [self continueAsAdddishOrEditDishEithTextString:YES];
    

}

-(CAShapeLayer *)setMaskHWithView:(UIView *)myView{
    UIBezierPath *maskPath;
    
    maskPath = [UIBezierPath bezierPathWithRoundedRect:myView.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = myView.bounds;
    maskLayer.path = maskPath.CGPath;
    return maskLayer;
}
-(void)quardzCoreWorkForView:(UIView *)myView{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:myView.bounds];
    myView.layer.cornerRadius=8.0f;
    myView.layer.masksToBounds = NO;
    myView.layer.shadowColor = [UIColor grayColor].CGColor;
    myView.layer.shadowRadius = 5.0f;
    myView.layer.shadowOpacity = 0.8f;
    myView.layer.shadowOffset = CGSizeMake(-1,1.5f);
    myView.layer.shadowPath = path.CGPath;
    myView.layer.shouldRasterize = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    //    [self setMaskHWithView:_doneCancelButtonsContainer];
    _doneCancelButtonsContainer.layer.mask = [self setMaskHWithView:_doneCancelButtonsContainer];
    
    _ingredientsDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    
    _cityTaxLbl.text = [NSString stringWithFormat:@"City Tax: %@%%",appDel.CurrentOwnerDetails.owner_city_tax];
    _stateTaxLbl.text = [NSString stringWithFormat:@"State Tax: %@%%",appDel.CurrentOwnerDetails.owner_state_tax];
    
    [self setUpContainer];
    
    
    if (appDel.CurrentOwnerDetails.owner_address.length != 0 && appDel.CurrentOwnerDetails.owner_city_tax.length != 0 && appDel.CurrentOwnerDetails.owner_state_tax.length != 0 && appDel.CurrentOwnerDetails.owner_cuisineArray.count != 0 ) {
        
        _register2AllFieldsContainer.hidden = YES;
    }else{
        _register2AllFieldsContainer.hidden = NO;
        
        BOOL isAddress = appDel.CurrentOwnerDetails.owner_address.length == 0;
        BOOL isCityTax = appDel.CurrentOwnerDetails.owner_city_tax.length == 0;
        BOOL isStateTax = appDel.CurrentOwnerDetails.owner_state_tax.length == 0;
        BOOL isACuisine = appDel.CurrentOwnerDetails.owner_cuisineArray.count == 0;
        
        CGRect myRect = CGRectMake(0, 10, 300, 60);
        CGRect rect1 = [self AddressTFAvaliable:isAddress WithFrame:myRect];
        CGRect rect2 = [self cityTaxAvaliable:isCityTax stateTaxAvaliable:isStateTax WithFrame:rect1];
        CGRect rect3 = [self cuisineTFAvaliable:isACuisine WithFrame:rect2];
        CGRect rect5 = [self ButtonsAddAtFrame:rect3];
        [self viewWithACiSCSetUpUpToFrame:rect5];
    }
    
    
    
    
}


#pragma mark
#pragma mark - Setup Address_StateTax_CityTax_CuisineTypes
-(void)setUpContainer{
    
    _AddCuisineGestureView.frame = CGRectMake(0, 10, 300, 60);
    _cityTaxViewContainer.frame = CGRectMake(0, 70, 150, 60);
    _stateTaxViewContainer.frame = CGRectMake(150, 70, 150, 60);
    _cuisineTFViewContainer.frame = CGRectMake(0, 130, 300, 60);
    _doneCancelButtonsContainer.frame = CGRectMake(0, 190, 300, 60);
    
    _ViewWithACSC.frame = CGRectMake(10, 75, 300, 250);
    
}
-(CGRect)AddressTFAvaliable:(BOOL)isavaliable WithFrame:(CGRect)myRect{
    
    CGRect returnRect;
    
    if (isavaliable) {
        _AddressViewContainer.hidden = NO;
        returnRect = CGRectMake(0, myRect.origin.y+60, 300, 60);
    }else{
        _AddressViewContainer.hidden = YES;
        returnRect = myRect;
    }
    return returnRect;
}
-(CGRect)cityTaxAvaliable:(BOOL)isCityTax stateTaxAvaliable:(BOOL)isStateTax WithFrame:(CGRect)myRect{
    CGRect returnRect;
    
    if (isCityTax && isStateTax) {
        _cityTaxViewContainer.hidden = NO;
        _stateTaxViewContainer.hidden = NO;
        
        
        CGRect cityTaxframe = _cityTaxViewContainer.frame;
        cityTaxframe.origin.y = myRect.origin.y;
        _cityTaxViewContainer.frame = cityTaxframe;
        
        CGRect stateTaxFrame = _stateTaxViewContainer.frame;
        stateTaxFrame.origin.y = myRect.origin.y;
        _stateTaxViewContainer.frame = stateTaxFrame;
        
        
        returnRect = CGRectMake(0, myRect.origin.y+60, 300, 60);
        
        
    }else if (isCityTax || isStateTax){
        if (isCityTax) {
            _cityTaxViewContainer.hidden = NO;
            _stateTaxViewContainer.hidden = YES;
            
            CGRect cityTaxframe = _cityTaxViewContainer.frame;
            cityTaxframe.origin.y = myRect.origin.y;
            cityTaxframe.size.width = myRect.size.width;
            _cityTaxViewContainer.frame = cityTaxframe;
            
            returnRect = CGRectMake(0, myRect.origin.y+60, 300, 60);
        }else{
            _cityTaxViewContainer.hidden = YES;
            _stateTaxViewContainer.hidden = NO;
            
            CGRect stateTaxFrame = _stateTaxViewContainer.frame;
            stateTaxFrame.origin.x = myRect.origin.x;
            stateTaxFrame.origin.y = myRect.origin.y;
            stateTaxFrame.size.width = myRect.size.width;
            _stateTaxViewContainer.frame = stateTaxFrame;
            
            returnRect = CGRectMake(0, myRect.origin.y+60, 300, 60);
        }
        
    }else{
        _cityTaxViewContainer.hidden = YES;
        _stateTaxViewContainer.hidden = YES;
        returnRect = myRect;
    }
    
    
    return returnRect;
}
-(CGRect)cuisineTFAvaliable:(BOOL)isAvaliable WithFrame:(CGRect)myRect{
    CGRect returnRect;
    
    if (isAvaliable) {
        _cuisineTFViewContainer.hidden = NO;
        CGRect cuisineFrame = _cuisineTFViewContainer.frame;
        cuisineFrame.origin.y = myRect.origin.y;
        _cuisineTFViewContainer.frame = cuisineFrame;
        
        returnRect = CGRectMake(0, myRect.origin.y+60, 300, 60);
    }else{
        _cuisineTFViewContainer.hidden = YES;
        returnRect = myRect;
    }
    
    return returnRect;
}
-(CGRect)ButtonsAddAtFrame:(CGRect)myRect{
    _doneCancelButtonsContainer.frame = myRect;
    return myRect;
}
-(void)viewWithACiSCSetUpUpToFrame:(CGRect)myRect{
    CGRect containerFrame = _ViewWithACSC.frame;
    
    containerFrame.size.height = myRect.origin.y+myRect.size.height;
    _ViewWithACSC.frame = containerFrame;
}





-(void)continueAsAdddishOrEditDishEithTextString:(BOOL )myBoolv{
    
    _navigationTitleLbl.text = @"Edit Dish";
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:_dishDetailDict];
    
    for (NSString * key in [dict allKeys]){
        if ([[dict objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:@"" forKey:key];
    }
        
    _DishPicImgV.image = [UIImage imageNamed:@"addphoto.png"];
    
    
    IImagesArray = [[NSMutableArray alloc]initWithCapacity:0];

    NSArray *defArray=[[NSArray alloc]initWithArray:[[_dishDetailDict valueForKey:@"images"] valueForKey:@"default"]];
    NSUInteger defIndex = [defArray indexOfObject:@"1"];
    if (defIndex != NSNotFound) {
        
        NSDictionary *ldic =[[_dishDetailDict valueForKey:@"images"]  objectAtIndex:defIndex];
        NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:ldic];
        
        NSString *path_lgStg = [dic valueForKey:@"path_lg"];
        [dic setValue:path_lgStg forKey:@"imageType"];
        [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isDeleted"];
        [dic setObject:@"EmPty" forKey:@"NewImage"];

        [IImagesArray addObject:dic];
    }else{
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic setValue:[UIImage imageNamed:@"addphoto.png"] forKey:@"path_lg"];
        [dic setValue:[UIImage imageNamed:@"addphoto.png"] forKey:@"imageType"];
        [dic setValue:@"EmPty" forKey:@"photo_id"];
        [dic setValue:@"0" forKey:@"default"];
        [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isDeleted"];
        [dic setObject:@"EmPty" forKey:@"NewImage"];
        [IImagesArray addObject:dic];
    }
    
    
    for (NSDictionary *dic1 in [_dishDetailDict valueForKey:@"images"]) {
        if (![[dic1 valueForKey:@"default"] boolValue]) {
            NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:dic1];
            
            NSString *path_lgStg = [dic valueForKey:@"path_lg"];
            [dic setValue:path_lgStg forKey:@"imageType"];
            [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isDeleted"];
            [dic setObject:@"EmPty" forKey:@"NewImage"];
            [IImagesArray addObject:dic];
            
            
            
        }
    }
    
    for (NSInteger i=IImagesArray.count; i<3; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dic setValue:[UIImage imageNamed:@"addphoto.png"] forKey:@"imageType"];
        [dic setValue:[UIImage imageNamed:@"addphoto.png"] forKey:@"path_lg"];
        [dic setValue:@"EmPty" forKey:@"photo_id"];
        [dic setValue:@"0" forKey:@"default"];
        [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isDeleted"];
        [dic setObject:@"EmPty" forKey:@"NewImage"];
        [IImagesArray addObject:dic];
    }
    
    
    
    for (int i=0; i<IImagesArray.count; i++) {
        switch (i) {
            case 0:{
                if ([[[IImagesArray objectAtIndex:i]valueForKey:@"imageType"] isKindOfClass:[NSString class]]) {
                    [_actIndicator1 startAnimating];
                    _imgDefLbl1.hidden = YES;
                    _DishPicImgV.image = [UIImage imageNamed:@"addphoto.png"];
                    NSString *url=[NSString stringWithFormat:@"%@%@",DishImageUrl,[[IImagesArray objectAtIndex:i] valueForKey:@"imageType"]];
                    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
                    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
                        if (image && finished) {
                            _DishPicImgV.image = image;
                            if ([[[IImagesArray objectAtIndex:i] valueForKey:@"default"] boolValue]) {
                                _imgDefLbl1.hidden = NO;
                            }else{
                                _imgDefLbl1.hidden = YES;
                            }
                            [_actIndicator1 stopAnimating];
                        }
                    }];
                }else {
                    if ([[[IImagesArray objectAtIndex:i] valueForKey:@"default"] boolValue]) {
                        _imgDefLbl1.hidden = NO;
                    }else{
                        _imgDefLbl1.hidden = YES;
                    }
                    _DishPicImgV.image = [[IImagesArray objectAtIndex:i] valueForKey:@"imageType"];
                }
                
            }
                break;
            case 1:{
                if ([[[IImagesArray objectAtIndex:i]valueForKey:@"imageType"] isKindOfClass:[NSString class]]) {
                    [_actIndicator2 startAnimating];
                    _imgDefLbl2.hidden = YES;
                    NSString *url =[NSString stringWithFormat:@"%@%@",DishImageUrl,[[IImagesArray objectAtIndex:i] valueForKey:@"imageType"]];
                    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
                    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
                        if (image && finished) {
                            [_gallaryBtn setImage:image forState:UIControlStateNormal];
                            [_actIndicator2 stopAnimating];
                            if ([[[IImagesArray objectAtIndex:i] valueForKey:@"default"] boolValue]) {
                                _imgDefLbl2.hidden = NO;
                            }else{
                                _imgDefLbl2.hidden = YES;
                            }
                        }
                    }];
                }else{
                    UIImage *img = [[IImagesArray objectAtIndex:i] valueForKey:@"imageType"];
                    if ([[[IImagesArray objectAtIndex:i] valueForKey:@"default"] boolValue]) {
                        _imgDefLbl2.hidden = NO;
                    }else{
                        _imgDefLbl2.hidden = YES;
                    }
                    [_gallaryBtn setImage:img forState:UIControlStateNormal];
                }
            }
                break;
            case 2:{
                if ([[[IImagesArray objectAtIndex:i]valueForKey:@"imageType"] isKindOfClass:[NSString class]]) {
                    NSString *url =[NSString stringWithFormat:@"%@%@",DishImageUrl,[[IImagesArray objectAtIndex:i] valueForKey:@"imageType"]];
                    [_actIndicator3 startAnimating];
                    _imgDefLbl3.hidden = YES;
                    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
                    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
                        if (image && finished) {
                            [_gallaryBtn1 setImage:image forState:UIControlStateNormal];
                            if ([[[IImagesArray objectAtIndex:i] valueForKey:@"default"] boolValue]) {
                                _imgDefLbl3.hidden = NO;
                            }else{
                                _imgDefLbl3.hidden = YES;
                            }
                            [_actIndicator3 stopAnimating];
                        }
                    }];
                }else{
                    UIImage *img = [[IImagesArray objectAtIndex:i] valueForKey:@"imageType"];
                    if ([[[IImagesArray objectAtIndex:i] valueForKey:@"default"] boolValue]) {
                        _imgDefLbl3.hidden = NO;
                    }else{
                        _imgDefLbl3.hidden = YES;
                    }
                    [_gallaryBtn1 setImage:img forState:UIControlStateNormal];
                }
        
                
            }
                break;
                
            default:
                break;
        }
    }
    
    
    
    
    /*
    NSMutableArray *GalImgAry = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSDictionary *dic in [_dishDetailDict valueForKey:@"images"]) {
        if ([[dic valueForKey:@"default"] boolValue]) {
            NSString *postUrlStg1;
            NSString *disturlStr1;
                
            postUrlStg1 = [dic valueForKey:@"path_lg"];
            disturlStr1=[NSString stringWithFormat:@"%@%@",DishImageUrl,postUrlStg1];
            [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:disturlStr1] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
                } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
                if (image && finished) {
                    _DishPicImgV.image = image;
                        
                }
            }];
        }
        else{
            [GalImgAry addObject:dic];
        }
    }
        
    if (GalImgAry.count > 0) {
        for (int i=0; i<GalImgAry.count; i++) {
            NSString *postUrlStg;
            NSString *disturlStr;
            switch (i) {
                case 0:{
                        
                    postUrlStg = [[GalImgAry valueForKey:@"path_lg"] objectAtIndex:i];
                    disturlStr=[NSString stringWithFormat:@"%@%@",DishImageUrl,postUrlStg];
                    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:disturlStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
                    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
                        if (image && finished) {
                            [gallaryArray addObject:image];
                            [_gallaryBtn setImage:image forState:UIControlStateNormal];
                                
                                
                        }
                    }];
                }
                break;
                case 1:{
                    postUrlStg = [[GalImgAry valueForKey:@"path_lg"] objectAtIndex:i];
                    disturlStr=[NSString stringWithFormat:@"%@%@",DishImageUrl,postUrlStg];
                    [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:disturlStr] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
                    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
                        if (image && finished) {
                                
                            [gallaryArray addObject:image];
                            [_gallaryBtn1 setImage:image forState:UIControlStateNormal];
                                
                                
                        }
                    }];
                }
                break;
                    
                default:
                break;
            }
        }
    }
    */
        
        
        
        
    if ([dict valueForKey:@"title"] != (id)[NSNull null] || [dict valueForKey:@"title"]!=0) {
        _dishNameTF.text = [dict valueForKey:@"title"];
            
    }
    
    @try {
        _dishPriceTF.text = [dict valueForKey:@"price"];
    }
    @catch (NSException *exception) {}
    @try {
        _dishQuantityTF.text = @"0";
        _inStockLbl.text=[NSString stringWithFormat:@"In Stock : %@",[dict valueForKey:@"qty"]];
    }
    @catch (NSException *exception) {}
    @try {
        _dishDescriptionTView.text = [dict valueForKey:@"description"];
    }
    @catch (NSException *exception) {}
    
    
    if ([[dict valueForKey:@"category"] count] >=  1) {
        _dishCategoryLBL.text = [[dict valueForKey:@"category"] valueForKey:@"title"];
        categoryTyype_Id = [[[dict valueForKey:@"category"] valueForKey:@"type_id"] integerValue];
    }
    
   
    NSString *sdate=[self formattedDate:[dict valueForKey:@"order_by_date"]];
    
    @try {
        _dishOrderedByLBL.text = [NSString stringWithFormat:@"%@ %@:%@ %@",sdate,[dict valueForKey:@"order_by_hr"],[dict valueForKey:@"order_by_min"],[dict valueForKey:@"order_by_ampm"]];
    }
    @catch (NSException *exception) {}
    @try {
        orderByDate =sdate ;
    }
    @catch (NSException *exception) {}
    @try {
        orderByHr = [dict valueForKey:@"order_by_hr"];
    }
    @catch (NSException *exception) {}
   
    @try {
        orderByMin = [dict valueForKey:@"order_by_min"];
    }
    @catch (NSException *exception) {}
    
    @try {
        orderByAmpm = [dict valueForKey:@"order_by_ampm"];
    }
    @catch (NSException *exception) {}
    
    NSString *adate=[self formattedDate:[dict valueForKey:@"avail_by_date"]];

    @try {
        _dishAvaliableByLBL.text = [NSString stringWithFormat:@"%@ %@:%@ %@",adate,[dict valueForKey:@"avail_by_hr"],[dict valueForKey:@"avail_by_min"],[dict valueForKey:@"avail_by_ampm"]];
    }
    @catch (NSException *exception) {}
    
    @try {
        availByDate = adate;
    }
    @catch (NSException *exception) {}
    
    @try {
        availByHr = [dict valueForKey:@"avail_by_hr"];
    }
    @catch (NSException *exception) {}
    
    
    @try {
        availByMin = [dict valueForKey:@"avail_by_min"];
    }
    @catch (NSException *exception) {}
    
    
    @try {
        availByAmpm = [dict valueForKey:@"avail_by_ampm"];
    }
    @catch (NSException *exception) {}
    
    NSString *udate=[self formattedDate:[dict valueForKey:@"avail_until_date"]];

    
    @try {
        _dishAvaliableUntilTF.text = [NSString stringWithFormat:@"%@ %@:%@ %@",udate,[dict valueForKey:@"avail_until_hr"],[dict valueForKey:@"avail_until_min"],[dict valueForKey:@"avail_until_ampm"]];
    }
    @catch (NSException *exception) {}
    
    
    @try {
        availUntilDate =udate ;
    }
    @catch (NSException *exception) {}
    
    
    @try {
        availUntilHr = [dict valueForKey:@"avail_until_hr"];
    }
    @catch (NSException *exception) {}
    
    @try {
        availUntilMin = [dict valueForKey:@"avail_until_min"];
    }
    @catch (NSException *exception) {}
    
    @try {
        availUntilAmpm = [dict valueForKey:@"avail_until_ampm"];
    }
    @catch (NSException *exception) {}
    
    @try {
        availByHr = [dict valueForKey:@"avail_by_hr"];
    }
    @catch (NSException *exception) {}
    
    @try {
        availByHr = [dict valueForKey:@"avail_by_hr"];
    }
    @catch (NSException *exception) {}
    
          
    if ([[dict valueForKey:@"ingrediants"] count]>0) {
        [ingredientsArray addObjectsFromArray:[dict valueForKey:@"ingrediants"]];
        ingTableRows = [[dict valueForKey:@"ingrediants"] count];
        [self resetFrames:YES];
    }else{
        ingTableRows=1;
    }
        
        
    _isVegetarian = [[dict valueForKey:@"vegetarian"] boolValue];
    if (_isVegetarian)
        _vegetarianButton.on = YES;
    else
        _vegetarianButton.on = NO;
        
        
    _isGlutineFree = [[dict valueForKey:@"gluten_free"] boolValue];
    if (_isGlutineFree)
        _glutenFreeButton.on = YES;
    else
        _glutenFreeButton.on = NO;
        
        
    _isVegan = [[dict valueForKey:@"vegan"] boolValue];
    if (_isVegan)
        _veganButton.on = YES;
    else
        _veganButton.on = NO;
        
        
    _isOrganic = [[dict valueForKey:@"organic"] boolValue];
    if (_isOrganic)
        _organicButton.on = YES;
    else
        _organicButton.on = NO;
        
        
    _isLocalIngradients = [[dict valueForKey:@"local_ingredients"] boolValue];
    if (_isLocalIngradients)
        _localIngredientsButton.on = YES;
    else
        _localIngredientsButton.on = NO;
        
        
    _isAvaliable =[[dict valueForKey:@"available"] boolValue];
    if (_isAvaliable)
        _avaliableButton.on = YES;
    else
        _avaliableButton.on = NO;
        
   
}
-(NSString *)formattedDate:(NSString *)date{
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt=[df dateFromString:date];
    [df setDateFormat:@"MM-dd-yyyy"];
    NSString *sdate=[df stringFromDate:dt];
    return sdate;
}
-(NSString *)formattedDatePast:(NSString *)date{
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM-dd-yyyy"];

    NSDate *dt=[df dateFromString:date];
    [df setDateFormat:@"yyyy-MM-dd"];

    NSString *sdate=[df stringFromDate:dt];
    return sdate;
}
-(void)showCustomActivityIndicatorInAddEditDish:(BOOL)mybool{
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

#pragma mark
#pragma mark - TextView Delegates
- (void)textViewDidEndEditing:(UITextView *)theTextView {
    if (![theTextView hasText]) {
        theTextView.textColor = [UIColor lightGrayColor];
        theTextView.text = @"Dish Description";
    }
}

- (void) textViewDidChange:(UITextView *)textView {
    if(![textView hasText]) {
    }
    else{
        textView.textColor = [UIColor blackColor];
        
    }
}



- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    [_scrollview setContentOffset:CGPointMake(0, 100) animated:YES];
    textView.text = @"";
    textView.textColor = [UIColor blackColor];
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField!=_dishNameTF && textField!=_dishPriceTF&& textField!=_dishQuantityTF) {
        CGFloat yPos = _additionalContainerView.frame.origin.y-200;
        [_scrollview setContentOffset:CGPointMake(0, yPos+10) animated:YES];
    }
    
    if (textField !=_dishNameTF && textField!=_dishPriceTF && textField!=_dishQuantityTF && textField!=_addressTF) {
        isIngredientsEditing = YES;
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField == _dishNameTF) {
        if(range.length + range.location > textField.text.length){
            return NO;
        }
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 40) ? NO : YES;
    }
    
    else if (textField == _dishPriceTF) {
        
        NSString* modifiedFieldText = [textField.text stringByReplacingCharactersInRange:range withString:string] ;
        // Remove all characters except for the digits 0 - 9.
        NSString* filteredToDigits = [GlobalMethods stringByFilteringCharactersInSet:[NSCharacterSet decimalDigitCharacterSet] withTextStg:modifiedFieldText];
        // Change textField's text only if the result is <= 9 digits  (7 integer digits and 2 fraction digits).
        if ( filteredToDigits.length <= 9 ) {
            // If you'd rather this method didn't change textField's text and only determined whether or not the change should proceed, you can move this code block into a method triggered by textField's Editing Changed, replacing this block with "return YES".  You'll need to once again filter textField's text to only the characters 0 - 9.
            
            
            
            NSNumberFormatter * formatter =  [NSNumberFormatter new];
            [formatter setUsesSignificantDigits:YES];
            [formatter setMaximumFractionDigits:2];
            [formatter setRoundingMode:NSNumberFormatterRoundCeiling];
            
            float num = (filteredToDigits.doubleValue/100);
            //            NSLog(@"Num = %.2f",num);
            
            
            
            //            NSNumber *asNumber = @(filteredToDigits.doubleValue / 100.0 ) ;
            //            NSLog(@"AsNum = %@",[formatter stringFromNumber:asNumber]);
            //            textField.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:asNumber]];
            if (num>9999.99) {
                [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Price greater than 9999.99 is not allowed."];
            }
            else
                textField.text = [NSString stringWithFormat:@"%.2f",num];        }
        // This method just changed textField's text based on the user's input, so iOS should not also change textField's text.
        return NO ;
        
    }else if (textField == _dishQuantityTF) {
        if(range.length + range.location > textField.text.length){
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 3) ? NO : YES;
    }
    
    
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField == _dishPriceTF) {
        if([_dishPriceTF.text floatValue] > 9999.9999) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Price greater than 9999.99 is not allowed."];
            [_dishPriceTF becomeFirstResponder];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField == _dishNameTF) {
        [_dishPriceTF becomeFirstResponder];
    }else if (textField == _dishPriceTF) {
        
        if (0.9999999999 > [_dishPriceTF.text floatValue]){
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter a value greater than or equal to 1."];
            [_dishPriceTF becomeFirstResponder];
        }else if ([_dishPriceTF.text floatValue] > 9999.9999) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Price greater than 9999.99 is not allowed."];
            [_dishPriceTF becomeFirstResponder];
        }else{
            [_dishQuantityTF becomeFirstResponder];
        }
        
    }else if (textField == _dishQuantityTF) {
        [_dishDescriptionTView becomeFirstResponder];
    }
  else if (textField == _addressTF){
        [textField resignFirstResponder];
    }else{
        
        
        if (textField!=_dishNameTF && textField!=_dishPriceTF && textField!=_dishQuantityTF && textField!=_addressTF) {
            return [self saveIngredients];
        }
        [textField resignFirstResponder];
    }
    
    
    
    //    [self performSelector:@selector(ActionSheetHide:) withObject:nil];
    return YES;
}
- (BOOL)saveIngredients{
    isIngredientsEditing = NO;
    [ingredientsArray removeAllObjects];
    NSInteger rows =  [_ingredientsTable numberOfRowsInSection:0];
    for (int row = 0; row < rows; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        TableViewCellH *cell = (TableViewCellH *)[_ingredientsTable cellForRowAtIndexPath:indexPath];
        NSString *stg = cell.ingredientsTfield.text;
        NSLog(@"txt= %@",stg);
        
        if (stg.length < 1) {
            [cell.ingredientsTfield resignFirstResponder];
            return YES;
        }
        if ([GlobalMethods whiteSpacesAvailableForString:stg]) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Ingredient name cannot be blank"];
            [cell.ingredientsTfield becomeFirstResponder];
            return YES;
            
        }
        
        if ([[ingredientsArray valueForKey:@"lowercaseString"] containsObject:[stg lowercaseString]]) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter unique ingredients."];
            cell.ingredientsTfield.text = @"";
            [cell.ingredientsTfield resignFirstResponder];
            return YES;
            
        } else {
            [ingredientsArray addObject:stg];
        }
        [cell.ingredientsTfield resignFirstResponder];
    }
    [_ingredientsTable reloadData];
    return YES;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ingTableRows;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent =@"cellIdentifier";
    
    TableViewCellH *cell=(TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    //    cell.ingredientsTfield.tag = indexPath.row+10001;
    cell.ingredientRemoveBtn.tag = indexPath.row+100001;
    
    
    @try {
        cell.ingredientsTfield.text = [ingredientsArray objectAtIndex:indexPath.row];
    }
    @catch (NSException *exception) {
        cell.ingredientsTfield.text = @"";
    }
    //    [cell.ingredientsTfield becomeFirstResponder];
    
    if (cell.ingredientRemoveBtn.tag == 100001) {
        cell.ingredientRemoveBtn.hidden=YES;
    }
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([_ingredientsTable numberOfRowsInSection:section]<10) {
        static NSString *cellIdent =@"sectionIdentifier";
        TableViewCellH *cell=(TableViewCellH *)[tableView dequeueReusableCellWithIdentifier:cellIdent];
        return cell;
    }
    
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40.0f;
}
- (IBAction)ingredientRemoveButtonAction:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.ingredientsTable];
    NSIndexPath *indexPath = [self.ingredientsTable indexPathForRowAtPoint:buttonPosition];
    TableViewCellH *cell = (TableViewCellH *)[_ingredientsTable cellForRowAtIndexPath:indexPath];
    
    @try {
        [ingredientsArray removeObjectAtIndex:indexPath.row];
        [cell.ingredientsTfield becomeFirstResponder];
        
    }
    @catch (NSException *exception) {}
    
    ingTableRows--;
    cell.ingredientsTfield.text = @"";
    
    [self resetFrames:YES];
    [_ingredientsTable reloadData];
}
-(void)resetFrames:(BOOL)mBool{
    CGRect TblFrame = _ingredientsTable.frame;
//    NSInteger rows1  = ingredientsArray.count+1;
    TblFrame.size.height = 40+(40*ingTableRows);
    _ingredientsTable.frame = TblFrame;
    
    
    CGRect additFrame = _additionalContainerView.frame;
    additFrame.origin.y = _ingredientsTable.frame.origin.y+_ingredientsTable.frame.size.height;
    _additionalContainerView.frame = additFrame;
    
    CGSize scrollsize = _scrollview.contentSize;
    scrollsize.height = additFrame.origin.y+additFrame.size.height;
    _scrollview.contentSize = scrollsize;
    
}

- (IBAction)addIngredientButtonAction:(id)sender {
    [ingredientsArray removeAllObjects];
    
    
    NSInteger rows =  [_ingredientsTable numberOfRowsInSection:0];
    for (int row = 0; row < rows; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        TableViewCellH *cell = (TableViewCellH *)[_ingredientsTable cellForRowAtIndexPath:indexPath];
        NSString *stg = cell.ingredientsTfield.text;
        NSLog(@"txt= %@",stg);
        
        if (stg.length < 1) {
            [cell.ingredientsTfield becomeFirstResponder];
            return;
        }
        if ([GlobalMethods whiteSpacesAvailableForString:stg]) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Ingredient name cannot be blank"];
            [cell.ingredientsTfield becomeFirstResponder];
            return;
        }
        
        
        if ([[ingredientsArray valueForKey:@"lowercaseString"] containsObject:[stg lowercaseString]]) {
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter unique ingredients."];
            cell.ingredientsTfield.text = @"";
            [cell.ingredientsTfield becomeFirstResponder];
            return;
            
            
        } else {
            [ingredientsArray addObject:stg];
        }
        [cell.ingredientsTfield becomeFirstResponder];
    }
    ingTableRows++;
    
    
    [self resetFrames:YES];
    
    
    [_ingredientsTable reloadData];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    [PhotoAlert canResignFirstResponder];
}

#pragma mark
#pragma mark - BackButton Action
- (IBAction)backButtonAction_dishes:(id)sender {
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

- (IBAction)addProfilePicButtonAction:(id)sender {
    [self.view endEditing:YES];
    
    NSDictionary *dic = [IImagesArray objectAtIndex:0];

    PhotoString = @"isProfilePic";
    selectedIndex = 0;

    if ([[dic valueForKey:@"imageType"]isKindOfClass:[UIImage class]] && [[dic valueForKey:@"imageType"] isEqual:[UIImage imageNamed:@"addphoto.png"]]) {
        PhotoAlert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Choose Photo",@"Take Photo", nil];
        [PhotoAlert show];
    }else{
        [self CustomActionSheetVisible:YES];
    }
}
-(void)CustomActionSheetVisible:(BOOL)myBool{
    self.CustomActionSheet = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Make Default", @"Delete", nil];
    
    self.CustomActionSheet.buttonResponse = IBActionSheetButtonResponseShrinksOnPress;
    [self.CustomActionSheet setButtonBackgroundColor:[UIColor whiteColor]];
    [self.CustomActionSheet setButtonTextColor:[UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [self.CustomActionSheet setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:0];
    [self.CustomActionSheet setButtonTextColor:[UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] forButtonAtIndex:0];
    
    [self.CustomActionSheet setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:1];
    [self.CustomActionSheet setButtonTextColor:[UIColor redColor] forButtonAtIndex:1];
    
    [self.CustomActionSheet setCancelButtonFont:[UIFont systemFontOfSize:22]];
    
    [self.CustomActionSheet showInView:[UIApplication sharedApplication].keyWindow];
}
- (IBAction)addPhotoButtonBlock:(id)sender {
    [self.view endEditing:YES];

    PhotoString = @"isGallaryPic";
    selectedIndex = 1;
    NSDictionary *dic = [IImagesArray objectAtIndex:1];
    if ([[dic valueForKey:@"imageType"]isKindOfClass:[UIImage class]] && [[dic valueForKey:@"imageType"] isEqual:[UIImage imageNamed:@"addphoto.png"]]) {
        PhotoAlert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Choose Photo",@"Take Photo", nil];
        [PhotoAlert show];
    }else{
        [self CustomActionSheetVisible:YES];
    }
}

- (IBAction)AddPhoto1ButtonBlock:(id)sender {
    [self.view endEditing:YES];
    
    PhotoString = @"isGallaryPic1";
    selectedIndex = 2;
    NSDictionary *dic = [IImagesArray objectAtIndex:2];
    if ([[dic valueForKey:@"imageType"]isKindOfClass:[UIImage class]] && [[dic valueForKey:@"imageType"] isEqual:[UIImage imageNamed:@"addphoto.png"]]) {
        PhotoAlert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Choose Photo",@"Take Photo", nil];
        [PhotoAlert show];
    }else{
        [self CustomActionSheetVisible:YES];

    }
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
#pragma mark
- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:{
            NSLog(@"make Default");
            
            for (NSInteger i=0; i<IImagesArray.count; i++) {
                if (selectedIndex == i) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[IImagesArray objectAtIndex:i]];
                    [dic setValue:@"1" forKey:@"default"];
                    [IImagesArray replaceObjectAtIndex:i withObject:dic];
                }else{
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[IImagesArray objectAtIndex:i]];
                    [dic setValue:@"0" forKey:@"default"];
                    [IImagesArray replaceObjectAtIndex:i withObject:dic];
                }
            }
            
            switch (selectedIndex) {
                case 0:{
                    _imgDefLbl1.hidden = NO;
                    _imgDefLbl2.hidden = YES;
                    _imgDefLbl3.hidden = YES;
                }
                    break;
                case 1:{
                    _imgDefLbl1.hidden = YES;
                    _imgDefLbl2.hidden = NO;
                    _imgDefLbl3.hidden = YES;
                }
                    break;
                case 2:{
                    _imgDefLbl1.hidden = YES;
                    _imgDefLbl2.hidden = YES;
                    _imgDefLbl3.hidden = NO;
                }
                    break;
                default:
                    break;
            }
            

            
        }
            break;
        case 1:{
            NSLog(@"Delete");
            
            if ([PhotoString isEqualToString:@"isProfilePic"] && buttonIndex == 1) {
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[IImagesArray objectAtIndex:0]];
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isDeleted"];
                [dic setObject:[UIImage imageNamed:@"addphoto.png"] forKey:@"imageType"];
                [dic setValue:@"EmPty" forKey:@"NewImage"];
                [dic setValue:@"0" forKey:@"default"];
                [IImagesArray replaceObjectAtIndex:0 withObject:dic];
                
                _imgDefLbl1.hidden = YES;
                _DishPicImgV.image = [UIImage imageNamed:@"addphoto.png"];
                
            }else if ([PhotoString isEqualToString:@"isGallaryPic"] && buttonIndex == 1){
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[IImagesArray objectAtIndex:1]];
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isDeleted"];
                [dic setObject:[UIImage imageNamed:@"addphoto.png"] forKey:@"imageType"];
                [dic setValue:@"EmPty" forKey:@"NewImage"];
                [dic setValue:@"0" forKey:@"default"];
                [IImagesArray replaceObjectAtIndex:1 withObject:dic];
                
                _imgDefLbl2.hidden = YES;
                [_gallaryBtn setImage:[UIImage imageNamed:@"addphoto.png"] forState:UIControlStateNormal];
                
                
            }else if([PhotoString isEqualToString:@"isGallaryPic1"] && buttonIndex == 1) {
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[IImagesArray objectAtIndex:2]];
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isDeleted"];
                [dic setObject:[UIImage imageNamed:@"addphoto.png"] forKey:@"imageType"];
                [dic setValue:@"EmPty" forKey:@"NewImage"];
                [dic setValue:@"0" forKey:@"default"];
                [IImagesArray replaceObjectAtIndex:2 withObject:dic];
                
                _imgDefLbl3.hidden = YES;
                [_gallaryBtn1 setImage:[UIImage imageNamed:@"addphoto.png"] forState:UIControlStateNormal];
                
            }
            
        }
            
            break;
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    profileImg = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(300,200) source:image];
    if ([PhotoString isEqualToString:@"isProfilePic"]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[IImagesArray objectAtIndex:0]];
        [dic setValue:profileImg forKey:@"imageType"];
        [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isDeleted"];
        [dic setValue:profileImg forKey:@"NewImage"];
        [dic setValue:@"1" forKey:@"default"];
        [IImagesArray replaceObjectAtIndex:0 withObject:dic];


        _DishPicImgV.image = profileImg;
        
    }else if ([PhotoString isEqualToString:@"isGallaryPic"]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[IImagesArray objectAtIndex:1]];
        [dic setValue:profileImg forKey:@"imageType"];
        [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isDeleted"];
        [dic setValue:profileImg forKey:@"NewImage"];
        
        if ([[_DishPicImgV image] isEqual:[UIImage imageNamed:@"addphoto.png"]]) {
            [dic setValue:@"1" forKey:@"default"];
        }

        [IImagesArray replaceObjectAtIndex:1 withObject:dic];

        
        [_gallaryBtn setImage:profileImg forState:UIControlStateNormal];
        [gallaryArray addObject:profileImg];
        
        
    }else if ([PhotoString isEqualToString:@"isGallaryPic1"]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[IImagesArray objectAtIndex:2]];
        [dic setValue:profileImg forKey:@"imageType"];
        [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isDeleted"];
        [dic setValue:profileImg forKey:@"NewImage"];
        [IImagesArray replaceObjectAtIndex:2 withObject:dic];

        if ([[_DishPicImgV image] isEqual:[UIImage imageNamed:@"addphoto.png"]] && [[_gallaryBtn currentImage] isEqual:[UIImage imageNamed:@"addphoto.png"]]) {
            [dic setValue:@"1" forKey:@"default"];
        }
        [_gallaryBtn1 setImage:profileImg forState:UIControlStateNormal];
        [gallaryArray addObject:profileImg];
    }
    
    //    * Adding a dish image
    //    * url - /addDishImage
    //    * method - POST
    //    * params - accessToken, dishId, dishImage,imageExt, default
}


- (IBAction)chooseGallaryButtonBlock:(id)sender {
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}




- (IBAction)categoryBainBtnBlock:(id)sender {
    [self.view endEditing:YES];
    _textPickerH.tag = 1000051;
    [_scrollview setContentOffset:CGPointMake(0, 150) animated:YES];
    [_textPickerH reloadAllComponents];
    [self TextactionSheetShows:YES];
}





-(NSDate *)maXDateFromDate:(NSDate *)fromDate{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *currentDate = fromDate;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:+1];
    [comps setDay:0];
    [comps setMinute:0];
    
    NSDate *maxDate = [gregorian dateByAddingComponents:comps toDate:currentDate  options:0];
    return maxDate;
    
}
-(NSDate *)minDateFromDate:(NSDate *)Tdate{
    return Tdate;
    
}
-(NSDate *)minMumDAteWithText:(NSString *)myString{
    NSDateFormatter *dtForm = [[NSDateFormatter alloc]init];
    //[dtForm setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
    [dtForm setDateFormat:@"MM-dd-yyyy hh:mm a"];
    NSDate *Mindate = [dtForm dateFromString:myString];
    _localDatePicker.date = Mindate;
    
    return Mindate;
}
- (IBAction)OrderTimeMainBtnBlock:(id)sender {
    
    if (![[_dishDetailDict valueForKey:@"enable_order_by_date"] boolValue]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Can't change OrderedByTime"];
        return;
    }
    scrollHelpingString = @"isOrderByTime";
    
    NSString *dateStg;
    NSDate *Vdate;
    if ([_dishOrderedByLBL.text isEqualToString:@"Order By date & time"]) {
        dateStg = [self stringOfDate:[NSDate date]];
        Vdate = [NSDate date];
    }else{
        dateStg = _dishOrderedByLBL.text;
        Vdate = [self dateOfStribng:_dishOrderedByLBL.text];
        if ([Vdate compare:[NSDate date]] == NSOrderedAscending) {
            Vdate = [NSDate date];
        }
    }
    
    _localDatePicker.minimumDate = [NSDate date];
    _localDatePicker.date = Vdate;
    [_localDatePicker setMinuteInterval:15];

    [_localDatePicker setMaximumDate:[self maXDateFromDate:[NSDate date]]];
    
    [_scrollview setContentOffset:CGPointMake(0, 200) animated:YES];
    [self actionSheetShows:YES];
}


-(NSString *)stringOfDate:(NSDate *)TDate{
    NSDateFormatter *formD = [[NSDateFormatter alloc]init];
    //[formD setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"PST"]];
    [formD setDateFormat:@"MM-dd-yyyy hh:mm a"];
    return [formD stringFromDate:TDate];
}
-(NSDate *)dateOfStribng:(NSString *)TString{
    NSDateFormatter *formD = [[NSDateFormatter alloc]init];
   
    [formD setDateFormat:@"MM-dd-yyyy hh:mm a"];

  //  [formD setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSLog(@"Date = %@ and String = %@",[formD dateFromString:TString],TString);
    return [formD dateFromString:TString];
}

- (IBAction)AvaliableByDateMainBtnBlocl:(id)sender {
    
    if (![[_dishDetailDict valueForKey:@"enable_avail_from_date"] boolValue]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Can't change AvailableFromDate"];
        return;
    }

    
    
    NSString *dateStg;
    NSDate *Vdate;
    if ([_dishOrderedByLBL.text isEqualToString:@"Order By date & time"]) {
        dateStg = [self stringOfDate:[NSDate date]];
        Vdate = [NSDate date];
    }else{
        dateStg = _dishOrderedByLBL.text;
        Vdate = [self dateOfStribng:_dishOrderedByLBL.text];
        if ([Vdate compare:[NSDate date]] == NSOrderedAscending) {
            Vdate = [NSDate date];
        }
    }
    
    
    NSDate *ToVdate;
    if ([_dishAvaliableByLBL.text isEqualToString:@"Available by date & time"]) {
        ToVdate = Vdate;
    }else{
        ToVdate = [self dateOfStribng:_dishAvaliableByLBL.text];
        if ([ToVdate compare:Vdate] == NSOrderedAscending) {
            ToVdate = Vdate;
        }
       

    }
    
    [_localDatePicker setMinimumDate:[self minDateFromDate:Vdate]];
    [_localDatePicker setDate:ToVdate];
    [_localDatePicker setMinuteInterval:15];
    [_localDatePicker setMaximumDate:[self maXDateFromDate:Vdate]];
    
    scrollHelpingString = @"isAvaliableByTime";
    [_scrollview setContentOffset:CGPointMake(0, 230) animated:YES];
    
    [self actionSheetShows:YES];

    
}
- (IBAction)AvaliableUntilMainBtnBlock:(id)sender {
//    NSLog(@"actFormet = %@",[NSDate date]);
//
//    NSString *arrivalDateString = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
//    NSLog(@"dateForm = %@",arrivalDateString);
    
    
    
    if (![[_dishDetailDict valueForKey:@"enable_avail_till_date"] boolValue]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Can't change AvailableTillDate"];
        return;
    }
    if (_dishOrderedByLBL.text == (id)[NSNull null] || _dishOrderedByLBL.text.length == 0 || [_dishOrderedByLBL.text isEqualToString:@"Order By date & time"] || _dishAvaliableByLBL.text == (id)[NSNull null] || _dishAvaliableByLBL.text.length == 0 || [_dishAvaliableByLBL.text isEqualToString:@"Available by date & time"]) {
        return;
    }
    
    
 
    NSString *dateStg;
    NSDate *Vdate;
    if ([_dishAvaliableByLBL.text isEqualToString:@"Available by date & time"]) {
        dateStg = [self stringOfDate:[NSDate date]];
        Vdate = [NSDate date];
    }else{
        dateStg = _dishAvaliableByLBL.text;
        Vdate = [self dateOfStribng:_dishAvaliableByLBL.text];
        if ([Vdate compare:[NSDate date]] == NSOrderedAscending) {
            Vdate = [NSDate date];
        }
    }


    
    NSDate *ToVdate;
    if ([_dishAvaliableUntilTF.text isEqualToString:@"Available until date & time "]) {
        ToVdate = Vdate;
    }else{
        ToVdate = [self dateOfStribng:_dishAvaliableUntilTF.text];
        if ([ToVdate compare:Vdate] == NSOrderedAscending) {
            ToVdate = Vdate;
        }
    }
    
    
    [_localDatePicker setMinimumDate:[self minDateFromDate:[self dateOfStribng:_dishAvaliableByLBL.text]]];
    [_localDatePicker setDate:ToVdate];
    [_localDatePicker setMinuteInterval:15];

    [_localDatePicker setMaximumDate:[self maXDateFromDate:[self dateOfStribng:_dishOrderedByLBL.text]]];
    
    
    scrollHelpingString = @"isAvaliableUntillTime";
    [_scrollview setContentOffset:CGPointMake(0, 250) animated:YES];
    [self actionSheetShows:YES];
}
-(void)actionSheetShows:(BOOL)myBool{
    [self.view endEditing:YES];
    
    if (!myBool) {
        [UIView animateWithDuration:0.3f animations:^{
            _trasparentBlackView.hidden = YES;
            _actionSheetView.frame = CGRectMake(0, self.view.bounds.size.height, _actionSheetView.bounds.size.width, _actionSheetView.bounds.size.height);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            _trasparentBlackView.hidden = NO;
            _actionSheetView.frame = CGRectMake(0, self.view.bounds.size.height-_actionSheetView.bounds.size.height, _actionSheetView.bounds.size.width, _actionSheetView.bounds.size.height);
        } completion:nil];
    }
    
}
-(NSString *)set12HoursTime:(NSDate *)mydate{

    
    NSDateFormatter *hhForm = [NSDateFormatter new];
   // [hhForm setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_us"]];
//    [hhForm setTimeZone:[NSTimeZone systemTimeZone]];
    [hhForm setDateFormat:@"MM-dd-yyyy h:mm a"];
    NSString *hhTime = [hhForm stringFromDate:mydate];
    NSLog(@"hhTime = %@",hhTime);
    return hhTime;
}
-(NSString *)setamPm:(NSDate *)mydate{
    
    
    NSDateFormatter *hhForm = [NSDateFormatter new];
  //  [hhForm setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
//    [hhForm setTimeZone:[NSTimeZone systemTimeZone]];
    [hhForm setDateFormat:@"a"];
    NSString *hhTime = [hhForm stringFromDate:mydate];
    NSLog(@"hhTime = %@",hhTime);
    return hhTime;
}
//-(NSString*)getTimetoFill{
//    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
//    [outputFormatter setDateFormat:@"h:mm a"];
//    
//    NSString *timetofill = [outputFormatter stringFromDate:_localDatePicker.date];
//    NSLog(@"time = %@",timetofill);
//    return timetofill;
//}

- (IBAction)selectDateTimeBlock:(id)sender {
    NSLog(@"dat = %@",_localDatePicker.date);
    
    NSString *strDateWhole = [self set12HoursTime:_localDatePicker.date];
    
    NSDateFormatter *dateForm1 = [NSDateFormatter new];
    [dateForm1 setDateFormat:@"MM-dd-yyyy"];
    NSString *strDate = [dateForm1 stringFromDate:_localDatePicker.date];
    
    NSDateFormatter *dateForm2 = [NSDateFormatter new];
    [dateForm2 setDateFormat:@"hh"];
    NSString *strHour = [dateForm2 stringFromDate:_localDatePicker.date];
    
    NSDateFormatter *dateForm3 = [NSDateFormatter new];
    [dateForm3 setDateFormat:@"mm"];
    NSString *strmin = [dateForm3 stringFromDate:_localDatePicker.date];
    
    NSString *strAmPm = [self setamPm:_localDatePicker.date];
    
    
    
    if ([scrollHelpingString isEqualToString: @"isOrderByTime"]){
        
        orderByDate = strDate;
        orderByHr = strHour;
        orderByMin = strmin;
        orderByAmpm = strAmPm;
//        _dishOrderedByLBL.textColor = [UIColor darkGrayColor];
        _dishOrderedByLBL.text = strDateWhole;
    }
    else if ([scrollHelpingString isEqualToString:@"isAvaliableByTime"]){
        availByDate = strDate;
        availByHr = strHour;
        availByMin = strmin;
        availByAmpm = strAmPm;
//        _dishAvaliableByLBL.textColor = [UIColor darkGrayColor];
        _dishAvaliableByLBL.text = strDateWhole;
    }
    else{
        availUntilDate = strDate;
        availUntilHr = strHour;
        availUntilMin = strmin;
        availUntilAmpm = strAmPm;
//        _dishAvaliableUntilTF.textColor = [UIColor darkGrayColor];
        _dishAvaliableUntilTF.text = strDateWhole;
    }
    
    [self performSelector:@selector(ActionSheetHide:) withObject:nil];
    
    
}

- (IBAction)orderedBuButton:(id)sender {
    [self performSelector:@selector(OrderTimeMainBtnBlock:) withObject:nil];
}
- (IBAction)avaliableByButton:(id)sender {
    [self performSelector:@selector(AvaliableByDateMainBtnBlocl:) withObject:nil];
}
- (IBAction)avaliableUntilButton:(id)sender {
    [self performSelector:@selector(AvaliableUntilMainBtnBlock:) withObject:nil];
}
- (IBAction)categoryButton:(id)sender {
    [self performSelector:@selector(categoryBainBtnBlock:) withObject:nil];
}




- (IBAction)VeretarianSwitchActionBlock:(id)sender {
    if ([sender isOn])
        _isVegetarian = YES;
    else
        _isVegetarian = NO;
}
- (IBAction)GlutenFreeSwitchActionBlock:(id)sender {
    if ([sender isOn])
        _isGlutineFree = YES;
    else
        _isGlutineFree = NO;
}
- (IBAction)VeganGlutenFreeSwitchActionBlock:(id)sender {
    if ([sender isOn])
        _isVegan = YES;
    else
        _isVegan = NO;
}
- (IBAction)OrganicGlutenFreeSwitchActionBlock:(id)sender {
    if ([sender isOn])
        _isOrganic = YES;
    else
        _isOrganic = NO;
}
- (IBAction)LocalIngradientsGlutenFreeSwitchActionBlock:(id)sender {
    if ([sender isOn])
        _isLocalIngradients = YES;
    else
        _isLocalIngradients = NO;
}
- (IBAction)AvaliableGlutenFreeSwitchActionBlock:(id)sender {
    if ([sender isOn])
        _isAvaliable = YES;
    else
        _isAvaliable = NO;
}









#pragma
#pragma Custom ActionSheet Methods
- (IBAction)ActionSheetHide:(id)sender {
    if ([scrollHelpingString isEqualToString: @"isOrderByTime"]){
        [_scrollview setContentOffset:CGPointMake(0, 50) animated:YES];
    }else if ([scrollHelpingString isEqualToString:@"isAvaliableByTime"]){
        [_scrollview setContentOffset:CGPointMake(0, 100) animated:YES];
    }else if([scrollHelpingString isEqualToString:@"isAvaliableUntillTime"]){
        [_scrollview setContentOffset:CGPointMake(0, 130) animated:YES];
        
    }else{
        [_scrollview setContentOffset:CGPointMake(0,0) animated:YES];
    }
    
    [self actionSheetShows:NO];
    [self TextactionSheetShows:NO];
    
}

#pragma
#pragma Gesture method for Dismiss
-(void)dismissKeyboardAddDish:(id)sender{
    [self.view endEditing:YES];
    [self actionSheetShows:NO];
    [self TextactionSheetShows:NO];
    if (isIngredientsEditing) {
        [self saveIngredients];
    }
}


-(void)TextactionSheetShows:(BOOL)myBool{
    NSLog(@"2 is %@",appDel.CurrentOwnerDetails.owner_cuisineArray);
    [self.view endEditing:YES];
    if (!myBool) {
        [UIView animateWithDuration:0.3f animations:^{
            _trasparentBlackView.hidden = YES;
            _textActionSheet.frame = CGRectMake(0, self.view.bounds.size.height, _textActionSheet.bounds.size.width, _textActionSheet.bounds.size.height);
        } completion:nil];
    }else{
        [UIView animateWithDuration:0.3f animations:^{
            _trasparentBlackView.hidden = NO;
            _textActionSheet.frame = CGRectMake(0, self.view.bounds.size.height-_textActionSheet.bounds.size.height, _textActionSheet.bounds.size.width, _textActionSheet.bounds.size.height);
        } completion:nil];
    }
}




- (IBAction)saveDishButtonBlock:(id)sender {
    
    [self showCustomActivityIndicatorInAddEditDish:YES];
    
    if (_dishNameTF.text == (id)[NSNull null] || _dishNameTF.text.length == 0) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish Name"];
        [_dishNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorInAddEditDish:NO];
        return;
    }
    NSCharacterSet *whitespaceDN = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedDN = [_dishNameTF.text stringByTrimmingCharactersInSet:whitespaceDN];
    if ([trimmedDN length] == 0) {
        // Text was empty or only whitespace.
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Dish Name cannot be blank"];
        [_dishNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorInAddEditDish:NO];
        return;
    }
    if (_dishNameTF.text.length < 2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"DishName cannot be less than 2 characters"];
        [_dishNameTF becomeFirstResponder];
        [self showCustomActivityIndicatorInAddEditDish:NO];
        return;
    }
    
    
    if (_dishPriceTF.text == (id)[NSNull null] || _dishPriceTF.text.length == 0){
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish Price"];
        [_dishPriceTF becomeFirstResponder];
        return;
    }
    
    if (0.0000000 > [_dishPriceTF.text floatValue]){
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter a value greater than or equal to 0."];
        [_dishPriceTF becomeFirstResponder];
        return;
    }
    if ([_dishPriceTF.text floatValue] > 9999.9999) {
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Price greater than 9999.99 is not allowed."];
        [_dishPriceTF becomeFirstResponder];
        return;
    }
    
    NSCharacterSet *whitespaceDP = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedDP = [_dishPriceTF.text stringByTrimmingCharactersInSet:whitespaceDP];
    if ([trimmedDP length] == 0) {
        // Text was empty or only whitespace.
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Price cannot be blank"];
        [_dishPriceTF becomeFirstResponder];
        return;
    }
    
    if (_dishQuantityTF.text == (id)[NSNull null] || _dishQuantityTF.text.length == 0){
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish Quantity"];
        [_dishQuantityTF becomeFirstResponder];
        return;
    }
    NSCharacterSet *whitespaceDQ = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedDQ = [_dishQuantityTF.text stringByTrimmingCharactersInSet:whitespaceDQ];
    if ([trimmedDQ length] == 0) {
        // Text was empty or only whitespace.
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Dish Quantity cannot be blank"];
        [_dishQuantityTF becomeFirstResponder];
        return;
    }
    
    if (_dishDescriptionTView.text == (id)[NSNull null] || _dishDescriptionTView.text.length == 0 || [_dishDescriptionTView.text caseInsensitiveCompare:@"Dish Description"]==NSOrderedSame){
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish Description"];
        [_dishDescriptionTView becomeFirstResponder];
        return;
    }
    NSCharacterSet *whitespaceDD = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedDD = [_dishDescriptionTView.text stringByTrimmingCharactersInSet:whitespaceDD];
    if ([trimmedDD length] == 0) {
        // Text was empty or only whitespace.
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Dish Description cannot be blank"];
        [_dishDescriptionTView becomeFirstResponder];
        return;
    }
    if (_dishDescriptionTView.text.length < 2) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Dish Description cannot be less than 2 characters"];
        [_dishDescriptionTView becomeFirstResponder];
        [self showCustomActivityIndicatorInAddEditDish:NO];
        return;
    }
    
    
    
    if (_dishCategoryLBL.text == (id)[NSNull null] || _dishCategoryLBL.text.length == 0 || [_dishCategoryLBL.text caseInsensitiveCompare:@"Select One..."]==NSOrderedSame){
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish Category"];
        return;
    }
    NSCharacterSet *whitespaceDC = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedDC = [_dishCategoryLBL.text stringByTrimmingCharactersInSet:whitespaceDC];
    if ([trimmedDC length] == 0) {
        // Text was empty or only whitespace.
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Dish Category cannot be blank"];
        return;
    }
    
    
    if (_dishOrderedByLBL.text == (id)[NSNull null] || _dishOrderedByLBL.text.length == 0){
        [self showCustomActivityIndicatorInAddEditDish:NO];
        
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish OrderByDate"];
        
        return;
    }
    NSCharacterSet *whitespaceDOby = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedDoby = [_dishOrderedByLBL.text stringByTrimmingCharactersInSet:whitespaceDOby];
    if ([trimmedDoby length] == 0) {
        // Text was empty or only whitespace.
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Dish OrderByDate cannot be blank"];
        return;
    }
    
    
    
    if (_dishAvaliableByLBL.text == (id)[NSNull null] || _dishAvaliableByLBL.text.length == 0){
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter DishOrder AvailableByDate"];
        return;
    }
    NSCharacterSet *whitespaceDOAv = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedDAv = [_dishAvaliableByLBL.text stringByTrimmingCharactersInSet:whitespaceDOAv];
    if ([trimmedDAv length] == 0) {
        // Text was empty or only whitespace.
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"DishOrder AvailableByDate cannot be blank"];
        return;
    }
    
    
    
    if (_dishAvaliableUntilTF.text == (id)[NSNull null] || _dishAvaliableUntilTF.text.length == 0){
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter DishOrder AvailableUntil"];
        return;
    }
    NSCharacterSet *whitespaceDOAn = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedDAn = [_dishAvaliableUntilTF.text stringByTrimmingCharactersInSet:whitespaceDOAn];
    if ([trimmedDAn length] == 0) {
        // Text was empty or only whitespace.
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"DishOrder AvailableUntilDate cannot be blank"];
        return;
    }
    
    
    
    if (orderByDate == (id)[NSNull null] || orderByDate.length == 0 ||
        orderByHr == (id)[NSNull null] || orderByHr.length == 0 ||
        orderByMin == (id)[NSNull null] || orderByMin.length == 0 ||
        orderByAmpm == (id)[NSNull null] || orderByAmpm.length == 0 ) {
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish OrderBy date&Time"];
        return;
    }
    
    if (availByDate == (id)[NSNull null] || availByDate.length == 0 ||
        availByHr == (id)[NSNull null] || availByHr.length == 0 ||
        availByMin == (id)[NSNull null] || availByMin.length == 0 ||
        availByAmpm == (id)[NSNull null] || availByAmpm.length == 0 ) {
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish AvailableBy date&Time"];
        return;
    }
    
    if (availUntilDate == (id)[NSNull null] || availUntilDate.length == 0 ||
        availUntilHr == (id)[NSNull null] || availUntilHr.length == 0 ||
        availUntilMin == (id)[NSNull null] || availUntilMin.length == 0 ||
        availUntilAmpm == (id)[NSNull null] || availUntilAmpm.length == 0 ) {
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish Available until date&Time"];
        return;
    }
    
    //    if (_ingredientTF.text == (id)[NSNull null] || _ingredientTF.text.length == 0) {
    //        [self showCustomActivityIndicatorInAddEditDish:NO];
    //        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Enter Dish Ingredients"];
    //        [_ingredientTF becomeFirstResponder];
    //        return;
    //    }
    //
    //    NSCharacterSet *whitespaceDIn = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    //    NSString *trimmedDIn = [_ingredientTF.text stringByTrimmingCharactersInSet:whitespaceDIn];
    //    if ([trimmedDIn length] == 0) {
    //        // Text was empty or only whitespace.
    //        [self showCustomActivityIndicatorInAddEditDish:NO];
    //        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Dish Ingredients cannot be blank"];
    //        [_ingredientTF becomeFirstResponder];
    //        return;
    //    }
    
    
    NSDate *orderD = [self dateOfStribng:_dishOrderedByLBL.text];
    NSDate *availBD = [self dateOfStribng:_dishAvaliableByLBL.text];
    NSDate *availUD = [self dateOfStribng:_dishAvaliableUntilTF.text];
    
    
    
    if ([availBD compare:orderD] == NSOrderedAscending) {
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Available by time cannot be less than order by time"];
        return;
        
    }
    
    
    if ([availUD compare:availBD] == NSOrderedAscending) {
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Available Until Time cannot be less than Available by time"];
        return;
    }
    
    
    
    //    NSMutableArray *locAryy = [[NSMutableArray alloc]initWithCapacity:0];
    //    [locAryy addObject:[_ingredientTF.text uppercaseString]];
    //    for (int i=10001; i<currentTFTag; i++) {
    //        UITextField *tf = (UITextField *)[_scrollview viewWithTag:i];
    //        if (tf.text != (id)[NSNull null] || tf.text.length != 0 || ![tf.text isEqualToString:@"Ingredient name"]) {
    //            if ([locAryy containsObject:[tf.text uppercaseString]]) {
    //                [self showCustomActivityIndicatorInAddEditDish:NO];
    //                tf.text=@"";
    //                [tf becomeFirstResponder];
    //                [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter unique ingredients."];
    //                return;
    //            }else{
    //                [locAryy addObject:[tf.text uppercaseString]];
    //            }
    //        }
    //    }
    
    
    NSMutableArray *locAry = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i<ingredientsArray.count; i++) {
        NSString *IngStg = [ingredientsArray objectAtIndex:i];
        if (IngStg.length > 1 && [GlobalMethods whiteSpacesAvailableForString:IngStg]) {
            [self showCustomActivityIndicatorInAddEditDish:NO];
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Ingredients name cannot be blank"];
            return;
        }
        else if ([locAry containsObject:[[ingredientsArray objectAtIndex:i]uppercaseString]]) {
            [self showCustomActivityIndicatorInAddEditDish:NO];
            [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Please enter unique ingredients."];
            return;
        }
        else{
            [locAry addObject:[[ingredientsArray objectAtIndex:i] uppercaseString]];
            
        }
    }
    
    
    
    
    
    [self AddDishWebServicesPostData];
}



- (IBAction)TextPickerDoneAction:(id)sender {
    [self.view endEditing:YES];
    if (_textPickerH.tag == 1000051) {
        _addCuisineTF.textColor = [UIColor blackColor];
        _dishCategoryLBL.text = [[appDel.CurrentOwnerDetails.owner_cuisineArray objectAtIndex:[_textPickerH selectedRowInComponent:0]] valueForKey:@"cuisine_title"];
        categoryTyype_Id = [[[appDel.CurrentOwnerDetails.owner_cuisineArray objectAtIndex:[_textPickerH selectedRowInComponent:0]] valueForKey:@"cuisine_type_id"] integerValue];
        
    }else if (_textPickerH.tag == 1000055) {
        _cityTaxTF.text = [appDel.cityTaxAray objectAtIndex:[_textPickerH selectedRowInComponent:0]];
        
    }else if (_textPickerH.tag == 1000056) {
        _stateTaxTF.text = [appDel.stateTaxAray objectAtIndex:[_textPickerH selectedRowInComponent:0]];
        
    }else if (_textPickerH.tag == 1000057) {
        _addCuisineTF.textColor = [UIColor darkGrayColor];
        _addCuisineTF.text = [[appDel.cuisineAry valueForKey:@"title"] objectAtIndex:[_textPickerH selectedRowInComponent:0]];
        
    }
    
    [self TextactionSheetShows:NO];
    
}


-(void)AddDishWebServicesPostData{
    
    
    ////
    NSInteger rows =  [_ingredientsTable numberOfRowsInSection:0];
    for (int row = 0; row < rows; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        TableViewCellH *cell = (TableViewCellH *)[_ingredientsTable cellForRowAtIndexPath:indexPath];
        NSString *stg = cell.ingredientsTfield.text;
        NSLog(@"txt= %@",stg);
        if (stg.length > 1 && ![GlobalMethods whiteSpacesAvailableForString:stg]) {
            NSString *key = [NSString stringWithFormat:@"%i",row];
            @try {
                [_ingredientsDict setObject:stg forKey:key];
            }
            @catch (NSException *exception) {}
        }
        
    }
    


 
    
    NSData *ingredientData = [NSJSONSerialization dataWithJSONObject:_ingredientsDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *IngredientString = [[NSString alloc] initWithData:ingredientData encoding:NSUTF8StringEncoding];
    
    
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    
    
    
    @try {
        [paramDict setObject:[_dishDetailDict valueForKey:@"dish_id"] forKey:@"dishId"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:_dishNameTF.text forKey:@"title"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:_dishDescriptionTView.text forKey:@"description"];
    }
    @catch (NSException *exception) {}
    
    @try {
        [paramDict setObject:_dishPriceTF.text forKey:@"price"];
    }
    @catch (NSException *exception) {}
    
    @try {
        [paramDict setObject:_dishQuantityTF.text forKey:@"qty"];
    }
    @catch (NSException *exception) {}
    
    @try {
        [paramDict setObject:[NSNumber numberWithInteger:categoryTyype_Id] forKey:@"dish_type_id"];
    }
    @catch (NSException *exception) {}
    
    @try {
        [paramDict setObject:[self formattedDatePast:orderByDate] forKey:@"order_by_date"];
    }
    @catch (NSException *exception) {}
    
    @try {
        [paramDict setObject:orderByHr forKey:@"order_by_hr"];
    }
    @catch (NSException *exception) {}
    
    @try {
        [paramDict setObject:orderByMin forKey:@"order_by_min"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:orderByAmpm forKey:@"order_by_ampm"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:[self formattedDatePast:availByDate] forKey:@"avail_by_date"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:availByHr forKey:@"avail_by_hr"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:availByMin forKey:@"avail_by_min"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:availByAmpm forKey:@"avail_by_ampm"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:[self formattedDatePast:availUntilDate] forKey:@"avail_until_date"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:availUntilHr forKey:@"avail_until_hr"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:availUntilMin forKey:@"avail_until_min"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:availUntilAmpm forKey:@"avail_until_ampm"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setValue:[NSNumber numberWithBool:_isVegetarian] forKey:@"vegetarian"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setValue:[NSNumber numberWithBool:_isVegan] forKey:@"vegan"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setValue:[NSNumber numberWithBool:_isGlutineFree] forKey:@"gluten_free"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setValue:[NSNumber numberWithBool:_isLocalIngradients] forKey:@"local_ingredients"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setValue:[NSNumber numberWithBool:_isOrganic] forKey:@"organic"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setValue:[NSNumber numberWithBool:_isAvaliable] forKey:@"available"];
    }
    @catch (NSException *exception) {}
    @try {
        [paramDict setObject:IngredientString forKey:@"ingredients"];
    }
    @catch (NSException *exception) {}
    
    isUpDating = @"EditDishValues";
    
    
    
        
//    if (![_DishPicImgV.image isEqual:[UIImage imageNamed:@"addphoto.png"]]) {
//            
//            
//        NSData *imageData = UIImageJPEGRepresentation(_DishPicImgV.image, 0.5);
//        NSString *Str=[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//        [paramDict setObject:Str forKey:@"dishImage"];
//        [paramDict setObject:@"jpeg" forKey:@"imageExt"];
//        NSString *defStg = [[IImagesArray objectAtIndex:0] valueForKey:@"default"];
//        [paramDict setObject:defStg forKey:@"default"];
//            
//            
//            
//    }
    totalCount++;
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editDish"];
        
//    for (UIImage *img in gallaryArray) {
//            //            * Adding a dish image
//            //            * url - /addDishImage
//            //            * method - POST
//            //            * params - accessToken, dishId, dishImage,imageExt, default
//        /*
//         
//         accesstoken, photo_id, dish_id are the required params
//         */
//        
//        
//            
//        NSMutableDictionary *paramDictL=[[NSMutableDictionary alloc]initWithCapacity:0];
//        [paramDictL setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
//        [paramDictL setObject:[_dishDetailDict valueForKey:@"dish_id"] forKey:@"dishId"];
//        NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
//        NSString *Str=[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//        [paramDictL setObject:Str forKey:@"dishImage"];
//        [paramDictL setObject:@"jpeg" forKey:@"imageExt"];
//        [paramDictL setObject:[NSNumber numberWithInt:0] forKey:@"default"];
//        [webParser parserPostMethodWithParameters:paramDictL andExtendUrl:@"addDishImage"];
//
//    }
    


    for (NSDictionary *dic in IImagesArray) {
        if ([[dic valueForKey:@"isDeleted"]boolValue]) {
            if (![[dic valueForKey:@"photo_id"] isEqualToString:@"EmPty"] && [[dic valueForKey:@"NewImage"] isKindOfClass:[NSString class]]) {
                NSLog(@"Delete Image");
                /*   accesstoken, photo_id, dish_id are the required params    deleteDishImage isUrl*/
                NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]initWithCapacity:0];
                [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
                [paramDict setObject:[_dishDetailDict valueForKey:@"dish_id"] forKey:@"dish_id"];
                @try {
                    [paramDict setObject:[dic valueForKey:@"photo_id"] forKey:@"photo_id"];
                }
                @catch (NSException *exception) { }
                totalCount++;
                [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"deleteDishImage"];

            }
            /*! Valid Photo Id There and new Image avaliable   UPDATING IMAGE */
            else if (![[dic valueForKey:@"photo_id"] isEqualToString:@"EmPty"] && [[dic valueForKey:@"NewImage"] isKindOfClass:[UIImage class]]) {
                NSLog(@"replace Image");
                NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]initWithCapacity:0];
                [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
                [paramDict setObject:[_dishDetailDict valueForKey:@"dish_id"] forKey:@"dishId"];
                [paramDict setObject:[dic valueForKey:@"photo_id"] forKey:@"photo_id"];
                NSData *imageData = UIImageJPEGRepresentation([dic valueForKey:@"NewImage"], 0.5);
                NSString *Str=[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                [paramDict setObject:Str forKey:@"dishImage"];
                [paramDict setObject:@"jpeg" forKey:@"imageExt"];
                [paramDict setObject:[dic valueForKey:@"default"] forKey:@"default"];
                totalCount++;
                [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"addDishImage"];
                
                
             
            }
            /*! ADDING IMAGE */
            
            else if ([[dic valueForKey:@"photo_id"] isEqualToString:@"EmPty"] && [[dic valueForKey:@"NewImage"] isKindOfClass:[UIImage class]]) {
                NSLog(@"Add Image");
                
                NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]initWithCapacity:0];
                [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
                [paramDict setObject:[_dishDetailDict valueForKey:@"dish_id"] forKey:@"dishId"];
                NSData *imageData = UIImageJPEGRepresentation([dic valueForKey:@"NewImage"], 0.5);
                NSString *Str=[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                [paramDict setObject:Str forKey:@"dishImage"];
                [paramDict setObject:@"jpeg" forKey:@"imageExt"];
//                [paramDict setObject:[dic valueForKey:@"default"] forKey:@"default"];
                [paramDict setObject:[NSNumber numberWithInt:[[dic valueForKey:@"default"] integerValue]] forKey:@"default"];
                totalCount++;
                [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"addDishImage"];
                
                
            }
        }
        
        /*! CHECKING FOR ONLY DEFAULT VALUE */
        
        else if (![[dic valueForKey:@"isDeleted"]boolValue] && [[dic valueForKey:@"default"] boolValue]) {
            NSLog(@"Changed Only default value");
            NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]initWithCapacity:0];
            [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
            [paramDict setObject:[_dishDetailDict valueForKey:@"dish_id"] forKey:@"dishId"];
           
            [paramDict setObject:[dic valueForKey:@"default"] forKey:@"default"];
            @try {
                [paramDict setObject:[dic valueForKey:@"photo_id"] forKey:@"photo_id"];
            }
            @catch (NSException *exception) { }
            [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"addDishImage"];


            
        }
        
       

    }
        
        
}


-(void)performReloadOwnerProfileA:(NSDictionary *)result{
    
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
    [appDel removeCusinesFromCusineArray:appDel.cuisineAry WithComparingArray:appDel.CurrentOwnerDetails.owner_cuisineArray];
    
    
    _addressTF.text = @"";
    _stateTaxTF.text = @"";
    _cityTaxTF.text = @"";
    _addCuisineTF.text = @"";
    
    [self viewWillAppear:YES];
    
    [self showCustomActivityIndicatorInAddEditDish:NO];
    
}




#pragma mark
#pragma mark - CustomPickerView Datasource Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag ==1000051) {
        return appDel.CurrentOwnerDetails.owner_cuisineArray.count;
    }else  if (pickerView.tag ==1000055) {
        return appDel.cityTaxAray.count;
    }else  if (pickerView.tag ==1000056) {
        return appDel.stateTaxAray.count;
    }else  if (pickerView.tag ==1000057) {
        return appDel.cuisineAry.count;
    }
    return 0;
}
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag ==1000051) {
        return [appDel.CurrentOwnerDetails.owner_cuisineArray[row] valueForKey:@"cuisine_title"];
    }else  if (pickerView.tag ==1000055) {
        return appDel.cityTaxAray[row];
    }else  if (pickerView.tag ==1000056) {
        return appDel.stateTaxAray[row];
    }else  if (pickerView.tag ==1000057) {
        return [appDel.cuisineAry[row] valueForKey:@"title"];
    }
    return  @"";
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        [tView setFont:[UIFont fontWithName:Regular size:18]];
        [tView setTextAlignment:NSTextAlignmentCenter];
    }
    // Fill the label text here
    
    NSString *stg = nil;
    if (pickerView.tag ==1000051) {
        stg = [appDel.CurrentOwnerDetails.owner_cuisineArray[row] valueForKey:@"cuisine_title"];
    }else  if (pickerView.tag ==1000055) {
        stg =  appDel.cityTaxAray[row];
    }else  if (pickerView.tag ==1000056) {
        stg =  appDel.stateTaxAray[row];
    }else  if (pickerView.tag ==1000057) {
        stg =  [appDel.cuisineAry[row] valueForKey:@"title"];
    }
    
    
    
    tView.text = [NSString stringWithFormat:@"%@%@",[[stg substringToIndex:1] uppercaseString],[stg substringFromIndex:1] ];
    return tView;
}

- (IBAction)menuButtonClicked:(id)sender {
    if(dropDownV==nil){
        [self menuViewShow:YES];
    }else{
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

-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath{
    
    [self menuViewShow:NO];

    
    //    if (myIndexPath.row == 5) {
    //        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    //    }else if (myIndexPath.row == 3){
    //        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    //    }
    
    
    if (myIndexPath.row == 1){
        [self performSegueWithIdentifier:@"goToAddDishView" sender:self];
    }else if (myIndexPath.row == 2){
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3){
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4){
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5) {
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
    }else if (myIndexPath.row == 6) {
        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    }else if (myIndexPath.row == 7) {
        [self performSegueWithIdentifier:@"goToNotificationsView" sender:self];
    }else if (myIndexPath.row == 8){
        [self goToSignInViewLogout];
    }
    
    
    
}
-(void)goToSignInViewLogout{
    //    [self performSegueWithIdentifier:@"goToSignInView" sender:self];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginE_PProfile"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OwnerProfile"];
    [appDel clearOwnerProfileClass];
    //    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //    SignInVC *SignInVC = [sb instantiateViewControllerWithIdentifier:@"SignInViewC"];
    //    [self.navigationController popToViewController:SignInVC animated:YES];
    
    [self performSegueWithIdentifier:@"goToSignInV" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self.view endEditing:YES];
    if ([segue.identifier isEqualToString:@"goToOrdersView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReviewsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToBasicInfo"]) {
        [segue destinationViewController];
    }
}




- (IBAction)Register2ViewDoneAction:(id)sender {
    [self.view endEditing:YES];
    [self showCustomActivityIndicatorInAddEditDish:YES];
    
    if (_addressTF.text.length>1 &&[GlobalMethods whiteSpacesAvailableForString:_addressTF.text]) {
        [GlobalMethods showAlertwithTitle:AppTitle andMessage:@"Address cannot be blank"];
        _addressTF.text = @"";
        [self showCustomActivityIndicatorInAddEditDish:NO];
        [_addressTF becomeFirstResponder];
        return;
    }
    
    
    
    isUpDating = @"registerDetails";
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    
    
    
    if (_addressTF.text.length > 1) {
        [paramDict setObject:_addressTF.text forKey:@"address"];
    }
    if (_cityTaxTF.text.length > 1) {
        [paramDict setObject:_cityTaxTF.text forKey:@"city_tax"];
    }
    if (_stateTaxTF.text.length > 1) {
        [paramDict setObject:_stateTaxTF.text forKey:@"state_tax"];
    }
    NSString *CuisinesString;
    if (_addCuisineTF.text.length > 1) {
        for (NSDictionary *dic in appDel.cuisineAry) {
            if ([[dic valueForKey:@"title"] caseInsensitiveCompare:_addCuisineTF.text]==NSOrderedSame) {
                
                NSDictionary *dict = [NSDictionary dictionaryWithObject:[dic valueForKey:@"type_id"] forKey:@"0"];
                NSData *CuisinesData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
                CuisinesString = [[NSString alloc] initWithData:CuisinesData encoding:NSUTF8StringEncoding];
            }
        }
        [paramDict setObject:CuisinesString forKey:@"cuisineTypes"];
    }
    
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];
    
}






#pragma mark
#pragma mark - WebParsing Delegates
-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    
    NSLog(@"result = %@",result);
    NSLog(@"responcecode = %li, totalCode = %li",(long)responceCount,(long)totalCount);
    [self showCustomActivityIndicatorInAddEditDish:NO];
    
    
//    
    if (![[result valueForKey:@"error"] boolValue] && [isUpDating isEqualToString:@"EditDishValues"]) {
        if ([[result valueForKey:@"code"] integerValue]==109 || [[result valueForKey:@"code"] integerValue]==115 || [[result valueForKey:@"code"] integerValue]==121) {
            responceCount++;
            if (responceCount == totalCount) {
                NSString *resultStg = @"Dish details successfully updated";
                [GlobalMethods showAlertwithTitle:AppTitle andMessage:resultStg];

                [self performSelector:@selector(backButtonAction_dishes:) withObject:nil];
            }
        }
    }else if (![[result valueForKey:@"error"] boolValue] && [isUpDating isEqualToString:@"registerDetails"]) {
        [self performSelector:@selector(performReloadOwnerProfileA:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];

    }else{
        
    }
    
//
    
    
//    if (![[result objectForKey:@"error"] boolValue] && ([[result objectForKey:@"code"]integerValue]==109 || [[result objectForKey:@"code"]integerValue] == 115)) {
//        responceCount++;
//        if (responceCount == 1+gallaryArray.count) {
//            [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result objectForKey:@"code"]integerValue]];
//            [self performSelector:@selector(backButtonAction_dishes:) withObject:nil];
//        }
//        
//    }else if (![[result objectForKey:@"error"] boolValue] && [[result objectForKey:@"code"] integerValue]==113) {
//        [self performSelector:@selector(performReloadOwnerProfileA:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];
//    }else{
//        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result objectForKey:@"code"]integerValue]];
//    }
//    
    
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showCustomActivityIndicatorInAddEditDish:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}



-(void)goForSendAddDishImage:(NSDictionary *)result{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:[result valueForKey:@"profile"]];
    [dict setObject:[result valueForKey:@"accessToken"] forKey:@"accessToken"];
    
    for (NSString * key in [dict allKeys]){
        if ([[dict objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:@"" forKey:key];
    }
    
    [appDel ownerProfileUpDateWithResult:dict];
    
    
    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:[dict valueForKey:@"accessToken"] forKey:@"accessToken"];
    [paramDict setObject:[dict valueForKey:@"dishId"] forKey:@"dishId"];
    
    
    
    /*
     if (<#condition#>) {
     <#statements#>
     }
     [paramDict setObject:[dict valueForKey:@"accessToken"] forKey:@"accessToken"];
     [paramDict setObject:[dict valueForKey:@"accessToken"] forKey:@"accessToken"];
     [paramDict setObject:[dict valueForKey:@"accessToken"] forKey:@"accessToken"];
     []
     */
    
    /*
     * Adding a dish image
     * url - /addDishImage
     * method - POST
     * params - accessToken, dishId, dishImage,imageExt, default
     */
}

- (IBAction)Register2ViewCancelAction:(id)sender {
    //    self.register2AllFieldsContainer.hidden = YES;
    
    [self performSegueWithIdentifier:@"goToBasicInfo" sender:self];
}

@end
