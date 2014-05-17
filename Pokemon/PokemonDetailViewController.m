//
//  PokemonDetailViewController.m
//  Pokemon
//
//  Created by Eddú Meléndez on 17/05/14.
//  Copyright (c) 2014 EDDU MELENDEZ. All rights reserved.
//

@import Dispatch;

#import "PokemonDetailViewController.h"
#import "PokemonMapViewController.h"
#import "PokemonMonster.h"

@interface PokemonDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *textDetail;
@property (strong, nonatomic) dispatch_queue_t queue;

@end

@implementation PokemonDetailViewController

- (dispatch_queue_t)queue
{
    if (!_queue)
    {
        _queue = dispatch_queue_create("queue", 0);
    }
    return _queue;
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
    self.labelName.text = self.name;
    self.textDetail.text = self.description;
    
    PokemonMonster *pokemon = [[PokemonMonster alloc] initWithName:self.name url:[NSURL URLWithString:self.url] location:self.location andDescription:self.description];
    
    dispatch_async(self.queue, ^{
        UIImage *image = [pokemon imageFromServer];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mapSegue"])
    {
        PokemonMapViewController *vc = segue.destinationViewController;
        vc.name = self.name;
        vc.location = self.location;
    }
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
