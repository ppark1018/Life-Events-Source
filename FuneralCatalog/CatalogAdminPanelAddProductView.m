//
//  CatalogAdminPanelAddProductController.m
//  FuneralCatalog
//
//  Created by Paul Park on 3/9/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "CatalogAdminPanelAddProductView.h"
#import "CatalogAppDelegate.h"
#import "Category.h"
#import "Product.h"
#import "CatalogAdminEditPanelSubview.h"

@implementation CatalogAdminPanelAddProductView

@synthesize popupState;
@synthesize addProductButton;
@synthesize cancelButton;
@synthesize saveButton;
@synthesize productScrollView;
@synthesize productNameField;
@synthesize productImageField;
@synthesize mainView;
@synthesize visibilityButton;
@synthesize visibilityState;
@synthesize productEditIndex;
@synthesize isEditing;
@synthesize customFieldsArray;

CGFloat pScrollObjHeight = 150;
CGFloat pScrollObjWidth = 200;

- (IBAction)addProductRequest
{
    isEditing = 0;
    [self populateSelection];
    if (popupState == 0)
    {
        // Move the panel down.
        popupState = 1;
        // The drawer is "closed"
        // We want to "open" it.
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect currPaneRect = [self frame];
                             currPaneRect.origin.y += 150;
                             [self setFrame:currPaneRect];
                             CGRect currProdRect = [mainView frame];
                             currProdRect.origin.y += 150;
                             [mainView setFrame:currProdRect];
                         }
                         completion:^(BOOL finished){
                             if(finished){
                                 popupState = 1; // The drawer is now "open".
                             }
                         }];
    }
}

- (IBAction)cancelProductRequest
{
    if (popupState == 1)
    {
        // Move the panel up.
        // The drawer is "open"
        // We want to "close" it.
        CGRect currPaneRect = [self frame];
        currPaneRect.origin.y -= 150;
        CGRect currProdRect = [mainView frame];
        currProdRect.origin.y -= 150;
        [UIView animateWithDuration:0.5 animations:^{
            [self setFrame:currPaneRect];
            [mainView setFrame:currProdRect];
        }
                         completion:^(BOOL finished){
                             if (finished)
                             {
                                 popupState = 0; // The drawer is now "closed".
                             }
                         }];
    }
}

- (IBAction)saveToTable
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    Product *product;
    if (isEditing == 0)
    {
        product = [[Product alloc] init];
        [product initialize];
    }
    else // Edit mode
    {
        product = [appDelegate.dataArray objectAtIndex:productEditIndex];
    }
    
    product.productName = productNameField.text;
    product.visibleState = visibilityState;
    // Get image from URL if one hasn't been chosen from the album.
    if (appDelegate.currentImage == NULL)
    {
        product.productImageURL = productImageField.text;
        
        NSURL *imageURL = [NSURL URLWithString:product.productImageURL];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        product.productImage = image;
    }
    else
    {
        product.productImageURL = productImageField.text;
        product.productImage = appDelegate.currentImage;
        
        appDelegate.currentImage = NULL;
        productImageField.text = @"";
    }
    
    // Get additional fields and assign them to this product.
    NSArray *subviews = [productScrollView subviews];
    UIView *view = nil;
    int count = [appDelegate.fieldArray count];
    
    if (isEditing == 1)
    {
        product.propertyArray = [[NSMutableArray alloc]init];
    }
    
    for (int i = 0; i < count; i++)
    {
        Category *categoryTemp = [[Category alloc]init];
        for (view in subviews)
        {
            if ([view isKindOfClass:[UITextField class]] && view.tag == i)
            {
                UITextField *textField = (UITextField*)view;
                categoryTemp.valueString = textField.text;
            }
            
            if ([view isKindOfClass:[UILabel class]] && view.tag == i)
            {
                UILabel *label = (UILabel*)view;
                categoryTemp.categoryName = label.text;
            }
        }
        [product.propertyArray addObject:categoryTemp];
    }
    
    if (isEditing == 0)
    {
        [appDelegate.dataArray addObject:product];
    }
    // Clear out fields after adding a product.
    productNameField.text = @"";
    for (view in subviews)
    {
        if ([view isKindOfClass:[UITextField class]])
             {
                 UITextField *textField = (UITextField*)view;
                 textField.text = @"";
             }
    }
    isEditing = 0;
    CatalogAdminEditPanelSubview *panelControl = (CatalogAdminEditPanelSubview*)mainView;
    [panelControl refreshTable];
    
}

