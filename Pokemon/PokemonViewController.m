//
//  PokemonViewController.m
//  Pokemon
//
//  Created by Eddú Meléndez on 17/05/14.
//  Copyright (c) 2014 EDDU MELENDEZ. All rights reserved.
//

#import "PokemonViewController.h"
#import "PokemonMonster.h"
#import "PokemonDetailViewController.h"

@interface PokemonViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSArray *plist;
@property (strong, nonatomic) NSMutableArray *pokemonData;
@property (strong, nonatomic) NSMutableArray *resultData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PokemonViewController

- (NSArray *)plist
{
    if (!_plist)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PokemonList" ofType:@"plist"];
        _plist = [[NSArray alloc] initWithContentsOfFile:path];
    }
    return _plist;
}

- (NSMutableArray *)pokemonData
{
    if (!_pokemonData)
    {
        _pokemonData = [[NSMutableArray alloc] init];
    }
    return _pokemonData;
}

- (NSMutableArray *)resultData
{
    if (!_resultData)
    {
        _resultData = [[NSMutableArray alloc] init];
    }
    return _resultData;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.plist enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         PokemonMonster *pokemon = [[PokemonMonster alloc] initWithName:obj[@"name"] url:obj[@"url"] location:obj[@"location"] andDescription:obj[@"description"]];
         [self.pokemonData addObject:pokemon];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tableView)
    {
        return [self.pokemonData count];
    }
    else
    {
        return [self.resultData count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PokemonViewControllerCell"];
    
    if (tableView == self.tableView)
    {
        PokemonMonster *search = self.pokemonData[indexPath.row];
        cell.textLabel.text = search.name;
    }
    else
    {
        PokemonMonster *search = self.resultData[indexPath.row];
        cell.textLabel.text = search.name;
    }
    
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.resultData removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchText];
    [self.resultData addObjectsFromArray:[self.pokemonData filteredArrayUsingPredicate:predicate]];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
    NSLog(@"Results table view");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"descriptionSegue"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        PokemonMonster *pokemon = self.pokemonData[indexPath.row];
        
        PokemonDetailViewController *vc = segue.destinationViewController;
        vc.name = pokemon.name;
        vc.location = pokemon.location;
        vc.url = pokemon.url;
        vc.description = pokemon.description;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"descriptionSegue" sender:self];
}


@end
