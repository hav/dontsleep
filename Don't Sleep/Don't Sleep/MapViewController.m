//
//  MapViewController.m
//  Don't Sleep
//
//  Created by Christian Danheimer Furedal on 2014-03-25.
//  Copyright (c) 2014 Don't Sleep. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.map setShowsUserLocation:YES];
}

- (void)setCenterOnCoordinate:(CLLocationCoordinate2D)coordinate
{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.001;
    span.longitudeDelta = 0.001;
    region.span = span;
    region.center = coordinate;
    [self.map setRegion:region animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [self setCenterOnCoordinate:self.map.userLocation.location.coordinate];
    [self.map setUserTrackingMode:MKUserTrackingModeFollow animated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
