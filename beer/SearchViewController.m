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

@synthesize searchBar, searchButton, beerImage, beerMugImage;

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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"navy_blue.png"]]];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [beerImage setHidden:NO];
    [beerMugImage setHidden:NO];
//    UIImage *beerImage_ = [[UIImage imageNamed:@"beer.png"]
//                           resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)];
//    [beerImage setImage:beerImage_];
    CGRect beerFrame = [beerImage frame];
    [beerImage setFrame:CGRectMake(beerFrame.origin.x, beerFrame.origin.y+beerFrame.size.height,beerFrame.size.width,0)];
    [UIView beginAnimations:@"ToggleViews" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationRepeatCount:100];
    [UIView setAnimationRepeatAutoreverses:YES];
    
    // Make the animatable changes.
    [beerImage setFrame:CGRectMake(beerFrame.origin.x, beerFrame.origin.y, beerFrame.size.width,beerFrame.size.height)];

    
    // Commit the changes and perform the animation.
    [UIView commitAnimations];
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
    [searchBar resignFirstResponder];
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
