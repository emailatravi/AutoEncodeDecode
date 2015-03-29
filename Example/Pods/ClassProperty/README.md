# ClassProperty

[![Version](https://img.shields.io/cocoapods/v/ClassProperty.svg?style=flat)](http://cocoapods.org/pods/ClassProperty)
[![License](https://img.shields.io/cocoapods/l/ClassProperty.svg?style=flat)](http://cocoapods.org/pods/ClassProperty)
[![Platform](https://img.shields.io/cocoapods/p/ClassProperty.svg?style=flat)](http://cocoapods.org/pods/ClassProperty)

### Why use ClassProperty?

Code to fetch all the instance variables and its corresponding type for an Objective-C Class (using Objective-C runtime)


It also supports Super class

### Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Installation

ClassProperty is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod "ClassProperty"
```

### Author

Ravi Prakash Sahu, emailatravi@gmail.com

### License

ClassProperty is available under the MIT license. See the LICENSE file for more info.

### Example

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
