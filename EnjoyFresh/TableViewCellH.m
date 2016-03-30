//
//  TableViewCellH.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/6/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "TableViewCellH.h"

@implementation TableViewCellH

- (void)awakeFromNib {
    // Initialization code
    
    
    _sectionContainerV.layer.borderWidth = 0.5f;
    _sectionContainerV.layer.borderColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1].CGColor;
    _sectionPaymentContainerV.layer.borderWidth = 0.5f;
    _sectionPaymentContainerV.layer.borderColor = [UIColor colorWithRed:235.0/255.0 green:235.0/255.0 blue:235.0/255.0 alpha:1].CGColor;
    
    
    _ingredientsTfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    _ingredientsTfield.leftViewMode = UITextFieldViewModeAlways;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
