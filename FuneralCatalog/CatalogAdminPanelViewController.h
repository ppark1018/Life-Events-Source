//
//  CatalogAdminPanelViewController.h
//  FuneralCatalog
//
//  Created by Paul Park on 2/18/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogAdminPanelViewController : UIViewController
{
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
    IBOutlet UIButton *okayButton;
}

@property (nonatomic, retain) UITextField *usernameField;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UIButton *okayButton;

- (IBAction)authenticate;

@end
