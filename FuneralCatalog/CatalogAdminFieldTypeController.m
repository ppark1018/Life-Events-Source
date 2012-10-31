//
//  CatalogAdminFieldTypeController.m
//  FuneralCatalog
//
//  Created by Paul Park on 4/2/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "CatalogAdminFieldTypeController.h"
#import "CatalogAdminEditViewController.h"
#import "CatalogAppDelegate.h"

@implementation CatalogAdminFieldTypeController

@synthesize standardButton;
@synthesize priceButton;

- (IBAction)selectStandard
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.fieldType = @"Standard";
    appDelegate.editViewController.fieldTypeText.text = @"Standard";
}

- (IBAction)selectPrice
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.fieldType = @"Price";
    appDelegate.editViewController.fieldTypeText.text = @"Price";
}

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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
