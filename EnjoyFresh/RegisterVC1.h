//
//  RegisterVC1.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterVC1 : UIViewController{
    BOOL isT_C_Enabled;

}
- (IBAction)BackBtnClicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollV;
@property (strong, nonatomic) IBOutlet UITextField *RestaurentNameTF;
@property (strong, nonatomic) IBOutlet UITextField *OwnerNameTF;
@property (strong, nonatomic) IBOutlet UITextField *OwnerLastNameTF;
@property (strong, nonatomic) IBOutlet UITextField *OwnerEmailTF;
@property (strong, nonatomic) IBOutlet UITextField *OwnerPasswordTF;
@property (strong, nonatomic) IBOutlet UITextField *RestaurentPhNoTF;
@property (strong, nonatomic) IBOutlet UITextField *RestaurentFaxNoTF;
- (IBAction)aggrimentCheckMarkBlock:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *aggrimentHyperLinkView;
@property (strong, nonatomic) IBOutlet UIButton *checkMarkBtn;
@property (strong, nonatomic) IBOutlet UIButton *checkMarkBtn2;

@property (strong, nonatomic) IBOutlet UIButton *continueBtn;
- (IBAction)continueButtonAction:(id)sender;
- (IBAction)CheckMark2Button:(id)sender;

@end
