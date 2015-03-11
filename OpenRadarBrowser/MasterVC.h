@import UIKit;
@import CoreData;

@interface MasterVC : UITableViewController <NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSManagedObjectContext *moc;
@end

