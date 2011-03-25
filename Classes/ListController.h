//
//  ListController.h
//  Just4Me
//
//  Created by Vera Henneberger on 03.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class ImageController;

@interface ListController : UITableViewController <UIImagePickerControllerDelegate, NSFetchedResultsControllerDelegate> 
{
	IBOutlet UIImagePickerController *pickerController;
	IBOutlet UIImagePickerController *cameraController;
	
@private
    NSFetchedResultsController *fetchedResultsController_;
    NSManagedObjectContext *managedObjectContext_;
	
}

@property (nonatomic, retain) IBOutlet ImageController *imageController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
