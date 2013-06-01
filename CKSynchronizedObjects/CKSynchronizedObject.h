//
//  CKSynchronizedObject.h
//  CKSynchronziedObjects
//
//  Created by Jake Heiser on 6/1/13.
//  Copyright (c) 2013 jakeheiser. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    CKFileSynchronizationTypePlist,
    CKFileSynchronizationTypeArchivedData
} CKFileSynchronizationTypes;

@interface CKSynchronizedObject : NSObject

@property (strong, nonatomic) NSString *filePath;
@property (assign, nonatomic) CKFileSynchronizationTypes synchronizationType;

+(id)synchronizedObjectWithFilePath:(NSString *)filePath;
+(id)synchronizedObjectWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType;

-(id)initWithFilePath:(NSString *)filePath;
-(id)initWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType;

-(NSString *)contentsDescription;

@end
