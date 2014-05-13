//
//  TestNSPredicateTests.m
//  TestNSPredicateTests
//
//  Created by Yu Sugawara on 2014/05/12.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "User.h"
#import "Library.h"
#import "Author.h"
#import "Book.h"

@interface TestNSPredicateTests : XCTestCase

@end

@implementation TestNSPredicateTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSArray*)users
{
    return @[[[User alloc] initWithFirstName:@"Herbert" listName:@"Korberg" age:20 gender:YES],
             [[User alloc] initWithFirstName:@"Anne" listName:@"Nordenskiold" age:24 gender:NO],
             [[User alloc] initWithFirstName:@"Juanito" listName:@"Suela" age:35 gender:YES],
             [[User alloc] initWithFirstName:@"Rebecca" listName:@"Vinci" age:14 gender:NO],
             [[User alloc] initWithFirstName:@"Márkä" listName:@"Chèrêpkõv" age:50 gender:NO]];
//    [[User alloc] initWithFirstName:@"<#(NSString *)#>" listName:@"<#(NSString *)#>" age:<#(NSUInteger)#> gender:<#(BOOL)#>]
}

- (NSArray*)languages
{
    return @[@"C",
             @"Objective-C",
             @"Java",
             @"JavaScript",
             @"ActionScript",
             @"Ruby",
             @"Python",
             @"Perl",
             @"PHP"];
}

- (Library*)library
{
    Book *b1 = [[Book alloc] initWithTitle:@"AAA" year:1990];
    Book *b2 = [[Book alloc] initWithTitle:@"BBB" year:2000];
    Book *b3 = [[Book alloc] initWithTitle:@"CCC" year:2010];
    Book *b4 = [[Book alloc] initWithTitle:@"DDD" year:1991];
    Book *b5 = [[Book alloc] initWithTitle:@"EEE" year:2001];
    
    Author *a1 = [[Author alloc] initWithName:@"Herbert"];
    Author *a2 = [[Author alloc] initWithName:@"Anne"];
    Author *a3 = [[Author alloc] initWithName:@"Juanito"];
    
    b1.author = a1;
    b2.author = a1;
    b3.author = a1;
    a1.books = [NSSet setWithObjects:b1, b2, b3, nil];
    
    b4.author = a2;
    a2.books = [NSSet setWithObject:b4];
    
    b5.author = a3;
    a3.books = [NSSet setWithObject:b5];
    
    return [[Library alloc] initWihtAuthors:@[a1, a2, a3] books:@[b1, b2, b3, b4, b5]];
}

- (NSArray*)schoolClasses
{
    return @[@[@"1-A", @"1-B", @"1-C"],
             @[@"2-A", @"2-B"],
             @[@"3-A", @"3-B", @"3-C", @"3-D"]];
}

#pragma mark -

- (void)testTRUEPREDICATE
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
    XCTAssertTrue([predicate evaluateWithObject:[self users]], @"%@", @([predicate evaluateWithObject:[self users]]));
    XCTAssertTrue([[[self users] filteredArrayUsingPredicate:predicate] count] == [[self users] count], @"%@, %@", [[self users] filteredArrayUsingPredicate:predicate], [self users]);
}

- (void)testFALSEPREDICATE
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"FALSEPREDICATE"];
    XCTAssertFalse([predicate evaluateWithObject:[self users]], @"%@", @([predicate evaluateWithObject:[self users]]));
    XCTAssertTrue([[[self users] filteredArrayUsingPredicate:predicate] count] == 0, @"%@", [[self users] filteredArrayUsingPredicate:predicate]);
}

- (void)testCaseInsensitive
{
    NSArray *filterdArray = [[self users] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"firstName LIKE 'anne'"]];
    XCTAssertTrue([filterdArray count] == 0, @"%@", filterdArray);
    
    filterdArray = [[self users] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"firstName LIKE[c] 'anne'"]];
    XCTAssertTrue([filterdArray count] == 1, @"%@", filterdArray);
}

- (void)testDiacriticInsensitive
{
    NSArray *filterdArray = [[self users] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"firstName LIKE 'Marka'"]];
    XCTAssertTrue([filterdArray count] == 0, @"%@", filterdArray);
    
    filterdArray = [[self users] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"firstName LIKE[d] 'Marka'"]];
    XCTAssertTrue([filterdArray count] == 1, @"%@", filterdArray);
}

- (void)testBEGINSWITH
{
    NSString *prefix = @"Java";
    NSArray *filterdArray = [self BEGINSWITH:prefix];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] == [self countPrefixWithSourceArray:[self languages] prefix:prefix], @"%@", filterdArray);
    
    prefix = @"C";
    filterdArray = [self BEGINSWITH:prefix];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] == [self countPrefixWithSourceArray:[self languages] prefix:prefix], @"%@", filterdArray);
}

