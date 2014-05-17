//
//  PokemonMonster.m
//  Pokemon
//
//  Created by Eddú Meléndez on 17/05/14.
//  Copyright (c) 2014 EDDU MELENDEZ. All rights reserved.
//

#import "PokemonMonster.h"

@implementation PokemonMonster

- (instancetype)initWithName:(NSString *)name url:(NSURL *)url location:(NSString *)location andDescription:(NSString *)description
{
    self = [super init];
    
    if (self)
    {
        self.name = name;
        self.url = url;
        self.location = location;
        self.description = description;
    }
    
    return self;
}


- (UIImage *)imageFromServer
{
    NSLog(@"Download started");
    NSData *data = [[NSData alloc] initWithContentsOfURL:self.url];
    UIImage *image = [[UIImage alloc] initWithData:data];
    NSLog(@"Image: %@", image);
    
    return image;
}

@end
