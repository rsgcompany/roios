//
//  NotificationCell.h
//  EnjoyFresh
//
//  Created by Siva  on 28/12/15.
//  Copyright (c) 2015 VrindaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UIImageView *imgNotification;
@property (strong, nonatomic) IBOutlet UILabel *lblText;
@end
