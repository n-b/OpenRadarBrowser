#import "NSManagedObjectContext+OpenRadar.h"
#import "KVCMapping/KVCMapping.h"

@implementation NSManagedObjectContext (OpenRadar)

- (void) refreshFromOpenRadar
{
    id url = [NSURL URLWithString:@"http://openradar.appspot.com/api/radar?user=nicolas.bouilleaud@gmail.com"];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         id values = [self parseOpenRadarData:data];

         [self importOpenRadarValues:values];
         
         [self save:NULL]; // YOLO
     }];
    
}

- (id) parseOpenRadarData:(NSData*)data
{
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
}

- (void) importOpenRadarValues:(id)values
{
    id mapping = [[KVCModelMapping alloc] initWithMappingDictionary:
                  @{@"result": @{ @"Radar.identifier" :
                                      @{@"id" : @"identifier",
                                        @"description" : @"text",
                                        @"classification" : @"classification",
                                        @"number" : @"number",
                                        @"originated" : @"originated",
                                        @"product" : @"product",
                                        @"product_version" : @"productVersion",
                                        @"reproducible" : @"reproducible",
                                        @"resolved" : @"resolved",
                                        @"status" : @"status",
                                        @"title" : @"title",
                                        @"user" : @"user"
                                        }}
                    }];
    
    [self kvc_importObjects:values
           withModelMapping:mapping
                    options:@{KVCCreateObjectOption:@YES}];
}

@end
