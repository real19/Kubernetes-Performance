//
//  Constants.m
//  Kubernetes Performance
//
//  Created by Suleman Imdad on 2/17/20.
//  Copyright © 2020 Suleman Imdad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@implementation Constants

NSString * const kdata_URL = @"http://localhost:8080/api/v1.3/containers/";
NSString * const kCPU_Usage = @"CPU Usage";
NSString * const kMemory_Usage = @"Memory Usage";
NSString * const kISO_date_format = @"yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ";
NSString * const kShort_date_format = @"hh:mm:ss a";
NSString * const kStats = @"stats";
NSString * const kTimestamp = @"timestamp";
NSString * const kMemory = @"memory";
NSString * const kUsage = @"usage";
NSString * const kCPU= @"cpu";
NSString * const kTotal = @"total";

@end
