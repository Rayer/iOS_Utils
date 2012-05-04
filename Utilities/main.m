//
//  main.m
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResourceProxy.h"
#import "FileSystemResourceProvisioner.h"
#import "MemoryResourceCacheProvisioner.h"
#import "NetResourceProvisioner.h"
#import "StringDCD.h"


id<IResourceProvisioner> memProvisioner;
id<IResourceProvisioner> fileProvisioner;
id<IResourceProvisioner> netProvisioner;


@interface NetResourceProvisionerDelegate : StringDCD <INetDataConvertDelegate>

@property (strong, atomic) NSString* currentID;

@end

@implementation NetResourceProvisionerDelegate

@synthesize currentID;

-(NSURL*) createResourceURL:(NSString*) identificator {
    NSString* targetURLString = [NSString stringWithFormat:@"http://api.appwondr.com/app/get/2.json?module=%@", identificator];
    return [NSURL URLWithString:targetURLString];
}

-(void) onResourceFetchingError:(NSError*) err {
    
}

@end

NetResourceProvisionerDelegate* netDelegate;


void activeTest() {
    for(int i = 0; i < 12; ++i) {
        NSString* idIndex = [NSString stringWithFormat:@"%d", i];
        ResourceProxy* proxy = [ResourceProxy proxyWithIdentificator:idIndex];
        [proxy addProvisioner:memProvisioner];
        [proxy addProvisioner:fileProvisioner];
        [netDelegate setCurrentID:idIndex];
        [proxy addProvisioner:netProvisioner];
        
        NSString* target = [proxy getResource];
        NSLog(@"%@", target == nil ? @"target not fetched" : @"target fetched");
    }
}


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        memProvisioner = [MemoryResourceCacheProvisioner createProvisioner];
        fileProvisioner = [FileSystemResourceProvisioner createProvisionerWithPath:@"/Users/Killercat/Desktop/TestCache" withParameterDelegate:[StringDCD new]];
        
        netDelegate = [[NetResourceProvisionerDelegate alloc] init];
        netProvisioner = [NetResourceProvisioner createProvisionerWithDelegate:netDelegate];
        
        
        //[fileProvisioner clearResources];
        NSLog(@"Start testing proxy");
        activeTest();
        
        NSLog(@"Supposed memory cache should works for now");
        activeTest();
        
    }
    return 0;
}

