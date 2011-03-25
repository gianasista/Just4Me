//
//  PhotoList.m
//  Just4Me
//
//  Created by Vera Henneberger on 06.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PhotoList.h"

#import "NSString+Helper.h"

static NSMutableArray *photoList;

@implementation PhotoList

+ (void) initialize
{
	NSString *photoListFile = [@"PhotoList.plist" pathInDocumentsDirectory];
	NSData *photoListData = [NSData dataWithContentsOfFile:photoListFile];
	NSArray *photoListRaw = [NSPropertyListSerialization propertyListFromData:photoListData
													mutabilityOption:0
															  format:NULL
													errorDescription:NULL];
	
	
}



@end
