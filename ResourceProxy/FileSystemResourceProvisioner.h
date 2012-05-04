//
//  FileSystemResourceProvisioner.h
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IResourceProvisioner.h"
#import "IDataConvertDelegate.h"


@interface FileSystemResourceProvisioner : NSObject <IResourceProvisioner>

+(FileSystemResourceProvisioner*) createProvisionerWithPath:(NSString*) path withParameterDelegate:(id<IDataConvertDelegate>) delegate;



@property NSString* targetCachePath;
@property id<IDataConvertDelegate> dataDelegate;
@end
