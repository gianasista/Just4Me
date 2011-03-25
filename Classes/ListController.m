//
//  ListController.m
//  Just4Me
//
//  Created by Vera Henneberger on 03.08.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ListController.h"

#import "ApplicationStore.h"
#import "NSData+AES256.h"
#import "ImageController.h"

@interface ListController ()
- (NSManagedObject *) insertNewObject;
@end

@implementation ListController


#pragma mark -
#pragma mark View lifecycle


- (void) viewDidLoad 
{
	[super viewDidLoad];
	
	self.title = @"Liste";
	
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
	
	if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
	{
		cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;
		UIBarButtonItem *cameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(camera:)];
		self.navigationItem.leftBarButtonItem = cameraButton;
		[cameraButton release];
	}
}

- (void) add: (id) sender
{
	[self presentModalViewController:pickerController animated:YES];
}

- (void) camera: (id)sender
{
	[self presentModalViewController:cameraController animated:YES];
}


/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView 
{
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section 
{
	/*
	NSInteger anzahl = [[NSUserDefaults standardUserDefaults] integerForKey:@"bilderAnzahl"];
    return anzahl;
	 */
	id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


// Customize the appearance of table view cells.
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath 
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	/*
	cell.textLabel.text = [NSString stringWithFormat:@"image number %d", indexPath.row];
    */
	
	NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSDate *date = [managedObject valueForKey:@"createdAt"];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *dateString = [formatter stringFromDate:date];
	 
	[formatter release];
	
    cell.textLabel.text = dateString;
	UIImage *image = [UIImage imageNamed:@"Schloss.png"];
	[cell.imageView setImage:image];
	
	// Configure the cell.
	
    return cell;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
         *error = nil;
        if (![context save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}
*/

- (BOOL) tableView: (UITableView *) tableView canMoveRowAtIndexPath: (NSIndexPath *) indexPath 
{
    // The table view should not be re-orderable.
    return NO;
}

- (void) tableView: (UITableView*) tableView willBeginEditingRowAtIndexPath: (NSIndexPath *) indexPath
{
	NSLog(@"willBeginEditingRowAtIndexPath");
}

- (void) tableView: (UITableView *) tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath: (NSIndexPath *) indexPath
{
	// notwendig fuer swipe-to-delete
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
		[context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
		
		NSError *error;
		if (![context save:&error]) 
		{
			NSLog(@"Unresolved error while deleting row, %@, %@", error, [error userInfo]);
		}
		//else 
//		{
//			[self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//		}
	}
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    
	/*
	NSInteger index = indexPath.row;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *filename = [NSString stringWithFormat:@"image_%d.data", index];
	
	NSString *writablePath = [documentsDirectory stringByAppendingPathComponent:filename];
	
	NSData* data = [fileManager contentsAtPath:writablePath];
	NSData* decrypted = [data AES256DecryptWithKey:[[ApplicationStore sharedInstance] password]];
	[self.imageController setImageData: decrypted];
	
	[self.navigationController pushViewController:self.imageController animated:YES];
	*/
	NSManagedObject *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	//NSLog(@"ObjectId (EntityDesc): %@", [[selectedObject objectID] entity]);
	
	NSString *uuid = [selectedObject valueForKey:@"uuid"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *filename = uuid;
	
	NSString *writablePath = [documentsDirectory stringByAppendingPathComponent:filename];
	
	NSData* data = [fileManager contentsAtPath:writablePath];
	NSData* decrypted = [data AES256DecryptWithKey:[[ApplicationStore sharedInstance] password]];
	[self.imageController setImageData: decrypted];
	
	[self.navigationController pushViewController:self.imageController animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void) viewDidUnload 
{
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

/*
- (void) didCryptWithData: (NSData *) data
{
	[self.navigationController popViewControllerAnimated:NO];
	NSInteger anzahl = [[NSUserDefaults standardUserDefaults] integerForKey:@"bilderAnzahl"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *fileName = [NSString stringWithFormat:@"image_%d.data", ++anzahl];
	NSString *writablePath = [documentsDirectory stringByAppendingPathComponent:fileName];
	
	NSLog(@"Filename: %@", writablePath);
	
	[fileManager createFileAtPath:writablePath contents:data attributes:nil];
	
	[[NSUserDefaults standardUserDefaults] setInteger:anzahl forKey:@"bilderAnzahl"];
	
	[self.tableView reloadData];
}
 */

- (BOOL) isEncryptMode
{
	return YES;
}

#pragma mark UIImagePickerControllerDelegate

- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info
{	
	NSManagedObject *newRow = [self insertNewObject];
	
	UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
	[self dismissModalViewControllerAnimated:YES];
	NSData *data = UIImagePNGRepresentation(selectedImage);
	NSData *result = [data AES256EncryptWithKey:[[ApplicationStore sharedInstance] password]];
	
	//NSInteger anzahl = [[NSUserDefaults standardUserDefaults] integerForKey:@"bilderAnzahl"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
	
	//NSString *fileName = [NSString stringWithFormat:@"image_%d.data", anzahl++];
	NSString *fileName = [newRow valueForKey:@"uuid"];
	NSString *writablePath = [documentsDirectory stringByAppendingPathComponent:fileName];
	
	NSLog(@"Filename: %@", writablePath);
	
	[fileManager createFileAtPath:writablePath contents:result attributes:nil];
	
	//[[NSUserDefaults standardUserDefaults] setInteger:anzahl forKey:@"bilderAnzahl"];
	//NSLog(@"User default %d", [[NSUserDefaults standardUserDefaults] integerForKey:@"bilderAnzahl"]);
	
	//[newRow setValue:fileName forKey:@"filename"];	
	
	[self.tableView reloadData];
	
}

#pragma mark Add a new object

- (NSManagedObject *) insertNewObject 
{
    
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
	[newManagedObject setValue:[NSDate date] forKey:@"createdAt"];
	
	CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
	NSString *uString = (NSString *)CFUUIDCreateString(NULL, uuidRef);
	CFRelease(uuidRef);
    [newManagedObject setValue:uString forKey:@"uuid"];
	[uString release];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
	
	return newManagedObject;
}

#pragma mark Fetched results controller

- (NSFetchedResultsController *) fetchedResultsController 
{
    
    if (fetchedResultsController_ != nil) {
        return fetchedResultsController_;
    }
    
    /*
     Set up the fetched results controller.
	 */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdAt" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
    NSError *error = nil;
    if (![fetchedResultsController_ performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return fetchedResultsController_;
}    


#pragma mark -
#pragma mark Fetched results controller delegate


- (void) controllerWillChangeContent: (NSFetchedResultsController *) controller 
{
    [self.tableView beginUpdates];
}


- (void) controller: (NSFetchedResultsController *) controller didChangeSection: (id <NSFetchedResultsSectionInfo>) sectionInfo
           atIndex: (NSUInteger) sectionIndex forChangeType: (NSFetchedResultsChangeType) type 
{
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void) controller: (NSFetchedResultsController *) controller didChangeObject: (id) anObject
        atIndexPath: (NSIndexPath *) indexPath forChangeType: (NSFetchedResultsChangeType) type
       newIndexPath: (NSIndexPath *) newIndexPath 
{
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void) controllerDidChangeContent: (NSFetchedResultsController *) controller 
{
    [self.tableView endUpdates];
}


- (void) dealloc 
{
	[fetchedResultsController_ release];
    [managedObjectContext_ release];
	self.imageController = nil;
    [super dealloc];
}

@synthesize imageController;
@synthesize fetchedResultsController=fetchedResultsController_, managedObjectContext=managedObjectContext_;


@end
