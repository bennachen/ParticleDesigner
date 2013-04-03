//
//  MSParticles.h
//  ParticleDesigner
//
//  Created by  on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCParticleSystemQuad.h"
#import "cocos2d.h"
#include "base64.h"
#import "ZipUtils.h"
@interface MSParticles : CCParticleSystemQuad
- (void) ChangeParticleWithDictionary:(NSDictionary *) dictionary;
- (void) ChangeParticleWithObject:(id) object forKey:(NSString *)forkey;
@end
