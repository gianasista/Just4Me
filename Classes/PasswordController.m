//
//  PasswordController.m
//  Just4Me
//
//  Created by Vera Henneberger on 04.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PasswordController.h"

#import "NSData+AES256.h"

@implementation PasswordController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad 
{
    [super viewDidLoad];
	[self.navigationItem setHidesBackButton:YES];
	passwordTextField.secureTextEntry = YES;
}

- (IBAction) passwordEntered
{
	NSString *password = passwordTextField.text;
	
	NSData *result = [self.delegate isEncryptMode] ? [self.data AES256EncryptWithKey:password] : [self.data AES256DecryptWithKey:password];	
	[self.delegate didCryptWithData:result];
}

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{	
	UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	[self dismissModalViewControllerAnimated:YES];
	NSData *data = UIImagePNGRepresentation(selectedImage);
	[self updateData:data];
}

- (void) updateData: (NSData *) data
{
	self.data = data;
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


- (void) dealloc 
{
	self.data = nil;
    [super dealloc];
}

@synthesize data;
@synthesize delegate;


@end
