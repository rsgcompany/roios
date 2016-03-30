//
//  AddPhotosVC.h
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/31/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBActionSheet.h"


@interface AddPhotosVC : UIViewController<UIActionSheetDelegate,IBActionSheetDelegate>{
    NSMutableArray *imagesArray,*isDefaultArray;
   
   

    NSIndexPath *selectedindex;
}
@property IBActionSheet *CustomActionSheet;
@property IBActionSheet *CustomActionSheet1;

@property (strong, nonatomic) IBOutlet UICollectionView *photosCollectionV;

- (IBAction)backbuttonAction:(id)sender;
- (IBAction)menuButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *mainBtn;


- (IBAction)saveSettingsAction:(id)sender;
@end
