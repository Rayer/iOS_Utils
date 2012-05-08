//
//  ResourceProxy.h
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IResourceProvisioner.h"

@protocol IResourceProxyDelegate <NSObject>
-(void) provisionerBeingRead:(id<IResourceProvisioner>) prov andResource:(id)data;
-(void) provisionerBeingWritten:(id<IResourceProvisioner>) prov andResource:(id)data;
-(void) onEndGetResource:(id)res andByProvisioner:(id<IResourceProvisioner>) prov andWithIdentify:(NSString*)identify;
@end

@interface ResourceProxy : NSObject


+(ResourceProxy*) proxyWithIdentificator:(NSString*) identificator andForceUpdate:(BOOL)force; 
//有setIndentificator / setForceUpdate in properties

-(void) addProvisioner:(id<IResourceProvisioner>)provisioner;
-(void) removeProvisioner:(id<IResourceProvisioner>)provisioner;
-(id) getResourceWithDelegate:(id<IResourceProxyDelegate>) delegate;
-(id) getResource;
-(void) getResourceAsync:(id<IResourceProxyDelegate>)delegate;

@property(strong, atomic) NSMutableArray* provisionerList;
@property(strong, nonatomic) NSString* identificator;
@property BOOL forceUpdate;
@end
