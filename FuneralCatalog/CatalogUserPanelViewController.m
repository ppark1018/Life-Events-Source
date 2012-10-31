//
//  CatalogUserPanelViewController.m
//  FuneralCatalog
//
//  Created by Paul Park on 2/20/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "CatalogAppDelegate.h"
#import "CatalogUserPanelViewController.h"
#import "Product.h"
#import "Category.h"

@implementation CatalogUserPanelViewController

@synthesize popupButton;
@synthesize popupPanel;
@synthesize popupState;
@synthesize mainView;
@synthesize productNameLabel;
@synthesize productImageView;
@synthesize productImageScrollView;
@synthesize selectionPanel;
@synthesize selectionPanelScrollView;
@synthesize selectionPanelOpenButton;
@synthesize selectionState;
@synthesize filterPanelScrollView;
@synthesize filterSettingsArray;
@synthesize tagCategoryArray;
@synthesize filterTagArray;
@synthesize filterGroupMap;
@synthesize currentProductIndex;

CGFloat kScrollObjHeight = 140;
CGFloat kScrollObjWidth = 180;

int animationInProgress = 0;

- (IBAction)zoomOut
{
    [productImageScrollView setZoomScale:0 animated:YES];
}

- (IBAction)swipeRight
{
    if (animationInProgress == 1)
    {
        return;
    }
    
    // Get visible array so that it's accurate.
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSMutableArray *visibleArray = [[NSMutableArray alloc]init];
    int count;
    if ([appDelegate.filterArray count] == 0)
    {
        count = [appDelegate.dataArray count];
    }
    else
    {
        count = [appDelegate.filterArray count];
    }
    
    for (int i = 0; i < count; i++)
    {
        Product *product;
        if ([appDelegate.filterArray count] == 0)
        {
            product = [appDelegate.dataArray objectAtIndex:i];
        }
        else
        {
            product = [appDelegate.filterArray objectAtIndex:i];
        }
        if (product.visibleState == 1)
        {
            [visibleArray addObject:product];
        }
    }
    
    if (currentProductIndex > 0 && [visibleArray count] > 0)
    {
        animationInProgress = 1;
        CGRect origRect = [productImageView frame];
        CGRect origTextRect = [productNameLabel frame];
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect currPaneRect = [productImageView frame];
                             currPaneRect.origin.x += 1024;
                             [productImageView setFrame:currPaneRect];
                             currPaneRect = [productNameLabel frame];
                             currPaneRect.origin.x += 1024;
                             [productNameLabel setFrame:currPaneRect];
                         }
                         completion:^(BOOL finished){
                             if(finished){
                                 Product *product = [visibleArray objectAtIndex:(currentProductIndex - 1)];
                                 currentProductIndex--;
                                 productNameLabel.text = product.productName;
                                 productImageView.image = product.productImage;
                                 CGRect newPaneRect = origRect;
                                 newPaneRect.origin.x -= 1024;
                                 [productImageView setFrame:newPaneRect];
                                 newPaneRect = origTextRect;
                                 newPaneRect.origin.x -= 1024;
                                 [productNameLabel setFrame:newPaneRect];
                                 [UIView animateWithDuration:0.5
                                                  animations:^{
                                                      [productImageView setFrame:origRect];
                                                      [productNameLabel setFrame:origTextRect];
                                                  }
                                                  completion:^(BOOL finished){
                                                      if (finished){
                                                          animationInProgress = 0;
                                                      }
                                                  }];
                             }
                         }];
        
    }  
}

