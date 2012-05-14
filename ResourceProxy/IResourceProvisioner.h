//
//  IResourceProvisioner.h
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol IResourceProvisioner
@required
-(id)getResource:(NSString*)identify;
-(void)setResourceID:(NSString*)identify withObject:(id)obj;
@optional
-(void)clearResources;
-(BOOL)clearResourcesWithId:(NSString*) identificator;
@end