//
//  CustomTableViewH.h
//  RestPrac1
//
//  Created by cprompt solutions on 12/3/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol CustomTableViewHDelegate <NSObject>
-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath;
@end


@interface CustomTableViewH : UITableViewController{
    int indexpth;
}
-(CGRect)dropDownViewFrame;

@property (nonatomic,retain) NSArray *dropDownAry;
@property (nonatomic,retain) NSArray *imgAry;

@property(strong ,nonatomic)id <CustomTableViewHDelegate> delegate;


@end
