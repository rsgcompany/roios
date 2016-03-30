//
//  RegisterVC3.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/6/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParserHClass.h"
#import "MBProgressHUD.h"

@interface RegisterVC3 : UIViewController<UITextFieldDelegate,parserHDelegate,MBProgressHUDDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    BOOL isPaymentTableEnable;
    ParserHClass *webParser;
    MBProgressHUD *hud;


}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (strong, nonatomic) IBOutlet UITextField *webSiteTF;
@property (strong, nonatomic) IBOutlet UITextField *yepLinrTF;
@property (strong, nonatomic) IBOutlet UITextField *instagramTF;
@property (strong, nonatomic) IBOutlet UITextField *facebookTF;
@property (strong, nonatomic) IBOutlet UITextField *twitterTF;
@property (strong, nonatomic) IBOutlet UITextField *paymentTF;
@property (strong, nonatomic) IBOutlet UITextField *urbanSpponTF;


- (IBAction)PaymentMethodTextFAction:(id)sender;
- (IBAction)PaymentMethodButtonAction:(id)sender;


@property (strong, nonatomic) IBOutlet UIView *view1Gesture;


- (IBAction)BackBtnClicked:(id)sender;
- (IBAction)RegistrationFinishButton:(id)sender;







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

@property (strong, nonatomic) IBOutlet UIView *pickerViewActionSheet;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerViewR3;
@property (strong, nonatomic) IBOutlet UIButton *pickerCancelButton;
- (IBAction)pickerCancelAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *pickerDoneButton;
- (IBAction)pickerDoneAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *finishBtn;




@end
