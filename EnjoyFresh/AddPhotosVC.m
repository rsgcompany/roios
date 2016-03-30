//
//  AddPhotosVC.m
//  EnjoyFresh
//
//  Created by cprompt solutions on 12/31/14.
//  Copyright (c) 2014 VrindaTech. All rights reserved.
//

#import "AddPhotosVC.h"
#import "CollectionViewCellH.h"
#import "CustomTableViewH.h"
#import "Global.h"
#import "GlobalMethods.h"
#import "UIImageView+WebCache.h"
#import "ParserHClass.h"
#import "MBProgressHUD.h"

@interface AddPhotosVC ()<UICollectionViewDataSource,UICollectionViewDelegate,CustomTableViewHDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,parserHDelegate,MBProgressHUDDelegate>{
    CustomTableViewH *dropDownV;
    
    ParserHClass *webParser;
    MBProgressHUD *hud;

    NSInteger responceCount,totalCount;
    NSString *presentlyUpDatedString;
    
    
    NSMutableArray *sendingImageAry;
    
    
    
    
    NSMutableArray *FArray;


}

@end

@implementation AddPhotosVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES];
    
//    imagesArray=[NSMutableArray arrayWithArray:[appDel.CurrentOwnerDetails.owner_profileImagesArray valueForKey:@"path_lg"]];
//    isDefaultArray=[NSMutableArray arrayWithArray:[appDel.CurrentOwnerDetails.owner_profileImagesArray valueForKey:@"default"]];
    
    webParser=[[ParserHClass alloc]init];
    webParser.delegate=self;
    
    responceCount = 0;
    totalCount = 0;
