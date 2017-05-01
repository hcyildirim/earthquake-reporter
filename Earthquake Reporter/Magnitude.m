//
//  Magnitude.m
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 01/05/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import "Magnitude.h"

@implementation Magnitude
    
    + (UIColor *)colorForMagnitude:(int)magnitude {
        
        UIColor *color;
        
        switch (magnitude) {
            case 0:
            case 1:
            color = [UIColor colorWithRed:74.0/255.0 green:123.0/255.0 blue:167.0/255.0 alpha:1.0];
            break;
            
            case 2:
            color = [UIColor colorWithRed:4.0/255.0 green:180.0/255.0 blue:179.0/255.0 alpha:1.0];
            break;
            
            case 3:
            color = [UIColor colorWithRed:16.0/255.0 green:202.0/255.0 blue:201.0/255.0 alpha:1.0];
            break;
            
            case 4:
            color = [UIColor colorWithRed:245.0/255.0 green:166.0/255.0 blue:35.0/255.0 alpha:1.0];
            break;
            
            case 5:
            color = [UIColor colorWithRed:255.0/255.0 green:125.0/255.0 blue:80.0/255.0 alpha:1.0];
            break;
            
            case 6:
            color = [UIColor colorWithRed:252.0/255.0 green:102.0/255.0 blue:68.0/255.0 alpha:1.0];
            break;
            
            case 7:
            color = [UIColor colorWithRed:231.0/255.0 green:95.0/255.0 blue:64.0/255.0 alpha:1.0];
            break;
            
            case 8:
            color = [UIColor colorWithRed:225.0/255.0 green:58.0/255.0 blue:32.0/255.0 alpha:1.0];
            break;
            
            case 9:
            color = [UIColor colorWithRed:217.0/255.0 green:50.0/255.0 blue:24.0/255.0 alpha:1.0];
            break;
            
            case 10:
            color = [UIColor colorWithRed:192.0/255.0 green:56.0/255.0 blue:35.0/255.0 alpha:1.0];
            break;
            
            default:
            color = [UIColor colorWithRed:192.0/255.0 green:56.0/255.0 blue:35.0/255.0 alpha:1.0];
            break;
        }
        
        return color;
    }


@end
