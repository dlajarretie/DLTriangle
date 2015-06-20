//
//  DLTriangle.h
//  RayTriangleIntersection
//
//  Created by Damien Lajarretie on 20/06/2015.
//  Copyright (c) 2015 Damien Lajarretie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface DLTriangle : NSObject {
    GLKVector3 vectors[3];
}

-(id) initWithVectors:(GLKVector3*)_vectors;

-(GLKVector3) getVector:(int)index;

-(BOOL) intersectsRayWithOrigin:(GLKVector3)origin direction:(GLKVector3)direction intersectionDistance:(float*)distance;
-(GLKVector3) intersectionPointWithRayWithOrigin:(GLKVector3)origin direction:(GLKVector3)direction;

@end
