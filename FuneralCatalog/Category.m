//
//  Category.m
//  FuneralCatalog
//
//  Created by Paul Park on 2/27/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import "Category.h"

@implementation Category

@synthesize categoryType;
@synthesize valueString;
@synthesize valueInteger;
@synthesize categoryName;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:categoryType forKey:@"kCategoryType"];
    [encoder encodeObject:valueString forKey:@"kValueString"];
    [encoder encodeInteger:valueInteger forKey:@"kValueInteger"];
    [encoder encodeObject:categoryName forKey:@"kCategoryName"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        categoryType = [decoder decodeObjectForKey:@"kCategoryType"];
        valueString = [decoder decodeObjectForKey:@"kValueString"];
        valueInteger = [decoder decodeIntegerForKey:@"kValueInteger"];
        categoryName = [decoder decodeObjectForKey:@"kCategoryName"];
    }
    return self;
}

@end
