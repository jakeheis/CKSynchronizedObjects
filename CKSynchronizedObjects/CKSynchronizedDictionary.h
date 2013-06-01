//
//  CKSynchronizedDictionary.h
//  CKSynchronziedObjects
//
//  Created by Jake Heiser on 6/1/13.
//  Copyright (c) 2013 jakeheiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "CKSynchronizedObject.h"

@interface CKSynchronizedDictionary : CKSynchronizedObject

+(CKSynchronizedDictionary *)synchronizedDictionaryWithFilePath:(NSString *)filePath;
+(CKSynchronizedDictionary *)synchronizedDictionaryWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType;

-(NSUInteger)count;
-(id)objectForKey:(id)aKey;

-(void)removeObjectForKey:(id)aKey;
-(void)setObject:(id)anObject forKey:(id <NSCopying>)aKey;
-(void)setVal:(id)value forKey:(NSString *)aKey;

-(void)changeArrayAndSynchronize:(void (^)(NSMutableDictionary *dictionary))changeBlock;

@end
