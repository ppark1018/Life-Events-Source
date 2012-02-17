//
//  CatalogMasterViewController.h
//  FuneralCatalog
//
//  Created by Paul Park on 2/17/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CatalogDetailViewController;

@interface CatalogMasterViewController : UITableViewController

@property (strong, nonatomic) CatalogDetailViewController *detailViewController;

@end
