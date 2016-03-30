//
//  LoginSettingsVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/23/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginSettingsVC : UIViewController<UITextFieldDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UITextField *EmailTF;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *ConfirmPasswordTF;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)menuButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *menuBtn;

@end
