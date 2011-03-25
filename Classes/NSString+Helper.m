//
//  NSString+Helper.m
//  Just4Me
//
//  Created by Vera Henneberger on 06.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString+Helper.h"


@implementation NSString (Helper)

- (NSString *) pathInDocumentsDirectory
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	
	return [documentsDirectory stringByAppendingPathComponent:self];
}
@end
