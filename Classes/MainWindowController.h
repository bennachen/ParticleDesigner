//
//  MainWindowController.h
//  ParticleDesigner
//
//  Created by Paul on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "cocos2d.h"
#import "CCGLView.h"
#import <Quartz/Quartz.h>
#import "MSParticles.h"
#import "BackgroundSettingWindow.h"
@interface MainWindowController : NSWindowController <NSOpenSavePanelDelegate, BackgroundSettingDelegate> {
	NSMutableDictionary *currentParticleData;
	NSBox *gBox;
    NSBox *rBox;
	CCGLView	*glView_;
	CCScene *mainScene;
    MSParticles *particle;
    NSWindow *exampleWindow;
    
    NSString *currentdirectory;
    
    BackgroundSettingWindow *bsw;
}
@property (nonatomic, retain) BackgroundSettingWindow *bsw;
@property (nonatomic, retain) NSMutableDictionary *currentParticleData;
@property (assign) IBOutlet CCGLView *glView;
@property (nonatomic, assign) IBOutlet NSBox *gBox;
@property (nonatomic, assign) IBOutlet NSBox *rBox;
@property (nonatomic, retain) CCScene *mainScene;
@property (nonatomic, retain) NSWindow *exampleWindow;
@property (nonatomic, retain) MSParticles *particle;
@property (nonatomic, retain) NSString *currentdirectory;

- (IBAction) ConfigurationChanged:(id)sender;
- (IBAction) ParticleColorChanged:(id)sender;
- (IBAction) DurationChanged:(id)sender;
- (IBAction) EmitterTypeChanged:(id)sender;
- (IBAction) ButtonBlendFunctionClick:(id)sender;
- (IBAction) BlendFunctionSourceChanged:(id)sender;
- (IBAction) BlendFunctionDestinationChanged:(id)sender;
- (IBAction) toggleFullScreen: (id)sender;
- (IBAction) ImageChanged:(id)sender;
- (IBAction) RestoreDefault:(id)sender;

- (void) didChangeImageFinished:(NSOpenPanel *)openPanel returnCode:(int)returnCode;
- (void) didEndSaveSheet:(NSSavePanel *)savePanel returnCode:(int)returnCode;
- (void) didEndOpenSheet:(NSOpenPanel *)openPanel returnCode:(int)returnCode;
- (void) didEndExampleSheet:(NSWindow *)examplewindow returnCode:(int)returnCode conextInfo:(void *)contextInfo;

- (void) InitParticleScreen;
- (void) InitParticleSettingWithFile:(NSString *)plistfilepath;
- (void) InitParticleSettingWithDictionary:(NSDictionary *)dictionary;

- (void) PlayParticleFromFile:(NSString *)filename;
- (void) PlayParticleFromDictionary:(NSDictionary *)dictionary;
- (void) ChangeParticleFormDictionary:(NSDictionary *)dictionary;
- (void) SwithEmitterType:(unsigned int)emittertype;
- (void) ResetSystem;

- (IBAction) OpenExampleWindow:(id)sender;
- (IBAction) LoadParticleFromFile:(id)sender;
- (IBAction) DataSaveAs:(id)sender;
- (IBAction) BackgroundChanged:(id)sender;


@end
