//
//  Book.m
//  TestNSPredicate
//
//  Created by Yu Sugawara on 2014/05/13.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "Book.h"

@implementation Book

- (id)initWithTitle:(NSString *)title year:(NSUInteger)year
{
    if (self = [super init]) {
        _title = title;
        _year = year;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<title: %@; year: %@>", self.title, @(self.year)];
}

@end
