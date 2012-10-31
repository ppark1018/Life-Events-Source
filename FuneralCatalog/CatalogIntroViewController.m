//
//  CatalogIntroViewController.m
//  FuneralCatalog
//
//  Created by Paul Park on 2/20/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "CatalogAppDelegate.h"
#import "CatalogIntroViewController.h"

@implementation CatalogIntroViewController

@synthesize imageView1;
@synthesize imageView2;
@synthesize imageView3;
@synthesize movieController;

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    [super viewDidLoad];
    
    if ([appDelegate.introDataArray objectAtIndex:1] != [NSNull null])
    {
        [imageView1 setImage:[appDelegate.introDataArray objectAtIndex:1] forState:UIControlStateNormal];
    }
    
    if ([appDelegate.introDataArray objectAtIndex:2] != [NSNull null])
    {
        [imageView2 setImage:[appDelegate.introDataArray objectAtIndex:2] forState:UIControlStateNormal];
    }
    
    if ([appDelegate.introDataArray objectAtIndex:3] != [NSNull null])
    {
        [imageView3 setImage:[appDelegate.introDataArray objectAtIndex:3] forState:UIControlStateNormal];
    }

    if (appDelegate.moviePath == [NSNull null])
    {
        appDelegate.moviePath = [[NSBundle mainBundle] pathForResource:@"movie" ofType:@"mp4"];
    }
    else
    {
        appDelegate.moviePath = [appDelegate.introDataArray objectAtIndex:0];
    }
    
    movieController = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:appDelegate.moviePath]];
    movieController.controlStyle = MPMovieControlStyleEmbedded;
    
    [movieController prepareToPlay];
    [movieController play];
    [self.view addSubview:movieController.view];
    
    movieController.view.frame = CGRectMake(0,0, 1024, 420);
    appDelegate.introViewController = self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [movieController stop];
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
