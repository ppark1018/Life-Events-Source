//
//  CatalogAdminEditViewController.h
//  FuneralCatalog
//
//  Created by Paul Park on 2/21/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CatalogAdminEditPanelSubview;

@interface CatalogAdminEditViewController : UIViewController
{
    IBOutlet UIButton *popupButton;
    IBOutlet UIView *popupPanel;
    IBOutlet UIView *mainView;
    IBOutlet UITableView *adminTable;
    
    IBOutlet UIButton *addButton;
    
    // Product Name Field
    IBOutlet UITextField *productNameField;
    IBOutlet UIButton *productNameCheck;
    
    // Product Image Field
    IBOutlet UITextField *productImageURLField;
    IBOutlet UIButton *productImageCheck;
    IBOutlet UIButton *productImagePreview;
    UIImagePickerController *imagePicker;
    UIPopoverController *imagePopupController;
    
    int popupState;
    NSIndexPath *selectedProductIndexPath;
    
    // Field Panel
    IBOutlet UIView *fieldPanel;
    IBOutlet UITextField *fieldText;
    int fieldState;
    IBOutlet UIButton *fieldTypeButton;
    IBOutlet UITextField *fieldTypeText;
    
    // Add Product Panel
    IBOutlet UIView *addProductPanel;
}

@property (nonatomic, retain) IBOutlet UIButton *popupButton;
@property (nonatomic, retain) IBOutlet UIView *popupPanel;
@property (nonatomic, retain) IBOutlet UIView *mainView;
@property (nonatomic, retain) IBOutlet UITableView *adminTable;
@property (nonatomic, retain) IBOutlet UIButton *addButton;

// Product Name Field
@property (nonatomic, retain) IBOutlet UITextField *productNameField;
@property (nonatomic, retain) IBOutlet UIButton *productNameCheck;

// Product Image Field
@property (nonatomic, retain) IBOutlet UITextField *productImageURLField;
@property (nonatomic, retain) IBOutlet UIButton *productImageCheck;
@property (nonatomic, retain) IBOutlet UIButton *productImagePreview;
@property (nonatomic, retain) UIImagePickerController *imagePicker;
@property (nonatomic, retain) UIPopoverController *imagePopupController;

// Field Panel
@property (nonatomic, retain) IBOutlet UIView *fieldPanel;
@property (nonatomic) int fieldState;
@property (nonatomic, retain) IBOutlet UITextField *fieldText;
@property (nonatomic, retain) IBOutlet UITextField *fieldTypeText;
@property (nonatomic, retain) IBOutlet UIButton *fieldTypeButton;
@property (nonatomic, retain) IBOutlet UIButton *fieldConfirmButton;
@property (nonatomic, retain) IBOutlet UIButton *fieldCancelButton;

// Add Product Panel
@property (nonatomic, retain) IBOutlet UIView *addProductPanel;

@property (nonatomic) int popupState;
@property (nonatomic, retain) NSIndexPath *selectedProductIndexPath;

- (IBAction)popup;
- (IBAction)addField;
- (IBAction)addFieldConfirm;
- (IBAction)addFieldCancel;
- (IBAction)changeProductName;
- (IBAction)changeImageURL;
- (void)editField;

@end
