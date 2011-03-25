//
//  Photo.h
//  Just4Me
//
//  Created by Vera Henneberger on 06.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Photo : NSObject 

@property (nonatomic, assign) NSUInteger key;
@property (nonatomic, retain) NSString *tag;
@property (nonatomic, assign) BOOL hasThumbnail;
@property (nonatomic, retain) NSDate *createdAt;

@end
