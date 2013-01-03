//
//  BTIScanVC.h
//  BuyTag
//
//  Created by Ryan Connelly on 1/3/13.
//  Copyright (c) 2013 Buytag, inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTIViewController.h"
@interface BTIScanVC : BTIViewController <ZBarReaderViewDelegate, UIAlertViewDelegate>
{
    BOOL isShown;
}

@property (nonatomic, readonly, strong) ZBarCameraSimulator *cameraSim;
@property (nonatomic, readonly, strong) IBOutlet ZBarReaderView *readerView;
@property (weak, nonatomic) IBOutlet UIImageView *viewFinderImage;

@end
