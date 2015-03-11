#import "AppDelegate.h"
#import "DetailVC.h"
#import "MasterVC.h"

@interface AppDelegate ()
@property (nonatomic) NSManagedObjectContext *moc;
@property (nonatomic) NSManagedObjectModel *mom;
@property (nonatomic) NSPersistentStoreCoordinator *psc;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Setup CoreData stack
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OpenRadarBrowser" withExtension:@"momd"];
    self.mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    self.psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.mom];
    NSURL *storeURL = [[[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"OpenRadarBrowser.coredata"];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:NULL];
    NSError *error = nil;
    if (![self.psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }

    self.moc = [NSManagedObjectContext new];
    [self.moc setPersistentStoreCoordinator:self.psc];

    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    MasterVC *controller = (MasterVC *)navigationController.topViewController;
    controller.moc = self.moc;
    return YES;
}

@end
