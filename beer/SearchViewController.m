//
//  SearchViewController.m
//  beer
//
//  Created by Ben Weitzman on 1/11/13.
//  Copyright (c) 2013 Ben Weitzman. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultsViewController.h"
#import <MKNetworkKit.h>

@interface SearchViewController ()
{
    NSArray *results;
}

@end

@implementation SearchViewController

@synthesize searchBar, searchButton;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showResultsSegue"]) {
        ResultsViewController *resultsVC = (ResultsViewController*)[segue destinationViewController];
        resultsVC.results = results;
    }
}

- (IBAction)search:(id)sender {
    NSString *beerName = searchBar.text;
    //init the http engine, supply the web host
    //and also a dictionary with http headers you want to send
    MKNetworkEngine* engine = [[MKNetworkEngine alloc]
                               initWithHostName:@"localhost:5000" customHeaderFields:nil];
    
    //request parameters
    //these would be your GET or POST variables
    NSMutableDictionary* params = [@{@"beer_name":beerName} mutableCopy];
    //create operation with the host relative path, the params
    //also method (GET,POST,HEAD,etc) and whether you want SSL or not
    MKNetworkOperation* op = [engine
                              operationWithPath:@"find_beer"
                              params:params
                              httpMethod:@"GET" ssl:NO];
    
    //set completion and error blocks
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSLog(@"json: %@", [op responseJSON]);
        results = (NSArray *)[op responseJSON];
        [self performSegueWithIdentifier:@"showResultsSegue" sender:self];
    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    //add to the http queue and the request is sent
    [engine enqueueOperation: op];
    
}
@end
