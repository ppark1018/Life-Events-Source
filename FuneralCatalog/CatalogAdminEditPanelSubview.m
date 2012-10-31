//
//  CatalogAdminEditPanelSubview.m
//  FuneralCatalog
//
//  Created by Paul Park on 2/26/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "CatalogAppDelegate.h"
#import "CatalogAdminEditPanelSubview.h"
#import "CatalogAdminPanelAddProductView.h"
#import "Product.h"
#import "Category.h"

@implementation CatalogAdminEditPanelSubview

@synthesize categoryTable;
@synthesize categoryPopupPanel;
@synthesize closePopupPanelButton;
@synthesize popupState;

@synthesize categoryNameField;
@synthesize categoryValueField;

@synthesize templateLabel;
@synthesize templateCell;
@synthesize tableScrollView;
@synthesize addView;
@synthesize endX;

CGFloat cScrollObjHeight = 35;
CGFloat cScrollObjWidth = 300;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        popupState = 0;
        [self refreshTable];
    }
    return self;
}

- (void)prepareHeaderLayoutForSelection
{
    NSArray *subviews = [tableScrollView subviews];
    UIView *view = nil;
    
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIButton class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake((cScrollObjWidth) * view.tag + 800, 20);
            view.frame = frame;
        }
    }
}

- (void)populateHeaders
{
    // Clear all subviews every method call.
    //for (int i = 0; i < [[selectionPanelScrollView subviews] count]; i++ ) {
    //    [[[selectionPanelScrollView subviews] objectAtIndex:0] removeFromSuperview];
    //}
    
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    int count = [appDelegate.fieldArray count];
    int countProd = [appDelegate.dataArray count];
    endX = count * cScrollObjWidth + 800;
    [tableScrollView setContentSize:CGSizeMake(endX + 80 ,200 + (countProd * cScrollObjHeight))];
    
    int endCount = 0;
    // Populate additional field headers.
    for (int i = 0; i < count; i++)
    {
        Category *category = [appDelegate.fieldArray objectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect rect = button.frame;
        rect.size.height = 35;
        rect.size.width = cScrollObjWidth;
        rect.origin = CGPointMake((cScrollObjWidth) * i + 800, 20);
        button.frame = rect;
        button.titleLabel.frame = rect;
        button.titleLabel.textColor = templateLabel.titleLabel.textColor;
        button.titleLabel.font = templateLabel.titleLabel.font;
        [button setBackgroundImage:templateLabel.currentBackgroundImage forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:templateLabel.titleLabel.textAlignment];
        [button setContentVerticalAlignment:templateLabel.contentVerticalAlignment];
        
        [button setTitle:category.categoryName forState:UIControlStateNormal];
        
        button.tag = i;
        
        [tableScrollView addSubview:button];
        
        endCount = i;
    }
    
    endCount++;
    
    // Add headers for edit and delete buttons, too.
    for (int i = 0; i < 2; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect rect = button.frame;
        rect.size.height = 35;
        rect.size.width = 34;
        rect.origin = CGPointMake((cScrollObjWidth) * endCount + 800 + (35 * i), 20);
        button.frame = rect;
        button.titleLabel.frame = rect;
        button.titleLabel.textColor = templateLabel.titleLabel.textColor;
        button.titleLabel.font = templateLabel.titleLabel.font;
        [button setBackgroundImage:templateLabel.currentBackgroundImage forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:templateLabel.titleLabel.textAlignment];
        [button setContentVerticalAlignment:templateLabel.contentVerticalAlignment];
        
        button.tag = endCount + i;
        [tableScrollView addSubview:button];
    }
    
           
}

- (void)copyButtonSettingsFrom:(UIButton*)templateButton toButton:(UIButton*)targetButton
{
    [targetButton setTitleColor:templateButton.titleLabel.textColor forState:UIControlStateNormal];
    [targetButton.titleLabel setFont:templateButton.titleLabel.font];
    [targetButton setBackgroundImage:templateButton.currentBackgroundImage forState:UIControlStateNormal];
    [targetButton.titleLabel setTextAlignment:templateButton.titleLabel.textAlignment];
    [targetButton setContentVerticalAlignment:templateButton.contentVerticalAlignment];
}

- (void)deleteCancel:(NSTimer*)timer
{
    UIButton *senderButton = (UIButton*)[timer userInfo];
    [senderButton setSelected:FALSE];
}

- (void)removeProduct:(id)sender
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    UIButton *senderButton = (UIButton*)sender;
    int index = senderButton.tag;
    if (senderButton.selected == FALSE)
    {
        [senderButton setSelected:TRUE];
        [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(deleteCancel:) userInfo:senderButton repeats:NO];
    }
    else
    {
        CatalogAdminPanelAddProductView *addPanel = (CatalogAdminPanelAddProductView*)addView;
        [addPanel clearEditing];
        [appDelegate.dataArray removeObjectAtIndex:index];
        [self refreshTable];
    }
}