- (IBAction)swipeLeft
{
    if (animationInProgress == 1)
    {
        return;
    }
    
    // Get visible array so that it's accurate.
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSMutableArray *visibleArray = [[NSMutableArray alloc]init];
    int count;
    if ([appDelegate.filterArray count] == 0)
    {
        count = [appDelegate.dataArray count];
    }
    else
    {
        count = [appDelegate.filterArray count];
    }
    
    for (int i = 0; i < count; i++)
    {
        Product *product;
        if ([appDelegate.filterArray count] == 0)
        {
            product = [appDelegate.dataArray objectAtIndex:i];
        }
        else
        {
            product = [appDelegate.filterArray objectAtIndex:i];
        }
        if (product.visibleState == 1)
        {
            [visibleArray addObject:product];
        }
    }
    
    if (currentProductIndex < [visibleArray count] - 1 && [visibleArray count] > 0)
    {
        animationInProgress = 1;
        CGRect origRect = [productImageView frame];
        CGRect origTextRect = [productNameLabel frame];
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect currPaneRect = [productImageView frame];
                             currPaneRect.origin.x -= 1024;
                             [productImageView setFrame:currPaneRect];
                             currPaneRect = [productNameLabel frame];
                             currPaneRect.origin.x -= 1024;
                             [productNameLabel setFrame:currPaneRect];
                         }
                         completion:^(BOOL finished){
                             if(finished){
                                 Product *product = [visibleArray objectAtIndex:(currentProductIndex + 1)];
                                 currentProductIndex++;
                                 productNameLabel.text = product.productName;
                                 productImageView.image = product.productImage;
                                 CGRect newPaneRect = origRect;
                                 newPaneRect.origin.x += 1024;
                                 [productImageView setFrame:newPaneRect];
                                 newPaneRect = origTextRect;
                                 newPaneRect.origin.x += 1024;
                                 [productNameLabel setFrame:newPaneRect];
                                 [UIView animateWithDuration:0.5
                                                  animations:^{
                                                      [productImageView setFrame:origRect];
                                                      [productNameLabel setFrame:origTextRect];
                                                  }
                                                  completion:^(BOOL finished){
                                                      if (finished){
                                                          animationInProgress = 0;
                                                      }
                                                  }];
                             }
                         }];
        
    }  
}

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
                                 
                             }
                             completion:^(BOOL finished){
                                 if(finished){
                                     popupState = 1; // The drawer is now "open".
                                 }
                             }];
            // If selection is open, then close it to avoid lockups.
            if (selectionState == 1)
            {
                [self selectionOpen];
            }
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
            [UIView animateWithDuration:0.5 animations:^{
                [[self popupPanel] setFrame:currPaneRect];
                [[self mainView] setFrame:currMainRect];
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

- (IBAction)selectionOpen
{
    switch (selectionState)
    {
        case 0:
        {
            // The drawer is "closed"
            // We want to "open" it.
            [UIView animateWithDuration:0.5
                             animations:^{
                                 CGRect currPaneRect = [[self selectionPanel] frame];
                                 currPaneRect.origin.y -= 200;
                                 [[self selectionPanel] setFrame:currPaneRect];
                                 CGRect buttonRect = [[self selectionPanelOpenButton] frame];
                                 buttonRect.origin.y -= 200;
                                 [[self selectionPanelOpenButton] setFrame:buttonRect];
                             }
                             completion:^(BOOL finished){
                                 if(finished){
                                     selectionState = 1; // The drawer is now "open".
                                     [selectionPanelOpenButton setSelected:YES];
                                 }
                             }];
        }
            break;
        case 1:
        {
            // The drawer is "open"
            // We want to "close" it.
            CGRect currPaneRect = [[self selectionPanel] frame];
            currPaneRect.origin.y += 200;
            CGRect buttonRect = [[self selectionPanelOpenButton] frame];
            buttonRect.origin.y += 200;
            [UIView animateWithDuration:0.5 animations:^{
                [[self selectionPanel] setFrame:currPaneRect];
                [[self selectionPanelOpenButton] setFrame:buttonRect];
            }
                             completion:^(BOOL finished){
                                 if (finished)
                                 {
                                     selectionState = 0; // The drawer is now "closed".
                                     [selectionPanelOpenButton setSelected:NO];
                                 }
                             }];
        }
            break;
    }
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

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (UIView *)viewForZoomingInScrollView:(UIScrollView*)scrollView
{
    return self.productImageView;
}

- (void)prepareLayoutForSelection
{
    NSArray *subviews = [selectionPanelScrollView subviews];
    UIView *view = nil;
    
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIButton class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake((kScrollObjWidth + 20) * view.tag + 20, 20);
            view.frame = frame;
        }
        
        if ([view isKindOfClass:[UILabel class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake((kScrollObjWidth + 20) * view.tag + 20, 168);
            view.frame = frame;
        }
    }
}

- (void)selectProduct:(id)sender
{
    // Get visible array so that it's accurate.
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    NSMutableArray *visibleArray = [[NSMutableArray alloc]init];
    int count;
    if ([appDelegate.filterArray count] == 0)
    {
        count = [appDelegate.dataArray count];
    }
    else
    {
        count = [appDelegate.filterArray count];
    }
    
    for (int i = 0; i < count; i++)
    {
        Product *product;
        if ([appDelegate.filterArray count] == 0)
        {
            product = [appDelegate.dataArray objectAtIndex:i];
        }
        else
        {
            product = [appDelegate.filterArray objectAtIndex:i];
        }
        if (product.visibleState == 1)
        {
            [visibleArray addObject:product];
        }
    }

    UIButton *senderButton = (UIButton*)sender;
    int index = senderButton.tag;
    Product *product = [visibleArray objectAtIndex:index];
    currentProductIndex = index;
    productNameLabel.text = product.productName;
    productImageView.image = product.productImage;
}

- (void)populateSelection
{
    // Clear all subviews every method call.
    //for (int i = 0; i < [[selectionPanelScrollView subviews] count]; i++ ) {
    //    [[[selectionPanelScrollView subviews] objectAtIndex:0] removeFromSuperview];
    //}
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    int count;
    if ([appDelegate.filterArray count] == 0)
    {
        count = [appDelegate.dataArray count];
    }
    else
    {
        count = [appDelegate.filterArray count];
    }
    [selectionPanelScrollView setContentSize:CGSizeMake((count * kScrollObjWidth + 40),[selectionPanelScrollView bounds].size.height)];
    
    int tagIndex = 0;
    
    for (int i = 0; i < count; i++)
    {
        Product *product;
        if ([appDelegate.filterArray count] == 0)
        {
            product = [appDelegate.dataArray objectAtIndex:i];
        }
        else
        {
            product = [appDelegate.filterArray objectAtIndex:i];
        }
        
        if (product.visibleState == 1)
        {
            UIButton *button = [[UIButton alloc] init];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
            [button setImage:product.productImage forState:UIControlStateNormal];
            CGRect rect = button.frame;
            rect.size.height = kScrollObjHeight;
            rect.size.width = kScrollObjWidth;
            button.frame = rect;
            button.tag = tagIndex;
            [button addTarget:self action:@selector(selectProduct:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect labelRect= label.frame;
            labelRect.size.height = 20;
            labelRect.size.width = kScrollObjWidth;
            label.frame = labelRect;
            
            label.text = product.productName;
            label.numberOfLines = 1;
            label.textAlignment = UITextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:14.0];
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor whiteColor];
            
            label.tag = tagIndex;
            tagIndex++;
            
            
            [selectionPanelScrollView addSubview:button];
            [selectionPanelScrollView addSubview:label];
        }
         
    }
    
    [self prepareLayoutForSelection];
                                                        
}

- (void)calculateFilter
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.filterArray removeAllObjects];
    
    int countFilterSettings = [self.filterSettingsArray count];
    int countData = [appDelegate.dataArray count];
    for (int i = 0; i < countData; i++)
    {
        Product *product = [appDelegate.dataArray objectAtIndex:i];
        bool shouldAdd = true;
        for (int ii = 0; ii < countFilterSettings; ii++)
        {
            NSString *filterSetting = [self.filterSettingsArray objectAtIndex:ii];
            Category *filterCategory = [self.filterTagArray objectAtIndex:ii];
            if ([filterCategory.categoryType isEqualToString:@"Standard"]) //  The filter type is standard.
            {
                int countProperty = [product.propertyArray count];
                for (int iii = 0; iii < countProperty; iii++)
                {
                    Category *productCategory = [product.propertyArray objectAtIndex:iii];
                    if ([productCategory.categoryName isEqualToString:filterCategory.categoryName])
                    {
                        if (![productCategory.valueString isEqualToString:filterSetting])
                        {
                            shouldAdd = false;
                        }
                    }
                }
            }
            else // The filter type is price.
            {
                NSArray *priceArray = [filterSetting componentsSeparatedByString:@" - "];
                NSString *lowEndPriceStr = [priceArray objectAtIndex:0];
                NSString *highEndPriceStr = nil;
                int highEndPrice;
                
                // Now get rid of the dollar signs
                lowEndPriceStr = [lowEndPriceStr stringByReplacingOccurrencesOfString:@"$" withString:@""];
                int lowEndPrice = [lowEndPriceStr intValue];
                
                if ([priceArray count] > 1) // Check to exclude the case with "$6000+".
                {
                    highEndPriceStr = [priceArray objectAtIndex:1];
                    // Now get rid of the dollar sign.
                    highEndPriceStr = [highEndPriceStr stringByReplacingOccurrencesOfString:@"$" withString:@""];
                    highEndPrice = [highEndPriceStr intValue];
                }
                
                int countProperty = [product.propertyArray count];
                for (int iii = 0; iii < countProperty; iii++)
                {
                    Category *productCategory = [product.propertyArray objectAtIndex:iii];
                    if ([productCategory.categoryName isEqualToString:filterCategory.categoryName])
                    {
                        int price = [productCategory.valueString intValue];
                        if (((price < lowEndPrice || price > highEndPrice) && highEndPriceStr != nil) || (highEndPriceStr == nil && price < lowEndPrice))
                        {
                            shouldAdd = false;
                        }
                    }
                }
            }
        }
        if (shouldAdd == true)
        {
            [appDelegate.filterArray addObject:product];
        }
    }
    
    if ([appDelegate.filterArray count] == 0 && [self.filterSettingsArray count] > 0)
    {
        Product *nullProduct = [Product alloc];
        [appDelegate.filterArray addObject:nullProduct];
    }
}

- (void)forceOffFilter:(int)tagNumber
{
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    int index = tagNumber;
    UIButton *senderButton = nil;
    NSArray *subviews = [filterPanelScrollView subviews];
    UIView *view = nil;
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIButton class]] && view.tag == index)
        {
            senderButton = (UIButton*)view;
        }
    }
    
    if (senderButton.selected == TRUE)
    {
        [senderButton setSelected:FALSE];
        NSString *filterSetting = nil;
        
        for (view in subviews)
        {
            if ([view isKindOfClass:[UILabel class]] && view.tag == index)
            {
                UILabel *label = (UILabel*)view;
                filterSetting = label.text;
            }
        }
        
        int count = [filterSettingsArray count];
        for (int i = 0; i < count; i++)
        {
            if ([self.filterSettingsArray objectAtIndex:i] == filterSetting)
            {
                [self.filterSettingsArray removeObjectAtIndex:i];
                [self.filterTagArray removeObjectAtIndex:i];
                i = count;
            }
        }
    }
}

