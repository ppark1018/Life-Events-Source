//
//  CatalogAdminEditPanelSubview.h
//  FuneralCatalog
//
//  Created by Paul Park on 2/26/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CatalogAdminEditPanelSubview : UIView
{
    // Deprecated stuff
    IBOutlet UITableView *categoryTable;
    IBOutlet UIView *categoryPopupPanel;
    IBOutlet UIButton *closePopupPanelButton;
    
    IBOutlet UITextField *categoryNameField;
    IBOutlet UITextField *categoryValueField;
    
    int popupState;
    
    // What we need...
    IBOutlet UIButton *templateLabel;
    IBOutlet UIView *addView;
    
    IBOutlet UIScrollView *tableScrollView;
    
    int endX; // Where the X coord ends in the scroll view... for remove button.
}

@property (nonatomic, retain) IBOutlet UITableView *categoryTable;
@property (nonatomic, retain) IBOutlet UIView *categoryPopupPanel;
@property (nonatomic, retain) IBOutlet UIButton *closePopupPanelButton;
@property (nonatomic) int popupState;

@property (nonatomic, retain) IBOutlet UITextField *categoryNameField;
@property (nonatomic, retain) IBOutlet UITextField *categoryValueField;

// What we need...
@property (nonatomic, retain) IBOutlet UIButton *templateLabel;
@property (nonatomic, retain) IBOutlet UIButton *templateCell;
@property (nonatomic, retain) IBOutlet UIScrollView *tableScrollView;
@property (nonatomic, retain) IBOutlet UIView *addView;
@property (nonatomic) int endX;

- (IBAction)addCategory;
- (IBAction)closePopupPanel;
- (void)copyButtonSettingsFrom:(UIButton*)templateButton toButton:(UIButton*)targetButton;
- (void)populateHeaders;
- (void)refreshTable;
- (void)removeProduct:(id)sender;
- (void)editProduct:(id)sender;
@end
