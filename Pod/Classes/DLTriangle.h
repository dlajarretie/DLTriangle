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

/**
 * Initializes a triangle with the given GLKVector3s
 * @param _vectors a C-style array of GLKVector3
 */
-(id) initWithVectors:(GLKVector3*)_vectors;

/**
 * A simple getter returning the vertex at the given index
 * @return the vector at the given index
 * @param the index of the wanted vector
 */
-(GLKVector3) getVector:(int)index;

/**
 * Tells if the triangle is traversed by the given ray. If it is the case, provides the distance of the intersection from ray origin.
 * @return YES if the ray intersects this triangle, NO otherwise
 * @param origin a GLKVector3 defining the ray origin
 * @param direction a GLKVector3 defining a point on the ray
 * @param intersectionDistance a pointer to a float that will be set with the distance of the intersection from the ray origin, only if an intersection is found.
 */
-(BOOL) intersectsRayWithOrigin:(GLKVector3)origin direction:(GLKVector3)direction intersectionDistance:(float*)distance;

/**
 * Returns the position of the intersection point of the given ray with this triangle
 * @return a GLKVector3 defining the position of the intersection
 * @param origin a GLKVector3 defining the ray origin
 * @param direction a GLKVector3 defining a point on the ray
 */
-(GLKVector3) intersectionPointWithRayWithOrigin:(GLKVector3)origin direction:(GLKVector3)direction;

@end
