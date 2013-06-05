CKSynchronizedObjects
=====================

An easy way to keep arrays and dictionaries synced with a file. Start by intializing an arrray or dictionary with the 
file you want it to stay syncrhonzied with. After that, any changes you make to the synchronized object are automatically saved, in either .plist format or archived data created by NSKeyedArchiver.

###Usage
Intializing:
```objc
+(CKSynchronizedArray *)synchronizedArrayWithFilePath:(NSString *)fileName;
+(CKSynchronizedArray *)synchronizedArrayWithFilePath:(NSString *)fileName synchronizationType:(CKFileSynchronizationTypes)syncType;

+(CKSynchronizedDictionary *)synchronizedDictionaryWithFilePath:(NSString *)filePath;
+(CKSynchronizedDictionary *)synchronizedDictionaryWithFilePath:(NSString *)filePath synchronizationType:(CKFileSynchronizationTypes)syncType;
```

CKSynchronizedObjects provide some basic hooks into their underlying objects:
```obj
// Array
-(NSUInteger)count;
-(id)objectAtIndex:(NSUInteger)index;

-(void)addObject:(id)anObject;
-(void)insertObject:(id)anObject atIndex:(NSUInteger)index;
-(void)removeLastObject;
-(void)removeObjectAtIndex:(NSUInteger)index;
-(void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject;

// Dictionary
-(NSUInteger)count;
-(id)objectForKey:(id)aKey;

-(void)removeObjectForKey:(id)aKey;
-(void)setObject:(id)anObject forKey:(id <NSCopying>)aKey;
-(void)setVal:(id)value forKey:(NSString *)aKey;
```

After any of these methods are called on the underlying object (array/dictionary), it is automatically synced with the file you specified during initialization.

Any more advanced changes you need to make can be done easily as well:
```objc
[syncArray changeArrayAndSynchronize:^(NSMutableArray *array) {
        [array exchangeObjectAtIndex:3 withObjectAtIndex:1];
}];
```

After this block is executed, the object is also automatically synced.
