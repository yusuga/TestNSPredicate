//
//  Author.m
//  TestNSPredicate
//
//  Created by Yu Sugawara on 2014/05/13.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "Author.h"

@implementation Author

- (id)initWithName:(NSString *)name
{
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<name: %@; books: %@>", self.name, self.books];
}

@end
