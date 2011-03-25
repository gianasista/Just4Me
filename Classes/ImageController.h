//
//  ImageController.h
//  Just4Me
//
//  Created by Vera Henneberger on 03.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageController : UIViewController {
	IBOutlet UIImageView *imageView;
	IBOutlet UIScrollView *scrollView;
}

- (void) setImageData: (NSData *) data;

@end
