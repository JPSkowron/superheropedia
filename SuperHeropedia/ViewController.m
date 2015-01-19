//
//  ViewController.m
//  SuperHeropedia
//
//  Created by JP Skowron on 1/19/15.
//  Copyright (c) 2015 JP Skowron. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property NSArray *heroes;
@property (strong, nonatomic) IBOutlet UITableView *superheroTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/superheroes.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               self.heroes = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:NSJSONReadingAllowFragments
                                                                               error:&connectionError];
                               [self.superheroTableView reloadData];
        }];




    /*self.heroes = [NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:
                    @"Superman", @"name",
                    [NSNumber numberWithInt:32], @"age",nil],
                   [NSDictionary dictionaryWithObjectsAndKeys:
                    @"The Hulk", @"name",
                    [NSNumber numberWithInt:28], @"age",nil], nil]; */
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.heroes.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuperheroCell"];
    NSDictionary *hero = [self.heroes objectAtIndex:indexPath.row];

    cell.textLabel.text = [hero objectForKey:@"name"];
    cell.detailTextLabel.text = ((NSNumber *)[hero objectForKey:@"age"]).stringValue;
    return cell;
}

@end
