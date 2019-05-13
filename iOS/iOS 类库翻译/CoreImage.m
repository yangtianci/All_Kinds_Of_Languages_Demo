//
//  CoreImage.m
//  NormalDemo
//
//  Created by YangTianCi on 2017/12/8.
//  Copyright © 2017年 ytc. All rights reserved.
//

#import "CoreImage.h"

#import <CoreImage/CoreImage.h>

#ifdef __OBJC__

#import <CoreImage/CoreImageDefines.h>
#import <Foundation/Foundation.h>

#define UNIFIED_CORE_IMAGE 1

#import <CoreImage/CIVector.h>
#import <CoreImage/CIColor.h>
#import <CoreImage/CIImage.h>
#import <CoreImage/CIContext.h>
#import <CoreImage/CIFilter.h>
#import <CoreImage/CIKernel.h>
#import <CoreImage/CIDetector.h>
#import <CoreImage/CIFeature.h>
#import <CoreImage/CIImageProvider.h>
#import <CoreImage/CIImageProcessor.h>
#import <CoreImage/CIImageAccumulator.h>
#import <CoreImage/CIFilterConstructor.h>
#import <CoreImage/CIFilterShape.h>
#import <CoreImage/CISampler.h>
#import <CoreImage/CIRAWFilter.h>
#import <CoreImage/CIRenderDestination.h>
#import <CoreImage/CIBarcodeDescriptor.h>
#if !TARGET_OS_IPHONE
#import <CoreImage/CIFilterGenerator.h>
#import <CoreImage/CIPlugIn.h>
#endif

#endif /* __OBJC__ */

//#if __METAL_MACOS__ || __METAL_IOS__

#import <CoreImage/CIKernelMetalLib.h>


@implementation CoreImage

@end
