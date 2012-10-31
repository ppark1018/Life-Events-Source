//
//  CatalogIntroViewController.h
//  FuneralCatalog
//
//  Created by Paul Park on 2/20/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MPMoviePlayerController.h>

@interface CatalogIntroViewController : UIViewController
{
    MPMoviePlayerController *movieController;
    IBOutlet UIButton *imageView1;
    IBOutlet UIButton *imageView2;
    IBOutlet UIButton *imageView3;
}

@property (nonatomic, retain) IBOutlet UIButton *imageView1;
@property (nonatomic, retain) IBOutlet UIButton *imageView2;
@property (nonatomic, retain) IBOutlet UIButton *imageView3;
@property (nonatomic, retain) MPMoviePlayerController *movieController;

@end
