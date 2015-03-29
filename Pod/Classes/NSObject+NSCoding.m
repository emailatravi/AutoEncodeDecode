//
//  NSObject+NSCoding.m
//  OpenStack
//
//  Created by Michael Mayo on 3/4/11.
//  The OpenStack project is provided under the Apache 2.0 license.
//

#import "NSObject+NSCoding.h"
#import <objc/runtime.h>
#import <ClassProperty.h>

@implementation NSObject (NSCoding)

- (void)autoEncodeWithCoder:(NSCoder *)coder {
    NSDictionary *properties = [ClassProperty getPropertyDictionaryForClass:[self class]];
    for (NSString *key in properties) {
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
}

- (void)autoDecode:(NSCoder *)coder {
    NSDictionary *properties = [ClassProperty getPropertyDictionaryForClass:[self class]];
    for (NSString *key in properties) {
        object_setInstanceVariable(self, [key UTF8String], [coder decodeObjectForKey:key]);
    }
}

@end