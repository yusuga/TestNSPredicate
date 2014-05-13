//
//  Book.h
//  TestNSPredicate
//
//  Created by Yu Sugawara on 2014/05/13.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Author;

@interface Book : NSObject

- (id)initWithTitle:(NSString*)title year:(NSUInteger)year;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSUInteger year;
@property (weak, nonatomic) Author *author;

@end
