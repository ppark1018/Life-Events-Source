//
//  CatalogAdminIntroEditViewController.h
//  FuneralCatalog
//
//  Created by Paul Park on 8/8/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface CatalogAdminIntroEditViewController : UIViewController
{
    IBOutlet UIImageView *imageView1;
    IBOutlet UIImageView *imageView2;
    IBOutlet UIImageView *imageView3;
    IBOutlet UITextField *image1URLField;
    IBOutlet UITextField *image2URLField;
    IBOutlet UITextField *image3URLField;
    IBOutlet UIButton *imageView1PickerButton;
    IBOutlet UIButton *imageView2PickerButton;
    IBOutlet UIButton *imageView3PickerButton;
    IBOutlet UIButton *imageView1URLButton;
    IBOutlet UIButton *imageView2URLButton;
    IBOutlet UIButton *imageView3URLButton;
    IBOutlet UIButton *videoButton;
    
    UIImagePickerController *imagePicker;
    UIPopoverController *imagePopupController;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView1;
@property (nonatomic, retain) IBOutlet UIImageView *imageView2;
@property (nonatomic, retain) IBOutlet UIImageView *imageView3;
@property (nonatomic, retain) IBOutlet UITextField *image1URLField;
@property (nonatomic, retain) IBOutlet UITextField *image2URLField;
@property (nonatomic, retain) IBOutlet UITextField *image3URLField;
@property (nonatomic, retain) IBOutlet UIButton *imageView1PickerButton;
@property (nonatomic, retain) IBOutlet UIButton *imageView2PickerButton;
@property (nonatomic, retain) IBOutlet UIButton *imageView3PickerButton;
@property (nonatomic, retain) IBOutlet UIButton *imageView1URLButton;
@property (nonatomic, retain) IBOutlet UIButton *imageView2URLButton;
@property (nonatomic, retain) IBOutlet UIButton *imageView3URLButton;
@property (nonatomic, retain) IBOutlet UIButton *videoButton;
@property (nonatomic, retain) UIImagePickerController *imagePicker;
@property (nonatomic, retain) UIPopoverController *imagePopupController;

-(IBAction)changeImage1URL;
-(IBAction)changeImage2URL;
-(IBAction)changeImage3URL;
-(IBAction)setIDImage1;
-(IBAction)setIDImage2;
-(IBAction)setIDImage3;
-(IBAction)setIDVideo;
-(IBAction)changeImageFromPicker;

@end
