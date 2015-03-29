# ClassProperty
Code to fetch all the instance variables and its corresponding type for an Objective-C Class (using Objective-C runtime)


It also supports Super class

Example

Lets say we have three classes

RSClassA

```
@interface RSClassA : NSObject

@property NSString *alpha;
@property NSNumber *beta;
@property NSData *gamma;
@property NSArray *listArray;

@end

```

RSClassB

```
@interface RSClassB : RSClassA

@property NSString *intel;
@property NSString *mac;

@end
```

RSClassC

```
@interface RSClassC : RSClassB

@property NSInteger count;
@property CGFloat height;
@property NSIndexPath *indexPath;

@end
```

Simply import this 

```
#import <ClassProperty/ClassProperty.h>
```

Sample code 

```
NSDictionary *propertyDict = [ClassProperty getPropertyDictionaryForClass:[RSClassC class]];
for (NSString *key in [propertyDict allKeys]) {
	NSLog(@"Key : %@, Type : %@", key, [propertyDict valueForKey:key]);
}
```

OR

```
NSDictionary *propertyDict = [ClassProperty getPropertyDictionaryForClass:NSClassFromString(@"RSClassC")];
for (NSString *key in [propertyDict allKeys]) {
	NSLog(@"Key : %@, Type : %@", key, [propertyDict valueForKey:key]);
}
```
