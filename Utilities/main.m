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

@interface ProxyDelegate : NSObject <IResourceProxyDelegate>
@end

@implementation ProxyDelegate

-(void) provisionerBeingRead:(id<IResourceProvisioner>) prov andResource:(id)data {
    
}

-(void) provisionerBeingWritten:(id<IResourceProvisioner>) prov andResource:(id)data {
    
}

-(void) onEndGetResource:(id) res andByProvisioner:(id<IResourceProvisioner>)prov andWithIdentify:(NSString *)identify{
    //NSLog(@"get resource : %@", res);
    NSLog(@"End retrieving data : %@", identify);
}

@end

NetResourceProvisionerDelegate* netDelegate;


void activeTest() {
    ResourceProxy* proxy = [ResourceProxy proxyWithIdentificator:nil andForceUpdate:NO];
    [proxy addProvisioner:memProvisioner];
    [proxy addProvisioner:fileProvisioner];
    [proxy addProvisioner:netProvisioner];

    for(int i = 0; i < 240; ++i) {
        NSString* idIndex = [NSString stringWithFormat:@"%d", i];
        [proxy setIdentificator:idIndex];
        [proxy setForceUpdate:NO];
        [netDelegate setCurrentID:idIndex];
        
        NSString* target = [proxy getResource];
        NSLog(@"%@", target == nil ? @"target is not fetched" : @"target is fetched");
    }
}

void activeThreadTest() {
    
    for(int i = 0; i < 240; ++i) {
        NSString* idIndex = [NSString stringWithFormat:@"%d", i];
        
        ResourceProxy* proxy = [ResourceProxy proxyWithIdentificator:idIndex andForceUpdate:NO];
        [proxy addProvisioner:memProvisioner];
        [proxy addProvisioner:fileProvisioner];
        [proxy addProvisioner:netProvisioner];

        [netDelegate setCurrentID:idIndex];
        
        [proxy getResourceAsync:[[ProxyDelegate alloc] init]];
        //NSString* target = [proxy getResource];
        //NSLog(@"%@", target == nil ? @"target is not fetched" : @"target is fetched");
    }
    
    
}


int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        memProvisioner = [MemoryResourceCacheProvisioner createProvisioner];
        fileProvisioner = [FileSystemResourceProvisioner createProvisionerWithPath:@"/Users/Killercat/Desktop/TestCache" withParameterDelegate:[StringDCD new]];
        
        netDelegate = [[NetResourceProvisionerDelegate alloc] init];
        netProvisioner = [NetResourceProvisioner createProvisionerWithDelegate:netDelegate];
        
        
        activeThreadTest();
        while(YES)
            [NSThread sleepForTimeInterval:20];
        //[fileProvisioner clearResources];
//        NSLog(@"Start testing proxy");
//        activeTest();
//        
//        NSLog(@"Supposed memory cache should works for now");
//        activeTest();
        
    }
    return 0;
}

