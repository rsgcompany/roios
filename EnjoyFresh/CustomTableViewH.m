//
//  CustomTableViewH.m
//  RestPrac1
//
//  Created by cprompt solutions on 12/3/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "CustomTableViewH.h"

#import "Global.h"


@interface CustomTableViewH ()

@end


@implementation CustomTableViewH
@synthesize dropDownAry;
@synthesize delegate;


- (id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(CGRect)dropDownViewFrame{
    return CGRectMake(100, 55, 220, dropdownCount*40);
//    return CGRectMake(100, 63, 220, 2*50);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    dropDownAry=@[@"",@"Add Dish",@"Orders",@"Dishes",@"Reviews",@"Reports",@"Settings",@"Notification",@"Logout"];
    _imgAry=@[@"",@"Explore",@"Notifications",@"Explore",@"Contact",@"Favorites",@"Social Share",@"Notification",@"Logout"];

    
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [[UIColor clearColor] CGColor];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dropDownAry count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifer=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    UILabel *nameLBl;
    UILabel *acceryLbl;
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifer];
        cell.backgroundColor = [UIColor clearColor];
        
        
        nameLBl = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, 100, 50)];
        acceryLbl = [[UILabel alloc]initWithFrame:CGRectMake(180, 0, 30, 50)];
        nameLBl.font=[UIFont fontWithName:@"Raleway-Light" size:14.0f];
        acceryLbl.font=[UIFont fontWithName:@"Raleway-Light" size:12.0f];
        nameLBl.textColor =[UIColor redColor];
        [cell.contentView addSubview:nameLBl];
        [cell.contentView addSubview:acceryLbl];
        
        nameLBl.text=[dropDownAry objectAtIndex:indexPath.row];

        /*
        if(![appDel.accessToken length]){
            if(indexPath.row==0)
                nameLBl.text=@"Guest User";
            else if(indexPath.row==7)
                nameLBl.text=@"Login";
        }
        else{
            if(indexPath.row==0){
                NSDictionary *dict=[[NSUserDefaults standardUserDefaults] valueForKey:@"UserProfile"];
                
                NSString *abc = [NSString stringWithFormat:@"%@  %@",[dict valueForKey:@"first_name"],[dict valueForKey:@"last_name"]];
                nameLBl.text = [NSString stringWithFormat:@"%@%@",[[abc substringToIndex:1] uppercaseString],[abc substringFromIndex:1] ];
            }
            
        }
        */
        NSLog(@"user Name = %@",appDel.CurrentOwnerDetails.owner_owner_name);
        NSLog(@"user Name = %@",appDel.CurrentOwnerDetails.owner_accessToken);
        NSLog(@"currentDet1 = %@",appDel.CurrentOwnerDetails);

        if(![appDel.CurrentOwnerDetails.owner_accessToken length]){
            if(indexPath.row==0)
                nameLBl.text=@"Guest User";
            else if(indexPath.row==8)
                nameLBl.text=@"Login";
        }
        else{
            if(indexPath.row==0){                
//                NSString *abc = appDel.CurrentOwnerDetails.owner_owner_name;
//                nameLBl.text = [NSString stringWithFormat:@"%@%@",[[abc substringToIndex:1] uppercaseString],[abc substringFromIndex:1] ];
            }else if (indexPath.row == 8){
                nameLBl.text = @"Logout";
            }
            
        }


    }
  
    
    cell.imageView.image = [UIImage imageNamed:[_imgAry objectAtIndex:indexPath.row]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0 ) {
        return 0;
    }
    else{
        return 40;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *stg = [dropDownAry objectAtIndex:indexPath.row];
    [delegate didSelectRowInDropdownTableString:stg atIndexPath:indexPath];

    
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
