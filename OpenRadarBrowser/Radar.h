@import Foundation;
@import CoreData;


@interface Radar : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * classification;
@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSString * originated;
@property (nonatomic, retain) NSString * product;
@property (nonatomic, retain) NSString * productVersion;
@property (nonatomic, retain) NSString * reproducible;
@property (nonatomic, retain) NSString * resolved;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * user;

@end
