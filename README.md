# AutoEncodeDecode
Automatic encoding &amp; decoding  that conforms to NSCoding protocol (NSCoding / NSKeyed​Archiver). 

To understand how persistance can be achived, go through these useful links 

1. [NSCoding(Apple Doc)](https://developer.apple.com/library/prerelease/ios/documentation/Cocoa/2. Reference/Foundation/Protocols/NSCoding_Protocol/index.html), 
2. [NSHipster-NSCoding](http://nshipster.com/nscoding/), 
3. [Ray Wenderlich-Persistance](http://www.raywenderlich.com/1914/nscoding-tutorial-for-ios-how-to-save-your-app-data)

Just imagine if your Model Class has hell lot of Instance Variables and you want to dump it (persistance), you will curse yourself writing code for 

1. `- (id)initWithCoder:(NSCoder *)decoder` and 
2. `- (void)encodeWithCoder:(NSCoder *)encoder`

Sample:

Model Class

```
@interface RSClassA : NSObject <NSCoding>

@property NSString *alpha;
@property NSNumber *beta;
@property NSData *gamma;
@property NSArray *listArray;

@end
```

```
#import "RSClassA.h"
#import <AutoEncodeDecode/NSObject+NSCoding.h>

@implementation RSClassA

-(void)encodeWithCoder:(NSCoder *)coder {
    [self autoEncodeWithCoder:coder];
}

-(id)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        [self autoDecode:coder];
    }
    return self;
}

@end
```

This is for extremely **LAZY Ones**

```
#import <Foundation/Foundation.h>
#import <AutoEncodeDecode/BaseModel.h>

@interface RSClassB : BaseModel

@property NSString *windows;
@property NSString *mac;

@end
```
```
#import "RSClassB.h"

@implementation RSClassB

@end
```

```
- (void)testAutoEncoderDecoder {
    // Write to file
    NSString *fileNameWithPath = [self getFilePath:@"Class_A_File"];
    [NSKeyedArchiver archiveRootObject:[self getTestRSClassAObject] toFile:fileNameWithPath];
    
    // Read the file
    RSClassA *readObjA = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSLog(@"Alpha : %@, Gaama : %@, Array : %@", readObjA.alpha, readObjA.beta, [readObjA.listArray componentsJoinedByString:@"|"]);
    
    // Write to file
    fileNameWithPath = [self getFilePath:@"Class_B_File"];
    [NSKeyedArchiver archiveRootObject:[self getTestRSClassBObject] toFile:fileNameWithPath];
    
    // Read the file
    RSClassB *readObjB = [NSKeyedUnarchiver unarchiveObjectWithFile:fileNameWithPath];
    NSLog(@"Windows : %@, Mac : %@", readObjB.windows, readObjB.mac);
}

- (RSClassA*)getTestRSClassAObject {
    RSClassA *classObject = [RSClassA new];
    classObject.alpha = @"Test";
    classObject.beta = @(10);
    classObject.listArray = @[@"A", @"B"];
    return classObject;
}

- (RSClassB*)getTestRSClassBObject {
    RSClassB *classObject = [RSClassB new];
    classObject.windows = @"I hate it";
    classObject.mac = @"I love it";
    return classObject;
}

- (NSString*)getFilePath:(NSString *)aFileName {
    if (aFileName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        return [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@.archive", aFileName]];
    }
    return nil;
}
```

