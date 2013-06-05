//
//  CKViewController.m
//  Demo
//
//  Created by Jake Heiser on 6/5/13.
//  Copyright (c) 2013 jakeheiser. All rights reserved.
//

#import "CKViewController.h"
#import "CKSynchronizedObjects.h"

@interface CKViewController ()

@end

@implementation CKViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    CKSynchronizedArray *array = [CKSynchronizedArray synchronizedArrayWithFilePath:[docDir stringByAppendingPathComponent:@"array"]];
    NSLog(@"Array starting with: %@", array);
    
    [array addObject:[NSString stringWithFormat:@"Hey %i", [array count]]];
    
    CKSynchronizedDictionary *dict = [CKSynchronizedDictionary synchronizedDictionaryWithFilePath:[docDir stringByAppendingPathComponent:@"dict"] synchronizationType:CKFileSynchronizationTypeArchivedData];
    NSLog(@"Dictionary starting with: %@", dict);
    
    [dict setObject:[NSDate date] forKey:@([dict count])];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
