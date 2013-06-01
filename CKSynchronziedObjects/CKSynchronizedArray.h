//
//  CKSynchronizedArray.h
//  CKSynchronziedObjects
//
//  Created by Jake Heiser on 5/31/13.
//  Copyright (c) 2013 jakeheiser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKSynchronizedObject.h"

@interface CKSynchronizedArray : CKSynchronizedObject

+(CKSynchronizedArray *)synchronizedArrayWithFilePath:(NSString *)fileName;
+(CKSynchronizedArray *)synchronizedArrayWithFilePath:(NSString *)fileName synchronizationType:(CKFileSynchronizationTypes)syncType;

-(NSUInteger)count;
-(id)objectAtIndex:(NSUInteger)index;

-(void)addObject:(id)anObject;
-(void)insertObject:(id)anObject atIndex:(NSUInteger)index;
-(void)removeLastObject;
-(void)removeObjectAtIndex:(NSUInteger)index;
-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

-(void)changeArrayAndSynchronize:(void (^)(NSMutableArray *array))changeBlock;

@end
