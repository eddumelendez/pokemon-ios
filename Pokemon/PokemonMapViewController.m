//
//  PokemonMapViewController.m
//  Pokemon
//
//  Created by Eddú Meléndez on 17/05/14.
//  Copyright (c) 2014 EDDU MELENDEZ. All rights reserved.
//

@import MapKit;
@import CoreLocation;

#import "PokemonMapViewController.h"

@interface PokemonMapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLGeocoder *geoCoder;

@end

@implementation PokemonMapViewController

- (CLGeocoder *)geoCoder
{
    if(!_geoCoder) {
        _geoCoder = [CLGeocoder new];
    }
    return _geoCoder;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.geoCoder geocodeAddressString:self.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!error)
         {
             if ([placemarks count])
             {
                 CLPlacemark *placemark = [placemarks firstObject];
                 
                 self.mapView.region = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 50, 50);
                 
                 MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                 annotation.coordinate = placemark.location.coordinate;
                 annotation.title = self.location;
                 [self.mapView addAnnotation:annotation];
             }
         } else {
             NSLog(@"Error %@", error);
         }
     }];

}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) return nil;
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    pin.annotation = annotation;
    pin.pinColor = MKPinAnnotationColorRed;
    return pin;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
