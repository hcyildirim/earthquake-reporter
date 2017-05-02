//
//  EarthquakeMapViewController.m
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 01/05/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import "EarthquakeMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface EarthquakeMapViewController ()
    
@end

@implementation EarthquakeMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = _earthquake.property.place;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[[_earthquake.geometry.coordinates objectAtIndex:1] floatValue]
                                                            longitude:[[_earthquake.geometry.coordinates objectAtIndex:0] floatValue]
                                                                 zoom:6];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([[_earthquake.geometry.coordinates objectAtIndex:1] floatValue], [[_earthquake.geometry.coordinates objectAtIndex:0] floatValue]);
    marker.title = _earthquake.property.title;
    marker.snippet = _earthquake.property.place;
    marker.map = mapView;

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

@end
