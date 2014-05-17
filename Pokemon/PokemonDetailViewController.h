//
//  PokemonDetailViewController.h
//  Pokemon
//
//  Created by Eddú Meléndez on 17/05/14.
//  Copyright (c) 2014 EDDU MELENDEZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokemonDetailViewController : UIViewController

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *description;


@end
