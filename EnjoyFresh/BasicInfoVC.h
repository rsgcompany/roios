//
//  BasicInfoVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoVC : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;
@property (weak, nonatomic) IBOutlet UITextField *FirstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *LastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *RestaurentNameTF;
@property (weak, nonatomic) IBOutlet UITextField *RestaurentMobileTF;
@property (weak, nonatomic) IBOutlet UITextField *RestaurentFaxnoTF;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionTV;
@property (weak, nonatomic) IBOutlet UITextField *AddressTF;
@property (weak, nonatomic) IBOutlet UITextField *SuiteTF;
@property (weak, nonatomic) IBOutlet UITextField *CityTF;
@property (weak, nonatomic) IBOutlet UITextField *StateTF;
@property (weak, nonatomic) IBOutlet UITextField *ZipCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *CityTaxTF;
@property (weak, nonatomic) IBOutlet UITextField *StateTaxTF;

@property (strong, nonatomic) IBOutlet UIView *view1;
- (IBAction)addButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *stateTaxGesture;
@property (strong, nonatomic) IBOutlet UIView *cityTaxGesture;
@property (strong, nonatomic) IBOutlet UIView *stateGestureV;




@property (strong, nonatomic) IBOutlet UIView *TransparentBlackView;
@property (strong, nonatomic) IBOutlet UIView *PickerViewContainer;
@property (strong, nonatomic) IBOutlet UIPickerView *PickerViewH;
@property (strong, nonatomic) IBOutlet UIButton *donePickerView;
- (IBAction)donePickerViewAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelPickerView;
- (IBAction)cancelPickerViewAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *profilePicImg;




@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *imageActIndV;
- (IBAction)menuButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;



@property (nonatomic, retain) NSString *isFrom;



@end
