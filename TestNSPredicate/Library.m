//
//  Library.m
//  TestNSPredicate
//
//  Created by Yu Sugawara on 2014/05/13.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "Library.h"

@implementation Library

- (id)initWihtAuthors:(NSArray*)authors books:(NSArray*)books
{
    if (self = [super init]) {
        _authors = authors;
        _books = books;
    }
    return self;
}

@end
