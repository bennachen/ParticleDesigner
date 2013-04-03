//
//  BackgroundSettingWindow.h
//  ParticleDesigner
//
//  Created by ICM on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
@protocol BackgroundSettingDelegate;

@interface BackgroundSettingWindow : NSWindowController
{
    id _delegate;
    
    NSTextField *txtred;
    NSTextField *txtgreen;
    NSTextField *txtblue;
}

@property (nonatomic, retain) IBOutlet NSTextField *txtred;
@property (nonatomic, retain) IBOutlet NSTextField *txtgreen;
@property (nonatomic, retain) IBOutlet NSTextField *txtblue;

- (NSWindow *) getWindow;
- (IBAction) CloseThisWindow:(id)sender;
- (IBAction) ChangeBackground:(id)sender;
- (void) RestoreDefault;

- (void)setDelegate:(id <BackgroundSettingDelegate>)anObject;
- (id <BackgroundSettingDelegate>)delegate;
@end

@protocol BackgroundSettingDelegate
- (void) BackgroundChangedFinish:(ccColor3B) color;
@end