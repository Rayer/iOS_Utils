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
@synthesize forceUpdate = _forceUpdate;

+(ResourceProxy*) proxyWithIdentificator:(NSString *)identificator andForceUpdate:(BOOL) force{
    ResourceProxy* ret = [[ResourceProxy alloc]init];
    [ret setIdentificator:identificator];
    [ret setForceUpdate:force];
    return ret;
}

-(id) init {
    //_provisionerList = [[NSMutableArray alloc] init];
    [self setProvisionerList:[[NSMutableArray alloc] init]];
    return [super init];
}

-(void) addProvisioner:(id<IResourceProvisioner>)provisioner {
    [_provisionerList addObject:provisioner];
    
}
-(void) removeProvisioner:(id<IResourceProvisioner>)provisioner {
    [_provisionerList removeObject:provisioner];
}

-(id) getResource {
    return [self getResourceWithDelegate:nil];
}

-(id) getResourceWithDelegate:(id<IResourceProxyDelegate>) delegate {
    
    NSLog(@"initialize getResourceWithDelegate with resource id = %@", _id);
    NSMutableArray* _w2wList = [[NSMutableArray alloc] init];
    id ret = nil;
    id<IResourceProvisioner> elightableProv = nil;
    for(id<IResourceProvisioner> prov in _provisionerList) {
        //[delegate 
        id resource = [prov getResource:_id];
        [delegate provisionerBeingRead:prov andResource:resource];
        if(resource == nil) {
            [_w2wList addObject:prov];
            continue;
        }
        else {
            ret = resource;
            elightableProv = prov;
            NSLog(@"_id = %@", _id); 
            for(id<IResourceProvisioner> rp in _w2wList) {
                [rp setResourceID:_id withObject:resource];
                [delegate provisionerBeingWritten:prov andResource:resource];
            }
            break;
        }
    }
    [delegate onEndGetResource:ret andByProvisioner:elightableProv andWithIdentify:_id];
    return ret;
    
}

-(void) getResourceAsync:(id<IResourceProxyDelegate>)delegate {
    [NSThread detachNewThreadSelector:@selector(getResourceWithDelegate:) toTarget:self withObject:delegate];
}



@end