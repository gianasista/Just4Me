//
//  ApplicationStore.h
//  Just4Me
//
//  Created by Vera Henneberger on 11.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KeychainItemWrapper;

@interface ApplicationStore : NSObject {
	@private
	KeychainItemWrapper *wrapper;
}

+ (ApplicationStore *) sharedInstance;

- (void) setPassword: (NSString *)password;
- (NSString *) password;
- (BOOL) hasPasswordSet;

- (BOOL) isAuthenticated;
- (void) setAuthenticated: (BOOL) isAuth;
@end
