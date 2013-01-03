//
//  BTIViewController.m
//  BuyTag
//
//  Created by Ryan Connelly on 1/3/13.
//  Copyright (c) 2013 Buytag, inc. All rights reserved.
//

#import "BTIViewController.h"
#import "BTITabBarController.h"

@interface BTIViewController ()

@end

@implementation BTIViewController

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

- (IBAction)swipeLeft:(UIGestureRecognizer *)sender
{
    NSArray *tabViewControllers = self.tabBarController.viewControllers;
    if(self.tabBarController.selectedIndex == tabViewControllers.count - 1)
        return;
    
    UIViewController *view = [tabViewControllers objectAtIndex:self.tabBarController.selectedIndex + 1];
    [(BTITabBarController *)self.tabBarController showViewController:view];
}

- (IBAction)swipeRight:(UIGestureRecognizer *)sender
{
    NSArray *tabViewControllers = self.tabBarController.viewControllers;
    if(self.tabBarController.selectedIndex == 0)
        return;
    
    UIViewController *view =  [tabViewControllers objectAtIndex:self.tabBarController.selectedIndex - 1];
    [(BTITabBarController *)self.tabBarController showViewController:view];
    
}

@end
