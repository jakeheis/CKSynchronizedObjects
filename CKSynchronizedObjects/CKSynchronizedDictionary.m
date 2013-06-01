//
//  CKSynchronizedDictionary.m
//  CKSynchronziedObjects
//
//  Created by Jake Heiser on 6/1/13.
//  Copyright (c) 2013 jakeheiser. All rights reserved.
//

#import "CKSynchronizedDictionary.h"

@interface CKSynchronizedDictionary ()

@property (strong, nonatomic) NSMutableDictionary *underlyingDictionary;

@end

@implementation CKSynchronizedDictionary

#pragma mark - Synchronization

+(CKSynchronizedDictionary *)synchronizedDictionaryWithFilePath:(NSString *)filePath {
    return [self synchronizedObjectWithFilePath:filePath];
}

+(CKSynchronizedDictionary *)synchronizedDictionaryWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType {
    return [self synchronizedObjectWithFilePath:filePath synchronizationType:syncType];
}

-(id)initWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType {
    if ((self = [super initWithFilePath:filePath synchronizationType:syncType])) {
        NSMutableDictionary *newDict = nil;
        if (syncType == CKFileSynchronizationTypePlist)
            newDict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath] ?: [NSMutableDictionary dictionary];
        else if (syncType == CKFileSynchronizationTypeArchivedData)
            newDict = [NSMutableDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:filePath]];
        
        [self setUnderlyingDictionary:newDict];
    }
    return self;
}

-(void)synchronize {
    if ([self synchronizationType] == CKFileSynchronizationTypePlist) {
        [[self underlyingDictionary] writeToFile:[self filePath] atomically:YES];
    } else if ([self synchronizationType] == CKFileSynchronizationTypeArchivedData) {
        [NSKeyedArchiver archiveRootObject:[self underlyingDictionary] toFile:[self filePath]];
    }
}

#pragma mark - Dictionary hooks

-(NSUInteger)count {
    return [[self underlyingDictionary] count];
}

-(id)objectForKey:(id)aKey {
    return [[self underlyingDictionary] objectForKey:aKey];
}

-(void)removeObjectForKey:(id)aKey {
    [[self underlyingDictionary] removeObjectForKey:aKey];
    [self synchronize];
}

-(void)setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    [[self underlyingDictionary] setObject:anObject forKey:aKey];
    [self synchronize];
}

-(void)setVal:(id)value forKey:(NSString *)aKey { // Can't be setValue because of KVO
    [[self underlyingDictionary] setValue:value forKey:aKey];
    [self synchronize];
}

-(void)changeArrayAndSynchronize:(void (^)(NSMutableDictionary *dictionary))changeBlock {
    changeBlock([self underlyingDictionary]);
    [self synchronize];
}

-(NSString *)contentsDescription {
    return [[self underlyingDictionary] description];
}

@end
