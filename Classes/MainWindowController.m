//
//  MainWindowController.m
//  ParticleDesigner
//
//  Created by Paul on 11/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MainWindowController.h"
#import "MainLayer.h"
#import "ExampleWindowController.h"
@implementation MainWindowController
@synthesize glView = glView_;
@synthesize currentParticleData;
@synthesize mainScene;
@synthesize gBox;
@synthesize rBox;
@synthesize exampleWindow;
@synthesize particle;
@synthesize currentdirectory;
@synthesize bsw;

#pragma mark MainWindowController - IBActions
- (IBAction) ConfigurationChanged:(id)sender
{
	NSControl *ctrl = (NSControl *)sender;
	NSInteger ctrltag = ctrl.tag;
	NSInteger ctrl_config = ctrltag / 1000;
	NSInteger ctrl_type = (ctrltag - ctrl_config * 1000) / 100;
	NSInteger ctrl_id = ctrltag - ctrl_config * 1000 - ctrl_type * 100;
	NSView *windowview = [[self window] contentView];
	NSArray *pConfigList;
    if (ctrl_config == 1) {
        pConfigList = [[NSArray alloc] initWithObjects:@"maxParticles", @"particleLifespan", @"particleLifespanVariance", @"startParticleSize", @"startParticleSizeVariance", 
                       @"finishParticleSize", @"finishParticleSizeVariance", @"angle", @"angleVariance", @"rotationStart", @"rotationStartVariance", 
                       @"rotationEnd", @"rotationEndVariance", nil];
    }
    else if(ctrl_config == 2)
    {
        pConfigList = [[NSArray alloc] initWithObjects:@"speed", @"speedVariance", @"gravityx", @"gravityy", @"radialAcceleration", @"radialAccelVariance", @"tangentialAcceleration", @"tangentialAccelVariance", nil];
    }
    else if(ctrl_config == 8)
    {
        pConfigList = [[NSArray alloc] initWithObjects:@"maxRadius", @"maxRadiusVariance", @"minRadius", @"rotatePerSecond", @"rotatePerSecondVariance", nil];
    }
	float cvalue = 0.0f;
	if (ctrl_type == 1)
	{
		NSStepper *stepper = (NSStepper *)sender;
		NSSlider *slider = [windowview viewWithTag:ctrl_config * 1000 + 300 + ctrl_id];
		NSTextField *txt = [windowview viewWithTag:ctrl_config * 1000 + 200 + ctrl_id];
		cvalue = [stepper floatValue];
		[slider setFloatValue:cvalue];
		[txt setStringValue:[NSString stringWithFormat:@"%.02f", cvalue]];
	}
    else if(ctrl_type == 2)
    {
        NSTextField *txtField = (NSTextField*)sender;
        NSSlider *slider = [windowview viewWithTag:ctrl_config * 1000 + 300 + ctrl_id];
        NSStepper *stepper = [windowview viewWithTag:ctrl_config * 1000 + 100 + ctrl_id];
        cvalue = [txtField.stringValue floatValue];
        [slider setFloatValue:cvalue];
        [stepper setFloatValue:cvalue];
    }
	else if(ctrl_type == 3)
	{
		NSSlider *slider = (NSSlider *)sender;
		NSStepper *stepper = [windowview viewWithTag:ctrl_config * 1000 + 100 + ctrl_id];
		NSTextField *txt = [windowview viewWithTag:ctrl_config * 1000 + 200 + ctrl_id];
		cvalue = [slider floatValue];
		[stepper setFloatValue:cvalue];
		[txt setStringValue:[NSString stringWithFormat:@"%.02f", cvalue]];
	}
	[self.currentParticleData setObject:[NSString stringWithFormat:@"%.02f", cvalue] forKey:[pConfigList objectAtIndex:(ctrl_id - 1)]];
    if ([[pConfigList objectAtIndex:(ctrl_id - 1)] isEqual:@"maxParticles"]) {
        [self ResetSystem];
    }
    else
		[particle ChangeParticleWithObject:[NSString stringWithFormat:@"%.02f", cvalue] forKey:[pConfigList objectAtIndex:(ctrl_id - 1)]];
    [pConfigList release];
}

