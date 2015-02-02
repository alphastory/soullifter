//
//  HomeController.m
//  The Soul Lifter
//
//  Created by Matthew Wagner on 1/8/15.
//  Copyright (c) 2015 Planet Soul. All rights reserved.
//

#import "HomeController.h"

@interface HomeController ()

@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Show the home view.
    HomeView *homeView = [[HomeView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    homeView.delegate = self;
    self.view = homeView;
    NSLog(@"Home View");
}


-(void)loadViewForIdentifier:(NSString *)identifier {
    self.selectViewController = [[SelectionViewController alloc] init];
    if([identifier isEqualToString:@"recents"]){
        [self.selectViewController setActiveView:@"Recents"];
    } else if([identifier isEqualToString:@"favorites"]){
        [self.selectViewController setActiveView:@"Favorites"];
    } else if([identifier isEqualToString:@"static"]){
        [self.selectViewController setActiveView:@"Static"];
//        [self.selectViewController getCardsOfType:@"static"];
    } else if([identifier isEqualToString:@"animated"]){
        [self.selectViewController setActiveView:@"Animated"];
//        [self.selectViewController getCardsOfType:@"animated"];
    }
    [self presentViewController:self.selectViewController animated:YES completion:nil];
}

-(void)showContactView {
    self.contactViewController = [[ContactViewController alloc] init];
    [self presentViewController:self.contactViewController animated:YES completion:nil];
}

-(void)showSettingsView {
    self.settingsViewController = [[SettingsViewController alloc] init];
    [self presentViewController:self.settingsViewController animated:YES completion:nil];
}

-(void)showAboutView {
    self.aboutViewController = [[AboutViewController alloc] init];
    [self presentViewController:self.aboutViewController animated:YES completion:nil];
}

-(void)showStoreView {
    self.storeViewController = [[StoreViewController alloc] init];
    [self presentViewController:self.storeViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
