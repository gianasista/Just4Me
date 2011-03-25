    //
//  SetPasswordController.m
//  Just4Me
//
//  Created by Vera Henneberger on 12.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SetPasswordController.h"

#import "ApplicationStore.h"


@implementation SetPasswordController

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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

#pragma mark Actions

- (IBAction) save
{
	NSString *password = passwordField.text;
	NSString *confirm = confirmField.text;
	
	if( ([password length] > 1) && [password isEqualToString:confirm])
	{
		[[ApplicationStore sharedInstance] setPassword:password];
		[[UIApplication sharedApplication].delegate performSelector: @selector(startApplicationWithPasswordSet)];
	}
}

- (void) dealloc 
{
    [super dealloc];
}

@end