- (IBAction) ParticleColorChanged:(id)sender
{
	NSView *windowview = [[self window] contentView];
    NSArray *pColorList = [[NSArray alloc] initWithObjects:@"startColorRed", @"startColorGreen", @"startColorBlue", @"startColorAlpha", 
						   @"startColorVarianceRed", @"startColorVarianceGreen", @"startColorVarianceBlue", @"startColorVarianceAlpha", 
						   @"finishColorRed", @"finishColorGreen", @"finishColorBlue", @"finishColorAlpha", 
						   @"finishColorVarianceRed", @"finishColorVarianceGreen", @"finishColorVarianceBlue", @"finishColorVarianceAlpha", 
                           @"sourcePositionx", @"sourcePositionVariancex", @"sourcePositiony", @"sourcePositionVariancey", nil];
	NSControl *ctrl = (NSControl *)sender;
	NSInteger ctrltag = ctrl.tag;
	NSInteger ctrl_config = ctrltag / 1000;
	NSInteger ctrl_type = (ctrltag - ctrl_config * 1000) / 100;
	NSInteger ctrl_id = ctrltag - ctrl_config * 1000 - ctrl_type * 100;
    float cvalue = 0.0f;
    if(ctrl_type == 2)
    {
        NSTextField *txtField = (NSTextField*)sender;
        NSSlider *slider = [windowview viewWithTag:ctrl_config * 1000 + 300 + ctrl_id];
        cvalue = [txtField.stringValue floatValue];
        [slider setFloatValue:cvalue];
    }
	else if(ctrl_type == 3)
	{
        NSSlider *slider = (NSSlider *)sender;
        NSTextField *txt = [windowview viewWithTag:ctrl_config * 1000 + 200 + ctrl_id];
        cvalue = [slider floatValue];
        [txt setStringValue:[NSString stringWithFormat:@"%.03f", cvalue]];
    }
    int isn = (ctrl_config - 3) * 4 + ctrl_id - 1;
    [particle ChangeParticleWithObject:[NSString stringWithFormat:@"%.03f", cvalue] forKey:[pColorList objectAtIndex:isn]];
    [self.currentParticleData setObject:[NSString stringWithFormat:@"%.03f", cvalue] forKey:[pColorList objectAtIndex:isn]];
    [pColorList release];
}

- (IBAction) DurationChanged:(id)sender
{
	NSView *windowview = [[self window] contentView];
    NSControl *ctrl = (NSControl *)sender;
	NSInteger ctrltag = ctrl.tag;
    float cvalue = 0.0f;
    if (ctrltag == 9001) {
        NSTextField *txt = (NSTextField *)sender;
        cvalue = [txt.stringValue floatValue];
        NSStepper *stepper = [windowview viewWithTag:9002];
        [stepper setFloatValue:cvalue];
    }
    else
    {
        NSStepper *stepper = (NSStepper *)sender;
        NSTextField *txt = [windowview viewWithTag:9001];
        cvalue = [stepper floatValue];
        [txt setStringValue:[NSString stringWithFormat:@"%.02f", cvalue]];
    }
    
    [self.currentParticleData setObject:[NSString stringWithFormat:@"%.03f", cvalue] forKey:@"duration"];
	[particle ChangeParticleWithObject:[NSString stringWithFormat:@"%.03f", cvalue] forKey:@"duration"];
}

- (IBAction) ButtonBlendFunctionClick:(id)sender
{
	NSButton *btn = (NSButton *)sender;
	NSView *windowview = [[self window] contentView];
	NSPopUpButton *popsource = [windowview viewWithTag:9801];
	NSPopUpButton *popdestination = [windowview viewWithTag:9802];
	[popsource selectItemAtIndex:4];
    [self.currentParticleData setObject:@"770" forKey:@"blendFuncSource"];
    [particle ChangeParticleWithObject:@"770" forKey:@"blendFuncSource"];
	if (btn.tag == 9901)
    {
		[popdestination selectItemAtIndex:5];
        [self.currentParticleData setObject:@"771" forKey:@"blendFuncDestination"];
        [particle ChangeParticleWithObject:@"771" forKey:@"blendFuncDestination"];
    }
	else if (btn.tag == 9902)
    {
		[popdestination selectItemAtIndex:1];
        [self.currentParticleData setObject:@"1" forKey:@"blendFuncDestination"];
        [particle ChangeParticleWithObject:@"1" forKey:@"blendFuncDestination"];
    }
}

