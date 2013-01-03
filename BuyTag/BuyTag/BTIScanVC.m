//
//  BTIScanVC.m
//  BuyTag
//
//  Created by Ryan Connelly on 1/3/13.
//  Copyright (c) 2013 Buytag, inc. All rights reserved.
//

#import "BTIScanVC.h"

@interface BTIScanVC ()
- (void) setupScanner;
@end

@implementation BTIScanVC

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
    
    // ensure initial camera orientation is correctly set
    UIApplication *app = [UIApplication sharedApplication];
    [self.readerView willRotateToInterfaceOrientation: app.statusBarOrientation duration: 0];
    self.readerView.readerDelegate = self;
    self.readerView.tracksSymbols = NO;
    
    [self setupScanner];
    
    if(TARGET_IPHONE_SIMULATOR) {
        _cameraSim = [[ZBarCameraSimulator alloc]
                      initWithViewController: self];
        _cameraSim.readerView = self.readerView;
    }
}

- (void) setupScanner
{
    [self.readerView.scanner setSymbology:ZBAR_EAN2 config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_EAN5 config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_EAN8 config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_UPCE config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_ISBN10 config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_UPCA config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_EAN13 config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_COMPOSITE config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_DATABAR config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_DATABAR_EXP config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_CODABAR config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_CODE39 config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_PDF417 config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_CODE93 config:ZBAR_CFG_ENABLE to:0];
    [self.readerView.scanner setSymbology:ZBAR_CODE128 config:ZBAR_CFG_ENABLE to:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.readerView start];
    isShown = YES;
}

- (void) viewDidAppear: (BOOL) animated
{
    [super viewDidAppear:animated];
    // run the reader when the view is visible
}

- (BOOL) shouldAutorotate
{
    return YES;
}

- (void) viewWillDisappear: (BOOL) animated
{
    isShown = NO;
   // [self.readerView stop];
    
    [super viewDidDisappear:animated];
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    if(!isShown)
        return;

    NSString *text = nil;
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        text = sym.data;
        break;
    }
    
    self.viewFinderImage.image = [UIImage imageNamed: @"ReaderSquareOn.png"];
    [self.readerView stop];
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"Scan Complete"
                                                message:text
                                               delegate:self
                                      cancelButtonTitle:@"Ok"
                                      otherButtonTitles:nil];
    [v show];
}

- (void) readerViewDidStart: (ZBarReaderView*) readerView
{
    
}

- (void) readerView: (ZBarReaderView*) readerView
   didStopWithError: (NSError*) error
{
    
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // compensate for view rotation so camera preview is not rotated
    [self.readerView willRotateToInterfaceOrientation: orient
                                             duration: duration];
}

- (void) willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation) orient
                                          duration: (NSTimeInterval) duration
{
    // perform rotation in animation loop so camera preview does not move
    // wrt device orientation
    [self.readerView setNeedsLayout];
}


- (void) alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger) buttonIndex
{
    [self.readerView start];
    self.viewFinderImage.image = [UIImage imageNamed: @"ReaderSquare.png"];    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
}

@end
