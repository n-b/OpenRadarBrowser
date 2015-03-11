//
//  MasterViewController.h
//  OpenRadarBrowser
//
//  Created by Nicolas Bouilleaud on 11/03/2015.
//  Copyright (c) 2015 Nicolas Bouilleaud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