- (IBAction) EmitterTypeChanged:(id)sender
{
    NSPopUpButton *pop = (NSPopUpButton *)sender;
    if ([pop selectedTag] == 15001) {
        gBox.alphaValue = 1;
        rBox.alphaValue = 0;
        [self SwithEmitterType:0];
        [self.currentParticleData setObject:@"0" forKey:@"emitterType"];
    }
    else
    {
        gBox.alphaValue = 0;
        rBox.alphaValue = 1;
        [self SwithEmitterType:1];
        [self.currentParticleData setObject:@"1" forKey:@"emitterType"];
    }
    @try {
        MainLayer *layer = (MainLayer *)[mainScene getChildByTag:1000];
        [layer removeAllChildrenWithCleanup:YES];
        if (particle) {
            self.particle = nil;
        }
        MSParticles *particles = [[MSParticles alloc] initWithDictionary:self.currentParticleData];
        self.particle = particles;
        [particles release];
        [layer addChild:particle];
    }
    @catch (NSException *exception) {
        CCLOG(@"Error: Emitter Type Changed \n%@", exception);
    }
    
}

- (IBAction) BlendFunctionSourceChanged:(id)sender
{
    NSArray *blendlist = [[NSArray alloc] initWithObjects:@"0", @"1", @"774", @"775", @"770", @"771", @"772", @"773", @"776", nil];
    NSPopUpButton *pop = (NSPopUpButton *)sender;
    [self.currentParticleData setObject:[blendlist objectAtIndex:[pop selectedTag] - 18000] forKey:@"blendFuncSource"];
	[particle ChangeParticleWithObject:[blendlist objectAtIndex:[pop selectedTag] - 18000] forKey:@"blendFuncSource"];
    [blendlist release];
}

- (IBAction) BlendFunctionDestinationChanged:(id)sender
{
    NSArray *blendlist = [[NSArray alloc] initWithObjects:@"0", @"1", @"774", @"775", @"770", @"771", @"772", @"773", @"776", nil];
    NSPopUpButton *pop = (NSPopUpButton *)sender;
    [self.currentParticleData setObject:[blendlist objectAtIndex:[pop selectedTag] - 19000] forKey:@"blendFuncDestination"];
	[particle ChangeParticleWithObject:[blendlist objectAtIndex:[pop selectedTag] - 19000] forKey:@"blendFuncDestination"];
    [blendlist release];
}

- (IBAction)toggleFullScreen: (id)sender
{
	CCDirectorMac *director = (CCDirectorMac *)[CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}

- (IBAction) ImageChanged:(id)sender
{
    NSOpenPanel *openimg = [NSOpenPanel openPanel];
    NSArray *filetypes = [[NSArray alloc] initWithObjects:@"png", @"bmp", @"jpg", @"jpeg", @"gif", nil];
    [openimg setCanChooseFiles:YES];
    [openimg setCanChooseDirectories:NO];
    [openimg setAllowedFileTypes:filetypes];
    [openimg setDirectoryURL:[NSURL fileURLWithPath:self.currentdirectory isDirectory:YES]];
    [openimg beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result) {
        [self didChangeImageFinished:openimg returnCode:result];
    }];
    [filetypes release];
}

