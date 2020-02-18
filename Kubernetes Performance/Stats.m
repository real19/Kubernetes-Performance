//
//  Stats.m
//  Kubernetes Performance
//
//  Created by Suleman Imdad on 2/17/20.
//  Copyright © 2020 Suleman Imdad. All rights reserved.
//

#import "Stats.h"



@implementation Stats

@synthesize dateString, cpuUsage, memoryUsage;

- (instancetype)initWithDate:(NSString *) dateString  cpuUsage:(double) cpuUsage memoryUsage:(double) memoryUsage{
    self = [super init];
    if (self) {
        self.dateString = dateString;
        self.cpuUsage = cpuUsage;
        self.memoryUsage = memoryUsage;
    }
    return self;
}

+ (void)getDataWithCompletion:(void (^)(NSMutableArray *statsArray))block{
    NSDateFormatter *iSODateformatter = [[NSDateFormatter alloc]init];
    [iSODateformatter setDateFormat:kISO_date_format];
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
       [timeFormatter setDateFormat:kShort_date_format];
    NSURL *url = [NSURL URLWithString:kdata_URL];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession]
      dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil){
            NSLog(@"%@",[error localizedDescription]);
        } else {
            NSArray * jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSArray *statsData = [jsonArray valueForKey:kStats];
            NSMutableArray *statsArray = [[NSMutableArray alloc] init];
            
            for( int i = 0; i < statsData.count; i++) {
                
                NSString *timestamp = [statsData[i] valueForKey:kTimestamp];
                NSDate *datetime = [iSODateformatter dateFromString:timestamp];
                
                NSString * timeStamp = [timeFormatter stringFromDate:datetime];
                double memoryUsage = [[[statsData[i] valueForKey:kMemory] valueForKey:kUsage] doubleValue];
                double cpuUsage = [[[[statsData[i] valueForKey:kCPU] valueForKey:kUsage] valueForKey:kTotal] doubleValue];
                
                //NSLog(@" memory usage at %d is : %f", i, memoryUsage);
                Stats * stats = [[Stats alloc] initWithDate:timeStamp cpuUsage:cpuUsage memoryUsage:memoryUsage];
                [statsArray addObject:stats];
            }
        
            block(statsArray);
        }
    }];
    [dataTask resume];
    
}

@end
