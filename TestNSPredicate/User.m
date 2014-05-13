//
//  User.m
//  TestNSPredicate
//
//  Created by Yu Sugawara on 2014/05/12.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithFirstName:(NSString *)firstName listName:(NSString *)lastName age:(NSUInteger)age gender:(BOOL)gender
{
    if (self = [super init]) {
        _firstName = firstName;
        _lastName = lastName;
        _age = age;
        _gender = gender;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<firstName: %@; lastName: %@; age: %@; gender: %@>", self.firstName, self.lastName, @(self.age), @(self.gender)];
}

@end