- (void) didChangeImageFinished:(NSOpenPanel *)openPanel returnCode:(int)returnCode
{
    if (returnCode == NSOKButton) {
        NSString *filename = [[openPanel URL] path];
        NSFileManager *filemanager = [[NSFileManager alloc] init];
        if ([filemanager isReadableFileAtPath:filename]) {
            if ([[CCTextureCache sharedTextureCache] addImage:filename]) {
                [self.currentParticleData setObject:filename forKey:@"textureFileName"];
                [particle ChangeParticleWithObject:filename forKey:@"textureFileName"];
//                [self ResetSystem];
                NSButton *btnimage = (NSButton *)[[[self window] contentView] viewWithTag:9004];
                
                [btnimage setImage:[[[NSImage alloc] initWithContentsOfFile:filename] autorelease]];
                self.currentdirectory = openPanel.directoryURL.path;
            }
            else {
                NSAlert *alert = [NSAlert alertWithMessageText:@"Only valid images!" 
                                                 defaultButton:@"Close" 
                                               alternateButton:nil 
                                                   otherButton:nil 
                                     informativeTextWithFormat:@""];
                [alert setAlertStyle:2];
                [alert beginSheetModalForWindow:nil modalDelegate:nil didEndSelector:nil contextInfo:nil];
            }
        }
        else {
            NSAlert *alert = [NSAlert alertWithMessageText:@"Can not open this file!" 
                                             defaultButton:@"Close" 
                                           alternateButton:nil 
                                               otherButton:nil 
                                 informativeTextWithFormat:@""];
            [alert setAlertStyle:2];
            [alert beginSheetModalForWindow:nil modalDelegate:nil didEndSelector:nil contextInfo:nil];
        }
        [filemanager release];
    }
}

- (IBAction) RestoreDefault:(id)sender
{
    MainLayer *layer = (MainLayer *)[mainScene getChildByTag:1000];
    [layer removeAllChildrenWithCleanup:YES];
    if (particle) {
        [particle release];
        particle = nil;
    }
    NSString *filepath = [[CCFileUtils sharedFileUtils] fullPathFromRelativePath:@"particle.plist"];
    [self InitParticleSettingWithFile:filepath];
    [layer setColor:ccc3(0, 0, 0)];
    if (!bsw) {
        bsw = [[BackgroundSettingWindow alloc] initWithWindowNibName:@"BackgroundWindow"];
    }
    [bsw RestoreDefault];
}

#pragma mark MainWindowController - ToolBar
- (IBAction) BackgroundChanged:(id)sender
{
    if (!bsw) {
        bsw = [[BackgroundSettingWindow alloc] initWithWindowNibName:@"BackgroundWindow"];
    }
    [NSApp beginSheet:[bsw getWindow] modalForWindow:[self window] modalDelegate:self didEndSelector:nil contextInfo:NULL];
    [bsw setDelegate:self];
    //[bsw release];
}

- (void) BackgroundChangedFinish:(ccColor3B) color
{
    MainLayer *layer = (MainLayer *)[mainScene getChildByTag:1000];
    [layer setColor:color];
}

- (IBAction) DataSaveAs:(id)sender
{
    NSSavePanel *spanel = [NSSavePanel savePanel];
    NSArray *filetypes = [[NSArray alloc] initWithObjects:@"plist", nil];
    [spanel setAllowedFileTypes:filetypes];
    [spanel setDirectoryURL:[NSURL fileURLWithPath:self.currentdirectory isDirectory:YES]];
    [spanel beginSheetModalForWindow:[self window]  completionHandler:^(NSInteger result) {
        [self didEndSaveSheet:spanel returnCode:result];
    }];
    [filetypes release];
}
- (void)didEndSaveSheet:(NSSavePanel *)savePanel returnCode:(int)returnCode
{
    if (returnCode == NSOKButton)
    {
        NSString *file = [savePanel URL].path;
        NSDictionary *dic = self.currentParticleData;
        [dic writeToFile:file atomically:YES];
        self.currentdirectory = savePanel.directoryURL.path;
    }
    else
    {
        CCLOG(@"Cansel");
    }
}

- (IBAction) LoadParticleFromFile:(id)sender
{
    NSArray *filetypes = [[NSArray alloc] initWithObjects:@"plist", nil];
    NSOpenPanel *openpanel = [NSOpenPanel openPanel];
    [openpanel setCanChooseDirectories:NO];
    [openpanel setDirectoryURL:[NSURL fileURLWithPath:self.currentdirectory isDirectory:YES]];
    [openpanel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result) {
        [self didEndOpenSheet:openpanel returnCode:result];
    }];
    [filetypes release];
}
- (void)didEndOpenSheet:(NSOpenPanel *)openPanel returnCode:(int)returnCode
{
    BOOL checkfile = NO;
    NSString *filepath;
    if (returnCode == NSOKButton) {
        filepath = [[openPanel URL] path];
        checkfile = YES;
    }
    if (checkfile) {
        MainLayer *layer = (MainLayer *)[mainScene getChildByTag:1000];
        [layer removeAllChildrenWithCleanup:YES];
        [self.particle stopSystem];
        [self InitParticleSettingWithFile:filepath];
        self.currentdirectory = openPanel.directoryURL.path;
//        [self ResetSystem];
//        [self.particle resetSystem];
    }
}