- (NSArray*)BEGINSWITH:(NSString*)prefix
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", prefix];
    NSLog(@"%s\npredicate: %@", __func__, predicate);
    return [[self languages] filteredArrayUsingPredicate:predicate];
}

- (void)testCONTAINS
{
    NSString *str = @"c";
    NSArray *filterdArray = [self CONTAINS:str caseInsensitive:NO];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] ==  [self countContainsWithSourceArray:[self languages] string:str caseInsensitive:NO], @"%@", filterdArray);
    
    str = @"C";
    filterdArray = [self CONTAINS:str caseInsensitive:YES];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] == [self countContainsWithSourceArray:[self languages] string:str caseInsensitive:YES], @"%@", filterdArray);
}

- (NSArray*)CONTAINS:(NSString*)str caseInsensitive:(BOOL)caseInsensitive
{
    NSPredicate *predicate;
    if (caseInsensitive) {
        predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", str];
    } else {
        predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", str];
    }
    NSLog(@"%s\npredicate: %@", __func__, predicate);
    return [[self languages] filteredArrayUsingPredicate:predicate];
}

- (void)testENDSWITH
{
    NSString *suffix = @"Script";
    NSArray *filterdArray = [self ENDSWITH:suffix];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] == [self countSuffixWithSourceArray:[self languages] suffix:suffix], @"%@", filterdArray);
    
    suffix = @"C";
    filterdArray = [self ENDSWITH:suffix];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] == [self countSuffixWithSourceArray:[self languages] suffix:suffix], @"%@", filterdArray);
}

- (NSArray*)ENDSWITH:(NSString*)suffix
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF ENDSWITH %@", suffix];
    NSLog(@"%s\npredicate: %@", __func__, predicate);
    return [[self languages] filteredArrayUsingPredicate:predicate];
}

- (void)testLIKE
{
    NSString *str = @"C";
    NSArray *filterdArray = [self LIKE:str];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] == 1, @"%@", filterdArray);
    
    str = @"J";
    filterdArray = [self LIKE:str];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] == 0, @"%@", filterdArray);
    
    str = @"J*";
    filterdArray = [self LIKE:str];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] == [self countPrefixWithSourceArray:[self languages] prefix:@"J"], @"%@", filterdArray);
    
    str = @"*C";
    filterdArray = [self LIKE:str];
    NSLog(@"filterdArray: %@", filterdArray);
    XCTAssertTrue([filterdArray count] == [self countSuffixWithSourceArray:[self languages] suffix:@"C"], @"%@", filterdArray);
}

- (NSArray*)LIKE:(NSString*)str
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF LIKE %@", str];
    NSLog(@"%s\npredicate: %@", __func__, predicate);
    return [[self languages] filteredArrayUsingPredicate:predicate];
}

- (void)testMATCHES
{
    NSString *pattern = @"[A-Z]*";
    NSArray *filterdArray = [self MATCHES:pattern];
    NSLog(@"%@", filterdArray);
    NSUInteger count = [self countRegularExpressionWithPattern:[NSString stringWithFormat:@"(%@)", pattern]];
    XCTAssertTrue([filterdArray count] == count, @"%@, count: %@", filterdArray, @(count));
    
    pattern = @"[\\w-]+";
    filterdArray = [self MATCHES:pattern];
    NSLog(@"%@", filterdArray);
    count = [self countRegularExpressionWithPattern:[NSString stringWithFormat:@"(%@)", pattern]];
    XCTAssertTrue([filterdArray count] == count, @"%@, count: %@", filterdArray, @(count));
    XCTAssertTrue([filterdArray count] == [[self languages] count], @"%@, %@", filterdArray, [self languages]);
}

- (NSArray*)MATCHES:(NSString*)pattern
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    NSLog(@"%s\npredicate: %@", __func__, predicate);
    return [[self languages] filteredArrayUsingPredicate:predicate];
}

