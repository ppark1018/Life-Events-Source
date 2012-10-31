//
//  CatalogAdminIntroEditViewController.m
//  FuneralCatalog
//
//  Created by Paul Park on 8/8/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "CatalogAdminIntroEditViewController.h"
#import "CatalogIntroViewController.h"
#import "CatalogAppDelegate.h"

@implementation CatalogAdminIntroEditViewController

@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;
@synthesize image1URLField;
@synthesize image2URLField;
@synthesize image3URLField;
@synthesize imagePicker;
@synthesize imagePopupController;
@synthesize imageView1PickerButton;
@synthesize imageView2PickerButton;
@synthesize imageView3PickerButton;
@synthesize imageView1URLButton;
@synthesize imageView2URLButton;
@synthesize imageView3URLButton;
@synthesize videoButton;

int buttonID = 0;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (IBAction)changeImage1URL
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSURL *imageURL = [NSURL URLWithString:image1URLField.text];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    imageView1.image = image;
    [appDelegate.introViewController.imageView1.imageView setImage:image];
}

- (IBAction)changeImage2URL
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSURL *imageURL = [NSURL URLWithString:image2URLField.text];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    imageView2.image = image;
    [appDelegate.introViewController.imageView2.imageView setImage:image];
}

- (IBAction)changeImage3URL
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    NSURL *imageURL = [NSURL URLWithString:image3URLField.text];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    imageView3.image = image;
    [appDelegate.introViewController.imageView3.imageView setImage:image];
}

// Assigns ID to the view controller so that imagePicker knows which buttons are being called for.
// 1 - Bottom Left Image
// 2 - Bottom Center Image
// 3 - Bottom Right Image
// 4 - Video
- (IBAction)setIDImage1
{
    buttonID = 1;
}

- (IBAction)setIDImage2
{
    buttonID = 2;
}

- (IBAction)setIDImage3
{
    buttonID = 3;
}

- (IBAction)setIDVideo
{
    buttonID = 4;
}

- (IBAction)changeImageFromPicker // Using iPad album
{
    //CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    imagePicker = [[UIImagePickerController alloc]init];
    
    imagePicker.delegate = self;
    
    /*    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
     {
     imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
     }
     
     else
     {
     imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     }
     */
    
    switch (buttonID)
    {
        case 1: //BL Image
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            imagePopupController = popover;
            [popover presentPopoverFromRect:CGRectMake(50, 400, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
            
        }
            break;
        case 2: //BC Image
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            imagePopupController = popover;
            [popover presentPopoverFromRect:CGRectMake(400, 400, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
            
        }
            break;
        case 3: //BR Image
        {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            imagePopupController = popover;
            [popover presentPopoverFromRect:CGRectMake(740, 400, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        }
            break;
        case 4: //Video
        {
            imagePicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString *)kUTTypeMovie, nil];
            imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
            imagePopupController = popover;
            [popover presentPopoverFromRect:CGRectMake(450, 100, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
    }
    
    
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    switch (buttonID)
    {
        case 1:
        {
            imageView1.image = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImage *tempImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            [appDelegate.introDataArray replaceObjectAtIndex:1 withObject:tempImage];
        }
            break;
        case 2:
        {
            imageView2.image = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImage *tempImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            [appDelegate.introDataArray replaceObjectAtIndex:2 withObject:tempImage];
        }
            break;
        case 3:
        {
            imageView3.image = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImage *tempImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            [appDelegate.introDataArray replaceObjectAtIndex:3 withObject:tempImage];
        }
            break;
        case 4:
        {
            NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
            [appDelegate.introDataArray replaceObjectAtIndex:0 withObject:moviePath];
        }
    }
    
    //[productImagePreview setImage:product.productImage forState:UIControlStateNormal];
    
    [imagePopupController dismissPopoverAnimated:YES];
    
    
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    if ([appDelegate.introDataArray objectAtIndex:1] != [NSNull null])
    {
        [imageView1 setImage:[appDelegate.introDataArray objectAtIndex:1]];
    }
    
    if ([appDelegate.introDataArray objectAtIndex:2] != [NSNull null])
    {
        [imageView2 setImage:[appDelegate.introDataArray objectAtIndex:2]];
    }
    
    if ([appDelegate.introDataArray objectAtIndex:3] != [NSNull null])
    {
        [imageView3 setImage:[appDelegate.introDataArray objectAtIndex:3]];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

@end
