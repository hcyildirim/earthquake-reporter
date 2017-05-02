//
//  SettingsViewController.h
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 02/05/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
    
    @property (strong, nonatomic) IBOutlet UITextField *textFieldEarthquakeLimit;
    @property (strong, nonatomic) IBOutlet UITextField *textFieldMinimumMagnitude;
    - (IBAction)btnSaveOnClick:(id)sender;

@end
