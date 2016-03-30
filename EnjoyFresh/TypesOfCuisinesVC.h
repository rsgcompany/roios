//
//  TypesOfCuisinesVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypesOfCuisinesVC : UIViewController<UITextFieldDelegate>{
    
    BOOL isShowingDropDown;
    
    UIView *AnotherCuisineView,*CustomCuisineView;
    
    
    UITextField *aTextfield,*bTextfield;
    UIButton *staticDropDown2;
    
    
    NSInteger tag,tag2,currenttag,currenttag2;
    
    NSString *Checkstr;
    
    
}


@property (weak, nonatomic) IBOutlet UIScrollView *Scroller;




@property (strong, nonatomic) IBOutlet UIView *PickerViewContainer;
@property (strong, nonatomic) IBOutlet UIButton *PickerDoneButton;
- (IBAction)pickerDoneAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *pickerCancelButton;
- (IBAction)pickerCancelAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewH;
@property (strong, nonatomic) IBOutlet UIView *transparentBlackView;

@property (strong, nonatomic) IBOutlet UIView *typesCuisineGesture;

- (IBAction)SaveSettingsAction:(id)sender;
- (IBAction)menuButtonAction:(id)sender;













//It is for dynamic Chanding views
@property (strong, nonatomic) IBOutlet UIView *addAnothercontainer1;
- (IBAction)AddAnotherCuisine1Action:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *AddAnotherBtn1;
@property (strong, nonatomic) IBOutlet UIView *AddAnother1TFContainer;
@property (strong, nonatomic) IBOutlet UITextField *addAnotherCusine1TF;
- (IBAction)addAnotherCuisine1RemoveAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *CuisineRemove1Btn;
@property (strong, nonatomic) IBOutlet UIImageView *cuisineDownArrow1;


@property (strong, nonatomic) IBOutlet UIView *addAnotherContainer2;
- (IBAction)AddAnotherCuisine2Action:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *AddAnotherBtn2;
@property (strong, nonatomic) IBOutlet UIView *AddAnother2TFContainer;
@property (strong, nonatomic) IBOutlet UITextField *addAnotherCusine2TF;
- (IBAction)addAnotherCuisine2RemoveAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cusineRemove2Btn;
@property (strong, nonatomic) IBOutlet UIImageView *cuisineDownarrow2;






- (IBAction)AddCustomCuisineAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *AddCustomBtn;
@property (strong, nonatomic) IBOutlet UIView *AddCustomTFContainer;
@property (strong, nonatomic) IBOutlet UITextField *addCustomTF;
- (IBAction)addCustomRemoveAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *customRemoveBtn;





@property (strong, nonatomic) IBOutlet UIView *addAnotherCuisine1G;
@property (strong, nonatomic) IBOutlet UIView *addAnotherCuisine2G;


@property (nonatomic, retain) NSMutableDictionary *CuisinesDictionary;




@property (strong, nonatomic) IBOutlet UIView *mainCuisineTFContainer;
@property (strong, nonatomic) IBOutlet UITextField *mainCuisineTF1;
@property (strong, nonatomic) IBOutlet UIView *mainCuisineViewG;
@property (strong, nonatomic) IBOutlet UIImageView *mainDownArrow;
@property (strong, nonatomic) IBOutlet UIButton *mainBtn;






@end
