//
//  ParticleDesignerAppDelegate.h
//  ParticleDesigner
//
//  Created by ICM on 11/9/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import "cocos2d.h"

@interface ParticleDesignerAppDelegate : NSObject <NSApplicationDelegate>
{
	NSWindow *window_;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)toggleFullScreen:(id)sender;
@end
