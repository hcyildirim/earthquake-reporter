//
//  EarthquakeTableViewController.m
//  Earthquake Reporter
//
//  Created by H. Can Yıldırım on 30/04/2017.
//  Copyright © 2017 H. Can Yıldırım. All rights reserved.
//

#import "EarthquakeTableViewController.h"
#import <RestKit/RestKit.h>
#import "EarthquakeTableViewCell.h"
#import "Earthquake.h"
#import "Property.h"
#import "Geometry.h"
#import "Magnitude.h"
#import "EarthquakeDetailMapViewController.h"

@interface EarthquakeTableViewController ()
    
    @property (nonatomic, strong) NSArray *earthquakes;

@end

@implementation EarthquakeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadEarthquakes) name:@"loadEarthquakes" object:nil];
    
    UIRefreshControl *refreshController = [[UIRefreshControl alloc] init];
    [refreshController addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshController;
    
    [self configureRestKit];
    [self loadEarthquakes];
    [self.refreshControl beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureRestKit
    {
        // initialize AFNetworking HTTPClient
        NSURL *baseURL = [NSURL URLWithString:@"https://earthquake.usgs.gov"];
        AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
        
        
        // initialize RestKit
        RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
        
        // setup object mappings
        RKObjectMapping *earthquakeMapping = [RKObjectMapping mappingForClass:[Earthquake class]];
        [earthquakeMapping addAttributeMappingsFromDictionary:@{
                                                             @"id": @"id",
                                                             @"type": @"type",
                                                             }];
        
        // define properties object mapping
        RKObjectMapping *propertyMapping = [RKObjectMapping mappingForClass:[Property class]];
        [propertyMapping addAttributeMappingsFromArray:@[@"mag", @"place", @"title", @"time", @"url"]];
        
        
        // define relationship mapping
        [earthquakeMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"properties" toKeyPath:@"property" withMapping:propertyMapping]];
        
        // define geometry object mapping
        RKObjectMapping *geometryMapping = [RKObjectMapping mappingForClass:[Geometry class]];
        [geometryMapping addAttributeMappingsFromArray:@[@"coordinates"]];
        
        // define relationship mapping
        [earthquakeMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"geometry" toKeyPath:@"geometry" withMapping:geometryMapping]];
        
        // register mappings with the provider using a response descriptor
        RKResponseDescriptor *responseDescriptor =
        [RKResponseDescriptor responseDescriptorWithMapping:earthquakeMapping
                                                     method:RKRequestMethodGET
                                                pathPattern:nil
                                                    keyPath:@"features"
                                                statusCodes:[NSIndexSet indexSetWithIndex:200]];
        
        [objectManager addResponseDescriptor:responseDescriptor];
    }
    
    
- (void)loadEarthquakes
    {
        NSString *limit = [[NSUserDefaults standardUserDefaults] stringForKey:@"limit"];
        NSString *minmag = [[NSUserDefaults standardUserDefaults] stringForKey:@"magnitude"];
        
        NSDictionary *queryParams = @{@"limit" : limit,
                                      @"minmag" : minmag};
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/fdsnws/event/1/query?format=geojson"
                                               parameters:queryParams
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      _earthquakes = mappingResult.array;
                                                      [self.tableView reloadData];
                                                      [self.refreshControl endRefreshing];
                                                  }
                                                  failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                      NSLog(@"There is no data in usgs: %@", error);
                                                      [self.refreshControl endRefreshing];
                                                  }];
    }
    
    -(void)handleRefresh : (id)sender
    {
        NSLog (@"Pull To Refresh Method Called");
        [self loadEarthquakes];
    }

    
-(NSString*)stringBeforeString:(NSString*)match inString:(NSString*)string
    {
        if ([string rangeOfString:match].location != NSNotFound)
        {
            NSString *preMatch;
            
            NSScanner *scanner = [NSScanner scannerWithString:string];
            [scanner scanUpToString:match intoString:&preMatch];
            
            return preMatch;
        }
        else
        {
            return string;
        }
    }
    
    
-(NSString*)stringAfterString:(NSString*)match inString:(NSString*)string
    {
        if ([string rangeOfString:match].location != NSNotFound)
        {
            NSScanner *scanner = [NSScanner scannerWithString:string];
            
            [scanner scanUpToString:match intoString:nil];
            
            NSString *postMatch;
            
            if(string.length == scanner.scanLocation)
            {
                postMatch = [string substringFromIndex:scanner.scanLocation];
            }
            else
            {
                postMatch = [string substringFromIndex:scanner.scanLocation + match.length];
            }
            
            return postMatch;
        }
        else
        {
            return string;
        }
    }
    
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _earthquakes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EarthquakeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Earthquake *earthquake = _earthquakes[indexPath.row];
    
    cell.labelName.text = [self stringAfterString:@"of" inString:earthquake.property.place];
    cell.labelDirection.text = [self stringBeforeString:@"of" inString:earthquake.property.place];
    
    NSTimeInterval timeStamp = (NSTimeInterval)[earthquake.property.time doubleValue] / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];

    cell.labelDate.text = dateString;
    
    
    // label with circle
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = cell.labelMagnitude.bounds;
    circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 50, 50)].CGPath;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [Magnitude colorForMagnitude: earthquake.property.mag.intValue].CGColor;
    circleLayer.lineWidth = 2;
    
    [cell.labelMagnitude.layer addSublayer:circleLayer];
    cell.labelMagnitude.text = [NSString stringWithFormat:@"%.1f", earthquake.property.mag.floatValue];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
    

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"mapSegue"]) {
        EarthquakeDetailMapViewController *vc = [segue destinationViewController];
        vc.earthquake = [_earthquakes objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
