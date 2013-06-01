//
//  CKSynchronizedArray.m
//  CKSynchronziedObjects
//
//  Created by Jake Heiser on 5/31/13.
//  Copyright (c) 2013 jakeheiser. All rights reserved.
//

#import "CKSynchronizedArray.h"

@interface CKSynchronizedArray ()

@property (strong, nonatomic) NSMutableArray *underlyingArray;

@end

@implementation CKSynchronizedArray

#pragma mark - Synchronization

+(CKSynchronizedArray *)synchronizedArrayWithFilePath:(NSString *)filePath {
    return [self synchronizedObjectWithFilePath:filePath];
}

+(CKSynchronizedArray *)synchronizedArrayWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType {
    return [self synchronizedObjectWithFilePath:filePath synchronizationType:syncType];
}

-(id)initWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType {
    if ((self = [super initWithFilePath:filePath synchronizationType:syncType])) {
        NSMutableArray *newArray = nil;
        if (syncType == CKFileSynchronizationTypePlist)
            newArray = [NSMutableArray arrayWithContentsOfFile:filePath] ?: [NSMutableArray array];
        else if (syncType == CKFileSynchronizationTypeArchivedData)
            newArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]];

        [self setUnderlyingArray:newArray];
    }
    return self;
}

-(void)synchronize {
    if ([self synchronizationType] == CKFileSynchronizationTypePlist) {
        [[self underlyingArray] writeToFile:[self filePath] atomically:YES];
    } else if ([self synchronizationType] == CKFileSynchronizationTypeArchivedData) {
        [NSKeyedArchiver archiveRootObject:[self underlyingArray] toFile:[self filePath]];
    }
}

#pragma mark - Array hooks

-(NSUInteger)count {
    return [[self underlyingArray] count];
}

-(id)objectAtIndex:(NSUInteger)index {
    return [[self underlyingArray] objectAtIndex:index];
}

-(void)addObject:(id)anObject {
    [[self underlyingArray] addObject:anObject];
    [self synchronize];
}

-(void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    [[self underlyingArray] insertObject:anObject atIndex:index];
    [self synchronize];
}

-(void)removeLastObject {
    [[self underlyingArray] removeLastObject];
    [self synchronize];
}

-(void)removeObjectAtIndex:(NSUInteger)index {
    [[self underlyingArray] removeObjectAtIndex:index];
    [self synchronize];
}

-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    [[self underlyingArray] replaceObjectAtIndex:index withObject:anObject];
    [self synchronize];
}

-(void)changeArrayAndSynchronize:(void (^)(NSMutableArray *array))changeBlock {
    changeBlock([self underlyingArray]);
    [self synchronize];
}

-(NSString *)contentsDescription {
    return [[self underlyingArray] description];
}

@end
