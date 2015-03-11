#import "AllYouCanEatDateTransformer.h"

@implementation AllYouCanEatDateTransformer
{
    NSMutableArray * dateFormatters;
    NSDataDetector * dataDetector;
    NSCalendar * gregorian;
    NSDate * lastParsedDate;
}

+ (void)load
{
    [NSValueTransformer setValueTransformer:[self new] forName:@"allYouCanEatDate"];
}

- (id)init
{
    self = [super init];
    if (self) {
        gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        dateFormatters = [NSMutableArray new];
        NSArray * formats = [NSArray arrayWithObjects:
                             @"EEE, dd MMM yyyy HH:mm:ss zzz",
                             
                             @"yyyy-MM-dd'T'HH:mmZZZ",
                             
                             @"dd MMM yyyy hh:mm:ss zzz",
                             @"dd-MMM-yyyy hh:mm:ss a",
                             @"dd-MMM-yyyy hh:mm a zzz",
                             @"dd MMM yyyy hh:mm a zzz",
                             @"dd-MMM-yyyy hh:mm a",
                             @"dd-MMM-yyyy HH:mm",
                             @"dd MMMM yyyy",
                             
                             @"EEE MMM dd yyyy",
                             @"EEE MMM dd, yyyy",
                             @"MMMM dd, yyyy",
                             @"MMMM dd yyyy",
                             @"MMM dd, yyyy",
                             @"MMM dd,yyyy",
                             @"MM/dd/yyyy",
                             @"M-dd-yyyy",
                             @"MM.dd.yyyy",
                             @"MM/dd.yyyy",
                             @"MM.dd.yy",
                             
                             @"dd-MMM-yyyy",
                             @"dd/MM/yyyy",
                             @"dd-MM-yyyy",
                             @"dd.MM.yyyy",
                             @"dd.MM.yy",
                             
                             @"yyyy-MM-dd",
                             @"yyyy/MM/dd",
                             @"yyyyMMdd",
                             nil];
        for (NSString * format in formats) {
            NSDateFormatter * dateFormatter = [NSDateFormatter new];
            [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
            [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            [dateFormatter setDateFormat:format];
            [dateFormatters addObject:dateFormatter];
        }
        
        NSError * error = nil;
        dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeDate
                                                       error:&error];
    }
    return self;
}

+ (Class)transformedValueClass
{
    return [NSDate self];
}

- (id)transformedValue:(NSString*)value
{
    if(![value isKindOfClass:[NSString self]] || [value length]==0)
        return nil;
    
    NSTextCheckingResult * result = [[dataDetector matchesInString:value options:0 range:NSMakeRange(0, [value length])] lastObject];
    NSDate * date2 = result.date;
    NSDateComponents * components = [gregorian components:NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:date2];
    if ( components.hour==12
        && components.minute==0
        && components.second==0) {
        date2 = [date2 dateByAddingTimeInterval:-12*3600];// data detector creates dates at noon if no other info is passed, which is a bit of a fallacy.
    }
    
    if(result.timeZone==nil) // data detectors assume local timezone
        date2 = [date2 dateByAddingTimeInterval:(double)(int)[[NSTimeZone localTimeZone] secondsFromGMTForDate:date2]];
    
    NSDate * date1 = nil;
    for (NSDateFormatter * formatter in dateFormatters) {
        date1 = [formatter dateFromString:value];
        if (date1)
            break;
    }
    if(date1 && date2 && ![date1 isEqualToDate:date2])
    {
        NSLog(@"value: %@, dd: %@ df: %@. Laste date : %@",value, date2, date1, lastParsedDate);
        if(lastParsedDate==nil || fabs([lastParsedDate timeIntervalSinceDate:date1]) < fabs([lastParsedDate timeIntervalSinceDate:date2]))
        {
            NSLog(@" choosing df");
            lastParsedDate = date1;
            return date1;
        }
        else {
            NSLog(@" choosing dd");
            lastParsedDate = date2;
            return date2;
        }
    }
    
    if (date1)
        return date1;
    if (date2)
    {
        NSLog(@"data detector saves the day %@ > %@",value, date2);
        return date2;
    }
    
    //    if(![value isEqual:@"NO"]&&![value isEqual:@"No"]&&![value isEqual:@"no"]&&![value isEqual:@"Yes"]&&![value isEqual:@"Unknown"]&&![value hasPrefix:@"Duplicate"])
    //        NSLog(@"unparsed string : %@",value);
    return nil;
}


@end