- (void) ResetSystem
{
    @try {
        MainLayer *layer = (MainLayer *)[mainScene getChildByTag:1000];
        [layer removeAllChildrenWithCleanup:YES];
        if (particle) {
            self.particle = nil;
        }
        MSParticles *particles = [[MSParticles alloc] initWithDictionary:self.currentParticleData];
        self.particle = particles;
        [particles release];
        [layer addChild:self.particle];
    }
    @catch (NSException *exception) {
        CCLOG(@"Error: Emitter Type Changed \n%@", exception);
    }
}

- (IBAction) OpenExampleWindow:(id)sender
{
    self.exampleWindow = [[[ExampleWindowController alloc] initWithWindowNibName:@"ExampleWindow"] getWindow];
    [NSApp beginSheet:self.exampleWindow modalForWindow:[self window] modalDelegate:self didEndSelector:@selector(didEndExampleSheet:returnCode:conextInfo:) contextInfo:NULL];
    [self.exampleWindow release];
}
- (void)didEndExampleSheet:(NSWindow *)examplewindow returnCode:(int)returnCode conextInfo:(void *)contextInfo
{
    NSLog(@"%d", returnCode);
}

#pragma mark MainWindowController - Private Functions
- (void) PlayParticleFromFile:(NSString *)filename
{
	NSFileManager *file = [[NSFileManager alloc] init];
	BOOL isreadable = [file isReadableFileAtPath:filename];
	if (isreadable)
	{
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filename];
		[self PlayParticleFromDictionary:dict];	
	}
	else
	{
		NSString *path = [[CCFileUtils sharedFileUtils] fullPathFromRelativePath:filename];
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
		[self PlayParticleFromDictionary:dict];	
	}
	[file release];
}

- (void) PlayParticleFromDictionary:(NSDictionary *)dictionary
{
    MainLayer *layer = (MainLayer *)[mainScene getChildByTag:1000];
    if ([[layer children] count] <= 0) {
        if (self.particle) {
            self.particle = nil;
        }
        MSParticles *particles = [[MSParticles alloc] initWithDictionary:dictionary];
        self.particle = particles;
        [particles release];
        [layer addChild:self.particle];
    }
    else
    {
        [self.particle ChangeParticleWithDictionary:dictionary];
    }
}
- (void) ChangeParticleFormDictionary:(NSDictionary *)dictionary
{
        [particle ChangeParticleWithDictionary:dictionary];
}

- (void) InitParticleScreen
{
//    particle = [[MSParticles alloc] init];
//    particle.tag = 90000;
	CCDirectorMac *director = (CCDirectorMac *)[CCDirector sharedDirector];
	[director setDisplayStats:NO];	
	[director setView:glView_];
	[director setResizeMode:kCCDirectorResize_AutoScale];
	self.mainScene = [MainLayer scene];
	[director runWithScene:mainScene];
    self.currentdirectory = NSHomeDirectory();
}

- (void) InitParticleSettingWithFile:(NSString *)plistfilepath
{
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:plistfilepath];
    if (dict != nil && [dict count] > 0) {
        [self InitParticleSettingWithDictionary:dict];
    }
    else
    {
        NSAlert *alert = [NSAlert alertWithMessageText:@"Invalid particle file!" 
                                         defaultButton:@"Close" 
                                       alternateButton:nil 
                                           otherButton:nil 
                             informativeTextWithFormat:@""];
        [alert setAlertStyle:2];
        [alert beginSheetModalForWindow:nil modalDelegate:nil didEndSelector:nil contextInfo:nil];
    }
}

