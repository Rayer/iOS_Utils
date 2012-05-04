//
//  FileSystemResourceProvisioner.m
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileSystemResourceProvisioner.h"

@implementation FileSystemResourceProvisioner

@synthesize targetCachePath = _path;
@synthesize dataDelegate = _dele;

+(FileSystemResourceProvisioner*) createProvisionerWithPath:(NSString*) path withParameterDelegate:(id<IDataConvertDelegate>) delegate {
    FileSystemResourceProvisioner* ret = [[FileSystemResourceProvisioner alloc] init];
    [ret setTargetCachePath:path];
    [ret setDataDelegate:delegate];
    NSFileManager* mgr = [NSFileManager defaultManager];
    
    NSLog(@"Checking FS Dir %@ : %@", path, [mgr fileExistsAtPath:path] ? @"YES" : @"NO");
    if([mgr fileExistsAtPath:path] == NO)
        [mgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    return ret;
}

-(NSString*) createReferencePathByString:(NSString*) identify {
    NSString* hash = [NSString stringWithFormat:@"%d", [identify hash]];
    return [_path stringByAppendingPathComponent:hash];
}


-(id)getResource:(NSString*)identify {
    NSLog(@"File cache : asked for %@", identify);

    NSFileManager* mgr = [NSFileManager defaultManager];
    NSString* path = [self createReferencePathByString:identify];
    BOOL fileExists = [mgr fileExistsAtPath:path];
    if(fileExists == NO)
        return nil;
    
    NSData* data = [mgr contentsAtPath:path];
    return [_dele convertDataToResource:data];
}

-(void)setResourceID:(NSString*)identify withObject:(id)obj {
    NSFileManager* mgr = [NSFileManager defaultManager];
    NSData* data = [_dele convertResourceToData:obj];
    NSString* path = [self createReferencePathByString:identify];
    [mgr removeItemAtPath:path error:nil];
    [mgr createFileAtPath:path contents:data attributes:nil];
}

-(void)clearResources {
    NSFileManager* mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:_path error:nil];
    [mgr createDirectoryAtPath:_path withIntermediateDirectories:YES attributes:nil error:nil];
}

-(BOOL)clearResourcesWithId:(NSString*) identificator {
    NSFileManager* mgr = [NSFileManager defaultManager];
    NSString* path = [self createReferencePathByString:identificator];
    if([mgr fileExistsAtPath:path] == NO)
        return NO;
    
    [mgr removeItemAtPath:path error:nil];
    return YES;
}

@end
