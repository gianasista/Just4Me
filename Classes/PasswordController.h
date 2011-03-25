//
//  PasswordController.h
//  Just4Me
//
//  Created by Vera Henneberger on 04.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PasswordDelegate;

@interface PasswordController : UIViewController <UIImagePickerControllerDelegate> {
	IBOutlet UITextField *passwordTextField;
}
@property (nonatomic, retain) NSData *data;
@property (nonatomic, assign) id delegate;

- (IBAction) passwordEntered;
- (void) updateData: (NSData *)data;

@end

@protocol PasswordDelegate
- (void) didCryptWithData: (NSData *) data;
- (BOOL) isEncryptMode;
@end