- (void) InitParticleSettingWithDictionary:(NSDictionary *)dictionary
{
	self.currentParticleData = (NSMutableDictionary *)dictionary;
	NSView *windowview = [[self window] contentView];
	NSDictionary *dict = dictionary;
	NSArray *pConfigList = [[NSArray alloc] initWithObjects:@"maxParticles", @"particleLifespan", @"particleLifespanVariance", @"startParticleSize", @"startParticleSizeVariance", 
							@"finishParticleSize", @"finishParticleSizeVariance", @"angle", @"angleVariance", @"rotationStart", @"rotationStartVariance", 
							@"rotationEnd", @"rotationEndVariance", nil];
	NSArray *gConfigList = [[NSArray alloc] initWithObjects:@"speed", @"speedVariance", @"gravityx", @"gravityy", @"radialAcceleration", @"radialAccelVariance", @"tangentialAcceleration", @"tangentialAccelVariance", nil];
	NSArray *pColorList = [[NSArray alloc] initWithObjects:@"startColorRed", @"startColorGreen", @"startColorBlue", @"startColorAlpha", 
						   @"startColorVarianceRed", @"startColorVarianceGreen", @"startColorVarianceBlue", @"startColorVarianceAlpha", 
						   @"finishColorRed", @"finishColorGreen", @"finishColorBlue", @"finishColorAlpha", 
						   @"finishColorVarianceRed", @"finishColorVarianceGreen", @"finishColorVarianceBlue", @"finishColorVarianceAlpha", nil];
	NSArray *eLocationList = [[NSArray alloc] initWithObjects:@"sourcePositionx", @"sourcePositionVariancex", @"sourcePositiony", @"sourcePositionVariancey", nil];
	NSArray *blendlist = [[NSArray alloc] initWithObjects:@"0", @"1", @"774", @"775", @"770", @"771", @"772", @"773", @"776", nil];
    NSArray *rConfigList = [[NSArray alloc] initWithObjects:@"maxRadius", @"maxRadiusVariance", @"minRadius", @"rotatePerSecond", @"rotatePerSecondVariance", nil];
	for(int i = 0; i < [pConfigList count]; i++)
	{
		NSSlider *slider = [windowview viewWithTag:1301 + i];
		NSTextField *txt = [windowview viewWithTag:1201 + i];
		NSStepper *stepper = [windowview viewWithTag:1101 + i];
		float keyvalue = [[dict valueForKey:[pConfigList objectAtIndex:i]] floatValue];
		[slider setFloatValue:keyvalue];
		[stepper setFloatValue:keyvalue];
		[txt setStringValue:[NSString stringWithFormat:@"%.03f", keyvalue]];
	}
	for(int i = 0; i < [gConfigList count]; i++)
	{
		NSSlider *slider = [windowview viewWithTag:2301 + i];
		NSTextField *txt = [windowview viewWithTag:2201 + i];
		NSStepper *stepper = [windowview viewWithTag:2101 + i];
		float keyvalue = [[dict valueForKey:[gConfigList objectAtIndex:i]] floatValue];
		[slider setFloatValue:keyvalue];
		[stepper setFloatValue:keyvalue];
		[txt setStringValue:[NSString stringWithFormat:@"%.03f", keyvalue]];
	}
	for(int i = 0; i < [pColorList count]; i++)
	{
		int isn = i / 4;
		int isy = i % 4;
		NSSlider *slider = [windowview viewWithTag:3301 + isy + 1000 * isn];
		NSTextField *txt = [windowview viewWithTag:3201 + isy + 1000 * isn];
		float keyvalue = [[dict valueForKey:[pColorList objectAtIndex:i]] floatValue];
		[slider setFloatValue:keyvalue];
		[txt setStringValue:[NSString stringWithFormat:@"%.03f", keyvalue]];		
	}
	for(int i = 0; i < 4; i++)
	{
		NSSlider *slider = [windowview viewWithTag:7301 + i];
		NSTextField *txt = [windowview viewWithTag:7201 + i];
		float keyvalue = [[dict valueForKey:[eLocationList objectAtIndex:i]] floatValue];
		[slider setFloatValue:keyvalue];
		[txt setStringValue:[NSString stringWithFormat:@"%.03f", keyvalue]];
	}
    for (int i = 0; i < 5; i++) {
        NSSlider *slider = [windowview viewWithTag:8301 + i];
		NSTextField *txt = [windowview viewWithTag:8201 + i];
		NSStepper *stepper = [windowview viewWithTag:8101 + i];
		float keyvalue = [[dict valueForKey:[rConfigList objectAtIndex:i]] floatValue];
		[slider setFloatValue:keyvalue];
		[stepper setFloatValue:keyvalue];
		[txt setStringValue:[NSString stringWithFormat:@"%.02f", keyvalue]];
    }
	unsigned int blentfcintvalue = [[dict valueForKey:@"blendFuncSource"] intValue];
	unsigned int blentfcvintvalue = [[dict valueForKey:@"blendFuncDestination"] intValue];
	NSPopUpButton *popsource = [windowview viewWithTag:9801];
	NSPopUpButton *popdestination = [windowview viewWithTag:9802];
	for(int i = 0; i < [blendlist count]; i++)
	{
		unsigned int blendvalue = [[blendlist objectAtIndex:i] intValue];
		if (blendvalue == blentfcintvalue)
			[popsource selectItemAtIndex:i];
		if (blendvalue == blentfcvintvalue)
			[popdestination selectItemAtIndex:i];
	}
	NSTextField *txtduration = [windowview viewWithTag:9001];
	NSStepper *stepduration = [windowview viewWithTag:9002];
	float durationvalue = [[dict valueForKey:@"duration"] floatValue];
	[txtduration setStringValue:[NSString stringWithFormat:@"%.02f", durationvalue]];
	[stepduration setFloatValue:durationvalue];
	
	NSPopUpButton *popetype = [windowview viewWithTag:9003];
	unsigned int etypevalue = [[dict valueForKey:@"emitterType"] intValue];
	[popetype selectItemAtIndex:etypevalue];
	[self SwithEmitterType:etypevalue];
    
    NSFileManager *filemgr = [[NSFileManager alloc] init];
    NSString *texturePath = [dict valueForKey:@"textureFileName"];
    NSButton *btnimage = (NSButton *)[[[self window] contentView] viewWithTag:9004];
    if (![texturePath isAbsolutePath]) {
        texturePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], texturePath];
    }
    if (![filemgr isReadableFileAtPath:texturePath]) {
        [self.currentParticleData setObject:@"snow.png" forKey:@"textureFileName"];
        texturePath = [NSString stringWithFormat:@"%@/snow.png", [[NSBundle mainBundle] resourcePath]];
    }
    [btnimage setImage:[[[NSImage alloc] initWithContentsOfFile:texturePath] autorelease]];
	[pConfigList release];
	[gConfigList release];
	[pColorList release];
	[blendlist release];	
    [rConfigList release];
    [filemgr release];
    [self PlayParticleFromDictionary:self.currentParticleData];
}

- (void) SwithEmitterType:(unsigned int)emittertype
{
    NSView *windowview = [[self window] contentView];
    BOOL gend = NO;
    if (emittertype == 1) {
        rBox.alphaValue = 1;
        gBox.alphaValue = 0;
        gend = NO;
    }
    else
    {
        rBox.alphaValue = 0;
        gBox.alphaValue = 1;
        gend = YES;
    }
    for (int i = 2101; i < 2109; i++) {
        NSStepper *stepper = [windowview viewWithTag:i];
        [stepper setEnabled:gend];
        NSSlider *slider = [windowview viewWithTag:i + 200];
        [slider setEnabled:gend];
        NSTextField *txt = [windowview viewWithTag:i + 100];
        [txt setEnabled:gend];
    }
    for (int i = 8101; i < 8106; i++) {
        NSStepper *stepper = [windowview viewWithTag:i];
        [stepper setEnabled:!gend];
        NSSlider *slider = [windowview viewWithTag:i + 200];
        [slider setEnabled:!gend];
        NSTextField *txt = [windowview viewWithTag:i + 100];
        [txt setEnabled:!gend];
    }
}

- (void) dealloc
{
	[[CCDirector sharedDirector] end];
	[super dealloc];
}

@end























