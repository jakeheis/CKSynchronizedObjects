//
//  CKSynchronizedObject.m
//  CKSynchronziedObjects
//
//  Created by Jake Heiser on 6/1/13.
//  Copyright (c) 2013 jakeheiser. All rights reserved.
//

#import "CKSynchronizedObject.h"

@implementation CKSynchronizedObject

+(id)synchronizedObjectWithFilePath:(NSString *)filePath {
    return [[self alloc] initWithFilePath:filePath];
}

+(id)synchronizedObjectWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType {
    return [[self alloc] initWithFilePath:filePath synchronizationType:syncType];
}

-(id)initWithFilePath:(NSString *)filePath {
    return [self initWithFilePath:filePath synchronizationType:CKFileSynchronizationTypePlist];
}

-(id)initWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType {
    if ((self = [super init])) {
        [self setFilePath:filePath];
        [self setSynchronizationType:syncType];
    }
    return self;
}

-(NSString *)contentsDescription {
    return nil;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%@: %@", [super description], [self contentsDescription]];
}

@end
