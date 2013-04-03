//
//  MSParticles.m
//  ParticleDesigner
//
//  Created by  on 11/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MSParticles.h"

@implementation MSParticles

- (id) init
{
	return [self initWithTotalParticles:1500];
}

- (void) ChangeParticleWithDictionary:(NSDictionary *) dictionary
{
    id maxParticles = [dictionary valueForKey:@"maxParticles"];
    if (maxParticles) {
		[self setTotalParticles:[maxParticles intValue]];
    }
    if ([dictionary valueForKey:@"angle"]) {
        self.angle = [[dictionary valueForKey:@"angle"] floatValue];
    }
    if ([dictionary valueForKey:@"angleVariance"]) {
        self.angleVar = [[dictionary valueForKey:@"angleVariance"] floatValue];
    }
    if ([dictionary valueForKey:@"duration"]) {
        self.duration = [[dictionary valueForKey:@"duration"] floatValue];
        [self resetSystem];
    }
    if ([dictionary valueForKey:@"blendFuncSource"]) {
        blendFunc_.src = [[dictionary valueForKey:@"blendFuncSource"] intValue];
    }
    if ([dictionary valueForKey:@"blendFuncDestination"]) {
        blendFunc_.dst = [[dictionary valueForKey:@"blendFuncDestination"] intValue];
    }
    
    if ([dictionary valueForKey:@"startColorRed"]) {
        float red = [[dictionary valueForKey:@"startColorRed"] floatValue];
        startColor = (ccColor4F){red, self.startColor.g, self.startColor.b, self.startColor.a};
    }
    if ([dictionary valueForKey:@"startColorGreen"]) {
        float green = [[dictionary valueForKey:@"startColorGreen"] floatValue];
        startColor = (ccColor4F){self.startColor.r, green, self.startColor.b, self.startColor.a};
    }
    if ([dictionary valueForKey:@"startColorBlue"]) {
        float blue = [[dictionary valueForKey:@"startColorBlue"] floatValue];
        startColor = (ccColor4F){self.startColor.r, self.startColor.g, blue, self.startColor.a};
    }
    if ([dictionary valueForKey:@"startColorAlpha"]) {
        float alpha = [[dictionary valueForKey:@"startColorAlpha"] floatValue];
        startColor = (ccColor4F){self.startColor.r, self.startColor.g, self.startColor.b, alpha};
    }
    
    if ([dictionary valueForKey:@"startColorVarianceRed"]) {
        float red = [[dictionary valueForKey:@"startColorVarianceRed"] floatValue];
        startColorVar = (ccColor4F){red, self.startColorVar.g, self.startColorVar.b, self.startColorVar.a};
    }
    if ([dictionary valueForKey:@"startColorVarianceGreen"]) {
        float green = [[dictionary valueForKey:@"startColorVarianceGreen"] floatValue];
        startColorVar = (ccColor4F){self.startColorVar.r, green, self.startColorVar.b, self.startColorVar.a};
    }
    if ([dictionary valueForKey:@"startColorVarianceBlue"]) {
        float blue = [[dictionary valueForKey:@"startColorVarianceBlue"] floatValue];
        startColorVar = (ccColor4F){self.startColorVar.r, self.startColorVar.g, blue, self.startColorVar.a};
    }
    if ([dictionary valueForKey:@"startColorVarianceAlpha"]) {
        float alpha = [[dictionary valueForKey:@"startColorVarianceAlpha"] floatValue];
        startColorVar = (ccColor4F){self.startColorVar.r, self.startColorVar.g, self.startColorVar.b, alpha};
    }
    
    if ([dictionary valueForKey:@"finishColorRed"]) {
        float red = [[dictionary valueForKey:@"finishColorRed"] floatValue];
        endColor = (ccColor4F){red, self.endColor.g, self.endColor.b, self.endColor.a};
    }
    if ([dictionary valueForKey:@"finishColorGreen"]) {
        float green = [[dictionary valueForKey:@"finishColorGreen"] floatValue];
        endColor = (ccColor4F){self.endColor.r, green, self.endColor.b, self.endColor.a};
    }
    if ([dictionary valueForKey:@"finishColorBlue"]) {
        float blue = [[dictionary valueForKey:@"finishColorBlue"] floatValue];
        endColor = (ccColor4F){self.endColor.r, self.endColor.g, blue, self.endColor.a};
    }
    if ([dictionary valueForKey:@"finishColorAlpha"]) {
        float alpha = [[dictionary valueForKey:@"finishColorAlpha"] floatValue];
        endColor = (ccColor4F){self.endColor.r, self.endColor.g, self.endColor.b, alpha};
    }
    
    if ([dictionary valueForKey:@"finishColorVarianceRed"]) {
        float red = [[dictionary valueForKey:@"finishColorVarianceRed"] floatValue];
        endColorVar = (ccColor4F){red, self.endColorVar.g, self.endColorVar.b, self.endColorVar.a};
    }
    if ([dictionary valueForKey:@"finishColorVarianceGreen"]) {
        float green = [[dictionary valueForKey:@"finishColorVarianceGreen"] floatValue];
        endColorVar = (ccColor4F){self.endColorVar.r, green, self.endColorVar.b, self.endColorVar.a};
    }
    if ([dictionary valueForKey:@"finishColorVarianceBlue"]) {
        float blue = [[dictionary valueForKey:@"finishColorVarianceBlue"] floatValue];
        endColorVar = (ccColor4F){self.endColorVar.r, self.endColorVar.g, blue, self.endColorVar.a};
    }
    if ([dictionary valueForKey:@"finishColorVarianceAlpha"]) {
        float alpha = [[dictionary valueForKey:@"finishColorVarianceAlpha"] floatValue];
        endColorVar = (ccColor4F){self.endColorVar.r, self.endColorVar.g, self.endColorVar.b, alpha};
    }

    
    if ([dictionary valueForKey:@"startParticleSize"]) {
        self.startSize = [[dictionary valueForKey:@"startParticleSize"] floatValue];
    }
    if ([dictionary valueForKey:@"startParticleSizeVariance"]) {
        self.startSizeVar = [[dictionary valueForKey:@"startParticleSizeVariance"] floatValue];
    }
    if ([dictionary valueForKey:@"finishParticleSize"]) {
        self.endSize = [[dictionary valueForKey:@"finishParticleSize"] floatValue];
    }
    if ([dictionary valueForKey:@"finishParticleSizeVariance"]) {
        self.endSizeVar = [[dictionary valueForKey:@"finishParticleSizeVariance"] floatValue];
    }
    
    
    if ([dictionary valueForKey:@"sourcePositionx"]) {
        float x = [[dictionary valueForKey:@"sourcePositionx"] floatValue];
        self.position = ccp(x, position_.y);
    }
    if ([dictionary valueForKey:@"sourcePositiony"]) {
        float y = [[dictionary valueForKey:@"sourcePositiony"] floatValue];
        self.position = ccp(position_.x, y);
    }
    if ([dictionary valueForKey:@"sourcePositionVariancex"]) {
        posVar.x = [[dictionary valueForKey:@"sourcePositionVariancex"] floatValue];
    }
    if ([dictionary valueForKey:@"sourcePositionVariancey"]) {
        posVar.y = [[dictionary valueForKey:@"sourcePositionVariancey"] floatValue];
    }
    
    if ([dictionary valueForKey:@"rotationStart"]) {
        self.startSpin = [[dictionary valueForKey:@"rotationStart"] floatValue];
    }
    if ([dictionary valueForKey:@"rotationStartVariance"]) {
        self.startSpinVar = [[dictionary valueForKey:@"rotationStartVariance"] floatValue];
    }
    if ([dictionary valueForKey:@"rotationEnd"]) {
        self.endSpin = [[dictionary valueForKey:@"rotationEnd"] floatValue];
    }
    if ([dictionary valueForKey:@"rotationEndVariance"]) {
        self.endSpinVar = [[dictionary valueForKey:@"rotationEndVariance"] floatValue];
    }
    
    
    if ([dictionary valueForKey:@"emitterType"]) {
        emitterMode_ = [[dictionary valueForKey:@"emitterType"] intValue];
        [self stopSystem];
        [self resetSystem];
    }
    if ([dictionary valueForKey:@"gravityx"]) {
        mode.A.gravity.x = [[dictionary valueForKey:@"gravityx"] floatValue];
    }
    if ([dictionary valueForKey:@"gravityy"]) {
        mode.A.gravity.y = [[dictionary valueForKey:@"gravityy"] floatValue];
    }
    
    if ([dictionary valueForKey:@"speed"]) {
        mode.A.speed = [[dictionary valueForKey:@"speed"] floatValue];
    }
    if ([dictionary valueForKey:@"speedVariance"]) {
        mode.A.speedVar = [[dictionary valueForKey:@"speedVariance"] floatValue];
    }
    
    if ([dictionary valueForKey:@"radialAcceleration"]) {
        mode.A.radialAccel = [[dictionary valueForKey:@"radialAcceleration"] floatValue];
    }
    if ([dictionary valueForKey:@"radialAccelVariance"]) {
        mode.A.radialAccelVar = [[dictionary valueForKey:@"radialAccelVariance"] floatValue];
    }
    if ([dictionary valueForKey:@"tangentialAcceleration"]) {
        mode.A.tangentialAccel = [[dictionary valueForKey:@"tangentialAcceleration"] floatValue];
    }
    if ([dictionary valueForKey:@"tangentialAccelVariance"]) {
        mode.A.tangentialAccelVar = [[dictionary valueForKey:@"tangentialAccelVariance"] floatValue];
    }
    
    
    if ([dictionary valueForKey:@"maxRadius"]) {
        mode.B.startRadius = [[dictionary valueForKey:@"maxRadius"] floatValue];
    }
    if ([dictionary valueForKey:@"maxRadiusVariance"]) {
        mode.B.startRadiusVar = [[dictionary valueForKey:@"maxRadiusVariance"] floatValue];
    }
    if ([dictionary valueForKey:@"minRadius"]) {
        mode.B.endRadius = [[dictionary valueForKey:@"minRadius"] floatValue];
        mode.B.endRadiusVar = 0;
    }
    if ([dictionary valueForKey:@"rotatePerSecond"]) {
        mode.B.rotatePerSecond = [[dictionary valueForKey:@"rotatePerSecond"] floatValue];
    }
    if ([dictionary valueForKey:@"rotatePerSecondVariance"]) {
        mode.B.rotatePerSecondVar = [[dictionary valueForKey:@"rotatePerSecondVariance"] floatValue];
    }
    if ([dictionary valueForKey:@"particleLifespan"]) {
        self.life = [[dictionary valueForKey:@"particleLifespan"] floatValue];
    }
    if ([dictionary valueForKey:@"particleLifespanVariance"]) {
        self.lifeVar = [[dictionary valueForKey:@"particleLifespanVariance"] floatValue];
    }
    if ([dictionary valueForKey:@"textureFileName"]) {
        NSString *textureName = [dictionary valueForKey:@"textureFileName"];
        CCTexture2D *tex = [[CCTextureCache sharedTextureCache] addImage:textureName];
        if (tex) {
            self.texture = tex;
        }
    }
    if (self.duration <= -1.0f) {
        if (!self.active) {
            [self resetSystem];
        }
    }
    else
        [self resetSystem];
}
- (void) ChangeParticleWithObject:(id) object forKey:(NSString *)forkey
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:object forKey:forkey];
    [self ChangeParticleWithDictionary:dic];
    [dic release];
}

