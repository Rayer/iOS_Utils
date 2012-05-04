//
//  MemoryResourceCacheProvisioner.m
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MemoryResourceCacheProvisioner.h"

@implementation MemoryResourceCacheProvisioner

@synthesize cache = _cache;

+(MemoryResourceCacheProvisioner*) createProvisioner {
    MemoryResourceCacheProvisioner* ret = [[MemoryResourceCacheProvisioner alloc] init];
    [ret clearResources];
    return ret;
}


-(id) getResource:(NSString*)identify {
    NSLog(@"Mem cache : asked for %@", identify);
    return [_cache objectForKey:identify];
}

-(void) setResourceID:(NSString*)identify withObject:(id)obj {
    [_cache setObject:obj forKey:identify];
}

-(void) clearResources {
    _cache = nil;
    _cache = [[NSMutableDictionary alloc]init];
}

-(BOOL) clearResourcesWithId:(NSString *)identificator {
    return NO;
}

@end
