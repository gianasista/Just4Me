//
//  ApplicationStore.m
//  Just4Me
//
//  Created by Vera Henneberger on 11.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ApplicationStore.h"

#import <Security/Security.h>
#import "KeychainItemWrapper.h"

static ApplicationStore *instance;
static BOOL isAuthenticated;

@implementation ApplicationStore

+ (ApplicationStore *) sharedInstance
{
	if(!instance)
	{
		instance = [[ApplicationStore alloc] init];
		isAuthenticated = NO;
	}
	
	return instance;
}

- (id) init
{
	self = [super init];
	if(self)
	{
		wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
		//[wrapper resetKeychainItem];
	}
	
	return self;
}

- (void) setPassword: (NSString *)password
{
	[wrapper setObject:password forKey: (id)kSecValueData];
}

- (NSString *) password
{
	return [wrapper objectForKey:(id)kSecValueData];
}

- (BOOL) hasPasswordSet
{
	return [[self password] length] > 0;
}

- (BOOL) isAuthenticated
{
	return isAuthenticated;
}

- (void) setAuthenticated: (BOOL) isAuth
{
	isAuthenticated = isAuth;
}

@end
