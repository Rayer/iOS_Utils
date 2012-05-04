//
//  NetResourceProvisioner.h
//  Utilities
//
//  Created by Rayer Shih on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IResourceProvisioner.h"
#import "IDataConvertDelegate.h"

@protocol INetDataConvertDelegate <IDataConvertDelegate>

@required
-(NSURL*) createResourceURL:(NSString*) identificator;

@optional
-(void) onResourceFetchingError:(NSError*) err;

@end

@interface NetResourceProvisioner : NSObject <IResourceProvisioner>

+(NetResourceProvisioner*) createProvisionerWithDelegate:(id<INetDataConvertDelegate>) delegate;

@property (strong, atomic) id<INetDataConvertDelegate> delegate;
@end
