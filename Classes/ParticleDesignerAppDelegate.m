//
//  ParticleDesignerAppDelegate.m
//  ParticleDesigner
//
//  Created by ICM on 11/9/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "ParticleDesignerAppDelegate.h"
#import "MainLayer.h"
#import "MainWindowController.h"
@implementation ParticleDesignerAppDelegate
@synthesize window=window_;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[window_ setAcceptsMouseMovedEvents:NO];
	MainWindowController *mainctrl = [window_ windowController];
	[mainctrl InitParticleScreen];	
	NSFileManager *file = [[NSFileManager alloc] init];
	if ([file isReadableFileAtPath:[[CCFileUtils sharedFileUtils] fullPathFromRelativePath:@"particle.plist"]])
	{
		[mainctrl InitParticleSettingWithFile:[[CCFileUtils sharedFileUtils] fullPathFromRelativePath:@"particle.plist"]];
	}
    // Enable "moving" mouse event. Default no.
	[window_ setAcceptsMouseMovedEvents:NO];
}

- (BOOL) applicationShouldTerminateAfterLastWindowClosed: (NSApplication *) theApplication
{
	return YES;
}

- (void)dealloc
{
	[window_ release];
	[super dealloc];
}

#pragma mark AppDelegate - IBActions

- (IBAction)toggleFullScreen: (id)sender
{
	CCDirectorMac *director = (CCDirectorMac *)[CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}

@end