- (NSString*)findGroupID:(int)tagID
{
    NSArray *keyList = [filterGroupMap allKeys];
    int keyCount = [keyList count];
    for (int i = 0; i < keyCount; i++)
    {
        NSString *key = [keyList objectAtIndex:i];
        NSArray *filtersInGroup = [filterGroupMap objectForKey:key];
        int filterCount = [filtersInGroup count];
        for (int ii = 0; ii < filterCount; ii++)
        {
            if ([filtersInGroup containsObject:[NSNumber numberWithInt:tagID]])
            {
                return key;
            }
        }
    }
    return nil; // ERROR
}

- (void)selectFilter:(id)sender
{
    UIButton *senderButton = (UIButton*)sender;
    int index = senderButton.tag;
    
    // Deselect all other filters in this group if they are on.
    NSString *groupKey = [self findGroupID:index];
    NSArray *filtersInGroup = [filterGroupMap objectForKey:groupKey];
    for (NSNumber *filterID in filtersInGroup)
    {
        int filterIDInt = [filterID intValue];
        if (index != filterIDInt)
        {
            [self forceOffFilter:filterIDInt];
        }
    }
    
    if (senderButton.selected == FALSE)
    {
        [senderButton setSelected:TRUE];
        NSString *filterSetting;
        
        NSArray *subviews = [filterPanelScrollView subviews];
        UIView *view = nil;
        
        for (view in subviews)
        {
            if ([view isKindOfClass:[UILabel class]] && view.tag == index)
            {
                UILabel *label = (UILabel*)view;
                filterSetting = label.text;
            }
        }
        
        [self.filterSettingsArray addObject:filterSetting];
        Category *category = [self.tagCategoryArray objectAtIndex:index];
        [self.filterTagArray addObject:category];
    }
    else
    {
        [senderButton setSelected:FALSE];
        NSString *filterSetting = nil;
        
        NSArray *subviews = [filterPanelScrollView subviews];
        UIView *view = nil;
        
        for (view in subviews)
        {
            if ([view isKindOfClass:[UILabel class]] && view.tag == index)
            {
                UILabel *label = (UILabel*)view;
                filterSetting = label.text;
            }
        }
        
        int count = [filterSettingsArray count];
        for (int i = 0; i < count; i++)
        {
            if ([self.filterSettingsArray objectAtIndex:i] == filterSetting)
            {
                [self.filterSettingsArray removeObjectAtIndex:i];
                [self.filterTagArray removeObjectAtIndex:i];
                i = count;
            }
        }
    }
    
    [self calculateFilter];
    for (UIView *view in [selectionPanelScrollView subviews])
    {
        [view removeFromSuperview];
    }
    [self populateSelection];
    
}

