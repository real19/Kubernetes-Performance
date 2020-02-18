//
//  Stats.h
//  Kubernetes Performance
//
//  Created by Suleman Imdad on 2/17/20.
//  Copyright © 2020 Suleman Imdad. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <Charts-Swift.h>
#import "Constants.h"

@interface Stats : NSObject

@property (strong, nonatomic) NSString * dateString;
@property (nonatomic) double cpuUsage;
@property (nonatomic) double  memoryUsage;

- (instancetype)initWithDate:(NSString *) dateString  cpuUsage:(double) cpuUsage memoryUsage:(double) memoryUsage;
+ (void)getDataWithCompletion:(void (^)(NSMutableArray *statsArray))block;
@end
