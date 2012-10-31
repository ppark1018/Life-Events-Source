//
//  CatalogAdminEditViewController.m
//  FuneralCatalog
//
//  Created by Paul Park on 2/21/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "CatalogAppDelegate.h"
#import "CatalogAdminEditViewController.h"
#import "CatalogAdminEditPanelSubview.h"
#import "CatalogAdminPanelAddProductView.h"
#import "Product.h"
#import "Category.h"

@implementation CatalogAdminEditViewController

@synthesize popupButton;
@synthesize popupPanel;
@synthesize popupState;
@synthesize selectedProductIndexPath;
@synthesize mainView;
@synthesize addButton;
@synthesize adminTable;

// Product Name Field
@synthesize productNameField;
@synthesize productNameCheck;

// Product Image Field
@synthesize productImageCheck;
@synthesize productImageURLField;
@synthesize imagePicker;
@synthesize imagePopupController;

// Field Panel
@synthesize fieldPanel;
@synthesize fieldState;
@synthesize fieldText;
@synthesize fieldConfirmButton;
@synthesize fieldCancelButton;
@synthesize fieldTypeText;
@synthesize fieldTypeButton;

// Add Product Panel
@synthesize addProductPanel;

int editFieldState = 0;
int editFieldRow = 0;

- (IBAction)popup
{
    switch (popupState)
    {
        case 0:
        {
            // The drawer is "closed"
            // We want to "open" it.
            [UIView animateWithDuration:0.5
                             animations:^{
                                 CGRect currPaneRect = [[self popupPanel] frame];
                                 currPaneRect.origin.x += 423 - 50;
                                 [[self popupPanel] setFrame:currPaneRect];
                                 CGRect currMainRect = [[self mainView] frame];
                                 currMainRect.origin.x += 423 - 50;
                                 [[self mainView] setFrame:currMainRect];
                                 CGRect currProdRect = [[self addProductPanel] frame];
                                 currProdRect.origin.x += 423 - 50;
                                 [[self addProductPanel] setFrame:currProdRect];             
                             }
                             completion:^(BOOL finished){
                                 if(finished){
                                     popupState = 1; // The drawer is now "open".
                                 }
                             }];
        }
            break;
        case 1:
        {
            // The drawer is "open"
            // We want to "close" it.
            CGRect currPaneRect = [[self popupPanel] frame];
            currPaneRect.origin.x -= 423 - 50;
            CGRect currMainRect = [[self mainView] frame];
            currMainRect.origin.x -= 423 - 50;
            CGRect currProdRect = [[self addProductPanel] frame];
            currProdRect.origin.x -= 423 - 50;
            [UIView animateWithDuration:0.5 animations:^{
                [[self popupPanel] setFrame:currPaneRect];
                [[self mainView] setFrame:currMainRect];
                [[self addProductPanel] setFrame:currProdRect];
            }
                             completion:^(BOOL finished){
                                 if (finished)
                                 {
                                     popupState = 0; // The drawer is now "closed".
                                 }
                             }];
        }
            break;
    }
}

/*  DEPRECATED FUNCTION
- (Product*)findProductWithIndex:(NSUInteger)index
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSMutableArray *dataArray = appDelegate.dataArray;
    
    Product *product = [dataArray objectAtIndex:index];
    return product;
    
}
*/

- (IBAction)addField
{
    if (fieldState == 0)
    {
    fieldText.text = @"";
    fieldTypeText.text = @"";
    fieldState = 1;
    // The drawer is "closed"
    // We want to "open" it.
    [UIView animateWithDuration:0.5
                     animations:^{
                         CGRect currPaneRect = [[self fieldPanel] frame];
                         currPaneRect.origin.y += 403;
                         [[self fieldPanel] setFrame:currPaneRect];
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             fieldState = 1; // The drawer is now "open".
                         }
                     }];
    }
}

- (void)editField
{
    if (fieldState == 0)
    {
        fieldState = 1;
        // The drawer is "closed"
        // We want to "open" it.
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect currPaneRect = [[self fieldPanel] frame];
                             currPaneRect.origin.y += 403;
                             [[self fieldPanel] setFrame:currPaneRect];
                         }
                         completion:^(BOOL finished){
                             if(finished){
                                 fieldState = 1; // The drawer is now "open".
                             }
                         }];
    }
    
    if (editFieldState == 1)
    {
        CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
        Category *category = [appDelegate.fieldArray objectAtIndex:editFieldRow];
        fieldText.text = category.categoryName;
        fieldTypeText.text = category.categoryType;
        appDelegate.fieldType = category.categoryType;
    }
}

