//
//  ExampleWindowController.h
//  ParticleDesigner
//
//  Created by  on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "cocos2d.h"
#import <Quartz/Quartz.h>

@interface ExampleWindowController : NSWindowController
{
    IKImageBrowserView *imagesview;
    NSMutableArray * mImages; 
    NSMutableArray * mImportedImages; 
}

@property (nonatomic, assign) IBOutlet IKImageBrowserView *imagesview;

- (NSWindow *) getWindow;
- (IBAction) CloseThisWindow:(id)sender;

- (void) addAnImageWithPath:(NSString *)path;
- (void) addImagesWithPath:(NSString *)path recursive:(BOOL)recursive;
@end

@interface MyImageObject : NSObject
{ 
    NSString * mPath; 
} 
- (void) setPath:(NSString *) path;
@end