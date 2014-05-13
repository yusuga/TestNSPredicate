//
//  Author.h
//  TestNSPredicate
//
//  Created by Yu Sugawara on 2014/05/13.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

- (id)initWithName:(NSString*)name;

@property (nonatomic, readonly) NSString *name;
@property (nonatomic) NSSet *books;

@end