- (void)editProduct:(id)sender
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    UIButton *senderButton = (UIButton*)sender;
    int index = senderButton.tag;
    Product *product = [appDelegate.dataArray objectAtIndex:index];
    CatalogAdminPanelAddProductView *addPanel = (CatalogAdminPanelAddProductView*)addView;
    [addPanel setProductEditIndex:index];
    [addPanel editProduct:product];
}

- (void)populateTable
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    int productCount = [appDelegate.dataArray count];
    // Populate products.
    for (int i = 0; i < productCount; i++)
    {
        Product *product = [appDelegate.dataArray objectAtIndex:i];
        
        // Populate ID.
        UIButton *IDButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect rect = IDButton.frame;
        rect.size.height = 35;
        rect.size.width = 100;
        rect.origin = CGPointMake(0, 55 + (35 * i));
        IDButton.frame = rect;
        IDButton.titleLabel.frame = rect;
        [self copyButtonSettingsFrom:templateCell toButton:IDButton];
        [IDButton setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        IDButton.tag = i;
        [tableScrollView addSubview:IDButton];
        
        // Populate product name.
        UIButton *nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rect = nameButton.frame;
        rect.size.height = 35;
        rect.size.width = 300;
        rect.origin = CGPointMake(100, 55 + (35 * i));
        nameButton.frame = rect;
        nameButton.titleLabel.frame = rect;
        [self copyButtonSettingsFrom:templateCell toButton:nameButton];
        [nameButton setTitle:product.productName forState:UIControlStateNormal];
        nameButton.tag = i;
        [tableScrollView addSubview:nameButton];
        
        // Populate product URL.
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rect = imageButton.frame;
        rect.size.height = 35;
        rect.size.width = 300;
        rect.origin = CGPointMake(400, 55 + (35 * i));
        imageButton.frame = rect;
        imageButton.titleLabel.frame = rect;
        [self copyButtonSettingsFrom:templateCell toButton:imageButton];
        [imageButton setTitle:product.productImageURL forState:UIControlStateNormal];
        imageButton.tag = i;
        [tableScrollView addSubview:imageButton];
        
        // Populate product visibility.
        UIButton *visibilityButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rect = visibilityButton.frame;
        rect.size.height = 35;
        rect.size.width = 100;
        rect.origin = CGPointMake(700, 55 + (35 * i));
        visibilityButton.frame = rect;
        visibilityButton.titleLabel.frame = rect;
        [self copyButtonSettingsFrom:templateCell toButton:visibilityButton];
        [visibilityButton setTitle:product.returnVisibility forState:UIControlStateNormal];
        visibilityButton.tag = i;
        [tableScrollView addSubview:visibilityButton];
        
        // Populate additional fields.
        int fieldCount = [product.propertyArray count];
        for (int ii = 0; ii < fieldCount; ii++)
        {
            Category *categoryForField = [product.propertyArray objectAtIndex:ii];
            UIButton *fieldButton = [UIButton buttonWithType:UIButtonTypeCustom];
            rect = fieldButton.frame;
            rect.size.height = 35;
            rect.size.width = 300;
            rect.origin = CGPointMake(800 + (300 * ii), 55 + (35 * i));
            fieldButton.frame = rect;
            fieldButton.titleLabel.frame = rect;
            [self copyButtonSettingsFrom:templateCell toButton:fieldButton];
            [fieldButton setTitle:categoryForField.valueString forState:UIControlStateNormal];
            fieldButton.tag = i;
            [tableScrollView addSubview:fieldButton];
        }
        
        // Edit Product Button.
        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rect = editButton.frame;
        rect.size.height = 35;
        rect.size.width = 35;
        rect.origin = CGPointMake(endX, 55 + (35 * i));
        editButton.frame = rect;
        editButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [editButton setImage:[UIImage imageNamed:@"admin-field-edit.png"] forState:UIControlStateNormal];
        editButton.tag = i;
        [editButton addTarget:self action:@selector(editProduct:) forControlEvents:UIControlEventTouchUpInside];
        [self copyButtonSettingsFrom:templateCell toButton:editButton];
        [tableScrollView addSubview:editButton];
        
        // Delete Product Button.
        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rect = deleteButton.frame;
        rect.size.height = 35;
        rect.size.width = 35;
        rect.origin = CGPointMake(endX + 35, 55 + (35 * i));
        deleteButton.frame = rect;
        [deleteButton setImage:[UIImage imageNamed:@"admin-field-delete.png"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"admin-delete-square.png"] forState:UIControlStateSelected];
        deleteButton.tag = i;
        [deleteButton addTarget:self action:@selector(removeProduct:) forControlEvents:UIControlEventTouchUpInside];
        [deleteButton addTarget:self action:@selector(deleteCancel:) forControlEvents:UIControlEventTouchCancel];
        [self copyButtonSettingsFrom:templateCell toButton:deleteButton];
        [tableScrollView addSubview:deleteButton];
        
        
        
    }
    
}