- (void)testANY
{
    Library *library = [self library];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY books.year > 1999"];
    NSArray *filterdArray = [library.authors filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    
    NSMutableArray *books = @[].mutableCopy;
    for (Book *book in library.books) {
        if (book.year > 1999) {
            [books addObject:book];
        }
    }
    NSMutableArray *matchAuthors = @[].mutableCopy;
    for (Author *author in library.authors) {
        if ([author.books.allObjects firstObjectCommonWithArray:books] != nil) {
            [matchAuthors addObject:author];
        }
    }
    for (Author *author in filterdArray) {
        XCTAssertTrue([matchAuthors containsObject:author], @"mathAuthor: %@", matchAuthors);
    }
}

- (void)testALL
{
    Library *library = [self library];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ALL books.year > 1999"];
    NSArray *filterdArray = [[library authors] filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    NSMutableArray *books = @[].mutableCopy;
    for (Book *book in library.books) {
        if (book.year > 1999) {
            [books addObject:book];
        }
    }
    NSMutableArray *matchAuthors = @[].mutableCopy;
    for (Author *author in library.authors) {
        BOOL allContains = YES;
        for (Book *book in author.books) {
            if (![books containsObject:book]) {
                allContains = NO;
            }
        }
        if (allContains) {
            [matchAuthors addObject:author];
        }
    }
    for (Author *author in filterdArray) {
        XCTAssertTrue([matchAuthors containsObject:author], @"mathAuthor: %@", matchAuthors);
    }
}

- (void)testNONE
{
    Library *library = [self library];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NONE books.year > 1999"];
    NSArray *filterdArray = [[library authors] filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    NSMutableArray *books = @[].mutableCopy;
    for (Book *book in library.books) {
        if (book.year < 1999) {
            [books addObject:book];
        }
    }
    NSMutableArray *matchAuthors = @[].mutableCopy;
    for (Author *author in library.authors) {
        BOOL allContains = YES;
        for (Book *book in author.books) {
            if (![books containsObject:book]) {
                allContains = NO;
            }
        }
        if (allContains) {
            [matchAuthors addObject:author];
        }
    }
    for (Author *author in filterdArray) {
        XCTAssertTrue([matchAuthors containsObject:author], @"mathAuthor: %@", matchAuthors);
    }
}

- (void)testIN1
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name IN %@", @[@"Anne", @"Juanito"]];
    NSArray *filterdArray = [[self library].authors filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    XCTAssertTrue([filterdArray count] == 2, @"filterdArray: %@", filterdArray);
}

- (void)testIN2
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY books.year IN %@", @[@2000, @2001]];
    NSArray *filterdArray = [[self library].authors filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    XCTAssertTrue([filterdArray count] == 2, @"filterdArray: %@", filterdArray);
}

- (void)testSUBQUERY
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(books, $s, $s.year > 2000 AND $s.year < 2010).@count > 0"];
    NSLog(@"%s; %@", __func__, predicate);
    NSArray *filterdArray = [[self library].authors filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    XCTAssertTrue([filterdArray count] == 1, @"filterdArray: %@", filterdArray);
}

- (void)testArrayIndex
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF[1] = '2-B'"];
    NSArray *filterdArray = [[self schoolClasses] filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    XCTAssertTrue([filterdArray count] == 1, @"filterdArray: %@", filterdArray);
}

- (void)testArrayFIRST
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF[FIRST] = '1-A'"];
    NSArray *filterdArray = [[self schoolClasses] filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    XCTAssertTrue([filterdArray count] == 1, @"filterdArray: %@", filterdArray);
}

- (void)testArrayLAST
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF[LAST] = '1-C'"];
    NSArray *filterdArray = [[self schoolClasses] filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    XCTAssertTrue([filterdArray count] == 1, @"filterdArray: %@", filterdArray);
}

- (void)testArraySIZE
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF[SIZE] = 2"];
    NSArray *filterdArray = [[self schoolClasses] filteredArrayUsingPredicate:predicate];
    NSLog(@"%s; %@", __func__, filterdArray);
    XCTAssertTrue([filterdArray count] == 1, @"filterdArray: %@", filterdArray);
}

#pragma mark - count

- (NSUInteger)countPrefixWithSourceArray:(NSArray*)sourceArray prefix:(NSString*)prefix
{
    NSUInteger count = 0;
    for (NSString* lang in sourceArray) {
        if ([lang hasPrefix:prefix]) {
            count++;
        }
    };
    return count;
}

- (NSUInteger)countContainsWithSourceArray:(NSArray*)sourceArray string:(NSString*)string caseInsensitive:(BOOL)caseInsensitive
{
    NSUInteger count = 0;
    for (NSString* lang in sourceArray) {
        if ([lang rangeOfString:string options:caseInsensitive ? NSCaseInsensitiveSearch : 0].location != NSNotFound) {
            count++;
        }
    }
    return count;
}

- (NSUInteger)countSuffixWithSourceArray:(NSArray*)sourceArray suffix:(NSString*)suffix
{
    NSUInteger count = 0;
    for (NSString* lang in sourceArray) {
        if ([lang hasSuffix:suffix]) {
            count++;
        }
    }
    return count;
}

- (NSUInteger)countRegularExpressionWithPattern:(NSString*)pattern
{
    NSUInteger count = 0;
    NSError *error = nil;
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error == nil) {
        for (NSString *lang in [self languages]) {
            NSArray *arr = [regexp matchesInString:lang options:0 range:NSMakeRange(0, lang.length)];
            NSLog(@"lang: %@", lang);
            if ([arr count] > 0) {
                for (NSTextCheckingResult *match in arr) {
                    if (match.numberOfRanges > 1) {
                        NSRange range = [match rangeAtIndex:1];
                        if (lang.length == range.length) {
                            count++;
                            NSLog(@"match: %@, %@", lang, NSStringFromRange(range));
                        }
                    }
                }
            }
        }
    }
    return count;
}

@end
