//
//  Library.h
//  TestNSPredicate
//
//  Created by Yu Sugawara on 2014/05/13.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Library : NSObject

- (id)initWihtAuthors:(NSArray*)authors books:(NSArray*)books;

@property (nonatomic, readonly) NSArray *authors;
@property (nonatomic, readonly) NSArray *books;

@end
