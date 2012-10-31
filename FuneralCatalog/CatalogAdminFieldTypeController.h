//
//  CatalogAdminFieldTypeController.h
//  FuneralCatalog
//
//  Created by Paul Park on 4/2/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogAdminFieldTypeController : UIViewController
{
    IBOutlet UIButton *standardButton;
    IBOutlet UIButton *priceButton;
}

@property (nonatomic, retain) IBOutlet UIButton *standardButton;
@property (nonatomic, retain) IBOutlet UIButton *priceButton;

-(IBAction)selectStandard;
-(IBAction)selectPrice;

@end