//
//    
//    int i=5-imagesArray.count;
//    
//    for (int j=0; j<i ; j++) {
//        [imagesArray addObject:[UIImage imageNamed:@"addphoto.png"]];
//        [isDefaultArray addObject:@"0"];
//    }
//    
//    sendingImageAry = [[NSMutableArray alloc]initWithCapacity:0];
//    
//    [_photosCollectionV reloadData];
    
    
    
    FArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSArray *arr=[appDel.CurrentOwnerDetails.owner_profileImagesArray valueForKey:@"path_lg"];
    
    for (int i=0; i<[[appDel.CurrentOwnerDetails.owner_profileImagesArray valueForKey:@"path_lg"] count]; i++) {
        
        
        
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithCapacity:0];
        NSString *pathstg = [[appDel.CurrentOwnerDetails.owner_profileImagesArray valueForKey:@"path_lg"] objectAtIndex:i];
        NSString *photoIdStg = [[appDel.CurrentOwnerDetails.owner_profileImagesArray valueForKey:@"photo_id"] objectAtIndex:i];
        NSString *defaultStg = [[appDel.CurrentOwnerDetails.owner_profileImagesArray valueForKey:@"default"] objectAtIndex:i];
        [dic setValue:pathstg forKey:@"imageType"];
        [dic setValue:photoIdStg forKey:@"photo_Id"];
        [dic setValue:[NSNumber numberWithBool:YES] forKey:@"pathUtl"];
        [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isDeleted"];
        [dic setValue:@"0" forKey:@"onlyDefaultChanged"];
        [dic setObject:@"EmPty" forKey:@"NewImage"];
        [dic setObject:defaultStg forKey:@"default"];
        [FArray addObject:dic];
        
    }
    
    
    for (NSInteger i=appDel.CurrentOwnerDetails.owner_profileImagesArray.count; i<5; i++) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithCapacity:0];
        UIImage *pathImg = [UIImage imageNamed:@"addphoto.png"];

        [dic setValue:pathImg forKey:@"imageType"];
        [dic setValue:@"EmPty" forKey:@"photo_Id"];
        [dic setValue:[NSNumber numberWithBool:NO] forKey:@"pathUtl"];
        [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isDeleted"];
        [dic setObject:@"EmPty" forKey:@"NewImage"];
        [dic setValue:@"0" forKey:@"default"];
        [dic setObject:@"0" forKey:@"onlyDefaultChanged"];

        [FArray addObject:dic];
    }
    
    [_photosCollectionV reloadData];


}
-(void)viewWillAppear:(BOOL)animated{
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return FArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdent = @"collectIdentifier";
    CollectionViewCellH *cell = (CollectionViewCellH *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdent forIndexPath:indexPath];
    
    
    
    NSDictionary *IndexDic = [FArray objectAtIndex:indexPath.row];
    
    cell.DefaultLbl.hidden = YES;

    if ([[IndexDic valueForKey:@"imageType"] isKindOfClass:[NSString class]]) {
        cell.collectionImageV.image = [UIImage imageNamed:@"addphoto.png"];
        [cell.collectActIndcator startAnimating];
        [SDWebImageDownloader.sharedDownloader downloadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RestaurentImageUrl,[IndexDic valueForKey:@"imageType"]]] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize){
            // progression tracking code
        }completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished){
            if (image && finished){
                // do something with image
                cell.collectionImageV.image= [self imageWithImage:image scaledToSize:CGSizeMake(150, 150)];
                [cell.collectActIndcator stopAnimating];
                
                
                if ([[IndexDic valueForKey:@"default"] boolValue]) {
                    cell.DefaultLbl.hidden = NO;
                }else{
                    cell.DefaultLbl.hidden=YES;
                }

                
            }
        }];
        

    }else if ([[IndexDic valueForKey:@"imageType"] isKindOfClass:[UIImage class]]) {
        if ([[IndexDic valueForKey:@"default"] boolValue]) {
            cell.DefaultLbl.hidden = NO;
        }else{
            cell.DefaultLbl.hidden=YES;
        }
        cell.collectionImageV.image = [IndexDic valueForKey:@"imageType"];
    }
    


    
    
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedindex=indexPath;

    
    CollectionViewCellH *selectedCell=(CollectionViewCellH *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([selectedCell.collectionImageV.image isEqual:[UIImage imageNamed:@"addphoto.png"]] && [selectedCell.collectActIndcator isHidden]) {
        NSLog(@"open camera");
        UIAlertView *photoAlert=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Choose Photo",@"Take Photo",@"Cancel", nil];
        [photoAlert show];

    }else{
        if ([selectedCell.DefaultLbl isHidden]) {
            NSLog(@"send request");
            
            self.CustomActionSheet = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Make Default", @"Delete", nil];
            
            self.CustomActionSheet.buttonResponse = IBActionSheetButtonResponseShrinksOnPress;
            [self.CustomActionSheet setButtonBackgroundColor:[UIColor whiteColor]];
            [self.CustomActionSheet setButtonTextColor:[UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [self.CustomActionSheet setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:0];
            [self.CustomActionSheet setButtonTextColor:[UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] forButtonAtIndex:0];
            
            [self.CustomActionSheet setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:1];
            [self.CustomActionSheet setButtonTextColor:[UIColor redColor] forButtonAtIndex:1];
            
            [self.CustomActionSheet setCancelButtonFont:[UIFont systemFontOfSize:22]];
            
            [self.CustomActionSheet showInView:[UIApplication sharedApplication].keyWindow];
        }else{
            self.CustomActionSheet1 = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Delete", nil];
            
            self.CustomActionSheet1.buttonResponse = IBActionSheetButtonResponseShrinksOnPress;
            [self.CustomActionSheet1 setButtonBackgroundColor:[UIColor whiteColor]];
            [self.CustomActionSheet1 setButtonTextColor:[UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [self.CustomActionSheet1 setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:0];
            [self.CustomActionSheet1 setButtonTextColor:[UIColor colorWithRed:0/255.0 green:122.0/255.0 blue:255.0/255.0 alpha:1.0] forButtonAtIndex:0];
            
            [self.CustomActionSheet1 setButtonBackgroundColor:[UIColor whiteColor] forButtonAtIndex:1];
            [self.CustomActionSheet1 setButtonTextColor:[UIColor redColor] forButtonAtIndex:1];
            
            [self.CustomActionSheet1 setCancelButtonFont:[UIFont systemFontOfSize:22]];
            
            [self.CustomActionSheet1 showInView:[UIApplication sharedApplication].keyWindow];
        }
    }
    


}
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    
    if (buttonIndex==0) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        
    }
    
    else if (buttonIndex==1) {
        
//        [imagesArray replaceObjectAtIndex:selectedindex.row withObject:[UIImage imageNamed:@"Dark-Apple.jpg"]];
//        [_photosCollectionV reloadData];
        
         UIImagePickerController *picker = [[UIImagePickerController alloc] init];
         picker.delegate = self;
         picker.allowsEditing = YES;
         picker.sourceType =UIImagePickerControllerSourceTypeCamera;
        
         [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
}

#pragma mark - ActionSheet Delegate

- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    


    NSLog(@"%ld",(long)buttonIndex);
    if (actionSheet == self.CustomActionSheet1) {
        switch (buttonIndex) {
            case 0:{
                NSLog(@"Delete");
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:[FArray objectAtIndex:selectedindex.row]];
                [dic setValue:[UIImage imageNamed:@"addphoto.png"] forKey:@"imageType"];
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isDeleted"];
                [dic setValue:@"EmPty" forKey:@"NewImage"];
                [dic setValue:@"0" forKey:@"default"];
                [dic setValue:@"1" forKey:@"onlyDefaultChanged"];

                
                
                [FArray replaceObjectAtIndex:selectedindex.row withObject:dic];
                
                [_photosCollectionV reloadItemsAtIndexPaths:@[selectedindex]];
                
            }
                
        
                break;
                
            default:
                break;
        }
    }else{
        switch (buttonIndex) {
            case 0:{
                NSMutableDictionary *dic;
                for (int i=0; i< FArray.count; i++) {
                    if (i == selectedindex.row) {
                        dic=[NSMutableDictionary dictionaryWithDictionary:[FArray objectAtIndex:selectedindex.row]];
                        [dic setValue:[NSNumber numberWithBool:NO] forKey:@"isDeleted"];
                        [dic setValue:@"1" forKey:@"default"];
                        [dic setValue:@"1" forKey:@"onlyDefaultChanged"];
                        [FArray replaceObjectAtIndex:selectedindex.row withObject:dic];


                    }else{
                        dic=[NSMutableDictionary dictionaryWithDictionary:[FArray objectAtIndex:i]];
                        [dic setValue:@"0" forKey:@"default"];
                        [dic setValue:@"0" forKey:@"onlyDefaultChanged"];
                        [FArray replaceObjectAtIndex:i withObject:dic];


                    }
                }
                
                [_photosCollectionV reloadData];

                
                

            }
                break;
            case 1:{
                NSLog(@"Delete");
                
                
                NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:[FArray objectAtIndex:selectedindex.row]];
                [dic setValue:[UIImage imageNamed:@"addphoto.png"] forKey:@"imageType"];
                [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isDeleted"];
                [dic setValue:@"EmPty" forKey:@"NewImage"];
                [dic setValue:@"0" forKey:@"default"];

                [FArray replaceObjectAtIndex:selectedindex.row withObject:dic];
                
                
                
                [_photosCollectionV reloadItemsAtIndexPaths:@[selectedindex]];
                
                
                
                
                
                
                
                
            }
                
                break;
            default:
                break;
        }
    }
    
    
 }
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    UIImage *chosenImage = [GlobalMethods imageByScalingAndCroppingForSize:CGSizeMake(300,200) source:image];


    NSMutableDictionary *dic=[NSMutableDictionary dictionaryWithDictionary:[FArray objectAtIndex:selectedindex.row]];
    [dic setValue:chosenImage forKey:@"imageType"];
    [dic setValue:[NSNumber numberWithBool:YES] forKey:@"isDeleted"];
    [dic setValue:chosenImage forKey:@"NewImage"];
    [dic setValue:@"0" forKey:@"default"];
    [FArray replaceObjectAtIndex:selectedindex.row withObject:dic];
    
    [_photosCollectionV reloadItemsAtIndexPaths:@[selectedindex]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


- (IBAction)backbuttonAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)menuButtonAction:(id)sender {
    [self.view endEditing:YES];

    if(dropDownV==nil){
        [self menuViewShow:YES];
    }
    else{
        [self menuViewShow:NO];
    }

}

-(void)menuViewShow:(BOOL)myBool{
    [self.view endEditing:YES];
    
    if (myBool) {
        dropDownV = [[CustomTableViewH alloc] initWithStyle:UITableViewStylePlain];
        [dropDownV.view setFrame:CGRectMake(100, 55, 220, 0)];
        //        dropDownV.view.backgroundColor=[UIColor colorWithWhite:0.9f alpha:0.8f];
        dropDownV.view.backgroundColor=[UIColor whiteColor];
        
        dropDownV.delegate = self;
        
        
        [self.view addSubview:dropDownV.view];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [dropDownV.view setFrame:[dropDownV dropDownViewFrame]];
        [UIView commitAnimations];
        
        [_mainBtn setImage:[UIImage imageNamed:@"nf_close"] forState:UIControlStateNormal];

        //        _trasparentBlackView.hidden = NO;
        
    }else{
        [_mainBtn setImage:[UIImage imageNamed:@"HamburgerIcon"] forState:UIControlStateNormal];

        [UIView animateWithDuration:0.5
                         animations:^{
                             [dropDownV.view setFrame:CGRectMake(100, 55, 220, 0)];
                         }
                         completion:^(BOOL finished){
                             [dropDownV.view removeFromSuperview];
                             dropDownV=nil;
                             //                             _trasparentBlackView.hidden = YES;
                             
                         }
         ];
        
    }
}

#pragma mark
#pragma mark - CustomTableview Datasource Delegate
-(void)didSelectRowInDropdownTableString:(NSString *)myString atIndexPath:(NSIndexPath *)myIndexPath{
    [self menuViewShow:NO];

    if (myIndexPath.row == 1) {
        [self performSegueWithIdentifier:@"goToAddDishView" sender:self];
    }else if (myIndexPath.row == 2){
        [self performSegueWithIdentifier:@"goToOrdersView" sender:self];
    }else if (myIndexPath.row == 3){
        [self performSegueWithIdentifier:@"goToDishesView" sender:self];
    }else if (myIndexPath.row == 4) {
        [self performSegueWithIdentifier:@"goToReviewsView" sender:self];
    }else if (myIndexPath.row == 5) {
        [self performSegueWithIdentifier:@"goToReportsView" sender:self];
    }else if (myIndexPath.row == 6){
        [self performSegueWithIdentifier:@"goTosettingsView" sender:self];
    }else if (myIndexPath.row == 7) {
        [self performSegueWithIdentifier:@"goToNotificationsView" sender:self];
    }else if (myIndexPath.row == 8){
        [self goToSignInViewLogout];
    }
    
    
    
}

- (IBAction)saveSettingsAction:(id)sender {
    presentlyUpDatedString = @"ProfileImageUpDating";
    
    
    for (NSDictionary *dic in FArray) {
        if ([[dic valueForKey:@"isDeleted"] boolValue]) {
            /*! Valid Photo Id There and  new Image Not avaliable */
            if (![[dic valueForKey:@"photo_Id"] isEqualToString:@"EmPty"] && [[dic valueForKey:@"NewImage"] isKindOfClass:[NSString class]]) {
                [self showActivityIndicatorInPhotos:YES];

                totalCount++;

                NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]initWithCapacity:0];
                [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
                [paramDict setObject:[dic valueForKey:@"photo_Id"] forKey:@"photo_id"];
                [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"deleteRestaurantImage"];
            }
            /*! Valid Photo Id There and  new Image avaliable */
            else if (![[dic valueForKey:@"photo_Id"] isEqualToString:@"EmPty"] && [[dic valueForKey:@"NewImage"] isKindOfClass:[UIImage class]]) {
                [self showActivityIndicatorInPhotos:YES];

                totalCount++;

                NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]initWithCapacity:0];
                [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
                
                NSData *imageData = UIImageJPEGRepresentation([dic valueForKey:@"NewImage"], 0.5);
                NSString *ImgStr=[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                [paramDict setObject:@"jpeg" forKey:@"imageExt"];
                [paramDict setObject:ImgStr forKey:@"restaurantImage"];
                
                
                if ([[dic valueForKey:@"default"] boolValue]) {
                    [paramDict setValue:[NSNumber numberWithInt:1] forKey:@"default"];
                }else{
                    [paramDict setValue:[NSNumber numberWithInt:0] forKey:@"default"];
                }
                
                
                [paramDict setObject:[dic valueForKey:@"photo_Id"] forKey:@"photo_id"];
                [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"addRestaurantImage"];

            }
            /*! NO Valid Photo Id There and  new Image avaliable */
            else if ([[dic valueForKey:@"photo_Id"] isEqualToString:@"EmPty"] && [[dic valueForKey:@"NewImage"] isKindOfClass:[UIImage class]]) {
                [self showActivityIndicatorInPhotos:YES];

                totalCount++;

                NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]initWithCapacity:0];
                [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
                NSData *imageData = UIImageJPEGRepresentation([dic valueForKey:@"NewImage"], 0.5);
                NSString *ImgStr=[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                [paramDict setObject:@"jpeg" forKey:@"imageExt"];
                [paramDict setObject:ImgStr forKey:@"restaurantImage"];
                if ([[dic valueForKey:@"default"] boolValue]) {
                    [paramDict setValue:[NSNumber numberWithInt:1] forKey:@"default"];
                }else{
                    [paramDict setValue:[NSNumber numberWithInt:0] forKey:@"default"];
                }
                [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"addRestaurantImage"];
                

            }
        }
      
        
        /*! CHECKING FOR ONLY DEFAULT VALUE */
        
        else if (![[dic valueForKey:@"isDeleted"]boolValue] && [[dic valueForKey:@"default"] boolValue]) {
            [self showActivityIndicatorInPhotos:YES];
            
            totalCount++;
            
            NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]initWithCapacity:0];
            [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
       
            
            if (![[dic valueForKey:@"photo_Id"] isEqualToString:@"EmPty"]) {
                [paramDict setObject:[dic valueForKey:@"photo_Id"] forKey:@"photo_id"];
            }
            
            
            if ([[dic valueForKey:@"NewImage"] isKindOfClass:[UIImage class]]) {
                NSData *imageData = UIImageJPEGRepresentation([dic valueForKey:@"NewImage"], 0.5);
                NSString *ImgStr=[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
                [paramDict setObject:@"jpeg" forKey:@"imageExt"];
                [paramDict setObject:ImgStr forKey:@"restaurantImage"];
            }


            if ([[dic valueForKey:@"default"] boolValue]) {
                [paramDict setValue:[NSNumber numberWithInt:1] forKey:@"default"];
            }else{
                [paramDict setValue:[NSNumber numberWithInt:0] forKey:@"default"];
            }
            
            [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"addRestaurantImage"];
            
        }
        

    }
    
    
}


-(void)dataDidFinihLoadingwithResult:(NSDictionary *)result{
    
    if (![[result valueForKey:@"error"] boolValue]) {
        if ([presentlyUpDatedString isEqualToString:@"ProfileImageUpDating"] && [[result valueForKey:@"code"] integerValue] == 121) {
            responceCount++;
            if (responceCount == totalCount) {
                [self showActivityIndicatorInPhotos:NO];
                
                [self performSelector:@selector(editOwnerProfileFirst:) withObject:nil];
                [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];

            }
        }else{
            if ([presentlyUpDatedString isEqualToString:@"OwnerProgileUpDating"] && [[result valueForKey:@"code"] integerValue] == 113) {
                [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
                [self performSelector:@selector(saveLoginDetailsInDBP:) withObject:[result valueForKey:@"data"] afterDelay:0.1f];
            }else{
                [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
            }
        }
    }
    
    
    else{
        [self showActivityIndicatorInPhotos:NO];
        [GlobalMethods showAlertwithTitle:AppTitle ErrorCode:[[result valueForKey:@"code"] integerValue]];
    }
    
        
        
        
        
    
    
}
-(void)dataDidFinihLoadingwithError:(NSString *)errorH{
    [self showActivityIndicatorInPhotos:NO];
    [self showActivityIndicatorInPhotos:NO];
    [GlobalMethods showAlertwithTitle:AppTitle andMessage:errorH];
}
-(void)editOwnerProfileFirst:(id)sender {
    [self showActivityIndicatorInPhotos:YES];

    presentlyUpDatedString =@"OwnerProgileUpDating";

    NSMutableDictionary *paramDict=[[NSMutableDictionary alloc]init];
    [paramDict setObject:appDel.CurrentOwnerDetails.owner_accessToken forKey:@"accessToken"];
    [webParser parserPostMethodWithParameters:paramDict andExtendUrl:@"editOwnerProfile"];
}

-(void)saveLoginDetailsInDBP:(NSDictionary *)result{
    
    
    
    NSMutableDictionary *dict=[[NSMutableDictionary alloc]initWithDictionary:[result valueForKey:@"profile"]];
    [dict setObject:[result valueForKey:@"accessToken"] forKey:@"accessToken"];
    
    
    for (NSString * key in [dict allKeys])
    {
        if ([[dict objectForKey:key] isKindOfClass:[NSNull class]])
            [dict setObject:@"" forKey:key];
    }
    
    [appDel ownerProfileUpDateWithResult:dict];
    
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"OwnerProfile"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    
    [self viewDidLoad];
    [self showActivityIndicatorInPhotos:NO];

    [self performSelector:@selector(backbuttonAction:) withObject:nil];
    
}

#pragma mark
#pragma mark - CustomActivityIndicator Delegate
-(void)showActivityIndicatorInPhotos:(BOOL)myBool{
    if (myBool) {
        if(hud != nil)
        {
            [self.view addSubview:hud];
            hud = nil;
        }
        
        
        if(hud==nil)
        {
            hud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
            hud.delegate = self;
            [hud show:YES];
            [self.view addSubview:hud];
        }
    }
    else{
        [hud hide:YES];
    }
}

-(void)goToSignInViewLogout{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"LoginE_PProfile"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"OwnerProfile"];
    [appDel clearOwnerProfileClass];
    
    [self performSegueWithIdentifier:@"goToSignInV" sender:self];
    
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.view endEditing:YES];
    
    if ([segue.identifier isEqualToString:@"goToAddDishView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToOrdersView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToDishesView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReviewsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToReportsView"]){
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goTosettingsView"]) {
        [segue destinationViewController];
    }else if ([segue.identifier isEqualToString:@"goToSignInV"]) {
        [segue destinationViewController];
    }
    
}


@end
