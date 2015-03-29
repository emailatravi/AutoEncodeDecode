//
// ClassProperty.m
//
// The MIT License (MIT)
//
// Copyright (c) 2015 Ravi Prakash Sahu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import "ClassProperty.h"
#import <objc/runtime.h>

@interface ClassProperty ()

+ (ClassProperty*) sharedInstance;

@property (nonatomic, strong) NSCache *propertyCache;

- (void)addClassPropertyDictionaryToCache:(NSDictionary*)propertyDictionary forClass:(Class)aClass;
- (NSDictionary*)getClassPropertyDictionaryFromCache:(Class)aClass;

@end

@implementation ClassProperty

#pragma mark -
#pragma mark Singleton Methods

+ (ClassProperty*)sharedInstance {
    
	static ClassProperty *_sharedInstance;
	if(!_sharedInstance) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_sharedInstance = [[super allocWithZone:nil] init];
        });
    }
    
    return _sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

#pragma mark -
#pragma mark Public Methods

+ (NSDictionary*)getPropertyDictionaryForClass:(Class)aObjectClass {
    // Check if the cache dictionary has the property dictionary for this class
    NSDictionary *_cachePropertyDictionary = [[ClassProperty sharedInstance] getClassPropertyDictionaryFromCache:aObjectClass];
    if (_cachePropertyDictionary) {
        return _cachePropertyDictionary;
    }
    else {
        NSMutableDictionary *_propertyDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
        // Check if we have any super class or nor
        Class superClass = class_getSuperclass(aObjectClass);
        if (superClass != [NSObject class]) {
            [_propertyDictionary addEntriesFromDictionary:[ClassProperty getPropertyDictionaryForClass:superClass]];
        }
        u_int count;
        Ivar* ivars = class_copyIvarList(aObjectClass, &count);
        for (NSInteger i = 0; i < count ; i++)
        {
            const char* ivarName = ivar_getName(ivars[i]);
            const char* ivarType = ivar_getTypeEncoding(ivars[i]);
            NSString *propertyName = [NSString stringWithCString:ivarName encoding:NSUTF8StringEncoding];
            NSString *propertyType = [NSString stringWithCString:ivarType encoding:NSUTF8StringEncoding];
            propertyType = [propertyType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            propertyType = [propertyType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            [_propertyDictionary setValue:propertyType forKey:propertyName];
        }
        free(ivars);
        
        if (_propertyDictionary) {
            [[ClassProperty sharedInstance] addClassPropertyDictionaryToCache:_propertyDictionary forClass:aObjectClass];
        }
        return _propertyDictionary;
    }
	return nil;
}

#pragma mark -
#pragma mark Private Methods

- (void)addClassPropertyDictionaryToCache:(NSDictionary*)propertyDictionary forClass:(Class)aClass {
    if (!self.propertyCache) {
        self.propertyCache = [NSCache new];
    }
    [self.propertyCache setObject:propertyDictionary forKey:NSStringFromClass(aClass)];
}

- (NSDictionary*)getClassPropertyDictionaryFromCache:(Class)aClass {
    NSString *className = NSStringFromClass(aClass);
    if (self.propertyCache && [self.propertyCache objectForKey:className]) {
        return [self.propertyCache objectForKey:className];
    }
    return nil;
}

@end
