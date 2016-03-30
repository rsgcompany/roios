//
//  HomeVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/5/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeVC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;
@property (weak, nonatomic) IBOutlet UILabel *botomTxtLbl;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControler;
@property (weak, nonatomic) IBOutlet UIButton *ContincueAsGuestBtn;

- (IBAction)registerButtonAction:(id)sender;
- (IBAction)Continue_Guest_Clicked:(id)sender;
@end
