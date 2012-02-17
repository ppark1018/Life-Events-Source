//
//  CatalogDetailViewController.h
//  FuneralCatalog
//
//  Created by Paul Park on 2/17/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
