//
//  SignInVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInVC : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (weak, nonatomic) IBOutlet UITextField *emailFld;
@property (weak, nonatomic) IBOutlet UITextField *passwdFld;



- (IBAction)BackBtnClicked:(id)sender;
- (IBAction)loginBtnClicked:(id)sender;
- (IBAction)forgotPasswordButtonAction:(id)sender;

@end
