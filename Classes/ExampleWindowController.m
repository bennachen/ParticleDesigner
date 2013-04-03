//
//  ExampleWindowController.m
//  ParticleDesigner
//
//  Created by  on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExampleWindowController.h"

@implementation ExampleWindowController
@synthesize imagesview;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
         
    }
    return self;
}

- (void) imageBrowser:(IKImageBrowserView *) aBrowser cellWasDoubleClickedAtIndex:(NSUInteger) index
{
    [NSApp endSheet:[self window] returnCode:index];
    [[self window] orderOut:nil];
}

- (void) awakeFromNib
{
    mImages = [[NSMutableArray alloc] init];
    mImportedImages = [[NSMutableArray alloc] init]; 
    [imagesview setAnimates:YES];
    [imagesview setAcceptsTouchEvents:YES];
    [imagesview setPostsFrameChangedNotifications:YES];
}

- (void) updateDatasource 
{
    [mImages addObjectsFromArray:mImportedImages]; 
    [mImportedImages removeAllObjects]; 
    [imagesview reloadData]; 
} 

- (int) numberOfItemsInImageBrowser:(IKImageBrowserView *)view 
{ 
    return [mImages count]; 
} 

- (id) imageBrowser:(IKImageBrowserView *)view itemAtIndex:(int)index 
{ 
    return [mImages objectAtIndex:index]; 
} 


- (void) addImagesWithPath:(NSString *) path recursive:(BOOL) recursive 
{
    int i, n;
    BOOL dir;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&dir];
    if(dir) {
        NSArray *content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
        n = [content count];
        for(i = 0; i < n; i++) {
            if(recursive)
                [self addImagesWithPath:[path stringByAppendingPathComponent:[content objectAtIndex:i]] recursive:NO];
            else
                [self addAnImageWithPath:[path stringByAppendingPathComponent:[content objectAtIndex:i]]];
        }
    }
    else
        [self addAnImageWithPath:path];
}

- (void) addAnImageWithPath:(NSString *) path
{
    MyImageObject *p;
    p = [[MyImageObject alloc] init];
    [p setPath:path];
    [mImportedImages addObject:p];
    [p release]; 
} 


static NSArray *openFiles()
{
    NSOpenPanel *panel;
    panel = [NSOpenPanel openPanel];
    [panel setFloatingPanel:YES];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:YES];
    int i = [panel runModal];
    if(i == NSOKButton) {
        return [panel URLs];
    }
    return nil; 
} 


- (void) addImagesWithURLs:(NSArray *) urls
{
    int i, n;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [urls  retain];
    n = [urls count];
    for(i = 0; i < n; i++) {
        NSString *path = [(NSURL*)[urls objectAtIndex:i] path];
        [self addImagesWithPath:path recursive:YES];
    }
    [self performSelectorOnMainThread:@selector(updateDatasource) 
                           withObject:nil
                        waitUntilDone:YES];
    [urls release];
    [pool release]; 
} 


- (IBAction) addImageButtonClicked:(id) sender 
{
    NSArray *path = openFiles();
    if(!path) {
        NSLog(@"No path selected, return..."); 
        return;
    }
    [NSThread detachNewThreadSelector:@selector(addImagesWithURLs:) toTarget:self withObject:path];
} 

- (NSWindow *) getWindow
{
    return [self window];
}

- (IBAction) CloseThisWindow:(id)sender
{
    [NSApp endSheet:[self window] returnCode:-1];
    [[self window] orderOut:nil];
}


- (void) dealloc
{
    [mImages release]; 
    [mImportedImages release]; 
    [super dealloc];
}

@end


 

@implementation MyImageObject

- (NSString *) imageRepresentationType
{
    return IKImageBrowserPathRepresentationType;
}

- (id) imageRepresentation 
{
    return mPath;
} 

- (NSString *) imageUID 
{
    return mPath;
} 

- (void) setPath:(NSString *) path 
{
    if(mPath != path) {
        [mPath release];
        mPath = [path retain];
    } 
} 

- (void) dealloc
{
    [mPath release];
    [super dealloc];
}
@end
