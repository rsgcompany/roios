//
//  PaymentSettingsVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentSettingsVC : UIViewController

@property (strong, nonatomic) IBOutlet UIView *paymentGesture;


@property (weak, nonatomic) IBOutlet UIScrollView *Scrollview;
@property (weak, nonatomic) IBOutlet UITextField *PaymentmethodTF;









@property (strong, nonatomic) IBOutlet UIView *BankPaymenyView;
@property (strong, nonatomic) IBOutlet UITextField *bankACName;
@property (strong, nonatomic) IBOutlet UITextField *bankACNumber;
@property (strong, nonatomic) IBOutlet UITextField *routingNumberTF;


@property (strong, nonatomic) IBOutlet UIView *PaypalView;
@property (strong, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) IBOutlet UITextField *paypalFullNameTF;

@property (strong, nonatomic) IBOutlet UIView *ChequeView;
@property (strong, nonatomic) IBOutlet UITextField *FullNameTF;
@property (strong, nonatomic) IBOutlet UITextField *addressTF;
@property (strong, nonatomic) IBOutlet UITextField *suiteTF;
@property (strong, nonatomic) IBOutlet UITextField *cityTF;
@property (strong, nonatomic) IBOutlet UITextField *stateTF;
@property (strong, nonatomic) IBOutlet UITextField *zipCodeTF;

@property (strong, nonatomic) IBOutlet UIView *patmebtGesture;


- (IBAction)stateInPaymentClicked:(id)sender;






@property (strong, nonatomic) IBOutlet UIView *transparentBlackView;
@property (strong, nonatomic) IBOutlet UIView *pickerViewContainer;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewH;
@property (strong, nonatomic) IBOutlet UIButton *cancelPickerView;
- (IBAction)cancelPickerViewAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *donePickerview;
- (IBAction)donePickerAction:(id)sender;






- (IBAction)menuButtonAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *menuBtn;





@end
