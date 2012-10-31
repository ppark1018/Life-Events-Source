//
//  CatalogUserPanelViewController.h
//  FuneralCatalog
//
//  Created by Paul Park on 2/20/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Product;
@class Category;

@interface CatalogUserPanelViewController : UIViewController
{
    IBOutlet UIButton *popupButton;
    IBOutlet UIView *popupPanel;
    IBOutlet UIView *mainView;
    IBOutlet UIView *selectionPanel;
    IBOutlet UIScrollView *selectionPanelScrollView;
    IBOutlet UIButton *selectionPanelOpenButton;
    IBOutlet UIScrollView *productImageScrollView;
    
    IBOutlet UILabel *productNameLabel;
    IBOutlet UIImageView *productImageView;
    
    IBOutlet UIScrollView *filterPanelScrollView;
    
    NSMutableArray *filterSettingsArray;
    NSMutableArray *filterTagArray;
    NSMutableArray *tagCategoryArray;
    NSMutableDictionary *filterGroupMap;
    
    int popupState;
    int selectionState;
    int currentProductIndex;
}

@property (nonatomic, retain) IBOutlet UIButton *popupButton;
@property (nonatomic, retain) IBOutlet UIView *popupPanel;
@property (nonatomic, retain) IBOutlet UIView *mainView;
@property (nonatomic) int popupState;
@property (nonatomic, retain) IBOutlet UIView *selectionPanel;
@property (nonatomic, retain) IBOutlet UIScrollView *selectionPanelScrollView;
@property (nonatomic, retain) IBOutlet UIScrollView *productImageScrollView;
@property (nonatomic, retain) IBOutlet UIButton *selectionPanelOpenButton;
@property (nonatomic) int selectionState;
@property (nonatomic) int currentProductIndex;

@property (nonatomic, retain) IBOutlet UILabel *productNameLabel;
@property (nonatomic, retain) IBOutlet UIImageView *productImageView;

@property (nonatomic, retain) IBOutlet UIScrollView *filterPanelScrollView;

@property (nonatomic, retain) NSMutableArray *filterSettingsArray;
@property (nonatomic, retain) NSMutableArray *filterTagArray;
@property (nonatomic, retain) NSMutableArray *tagCategoryArray;
@property (nonatomic, retain) NSMutableDictionary *filterGroupMap;

- (IBAction)popup;
- (IBAction)selectionOpen;
- (IBAction)swipeRight;
- (IBAction)swipeLeft;
- (IBAction)zoomOut;
- (void)selectProduct:(id)sender;
- (void)selectFilter:(id)sender;
- (void)populateSelection;

@end