- (IBAction)addFieldConfirm
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if (editFieldState == 0)
    {
    NSInteger arraySize = [adminTable numberOfRowsInSection:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:arraySize inSection:0];
    
    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath, nil];
    
    Category *category = [Category alloc];
    [category setCategoryName:fieldText.text];
    [appDelegate.fieldArray addObject:category];
    [category setCategoryType:appDelegate.fieldType];
    appDelegate.fieldType = @"";
    fieldTypeText.text = @"";
    
    [adminTable cellForRowAtIndexPath:indexPath];
    [adminTable numberOfRowsInSection:0];
    [adminTable insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    
    // Populate the products with this new category.
    NSInteger productCount = [appDelegate.dataArray count];
    for (int i = 0; i < productCount; i++)
    {
        Product *getProd = [appDelegate.dataArray objectAtIndex:i];
        [getProd.propertyArray addObject:category];
    }
    }
    else
    {
        Category *category = [appDelegate.fieldArray objectAtIndex:editFieldRow];
        [category setCategoryName:fieldText.text];
        [category setCategoryType:appDelegate.fieldType];
        appDelegate.fieldType = @"";
        fieldTypeText.text = @"";
        editFieldRow = 0;
        editFieldState = 0;
    }
    
    
    // The drawer is "open"
    // We want to "close" it.
    CGRect currPaneRect = [[self fieldPanel] frame];
    currPaneRect.origin.y -= 403;
    [UIView animateWithDuration:0.5 animations:^{
        [[self fieldPanel] setFrame:currPaneRect];
    }
                     completion:^(BOOL finished){
                         if (finished)
                         {
                             fieldState = 0; // The drawer is now "closed".
                         }
                     }];
    
    fieldText.text = @"";
    [adminTable reloadData];
    CatalogAdminEditPanelSubview *panelControl = (CatalogAdminEditPanelSubview*)mainView;
    [panelControl refreshTable];
    CatalogAdminPanelAddProductView *addProductView = appDelegate.addProductView;
    [addProductView populateSelection];
}

- (IBAction)addFieldCancel
{
    // The drawer is "open"
    // We want to "close" it.
    CGRect currPaneRect = [[self fieldPanel] frame];
    currPaneRect.origin.y -= 403;
    [UIView animateWithDuration:0.5 animations:^{
        [[self fieldPanel] setFrame:currPaneRect];
    }
                     completion:^(BOOL finished){
                         if (finished)
                         {
                             fieldState = 0; // The drawer is now "closed".
                         }
                     }];
    
    if (editFieldState == 1)
    {
        editFieldRow = 0;
        editFieldState = 0;
    }
}

- (IBAction)changeProductName
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if (appDelegate.chosenProduct != NULL)
    {
    Product *product = [appDelegate.dataArray objectAtIndex:selectedProductIndexPath.row];
    
    product.productName = productNameField.text;
    
    [adminTable reloadData];
    }
}

- (IBAction)changeImageURL
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if (appDelegate.chosenProduct != NULL)
    {
    Product *product = [appDelegate.dataArray objectAtIndex:selectedProductIndexPath.row];
    
    product.productImageURL = productImageURLField.text;
    
    NSURL *imageURL = [NSURL URLWithString:product.productImageURL];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    
    product.productImage = image;
    
    [productImagePreview setImage:image forState:UIControlStateNormal];
    }
}

- (IBAction)changeImageFromPicker // Using iPad album
{
    //CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    imagePicker = [[UIImagePickerController alloc]init];
    
    imagePicker.delegate = self;
    
/*    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
 */

    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
    imagePopupController = popover;
    [popover presentPopoverFromRect:CGRectMake(425, 0, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    appDelegate.currentImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //[productImagePreview setImage:product.productImage forState:UIControlStateNormal];
    
    [imagePopupController dismissPopoverAnimated:YES];
    
    CatalogAdminPanelAddProductView *panel = (CatalogAdminPanelAddProductView*)addProductPanel;
    panel.productImageField.text = @"(Using Image From Album)";
}

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

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    return [appDelegate.fieldArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    static NSString *CellID = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
        
    Category *category = [appDelegate.fieldArray objectAtIndex:indexPath.row];
    cell.textLabel.text = category.categoryName;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    editFieldState = 1;
    editFieldRow = indexPath.row;
    [self editField];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.chosenProduct = NULL;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        Category *category = [appDelegate.fieldArray objectAtIndex:indexPath.row];
        int count = [appDelegate.dataArray count];
        for (int i = 0; i < count; i++)
        {
            Product *product = [appDelegate.dataArray objectAtIndex:i];
            [product removeCategoryWithName:category.categoryName];
        }
        
        [appDelegate.fieldArray removeObjectAtIndex:indexPath.row];
        [adminTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [adminTable reloadData];
        CatalogAdminEditPanelSubview *panelControl = (CatalogAdminEditPanelSubview*)mainView;
        [panelControl refreshTable];
        CatalogAdminPanelAddProductView *addProductView = appDelegate.addProductView;
        [addProductView populateSelection];
    }   
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
    [super viewDidLoad];
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    appDelegate.editViewController = self;
    appDelegate.chosenProduct = NULL;
    appDelegate.chosenCategory = NULL;
    popupState = 0;
    fieldState = 0;
    CatalogAdminEditPanelSubview *panelControl = (CatalogAdminEditPanelSubview*)mainView;
    [panelControl refreshTable];
    CatalogAdminPanelAddProductView *addView = (CatalogAdminPanelAddProductView*)addProductPanel;
    addView.visibilityState = 1;
    [addView.visibilityButton setSelected:FALSE];
    CatalogAdminPanelAddProductView *addProductPanelRef = (CatalogAdminPanelAddProductView*)addProductPanel;
    [addProductPanelRef initCustom];
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
