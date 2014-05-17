//
//  PokemonMonster.h
//  Pokemon
//
//  Created by Eddú Meléndez on 17/05/14.
//  Copyright (c) 2014 EDDU MELENDEZ. All rights reserved.
//

@import UIKit;
@import Foundation;

@interface PokemonMonster : NSObject

@property (strong) NSString *name;
@property (strong) NSURL *url;
@property (strong) NSString *location;
@property (strong) NSString *description;

- (UIImage *)imageFromServer;

- (instancetype)initWithName:(NSString *)name url:(NSURL *)url location:(NSString *)location andDescription:(NSString *)description;

@end
