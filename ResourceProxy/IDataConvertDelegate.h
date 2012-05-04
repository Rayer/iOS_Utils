//
//  IDataConvertDelegate.h
//  Utilities
//
//  Created by Rayer Shih on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IDataConvertDelegate <NSObject>
@required
-(id) convertDataToResource:(NSData*) data;
-(NSData*) convertResourceToData:(id) resource;
@end