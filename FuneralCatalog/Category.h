//
//  Category.h
//  FuneralCatalog
//
//  Created by Paul Park on 2/27/12.
//  Copyright (c) 2012 SC Governor's School for Science and Mathematics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject <NSCoding>
{
    NSString *categoryType;
    NSString *categoryName;
    NSString *valueString;
    NSInteger valueInteger;
}

@property (nonatomic, retain) NSString *categoryType;
@property (nonatomic, retain) NSString *categoryName;
@property (nonatomic, retain) NSString *valueString;
@property (nonatomic) NSInteger valueInteger;

@end
