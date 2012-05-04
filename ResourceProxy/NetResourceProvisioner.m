//
//  NetResourceProvisioner.m
//  Utilities
//
//  Created by Rayer Shih on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NetResourceProvisioner.h"



@implementation NetResourceProvisioner

@synthesize delegate = _dele;

+(NetResourceProvisioner*) createProvisionerWithDelegate:(id<INetDataConvertDelegate>) delegate {
    NetResourceProvisioner* ret = [[NetResourceProvisioner alloc] init];
    [ret setDelegate:delegate];
    return ret;
}

-(id)getResource:(NSString*)identify {
    NSLog(@"net cache : asked for %@", identify);

    NSURL* url = [_dele createResourceURL:identify];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    NSURLResponse* response = [[NSURLResponse alloc] init];
    NSError* error = [[NSError alloc] init ];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    //is this really required?
    if(data == nil) {
        [_dele onResourceFetchingError:error];
        return nil;
    }
    
    return [_dele convertDataToResource:data];
}

-(void)setResourceID:(NSString*)identify withObject:(id)obj {
    //do nothing
}

-(void)clearResources {
    //do nothing, maybe implements HTTPDEL?
}

-(BOOL)clearResourcesWithId:(NSString*) identificator {
    //do nothing, maybe implements HTTPDEL?
    return NO;
}

@end
