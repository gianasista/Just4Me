//
//  Photo.m
//  Just4Me
//
//  Created by Vera Henneberger on 06.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Photo.h"


@implementation Photo

- (id) initWithDictionary: (NSDictionary *) dictionary
{
	self = [super init];
	
	if(self)
	{
		//self.key = [
	}
	
	return self;
}

@synthesize key;
@synthesize tag;
@synthesize hasThumbnail;
@synthesize createdAt;

@end
