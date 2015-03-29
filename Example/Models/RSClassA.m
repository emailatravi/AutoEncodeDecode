//
//  RSClassA.m
//  ClassProperty
//
//  Created by Ravi Prakash Sahu on 28/03/15.
//  Copyright (c) 2015 Ravi Prakash Sahu. All rights reserved.
//

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
