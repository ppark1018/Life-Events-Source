//
//  Product.m
//  FuneralCatalog
//
//  Created by Paul Park on 2/22/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "Product.h"
#import "Category.h"

@implementation Product

@synthesize productName;
@synthesize propertyArray;
@synthesize tablePosition;
@synthesize productImage;
@synthesize productImageURL;
@synthesize visibleState;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:productName forKey:@"kProductName"];
    [encoder encodeObject:propertyArray forKey:@"kPropertyArray"];
    [encoder encodeInt:tablePosition forKey:@"kTablePosition"];
    [encoder encodeObject:productImage forKey:@"kProductImage"];
    [encoder encodeObject:productImageURL forKey:@"kProductImageURL"];
    [encoder encodeInt:visibleState forKey:@"kVisibleState"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        productName = [decoder decodeObjectForKey:@"kProductName"];
        propertyArray = [[decoder decodeObjectForKey:@"kPropertyArray"] mutableCopy];
        tablePosition = [decoder decodeIntForKey:@"kTablePosition"];
        productImage = [decoder decodeObjectForKey:@"kProductImage"];
        productImageURL = [decoder decodeObjectForKey:@"kProductImageURL"];
        visibleState = [decoder decodeIntForKey:@"kVisibleState"];
    }
    return self;
}


- (void)initialize
{
    self.propertyArray = [[NSMutableArray alloc] init];
}

- (void)removeCategoryWithName:(NSString*)name
{
    int count = [self.propertyArray count];
    for (int i = 0; i < count; i++)
    {
        Category *tempCat = [self.propertyArray objectAtIndex:i];
        if (tempCat.categoryName == name)
        {
            [self.propertyArray removeObjectAtIndex:i];
            return;
        }
    }
}

- (NSString*)returnVisibility
{
    if (visibleState == 1)
    {
        return @"Yes";
    }
    else
    {
        return @"No";
    }
}


@end
