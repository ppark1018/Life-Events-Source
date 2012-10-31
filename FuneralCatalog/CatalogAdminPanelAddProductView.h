//
//  CatalogAdminPanelAddProductController.h
//  FuneralCatalog
//
//  Created by Paul Park on 3/9/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;

@interface CatalogAdminPanelAddProductView : UIView
{
    int popupState;
    int visibilityState;
    int isEditing;
    int productEditIndex;
    
    //Keep track of custom fields so that they won't be duplicated on add product request.
    NSMutableArray *customFieldsArray;
    
    IBOutlet UIView *mainView;
    
    IBOutlet UIButton *addProductButton;
    IBOutlet UIButton *saveButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UIButton *visibilityButton;
    IBOutlet UIScrollView *productScrollView;
    
    IBOutlet UITextField *productNameField;
    IBOutlet UITextField *productImageField;
}

@property (nonatomic) int popupState;
@property (nonatomic) int visibilityState;
@property (nonatomic) int isEditing;
@property (nonatomic) int productEditIndex;
@property (nonatomic, retain) IBOutlet UIView *mainView;
@property (nonatomic, retain) IBOutlet UIButton *addProductButton;
@property (nonatomic, retain) IBOutlet UIButton *saveButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) IBOutlet UIScrollView *productScrollView;
@property (nonatomic, retain) IBOutlet UITextField *productNameField;
@property (nonatomic, retain) IBOutlet UITextField *productImageField;
@property (nonatomic, retain) IBOutlet UIButton *visibilityButton;
@property (nonatomic, retain) NSMutableArray *customFieldsArray;

- (IBAction)addProductRequest;
- (IBAction)cancelProductRequest;
- (IBAction)saveToTable;
- (IBAction)visibilityToggle;
- (void)populateSelection;
- (void)editProduct:(Product*)product;
- (void)clearEditing;
- (void)initCustom;


@end
