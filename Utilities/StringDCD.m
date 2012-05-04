//
//  DataDelegation.m
//  Utilities
//
//  Created by Rayer Shih on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StringDCD.h"

@implementation StringDCD

-(id) convertDataToResource:(NSData*) data {
    //NSLog(@"Retrieving Data : ");
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

-(NSData*) convertResourceToData:(id) resource {
    //NSLog(@"Writing Data : ");
    NSString* string = resource;
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}

@end
