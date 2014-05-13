//
//  User.h
//  TestNSPredicate
//
//  Created by Yu Sugawara on 2014/05/12.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

- (id)initWithFirstName:(NSString*)firstName listName:(NSString*)lastName age:(NSUInteger)age gender:(BOOL)gender;

@property (nonatomic, readonly) NSString *firstName;
@property (nonatomic, readonly) NSString *lastName;
@property (nonatomic, readonly) NSUInteger age;
@property (nonatomic, readonly) BOOL gender; // male == YES, female == NO

@end
