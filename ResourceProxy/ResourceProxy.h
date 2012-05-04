//
//  ResourceProxy.h
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IResourceProvisioner.h"

@protocol ResourceProxyDelegate <NSObject>
-(void) onProvisionerRead:(id<IResourceProvisioner>) prov andResource:(id)data;
-(void) onProvisionerwrite:(id<IResourceProvisioner>) prov andResource:(id)data;


@end

@interface ResourceProxy : NSObject

+(ResourceProxy*) proxyWithIdentificator:(NSString*) identificator;

-(void) addProvisioner:(id<IResourceProvisioner>)provisioner;
-(void) removeProvisioner:(id<IResourceProvisioner>)provisioner;
-(id) getResource;
-(void) getResourceAsync:(id<ResourceProxyDelegate>)delegate;

@property(strong, atomic) NSMutableArray* provisionerList;
@property(strong, nonatomic) NSString* identificator;
@end
