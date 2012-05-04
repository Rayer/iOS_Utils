//
//  MemoryResourceCacheProvisioner.h
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceProxy.h"

@interface MemoryResourceCacheProvisioner : NSObject <IResourceProvisioner>

+(MemoryResourceCacheProvisioner*) createProvisioner;

@property NSMutableDictionary* cache;
@end
