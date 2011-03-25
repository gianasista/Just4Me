//
//  ImageController.m
//  Just4Me
//
//  Created by Vera Henneberger on 03.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageController.h"

#import "Just4MeAppDelegate.h"
#import "ApplicationStore.h"

@interface ImageController()
@property (nonatomic, retain) UIImage *image;
@end

@implementation ImageController


- (void) setImageSource: (UIImage *) image
{
	self.image = image;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

- (void) viewWillAppear: (BOOL) animated
{
	[imageView setImage:self.image];
	[imageView sizeToFit];
	//[imageView setFr]
	imageView.frame = CGRectMake(0.0, 0.0, imageView.frame.size.width, imageView.frame.size.height);
	[scrollView setContentSize:self.image.size];
	float minimumScale = [scrollView frame].size.width  / self.image.size.width;
	scrollView.minimumZoomScale = minimumScale;
	[scrollView setZoomScale:minimumScale];
	
	/*
	NSLog(@"Image: %@", NSStringFromCGSize(self.image.size));
	NSLog(@"Scrollview: %@", NSStringFromCGSize(scrollView.frame.size));
	NSLog(@"ImageView: %@", NSStringFromCGSize(imageView.frame.size));
	NSLog(@"Minimum scale: %f", minimumScale);
	 */
	NSLog(@"ImageView: %@", NSStringFromCGPoint(imageView.frame.origin));
	NSLog(@"ScrollView: %@", NSStringFromCGPoint(scrollView.frame.origin));
	
}

- (void) viewWillDisappear: (BOOL) animated
{
	self.image = nil;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad 
{
    [super viewDidLoad];
	NSLog(@"Gefundenes Password in der Keychain: %@", [[ApplicationStore sharedInstance] password]);
}


- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) interfaceOrientation 
{
    return YES;
}

- (void) didRotateFromInterfaceOrientation: (UIInterfaceOrientation) fromInterfaceOrientation 
{
    [imageView sizeToFit];
	//[imageView setFr]
	imageView.frame = CGRectMake(0.0, 0.0, imageView.frame.size.width, imageView.frame.size.height);
	[scrollView setContentSize:self.image.size];
	float minimumScale = [scrollView frame].size.width  / self.image.size.width;
	scrollView.minimumZoomScale = minimumScale;
	[scrollView setZoomScale:minimumScale];
}

#pragma mark UIScrollViewDelegate

- (UIView *) viewForZoomingInScrollView: (UIScrollView *) scrollView
{
	return imageView;
}

- (void) scrollViewWillBeginZooming: (UIScrollView *) scrollView withView: (UIView *) view
{
}

- (void) scrollViewDidEndZooming: (UIScrollView *) scrollView withView: (UIView *) view atScale: (float) scale
{
	[scrollView setZoomScale:scale animated:NO];
}

- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewDidUnload 
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) setImageData: (NSData *) data
{
	UIImage * image = [[UIImage alloc] initWithData:data];
	[self setImageSource:image];
	[image release];
}

- (BOOL) isEncryptMode
{
	return NO;
}


- (void) dealloc 
{
	self.image = nil;
    [super dealloc];
}

@synthesize image;

@end
