//
//  SettingsViewController.m
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 02/05/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textFieldEarthquakeLimit.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"limit"];
    _textFieldMinimumMagnitude.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"minmag"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnSaveOnClick:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setInteger:_textFieldEarthquakeLimit.text.integerValue forKey:@"limit"];
    [[NSUserDefaults standardUserDefaults] setInteger:_textFieldMinimumMagnitude.text.integerValue forKey:@"minmag"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"New settings are saved. limit = %@ minmag = %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"limit"], [[NSUserDefaults standardUserDefaults] stringForKey:@"minmag"]);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadEarthquakes" object:self];
    [self.navigationController popViewControllerAnimated:YES];
}
    
    -(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
    {
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSNumber* candidateNumber;
        
        NSString* candidateString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        range = NSMakeRange(0, [candidateString length]);
        
        [numberFormatter getObjectValue:&candidateNumber forString:candidateString range:&range error:nil];
        
        if (([candidateString length] > 0) && (candidateNumber == nil || range.length < [candidateString length])) {
            
            return NO;
        }
        else 
        {
            return YES;
        }
    }
@end
