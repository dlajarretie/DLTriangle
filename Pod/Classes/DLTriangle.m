//
//  DLTriangle.m
//  RayTriangleIntersection
//
//  Created by Damien Lajarretie on 20/06/2015.
//  Copyright (c) 2015 Damien Lajarretie. All rights reserved.
//

#import "DLTriangle.h"

#define EPSILON 0.000001

@implementation DLTriangle

-(id) initWithVectors:(GLKVector3 *)_vectors {
    
    if(self = [super init]) {
        for(int i = 0; i < 3; i++) {
            vectors[i] = _vectors[i];
        }
    }
    
    return self;
}

-(GLKVector3) getVector:(int)index {
    return vectors[index];
}

-(BOOL) intersectsRayWithOrigin:(GLKVector3)origin direction:(GLKVector3)direction intersectionDistance:(float*)distance {

    // Möller-Trumbore algorithm GLKit implementation
    // Based on implementation found on https://en.wikipedia.org/wiki/M%C3%B6ller%E2%80%93Trumbore_intersection_algorithm
    
    // Declarations
    
    // Triangle vectors
    GLKVector3 V1 = vectors[0];
    GLKVector3 V2 = vectors[1];
    GLKVector3 V3 = vectors[2];
    // Ray vectors
    GLKVector3 O = origin;
    GLKVector3 D = direction;
    // Vars
    GLKVector3 edge1, edge2;
    GLKVector3 P, Q, T;
    float det, inv_det, u, v;
    float t;
    
    // Algorithm
    
    // Find vectors for two edges sharing V1

    edge1 = GLKVector3Subtract(V2, V1);
    edge2 = GLKVector3Subtract(V3, V1);

    // Begin calculating determinant - also used to calculate u parameter
    
    P = GLKVector3CrossProduct(D, edge2);
    
    // If determinant is near zero, ray lies in plane of triangle
    
    det = GLKVector3DotProduct(edge1, P);
    
    // NOT CULLING
    
    if(det > -EPSILON && det < EPSILON) return NO;
    inv_det = 1.f / det;
    
    // Calculate distance from V1 to ray origin
    
    T = GLKVector3Subtract(O, V1);
    
    // Calculate u parameter and test bound
    
    u = GLKVector3DotProduct(T, P) * inv_det;
    
    // The intersection lies outside of the triangle
    
    if(u < 0.f || u > 1.f) return 0;
    
    // Prepare to test v parameter
    
    Q = GLKVector3CrossProduct(T, edge1);
    
    // Calculate V parameter and test bound
    
    v = GLKVector3DotProduct(D, Q) * inv_det;
    
    // The intersection lies outside of the triangle
    
    if(v < 0.f || u + v  > 1.f) return 0;
    
    t = GLKVector3DotProduct(edge2, Q) * inv_det;
    
    if(t > EPSILON) { // Ray intersection
        if(distance != nil) {
            *distance = t;
        }
        return YES;
    }
    
    // No hit, no win
    
    return NO;
}

-(GLKVector3) intersectionPointWithRayWithOrigin:(GLKVector3)origin direction:(GLKVector3)direction intersectionDistance:(float)distance {

    float X = origin.x + distance * direction.x;
    float Y = origin.y + distance * direction.y;
    float Z = origin.z + distance * direction.z;
    
    return GLKVector3Make(X, Y, Z);
}

-(GLKVector3) intersectionPointWithRayWithOrigin:(GLKVector3)origin direction:(GLKVector3)direction {
    
    float intersectionDistance;
    
    [self intersectsRayWithOrigin:origin direction:direction intersectionDistance:&intersectionDistance];
    
    return [self intersectionPointWithRayWithOrigin:origin direction:direction intersectionDistance:intersectionDistance];
}

-(GLKVector3) getNormal {

    // Triangle vectors
    GLKVector3 V1 = vectors[0];
    GLKVector3 V2 = vectors[1];
    GLKVector3 V3 = vectors[2];
    
    // Find vectors for two edges sharing V1
    
    GLKVector3 edge1 = GLKVector3Subtract(V2, V1);
    GLKVector3 edge2 = GLKVector3Subtract(V3, V1);
    
    return GLKVector3CrossProduct(edge1, edge2);
}

-(float) getDistanceToOrigin {
    return -GLKVector3DotProduct([self getNormal], vectors[0]);
}

@end