- (NSMutableArray*)getAllPropertiesForCategory:(NSString*)categoryName
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    int count = [appDelegate.dataArray count];
    
    for (int i = 0; i < count; i++)
    {
        Product *product = [appDelegate.dataArray objectAtIndex:i];
        int count2 = [product.propertyArray count];
        for (int ii = 0; ii < count2; ii++)
        {
            Category *category = [product.propertyArray objectAtIndex:ii];
            if ([category.categoryName isEqualToString:categoryName])
            {
                if (![array containsObject:category.valueString] && category.valueString != nil)
                {
                    [array addObject:category.valueString];
                }
                ii = count2;
            }
        }
    }
    
    return array;
}

- (void)prepareFilter
{
    NSArray *subviews = [filterPanelScrollView subviews];
    UIView *view = nil;
    
    for (view in subviews)
    {
        if ([view isKindOfClass:[UIButton class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(300, view.tag * 50 + 20);
            view.frame = frame;
        }
        
        if ([view isKindOfClass:[UILabel class]] && view.tag >= 0)
        {
            CGRect frame = view.frame;
            frame.origin = CGPointMake(20, view.tag * 50 + 20);
            view.frame = frame;
        }
    }
}

- (void)populateFilter
{
    [filterPanelScrollView setContentSize:CGSizeMake(383,4000)];
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    int count = [appDelegate.fieldArray count];
    
    int tagIndex = 0;
    int groupTag = 0;
    
    for (int i = 0; i < count; i++)
    {
        Category *category = [appDelegate.fieldArray objectAtIndex:i];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        CGRect labelRect = label.frame;
        labelRect.size.height = 30;
        labelRect.size.width = 250;
        label.frame = labelRect;
        label.text = category.categoryName;
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:16.0];
        label.textColor = [UIColor cyanColor];
        label.backgroundColor = [UIColor clearColor];
        
        label.tag = tagIndex;
        groupTag = tagIndex;
        Category *nullCategory = [Category alloc];
        [self.tagCategoryArray addObject:nullCategory];
        
        [filterPanelScrollView addSubview:label];
        
        tagIndex++;
        
        if ([category.categoryType isEqualToString:@"Standard"])
        {
            NSMutableArray *categories = [self getAllPropertiesForCategory:category.categoryName];
            int count2 = [categories count];
            
            for (int ii = 0; ii < count2; ii++)
            {
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
                CGRect labelRect2 = label2.frame;
                labelRect2.size.height = 30;
                labelRect2.size.width = 250;
                label2.frame = labelRect2;
                label2.text = [categories objectAtIndex:ii];
                label2.textAlignment = UITextAlignmentLeft;
                label2.font = [UIFont systemFontOfSize:14.0];
                label2.textColor = [UIColor whiteColor];
                label2.backgroundColor = [UIColor clearColor];
                label2.tag = tagIndex;
                [self.tagCategoryArray addObject:category];
                
                
                UIButton *button = [[UIButton alloc] init];
                CGRect buttonRect = button.frame;
                buttonRect.size.height = 30;
                buttonRect.size.width = 30;
                button.frame = buttonRect;
                [button setImage:[UIImage imageNamed:@"active-button-red.png"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"active-button-green.png"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(selectFilter:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = tagIndex;
                
                [filterPanelScrollView addSubview:button];
                [filterPanelScrollView addSubview:label2];
                
                tagIndex++;
            }
        }
        else if ([category.categoryType isEqualToString:@"Price"])// Price
        {
            for (int ii = 0; ii < 6; ii++)
            {
                UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
                CGRect labelRect2 = label2.frame;
                labelRect2.size.height = 30;
                labelRect2.size.width = 250;
                label2.frame = labelRect2;
                label2.text = [NSString stringWithFormat:@"$%ld - $%ld", 1000 * ii, 1000 * ii + 999];
                label2.textAlignment = UITextAlignmentLeft;
                label2.font = [UIFont systemFontOfSize:14.0];
                label2.textColor = [UIColor whiteColor];
                label2.backgroundColor = [UIColor clearColor];
                label2.tag = tagIndex;
                [self.tagCategoryArray addObject:category];
                
                UIButton *button = [[UIButton alloc] init];
                CGRect buttonRect = button.frame;
                buttonRect.size.height = 30;
                buttonRect.size.width = 30;
                button.frame = buttonRect;
                [button setImage:[UIImage imageNamed:@"active-button-red.png"] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:@"active-button-green.png"] forState:UIControlStateSelected];
                [button addTarget:self action:@selector(selectFilter:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = tagIndex;
                
                [filterPanelScrollView addSubview:label2];
                [filterPanelScrollView addSubview:button];
                tagIndex++;
            }
            
            UILabel *labelF = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
            CGRect labelRectF = labelF.frame;
            labelRectF.size.height = 30;
            labelRectF.size.width = 250;
            labelF.frame = labelRectF;
            labelF.text = @"$6000+";
            labelF.textAlignment = UITextAlignmentLeft;
            labelF.font = [UIFont systemFontOfSize:14.0];
            labelF.textColor = [UIColor whiteColor];
            labelF.backgroundColor = [UIColor clearColor];
            labelF.tag = tagIndex;
            [self.tagCategoryArray addObject:category];
            
            UIButton *buttonF = [[UIButton alloc] init];
            CGRect buttonRectF = buttonF.frame;
            buttonRectF.size.height = 30;
            buttonRectF.size.width = 30;
            buttonF.frame = buttonRectF;
            [buttonF setImage:[UIImage imageNamed:@"active-button-red.png"] forState:UIControlStateNormal];
            [buttonF setImage:[UIImage imageNamed:@"active-button-green.png"] forState:UIControlStateSelected];
            [buttonF addTarget:self action:@selector(selectFilter:) forControlEvents:UIControlEventTouchUpInside];
            buttonF.tag = tagIndex;
            
            [filterPanelScrollView addSubview:labelF];
            [filterPanelScrollView addSubview:buttonF];
            tagIndex++;
        }
        
        // Group all the filters that belong to a category together.
        NSMutableArray *groupArray = [[NSMutableArray alloc] init];
        for (int groupCount = groupTag + 1; groupCount < tagIndex; groupCount++)
        {
            [groupArray addObject:[NSNumber numberWithInt:groupCount]];
        }
        [filterGroupMap setValue:groupArray forKey:[NSString stringWithFormat:@"%ld", i]];
    }
    
    [filterPanelScrollView setContentSize:CGSizeMake(383,tagIndex * 50 + 20)];
    [self prepareFilter];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    popupState = 0;
    selectionState = 0;
    self.filterSettingsArray = [[NSMutableArray alloc ]init];
    self.tagCategoryArray = [[NSMutableArray alloc]init];
    self.filterTagArray = [[NSMutableArray alloc]init];
    self.filterGroupMap = [[NSMutableDictionary alloc]init];
    [self populateSelection];
    [self populateFilter];
    currentProductIndex = 0;
    
    // If we have at least one product, we don't need a sample page.
    CatalogAppDelegate *appDelegate = (CatalogAppDelegate*)[[UIApplication sharedApplication]delegate];
    int count = [appDelegate.dataArray count];
    if (count > 0)
    {
        Product *product = [appDelegate.dataArray objectAtIndex:0];
        productNameLabel.text = product.productName;
        productImageView.image = product.productImage;
    }
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
