//
//  AuthentificationController.h
//  Just4Me
//
//  Created by Vera Henneberger on 12.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AuthentificationController : UIViewController {
	IBOutlet UITextField *passwordTextField;
}

- (IBAction) passwordEntered;

@end
