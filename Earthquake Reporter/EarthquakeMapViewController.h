//
//  EarthquakeMapViewController.h
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 01/05/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Earthquake.h"
#import "Property.h"
#import "Geometry.h"

@interface EarthquakeMapViewController : UIViewController
    
    @property (nonatomic) Earthquake *earthquake;
    
@end
