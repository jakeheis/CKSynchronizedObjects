//
//  CKViewController.m
//  CKSynchronziedObjects
//
//  Created by Jake Heiser on 5/31/13.
//  Copyright (c) 2013 jakeheiser. All rights reserved.
//

#import "CKViewController.h"
#import "CKSynchronizedArray.h"
#import "CKSynchronizedDictionary.h"

@interface CKViewController ()

@end

@implementation CKViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    CKSynchronizedArray *array = [CKSynchronizedArray synchronizedArrayWithFilePath:[docDir stringByAppendingPathComponent:@"array.plist"]];
    if (![array count]) {
        [array addObject:@"hi there"];
        [array addObject:@"sup"];
    } else {
        [array changeArrayAndSynchronize:^(NSMutableArray *array) {
            [array removeAllObjects];
        }];
    }
    
    CKSynchronizedDictionary *dict = [CKSynchronizedDictionary synchronizedDictionaryWithFilePath:[docDir stringByAppendingPathComponent:@"dict"] synchronizationType:CKFileSynchronizationTypeArchivedData];
    [dict setVal:@"hey there" forKey:@"greeting"];
    [dict setVal:@"sup" forKey:@"duos"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
