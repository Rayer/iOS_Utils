//
//  ResourceProxy.m
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ResourceProxy.h"

@implementation ResourceProxy
@synthesize provisionerList = _provisionerList;
@synthesize identificator = _id;

+(ResourceProxy*) proxyWithIdentificator:(NSString *)identificator {
    ResourceProxy* ret = [[ResourceProxy alloc]init];
    [ret setIdentificator:identificator];
    return ret;
}

-(id) init {
    _provisionerList = [[NSMutableArray alloc] init];
    return [super init];
}

-(void) addProvisioner:(id<IResourceProvisioner>)provisioner {
    [_provisionerList addObject:provisioner];
    
}
-(void) removeProvisioner:(id<IResourceProvisioner>)provisioner {
    [_provisionerList removeObject:provisioner];
}

-(id) getResource {
    NSMutableArray* _w2wList = [[NSMutableArray alloc] init];
    id ret = nil;
    for(id<IResourceProvisioner> prov in _provisionerList) {
        id resource = [prov getResource:_id];
        if(resource == nil) {
            [_w2wList addObject:prov];
            continue;
        }
        else {
            ret = resource;
            NSLog(@"_id = %@", _id); 
            for(id<IResourceProvisioner> rp in _w2wList)
                [rp setResourceID:_id withObject:resource];
            break;
        }
    }
    return ret;
}

-(void) getResourceAsync:(id<ResourceProxyDelegate>)delegate {
    
}



@end