- (id) initWithDictionary:(NSDictionary *)dictionary
{
	NSUInteger maxParticles = [[dictionary valueForKey:@"maxParticles"] intValue];
	// self, not super
	if ((self=[self initWithTotalParticles:maxParticles] ) ) {
		
		// angle
		angle = [[dictionary valueForKey:@"angle"] floatValue];
		angleVar = [[dictionary valueForKey:@"angleVariance"] floatValue];
		
		// duration
		duration = [[dictionary valueForKey:@"duration"] floatValue];
		
		// blend function 
		blendFunc_.src = [[dictionary valueForKey:@"blendFuncSource"] intValue];
		blendFunc_.dst = [[dictionary valueForKey:@"blendFuncDestination"] intValue];
		
		// color
		float r,g,b,a;
		
		r = [[dictionary valueForKey:@"startColorRed"] floatValue];
		g = [[dictionary valueForKey:@"startColorGreen"] floatValue];
		b = [[dictionary valueForKey:@"startColorBlue"] floatValue];
		a = [[dictionary valueForKey:@"startColorAlpha"] floatValue];
		startColor = (ccColor4F) {r,g,b,a};
		
		r = [[dictionary valueForKey:@"startColorVarianceRed"] floatValue];
		g = [[dictionary valueForKey:@"startColorVarianceGreen"] floatValue];
		b = [[dictionary valueForKey:@"startColorVarianceBlue"] floatValue];
		a = [[dictionary valueForKey:@"startColorVarianceAlpha"] floatValue];
		startColorVar = (ccColor4F) {r,g,b,a};
		
		r = [[dictionary valueForKey:@"finishColorRed"] floatValue];
		g = [[dictionary valueForKey:@"finishColorGreen"] floatValue];
		b = [[dictionary valueForKey:@"finishColorBlue"] floatValue];
		a = [[dictionary valueForKey:@"finishColorAlpha"] floatValue];
		endColor = (ccColor4F) {r,g,b,a};
		
		r = [[dictionary valueForKey:@"finishColorVarianceRed"] floatValue];
		g = [[dictionary valueForKey:@"finishColorVarianceGreen"] floatValue];
		b = [[dictionary valueForKey:@"finishColorVarianceBlue"] floatValue];
		a = [[dictionary valueForKey:@"finishColorVarianceAlpha"] floatValue];
		endColorVar = (ccColor4F) {r,g,b,a};
		
		// particle size
		startSize = [[dictionary valueForKey:@"startParticleSize"] floatValue];
		startSizeVar = [[dictionary valueForKey:@"startParticleSizeVariance"] floatValue];
		endSize = [[dictionary valueForKey:@"finishParticleSize"] floatValue];
		endSizeVar = [[dictionary valueForKey:@"finishParticleSizeVariance"] floatValue];
		
		
		// position
		float x = [[dictionary valueForKey:@"sourcePositionx"] floatValue];
		float y = [[dictionary valueForKey:@"sourcePositiony"] floatValue];
		self.position = ccp(x,y);
		posVar.x = [[dictionary valueForKey:@"sourcePositionVariancex"] floatValue];
		posVar.y = [[dictionary valueForKey:@"sourcePositionVariancey"] floatValue];
        
		
		// Spinning
		startSpin = [[dictionary valueForKey:@"rotationStart"] floatValue];
		startSpinVar = [[dictionary valueForKey:@"rotationStartVariance"] floatValue];
		endSpin = [[dictionary valueForKey:@"rotationEnd"] floatValue];
		endSpinVar = [[dictionary valueForKey:@"rotationEndVariance"] floatValue];
		
		emitterMode_ = [[dictionary valueForKey:@"emitterType"] intValue];
        
		// Mode A: Gravity + tangential accel + radial accel
		if( emitterMode_ == kCCParticleModeGravity ) {
			// gravity
			mode.A.gravity.x = [[dictionary valueForKey:@"gravityx"] floatValue];
			mode.A.gravity.y = [[dictionary valueForKey:@"gravityy"] floatValue];
			
			//
			// speed
			mode.A.speed = [[dictionary valueForKey:@"speed"] floatValue];
			mode.A.speedVar = [[dictionary valueForKey:@"speedVariance"] floatValue];
			
			// radial acceleration			
			NSString *tmp = [dictionary valueForKey:@"radialAcceleration"];
			mode.A.radialAccel = tmp ? [tmp floatValue] : 0;
			
			tmp = [dictionary valueForKey:@"radialAccelVariance"];
			mode.A.radialAccelVar = tmp ? [tmp floatValue] : 0;
            
			// tangential acceleration
			tmp = [dictionary valueForKey:@"tangentialAcceleration"];
			mode.A.tangentialAccel = tmp ? [tmp floatValue] : 0;
			
			tmp = [dictionary valueForKey:@"tangentialAccelVariance"];
			mode.A.tangentialAccelVar = tmp ? [tmp floatValue] : 0;
		}
		
		
		// or Mode B: radius movement
		else if( emitterMode_ == kCCParticleModeRadius ) {
			float maxRadius = [[dictionary valueForKey:@"maxRadius"] floatValue];
			float maxRadiusVar = [[dictionary valueForKey:@"maxRadiusVariance"] floatValue];
			float minRadius = [[dictionary valueForKey:@"minRadius"] floatValue];
			
			mode.B.startRadius = maxRadius;
			mode.B.startRadiusVar = maxRadiusVar;
			mode.B.endRadius = minRadius;
			mode.B.endRadiusVar = 0;
			mode.B.rotatePerSecond = [[dictionary valueForKey:@"rotatePerSecond"] floatValue];
			mode.B.rotatePerSecondVar = [[dictionary valueForKey:@"rotatePerSecondVariance"] floatValue];
            
		} else {
			NSAssert( NO, @"Invalid emitterType in config file");
		}
		
		// life span
		life = [[dictionary valueForKey:@"particleLifespan"] floatValue];
		lifeVar = [[dictionary valueForKey:@"particleLifespanVariance"] floatValue];				
		
		// emission Rate
		emissionRate = totalParticles / life;
        
		// texture		
		// Try to get the texture from the cache
		NSString *textureName = [dictionary valueForKey:@"textureFileName"];
        NSFileManager *filemgr = [[NSFileManager alloc] init];
        CCTexture2D *tex;
        NSString *texturePath;
        if ([textureName isAbsolutePath]) {
            texturePath = textureName;
        }
        else {
            texturePath = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], textureName];
        }
        
        if ([filemgr isReadableFileAtPath:texturePath]) {
            tex = [[CCTextureCache sharedTextureCache] addImage:texturePath];
        }
        else
            tex = nil;
		
        
		if(tex)
			self.texture = tex;
		else {
            
			NSString *textureData = [dictionary valueForKey:@"textureImageData"];
			NSAssert(textureData, @"CCParticleSystem: Couldn't load texture");
			
			// if it fails, try to get it from the base64-gzipped data			
			unsigned char *buffer = NULL;
			int len = base64Decode((unsigned char*)[textureData UTF8String], (unsigned int)[textureData length], &buffer);
			NSAssert(buffer != NULL, @"CCParticleSystem: error decoding textureImageData");
            
			unsigned char *deflated = NULL;
			NSUInteger deflatedLen = ccInflateMemory(buffer, len, &deflated);
			free( buffer );
            
			NSAssert( deflated != NULL, @"CCParticleSystem: error ungzipping textureImageData");
			NSData *data = [[NSData alloc] initWithBytes:deflated length:deflatedLen];
			
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
			UIImage *image = [[UIImage alloc] initWithData:data];
#elif defined(__MAC_OS_X_VERSION_MAX_ALLOWED)
			NSBitmapImageRep *image = [[NSBitmapImageRep alloc] initWithData:data];
#endif
			
			free(deflated); deflated = NULL;
            
			self.texture = [[CCTextureCache sharedTextureCache] addCGImage:[image CGImage] forKey:textureName];
			[data release];
			[image release];
		}
		[filemgr release];
		NSAssert( [self texture] != NULL, @"CCParticleSystem: error loading the texture");
		
	}
	
	return self;
}
@end