- (IBAction)visibilityToggle
{
    if (visibilityState == 1)
    {
        // Set to no.
        [visibilityButton setSelected:TRUE];
        visibilityState = 0;
    }
    else
    {
        // Set to yes.
        [visibilityButton setSelected:FALSE];
        visibilityState = 1;
    }
}

- (void)clearEditing
{
    isEditing = 0;
}

- (void)prepareLayoutForSelection
{
    NSArray *subviews = [productScrollView subviews];
    UIView *view = nil;
    
    for (view in subviews)
    {
        if ([view isKindOfClass:[UITextField class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake((pScrollObjWidth + 20) * view.tag + 20 + 610, 59);
            view.frame = frame;
        }
        
        if ([view isKindOfClass:[UILabel class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake((pScrollObjWidth + 20) * view.tag + 20 + 610, 20);
            view.frame = frame;
        }
    }
}

- (void)populateSelection
{
    // Clear all subviews every method call.
    //for (int i = 0; i < [[selectionPanelScrollView subviews] count]; i++ ) {
    //    [[[selectionPanelScrollView subviews] objectAtIndex:0] removeFromSuperview];
    //}
    if (customFieldsArray == nil)
    {
        customFieldsArray = [[NSMutableArray alloc] init];
    }
    
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    int count = [appDelegate.fieldArray count];
    [productScrollView setContentSize:CGSizeMake((count * pScrollObjWidth + 40 + 610),[productScrollView bounds].size.height)];
    for (UIView *thisView in customFieldsArray)
    {
        [thisView removeFromSuperview];
    }
    [customFieldsArray removeAllObjects];
    
    for (int i = 0; i < count; i++)
    {
        Category *category = [appDelegate.fieldArray objectAtIndex:i];
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        CGRect rect = field.frame;
        rect.size.height = 31;
        rect.size.width = pScrollObjWidth;
        field.frame = rect;
        field.textColor = [UIColor blackColor];
        field.font = [UIFont boldSystemFontOfSize:13.0];
        [field setBorderStyle:UITextBorderStyleRoundedRect];
        [field setTextAlignment:UITextAlignmentLeft];
        [field setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        if ([category.categoryType isEqualToString:@"Price"])
        {
            field.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        }
        field.tag = i;
        
        CGRect labelRect= label.frame;
        labelRect.size.height = 20;
        labelRect.size.width = pScrollObjWidth;
        label.frame = labelRect;
        
        label.text = category.categoryName;
        label.numberOfLines = 1;
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:17.0];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor grayColor];
        
        label.tag = i;
        
        
        [productScrollView addSubview:field];
        [productScrollView addSubview:label];
        [customFieldsArray addObject:field];
        [customFieldsArray addObject:label];
        
    }
    
    [self prepareLayoutForSelection];
    
}

- (void)initCustom
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    popupState = 0;
    isEditing = 0;
    productEditIndex = 0;
    [self populateSelection];
    appDelegate.addProductView = self;
}


// Request for the add product panel to be opened and fill in the settings from the chosen product for editing.
- (void)editProduct:(Product*)product
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    [self addProductRequest];
    
    productNameField.text = product.productName;
    productImageField.text = product.productImageURL;
    
    if (product.visibleState == 1)
    {
        visibilityState = 1;
        [visibilityButton setSelected:FALSE];
    }
    else
    {
        visibilityState = 0;
        [visibilityButton setSelected:TRUE];
    }
    
    if ([productImageField.text isEqualToString:@"(Using Image From Album)"])
    {
        appDelegate.currentImage = product.productImage;
    }
    
    isEditing = 1;
    
    NSArray *subviews = [productScrollView subviews];
    UIView *view = nil;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UITextField class]] && view.tag >= 0)
        {
            Category *category = [product.propertyArray objectAtIndex:view.tag];
            UITextField *textField = (UITextField*)view;
            textField.text = category.valueString;
        }
    }
}



@end
