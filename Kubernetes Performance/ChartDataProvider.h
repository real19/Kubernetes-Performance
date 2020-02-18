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

@interface ChartDataProvider : NSObject


+ (void)getChartData:(LineChartData **)chartDataForMemory chartDataForPower:(LineChartData **)chartDataForPower statsArray:(NSMutableArray *)statsArray timeStamps:(NSMutableArray **)timeStamps;


@end
