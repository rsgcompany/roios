//
//  RegisterVC2.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/6/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC2 : UIViewController{
    
        
    
   
    
    NSMutableArray *CuisineNameArray;
    NSString *Checkstr;
    
 
    
    
    

}


@property (weak, nonatomic) IBOutlet UIScrollView *ScrollV;
@property (strong, nonatomic) IBOutlet UITextField *addressTF;
@property (strong, nonatomic) IBOutlet UITextField *suiteTF;
@property (strong, nonatomic) IBOutlet UITextField *cityTF;
@property (strong, nonatomic) IBOutlet UITextField *stateTF;
@property (strong, nonatomic) IBOutlet UITextField *zipTF;
@property (strong, nonatomic) IBOutlet UIImageView *restImgV;
@property (strong, nonatomic) IBOutlet UITextField *restaurentDesTF;
@property (strong, nonatomic) IBOutlet UITextField *cityTaxTF;
@property (strong, nonatomic) IBOutlet UITextField *stateTaxTF;
@property (strong, nonatomic) IBOutlet UITextField *typesCuisinesTF;

@property (nonatomic, retain) NSMutableDictionary *CuisinesDictionary;

- (IBAction)StateButtonAction:(id)sender;
- (IBAction)cityTaxButtonAction:(id)sender;
- (IBAction)stateTaxButtonAction:(id)sender;
- (IBAction)TypesCuisineButtonAction:(id)sender;

- (IBAction)stateTFActionBlock:(id)sender;
- (IBAction)cityTaxTFActionBlock:(id)sender;
- (IBAction)stateTaxTFActionBlock:(id)sender;
- (IBAction)causindTFActionBlock:(id)sender;

- (IBAction)addPhotoButtonBlock:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *addPhotoBtn;


- (IBAction)BackBtnClicked:(id)sender;



- (IBAction)ContinueButtonAction:(id)sender;
- (IBAction)SkipTheStepButtonAction:(id)sender;




@property (strong, nonatomic) IBOutlet UIView *view1Gesture;
@property (strong, nonatomic) IBOutlet UIView *stateViewG;
@property (strong, nonatomic) IBOutlet UIView *typesCausineViewG;
@property (strong, nonatomic) IBOutlet UIView *cityTaxG;
@property (strong, nonatomic) IBOutlet UIView *statetaxViewG;



@property (strong, nonatomic) IBOutlet UIView *PickerViewContainer;
@property (strong, nonatomic) IBOutlet UIButton *PickerDoneButton;
- (IBAction)pickerDoneAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *pickerCancelButton;
- (IBAction)pickerCancelAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewH;
@property (strong, nonatomic) IBOutlet UIView *transparentBlackView;





//It is for dynamic Chanding views
@property (strong, nonatomic) IBOutlet UIView *addAnothercontainer1;
- (IBAction)AddAnotherCuisine1Action:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *AddAnotherBtn1;
@property (strong, nonatomic) IBOutlet UIView *AddAnother1TFContainer;
@property (strong, nonatomic) IBOutlet UITextField *addAnotherCusine1TF;
- (IBAction)addAnotherCuisine1RemoveAction:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *addAnotherContainer2;
- (IBAction)AddAnotherCuisine2Action:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *AddAnotherBtn2;
@property (strong, nonatomic) IBOutlet UIView *AddAnother2TFContainer;
@property (strong, nonatomic) IBOutlet UITextField *addAnotherCusine2TF;
- (IBAction)addAnotherCuisine2RemoveAction:(id)sender;



- (IBAction)AddCustomCuisineAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *AddCustomBtn;
@property (strong, nonatomic) IBOutlet UIView *AddCustomTFContainer;
@property (strong, nonatomic) IBOutlet UITextField *addCustomTF;
- (IBAction)addCustomRemoveAction:(id)sender;





@property (strong, nonatomic) IBOutlet UIView *addAnotherCuisine1G;
@property (strong, nonatomic) IBOutlet UIView *addAnotherCuisine2G;
@property (strong, nonatomic) IBOutlet UIView *addCustomCuisineG;

@property (strong, nonatomic) IBOutlet UIView *continueBtnContainer;

























@end
