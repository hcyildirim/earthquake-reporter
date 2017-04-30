//
//  EarthquakeTableViewCell.h
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 30/04/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EarthquakeTableViewCell : UITableViewCell
    
    @property (strong, nonatomic) IBOutlet UILabel *labelName;
    @property (strong, nonatomic) IBOutlet UILabel *labelDirection;
    @property (strong, nonatomic) IBOutlet UILabel *labelDate;
    @property (strong, nonatomic) IBOutlet UILabel *labelMagnitude;
    @property (strong, nonatomic) IBOutlet UIView *viewMagnitude;

@end