- (void)refreshTable
{
    // Refresh the screen.
    for (int i = 0; i < [[tableScrollView subviews] count]; i++ ) 
    {
        UIView *view = [[tableScrollView subviews] objectAtIndex:i];
        if (view.tag >= 0)
        {
            [[[tableScrollView subviews] objectAtIndex:i] removeFromSuperview];
            i--;
        }
    }
        
    [self populateHeaders];
    [self populateTable];
}

- (IBAction)addCategory
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    if (appDelegate.chosenProduct != NULL)
    {
    Product *product = appDelegate.chosenProduct;
    
    NSInteger arraySize = [categoryTable numberOfRowsInSection:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:arraySize inSection:0];
    
    NSArray *indexPaths = [NSArray arrayWithObjects:indexPath, nil];
    
    NSString *nameCategory = @"New Category";
    
    Category *category = [Category alloc];
    [category setCategoryName:nameCategory];
    
    [product.propertyArray addObject:category];
    
    [categoryTable cellForRowAtIndexPath:indexPath];
    [categoryTable numberOfRowsInSection:0];
    [categoryTable insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (IBAction)closePopupPanel
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    // Confirm choices and save new category name and value.
    Category *category = appDelegate.chosenCategory;
    category.categoryName = categoryNameField.text;
    category.valueString = categoryValueField.text;
    
    [categoryTable reloadData];
    
    // Edit view should appear.  A popover should do.
    if (popupState == 1)
    {
            // The drawer is "open"
            // We want to "close" it.
            [UIView animateWithDuration:0.5
                             animations:^{
                                 CGRect currPaneRect = [[self categoryPopupPanel] frame];
                                 currPaneRect.origin.x += 400;
                                 [[self categoryPopupPanel] setFrame:currPaneRect];
                                 
                             }
                             completion:^(BOOL finished){
                                 if(finished){
                                     popupState = 0; // The drawer is now "open".
                                 }
                             }];
    }
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    Product *product = appDelegate.chosenProduct;
    return [product.propertyArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    Product *product = appDelegate.chosenProduct;
    
    static NSString *CellID = @"ProductCategoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    
    Category *category = [product.propertyArray objectAtIndex:indexPath.row];
    cell.textLabel.text = category.categoryName;
    cell.detailTextLabel.text = category.valueString;
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    Product *product = appDelegate.chosenProduct;
    
    Category *category = [product.propertyArray objectAtIndex:indexPath.row];
    
    appDelegate.chosenCategory = category;
    
    categoryNameField.text = category.categoryName;
    categoryValueField.text = category.valueString;
    
    // Edit view should appear.  A popover should do.
    if (popupState == 0)
        {
            // The drawer is "closed"
            // We want to "open" it.
            [UIView animateWithDuration:0.5
                             animations:^{
                                 CGRect currPaneRect = [[self categoryPopupPanel] frame];
                                 currPaneRect.origin.x -= 400;
                                 [[self categoryPopupPanel] setFrame:currPaneRect];
                                 
                             }
                             completion:^(BOOL finished){
                                 if(finished){
                                     popupState = 1; // The drawer is now "open".
                                 }
                             }];
        }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    Product *product = appDelegate.chosenProduct;
    appDelegate.chosenCategory = NULL;
    
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        [product.propertyArray removeObjectAtIndex:indexPath.row];
        [categoryTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [categoryTable reloadData];
    }   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
