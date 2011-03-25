    //
//  AuthentificationController.m
//  Just4Me
//
//  Created by Vera Henneberger on 12.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AuthentificationController.h"

#import "ApplicationStore.h"

@implementation AuthentificationController

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


- (void)viewDidLoad 
{
    [super viewDidLoad];
	[passwordTextField setSecureTextEntry:YES];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark Actions

- (IBAction) passwordEntered
{
	if ([passwordTextField.text isEqualToString:[[ApplicationStore sharedInstance] password]])
	{
		[[ApplicationStore sharedInstance] setAuthenticated:YES];
		[[UIApplication sharedApplication].delegate performSelector:@selector(startApplicationWithPasswordSet)];
	}
	else 
	{
		passwordTextField.text = @"";
	}
}


- (void)dealloc {
    [super dealloc];
}


@end
