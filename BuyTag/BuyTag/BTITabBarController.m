//
//  BTITabBarController.m
//  BuyTag
//
//  Created by Ryan Connelly on 1/3/13.
//  Copyright (c) 2013 Buytag, inc. All rights reserved.
//

#import "BTITabBarController.h"

@interface BTITabBarController ()

@end

@implementation BTITabBarController

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
    self.delegate = self;
    self.selectedIndex = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showViewController:(UIViewController *)viewController
{
    NSArray *tabViewControllers = self.viewControllers;
    UIView * fromView = self.selectedViewController.view;
    UIView * toView = viewController.view;
    
    NSUInteger fromIndex = [tabViewControllers indexOfObject:self.selectedViewController];
    NSUInteger toIndex = [tabViewControllers indexOfObject:viewController];
    
    // Get the size of the view area.
    CGRect viewSize = fromView.frame;
    BOOL scrollRight = toIndex > fromIndex;
    
    // Add the to view to the tab bar view.
    [fromView.superview addSubview:toView];
    
    // Position it off screen.
    toView.frame = CGRectMake((scrollRight ? 320 : -320), viewSize.origin.y, 320, viewSize.size.height);
    
    [UIView animateWithDuration:0.3
                     animations: ^{
                         
                         // Animate the views on and off the screen. This will appear to slide.
                         fromView.frame =CGRectMake((scrollRight ? -320 : 320), viewSize.origin.y, 320, viewSize.size.height);
                         toView.frame =CGRectMake(0, viewSize.origin.y, 320, viewSize.size.height);
                     }
     
                     completion:^(BOOL finished) {
                         if (finished) {
                             
                             // Remove the old view from the tabbar view.
                             [fromView removeFromSuperview];
                             self.selectedIndex = toIndex;
                         }
                     }];
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(BTITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0)
{   
    UIView * fromView = tabBarController.selectedViewController.view;
    UIView * toView = viewController.view;
    
    if (fromView == toView)
        return NO;
    
    [tabBarController showViewController:viewController];
    
    return YES;
}

/*
 
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 
 }
 
 - (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers NS_AVAILABLE_IOS(3_0)
 {
 
 }
 
 - (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0)
 {
 
 }
 
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 
 }
 */
@end
