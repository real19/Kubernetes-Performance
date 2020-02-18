//
//  Stats.m
//  Kubernetes Performance
//
//  Created by Suleman Imdad on 2/17/20.
//  Copyright © 2020 Suleman Imdad. All rights reserved.
//

#import "ChartDataProvider.h"
#import "Stats.h"
#import "Constants.h"


@implementation ChartDataProvider


+ (void)getChartData:(LineChartData **)chartDataForMemory chartDataForPower:(LineChartData **)chartDataForPower statsArray:(NSMutableArray *)statsArray timeStamps:(NSMutableArray **)timeStamps {
    NSMutableArray * lineChartEntryForPowerArray = [[NSMutableArray alloc] init];
    NSMutableArray * lineChartEntryForMemoryArray = [[NSMutableArray alloc] init];
    *timeStamps = [[NSMutableArray alloc] init];
    NSArray* colors = @[[NSColor textColor]];
    
    for (int i = 0; i < statsArray.count; i++){
        Stats * stats = [statsArray objectAtIndex:i];
        
        ChartDataEntry * lineChartEntryForPower = [[ChartDataEntry alloc] init];
        ChartDataEntry * lineChartEntryForMemory = [[ChartDataEntry alloc] init];
        
        lineChartEntryForPower.x = i;
        lineChartEntryForPower.y = stats.cpuUsage;
        
        lineChartEntryForMemory.x = i;
        lineChartEntryForMemory.y = stats.memoryUsage;
        
        [lineChartEntryForPowerArray addObject:lineChartEntryForPower];
        [lineChartEntryForMemoryArray addObject:lineChartEntryForMemory];
        [*timeStamps addObject:stats.dateString];
        
    }
    
    LineChartDataSet * dataSetForPower = [[LineChartDataSet alloc] initWithEntries:lineChartEntryForPowerArray label:kCPU_Usage];
    LineChartDataSet * dataSetForMemory = [[LineChartDataSet alloc] initWithEntries:lineChartEntryForMemoryArray label:kMemory_Usage];
    
    dataSetForMemory.colors = colors;
    dataSetForMemory.drawCirclesEnabled = false;
    dataSetForMemory.drawFilledEnabled = true ;
    dataSetForMemory.drawValuesEnabled = false;
    dataSetForMemory.mode = LineChartModeCubicBezier;
    
    dataSetForPower.colors = colors;
    dataSetForPower.drawCirclesEnabled = false;
    dataSetForPower.drawFilledEnabled = true ;
    dataSetForPower.drawValuesEnabled = false;
    dataSetForPower.mode = LineChartModeCubicBezier;
    
    dataSetForPower.fillColor = [NSColor greenColor];
    
    *chartDataForPower = [[LineChartData alloc] initWithDataSets:@[dataSetForPower]];
    *chartDataForMemory = [[LineChartData alloc] initWithDataSets:@[dataSetForMemory]];
}




@end
