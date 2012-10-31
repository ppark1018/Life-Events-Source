//
//  Product.h
//  FuneralCatalog
//
//  Created by Paul Park on 2/22/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject <NSCoding>
{
    NSMutableArray *propertyArray;
    NSString *productName;
    int tablePosition;
    NSString *productImageURL;
    UIImage *productImage;
    int visibleState;
}

@property (nonatomic, retain) NSMutableArray *propertyArray;
@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) UIImage *productImage;
@property (nonatomic, retain) NSString *productImageURL;
@property (nonatomic) int tablePosition;
@property (nonatomic) int visibleState;

- (void)initialize;
- (void)removeCategoryWithName:(NSString*)name;
- (NSString*)returnVisibility;

@end
