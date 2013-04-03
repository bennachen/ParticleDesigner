//
//  BackgroundSettingWindow.m
//  ParticleDesigner
//
//  Created by ICM on 11/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BackgroundSettingWindow.h"

@implementation BackgroundSettingWindow

@synthesize txtred;
@synthesize txtgreen;
@synthesize txtblue;

- (NSWindow *) getWindow
{
    return [self window];
}

- (IBAction) ChangeBackground:(id)sender
{
    int cred = [(NSSlider *)[[[self window] contentView] viewWithTag:1001] intValue];
    int cgreen = [(NSSlider *)[[[self window] contentView] viewWithTag:1002] intValue];
    int cblue = [(NSSlider *)[[[self window] contentView] viewWithTag:1003] intValue];
    [txtred setStringValue:[NSString stringWithFormat:@"%d", cred]];
    [txtgreen setStringValue:[NSString stringWithFormat:@"%d", cgreen]];
    [txtblue setStringValue:[NSString stringWithFormat:@"%d", cblue]];
    [_delegate BackgroundChangedFinish:ccc3(cred, cgreen, cblue)];
}

- (IBAction) CloseThisWindow:(id)sender
{
    [NSApp endSheet:[self window] returnCode:-1];
    [[self window] orderOut:nil];
}

- (void) RestoreDefault
{
    [txtred setStringValue:@"0"];
    [txtgreen setStringValue:@"0"];
    [txtblue setStringValue:@"0"];
    //(NSSlider *)[[[self window] contentView] viewWithTag:1001] setIntValue:0
    [(NSSlider *)[[[self window] contentView] viewWithTag:1001] setIntValue:0];
    [(NSSlider *)[[[self window] contentView] viewWithTag:1002] setIntValue:0];
    [(NSSlider *)[[[self window] contentView] viewWithTag:1003] setIntValue:0];
}

- (void) setDelegate:(id <BackgroundSettingDelegate>)anObject
{
    _delegate = anObject;
}

- (id <BackgroundSettingDelegate>) delegate
{
    return _delegate;
}
@end
