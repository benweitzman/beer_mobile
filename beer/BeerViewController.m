//
//  BeerViewController.m
//  beer
//
//  Created by Ben Weitzman on 1/11/13.
//  Copyright (c) 2013 Ben Weitzman. All rights reserved.
//

#import "BeerViewController.h"
#import <MKNetworkKit.h>

@interface BeerViewController ()

@end

@implementation BeerViewController

@synthesize beerInfo, abvLabel, beerImageView, typeLabel, ratingLabel;

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

- (void)viewWillAppear:(BOOL)animated {
    [abvLabel setText:beerInfo[@"abv"]];
    [typeLabel setText:beerInfo[@"style"]];
    [ratingLabel setText:beerInfo[@"rating"]];
    
    MKNetworkEngine* engine = [[MKNetworkEngine alloc]
                               initWithHostName:@"beeradvocate.com" customHeaderFields:nil];
    
    //request parameters
    //these would be your GET or POST variables
    //create operation with the host relative path, the params
    //also method (GET,POST,HEAD,etc) and whether you want SSL or not
    MKNetworkOperation* op = [engine
                              operationWithPath:beerInfo[@"image"]
                              params:nil
                              httpMethod:@"GET" ssl:NO];
    
    //set completion and error blocks
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSLog(@"image");
        [beerImageView setImage:[op responseImage]];

    } onError:^(NSError *error) {
        NSLog(@"%@", error);
    }];
    
    //add to the http queue and the request is sent
    [engine enqueueOperation: op];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
