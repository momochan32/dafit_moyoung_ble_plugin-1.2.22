#if 0
#elif defined(__arm64__) && __arm64__
// Generated by Apple Swift version 5.5.2 (swiftlang-1300.0.47.5 clang-1300.0.29.30)
#ifndef SFDIALPLATESDK_SWIFT_H
#define SFDIALPLATESDK_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(ns_consumed)
# define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
#else
# define SWIFT_RELEASES_ARGUMENT
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import CoreBluetooth;
@import Foundation;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="SFDialPlateSDK",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif



@class NSString;

@interface NSData (SWIFT_EXTENSION(SFDialPlateSDK))
@property (nonatomic, readonly, copy) NSString * _Nonnull debugDescription;
@end

@class NSNumber;

SWIFT_CLASS("_TtC14SFDialPlateSDK16SFCommonLogModel")
@interface SFCommonLogModel : NSObject
/// 时间戳，毫秒
@property (nonatomic, readonly) NSInteger timestamp;
/// 日志内容
@property (nonatomic, readonly, copy) NSString * _Nonnull message;
- (nonnull instancetype)initWithTimestamp:(NSInteger)timestamp message:(NSString * _Nonnull)message OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@protocol SFDialPlateManagerDelegate;
@class NSURL;
@class SFFile;

SWIFT_CLASS("_TtC14SFDialPlateSDK18SFDialPlateManager")
@interface SFDialPlateManager : NSObject
/// 获取SFDialPlateManager单例对象
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) SFDialPlateManager * _Nonnull share;)
+ (SFDialPlateManager * _Nonnull)share SWIFT_WARN_UNUSED_RESULT;
/// 当前Manager是否正忙。为true则会忽略pushDialPlate函数的调用
@property (nonatomic, readonly) BOOL isBusy;
/// 推送过程、结果监听代理
@property (nonatomic, weak) id <SFDialPlateManagerDelegate> _Nullable delegate;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
/// 推送表盘文件
/// \param devIdentifier 目标设备的identifier字符串。通过CBPeripheral.identifier.uuidString获取
///
/// \param type 文件类型。0-表盘，1-多语言，2-背景图，3-自定义，4-音乐。其它类型查阅文档。
///
/// \param zipPath zip格式的升级文件位于本地的url
///
/// \param maxFileSliceLength 文件切片长度，默认1024字节。数值越大速度越快，但可能造成设备无法响应。该值应视具体设备而定。
///
/// \param withByteAlign 是否对文件进行CRC和字节对齐处理，需要依据具体的设备支持情况来决定该参数的取值。默认false。PS：当type为3时，总是会进行CRC和对齐操作，与该参数取值无关。
///
- (void)pushDialPlateWithDevIdentifier:(NSString * _Nonnull)devIdentifier type:(uint16_t)type zipPath:(NSURL * _Nonnull)zipPath maxFileSliceLength:(NSInteger)maxFileSliceLength withByteAlign:(BOOL)withByteAlign;
/// 推送表盘文件
/// \param devIdentifier 目标设备的identifier字符串。通过CBPeripheral.identifier.uuidString获取
///
/// \param type 文件类型。0-表盘，1-多语言，2-背景图，3-自定义，4-音乐。其它类型查阅文档。
///
/// \param files 所推送的文件序列。
///
/// \param maxFileSliceLength 文件切片长度，默认1024字节。数值越大速度越快，但可能造成设备无法响应。该值应视具体设备而定。
///
/// \param withByteAlign 是否对文件进行CRC和字节对齐处理，需要依据具体的设备支持情况来决定该参数的取值。默认false。PS：当type为3时，总是会进行CRC和对齐操作，与该参数取值无关。
///
- (void)pushDialPlateWithDevIdentifier:(NSString * _Nonnull)devIdentifier type:(uint16_t)type files:(NSArray<SFFile *> * _Nonnull)files maxFileSliceLength:(NSInteger)maxFileSliceLength withByteAlign:(BOOL)withByteAlign;
/// 终止任务。
- (void)stop;
@end

@class SFError;

SWIFT_PROTOCOL("_TtP14SFDialPlateSDK26SFDialPlateManagerDelegate_")
@protocol SFDialPlateManagerDelegate
/// 蓝牙状态发生改变时产生的回调。
- (void)dialPlateManagerWithManager:(SFDialPlateManager * _Nonnull)manager didUpdateBLEState:(CBManagerState)bleState;
/// 推送进度回调。progess取值0~100
- (void)dialPlateManagerWithManager:(SFDialPlateManager * _Nonnull)manager progress:(NSInteger)progress;
/// 推送结束回调。error为空表示推送成功，不为空表示推送失败
- (void)dialPlateManagerWithManager:(SFDialPlateManager * _Nonnull)manager complete:(SFError * _Nullable)error;
@end

enum SFErrorType : NSInteger;

SWIFT_CLASS("_TtC14SFDialPlateSDK7SFError")
@interface SFError : NSObject
/// 错误类型
@property (nonatomic) enum SFErrorType errType;
/// 错误信息
@property (nonatomic, copy) NSString * _Nonnull errInfo;
/// 当errType为ErrorCode(7)时，可从该属性获取到设备返回的错误码值，Int类型
@property (nonatomic, strong) NSNumber * _Nullable devErrorCode;
/// 错误码
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

typedef SWIFT_ENUM(NSInteger, SFErrorType, open) {
  SFErrorTypeUnknown = 0,
  SFErrorTypeTimeout = 1,
  SFErrorTypeNoConnection = 2,
  SFErrorTypeCanceled = 3,
  SFErrorTypeDisconnected = 4,
  SFErrorTypeFailedToConnect = 5,
  SFErrorTypeInvalidDataStruct = 6,
  SFErrorTypeErrorCode = 7,
  SFErrorTypeEncodeError = 8,
  SFErrorTypeInvalidValue = 9,
  SFErrorTypeOutOfRange = 10,
  SFErrorTypeUnzipFailed = 11,
  SFErrorTypeInvalidFile = 12,
  SFErrorTypeLoadFileFailed = 13,
  SFErrorTypeDeviceAbort = 14,
  SFErrorTypeFileSliceTooLarge = 15,
  SFErrorTypeInsufficientDeviceSpace = 16,
};


SWIFT_CLASS("_TtC14SFDialPlateSDK6SFFile")
@interface SFFile : NSObject
/// 文件名。包含文件后缀。
@property (nonatomic, readonly, copy) NSString * _Nonnull fileName;
/// 文件内容。
@property (nonatomic, readonly, copy) NSData * _Nonnull file;
/// 构造函数
/// \param fileName 文件名。包含文件后缀
///
/// \param file 文件内容。
///
- (nonnull instancetype)initWithFileName:(NSString * _Nonnull)fileName file:(NSData * _Nonnull)file OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14SFDialPlateSDK12SFLogManager")
@interface SFLogManager : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) SFLogManager * _Nonnull share;)
+ (SFLogManager * _Nonnull)share SWIFT_WARN_UNUSED_RESULT;
/// SDK内部日志开关。当关闭时，控制台不再打印内容，但QBleLogManagerDelegate的回调不受影响。
@property (nonatomic) BOOL openLog;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14SFDialPlateSDK19SFResponseBaseModel")
@interface SFResponseBaseModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
#endif

#elif defined(__ARM_ARCH_7A__) && __ARM_ARCH_7A__
// Generated by Apple Swift version 5.5.2 (swiftlang-1300.0.47.5 clang-1300.0.29.30)
#ifndef SFDIALPLATESDK_SWIFT_H
#define SFDIALPLATESDK_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(ns_consumed)
# define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
#else
# define SWIFT_RELEASES_ARGUMENT
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import CoreBluetooth;
@import Foundation;
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="SFDialPlateSDK",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif



@class NSString;

@interface NSData (SWIFT_EXTENSION(SFDialPlateSDK))
@property (nonatomic, readonly, copy) NSString * _Nonnull debugDescription;
@end

@class NSNumber;

SWIFT_CLASS("_TtC14SFDialPlateSDK16SFCommonLogModel")
@interface SFCommonLogModel : NSObject
/// 时间戳，毫秒
@property (nonatomic, readonly) NSInteger timestamp;
/// 日志内容
@property (nonatomic, readonly, copy) NSString * _Nonnull message;
- (nonnull instancetype)initWithTimestamp:(NSInteger)timestamp message:(NSString * _Nonnull)message OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@protocol SFDialPlateManagerDelegate;
@class NSURL;
@class SFFile;

SWIFT_CLASS("_TtC14SFDialPlateSDK18SFDialPlateManager")
@interface SFDialPlateManager : NSObject
/// 获取SFDialPlateManager单例对象
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) SFDialPlateManager * _Nonnull share;)
+ (SFDialPlateManager * _Nonnull)share SWIFT_WARN_UNUSED_RESULT;
/// 当前Manager是否正忙。为true则会忽略pushDialPlate函数的调用
@property (nonatomic, readonly) BOOL isBusy;
/// 推送过程、结果监听代理
@property (nonatomic, weak) id <SFDialPlateManagerDelegate> _Nullable delegate;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
/// 推送表盘文件
/// \param devIdentifier 目标设备的identifier字符串。通过CBPeripheral.identifier.uuidString获取
///
/// \param type 文件类型。0-表盘，1-多语言，2-背景图，3-自定义，4-音乐。其它类型查阅文档。
///
/// \param zipPath zip格式的升级文件位于本地的url
///
/// \param maxFileSliceLength 文件切片长度，默认1024字节。数值越大速度越快，但可能造成设备无法响应。该值应视具体设备而定。
///
/// \param withByteAlign 是否对文件进行CRC和字节对齐处理，需要依据具体的设备支持情况来决定该参数的取值。默认false。PS：当type为3时，总是会进行CRC和对齐操作，与该参数取值无关。
///
- (void)pushDialPlateWithDevIdentifier:(NSString * _Nonnull)devIdentifier type:(uint16_t)type zipPath:(NSURL * _Nonnull)zipPath maxFileSliceLength:(NSInteger)maxFileSliceLength withByteAlign:(BOOL)withByteAlign;
/// 推送表盘文件
/// \param devIdentifier 目标设备的identifier字符串。通过CBPeripheral.identifier.uuidString获取
///
/// \param type 文件类型。0-表盘，1-多语言，2-背景图，3-自定义，4-音乐。其它类型查阅文档。
///
/// \param files 所推送的文件序列。
///
/// \param maxFileSliceLength 文件切片长度，默认1024字节。数值越大速度越快，但可能造成设备无法响应。该值应视具体设备而定。
///
/// \param withByteAlign 是否对文件进行CRC和字节对齐处理，需要依据具体的设备支持情况来决定该参数的取值。默认false。PS：当type为3时，总是会进行CRC和对齐操作，与该参数取值无关。
///
- (void)pushDialPlateWithDevIdentifier:(NSString * _Nonnull)devIdentifier type:(uint16_t)type files:(NSArray<SFFile *> * _Nonnull)files maxFileSliceLength:(NSInteger)maxFileSliceLength withByteAlign:(BOOL)withByteAlign;
/// 终止任务。
- (void)stop;
@end

@class SFError;

SWIFT_PROTOCOL("_TtP14SFDialPlateSDK26SFDialPlateManagerDelegate_")
@protocol SFDialPlateManagerDelegate
/// 蓝牙状态发生改变时产生的回调。
- (void)dialPlateManagerWithManager:(SFDialPlateManager * _Nonnull)manager didUpdateBLEState:(CBManagerState)bleState;
/// 推送进度回调。progess取值0~100
- (void)dialPlateManagerWithManager:(SFDialPlateManager * _Nonnull)manager progress:(NSInteger)progress;
/// 推送结束回调。error为空表示推送成功，不为空表示推送失败
- (void)dialPlateManagerWithManager:(SFDialPlateManager * _Nonnull)manager complete:(SFError * _Nullable)error;
@end

enum SFErrorType : NSInteger;

SWIFT_CLASS("_TtC14SFDialPlateSDK7SFError")
@interface SFError : NSObject
/// 错误类型
@property (nonatomic) enum SFErrorType errType;
/// 错误信息
@property (nonatomic, copy) NSString * _Nonnull errInfo;
/// 当errType为ErrorCode(7)时，可从该属性获取到设备返回的错误码值，Int类型
@property (nonatomic, strong) NSNumber * _Nullable devErrorCode;
/// 错误码
@property (nonatomic, readonly, copy) NSString * _Nonnull description;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

typedef SWIFT_ENUM(NSInteger, SFErrorType, open) {
  SFErrorTypeUnknown = 0,
  SFErrorTypeTimeout = 1,
  SFErrorTypeNoConnection = 2,
  SFErrorTypeCanceled = 3,
  SFErrorTypeDisconnected = 4,
  SFErrorTypeFailedToConnect = 5,
  SFErrorTypeInvalidDataStruct = 6,
  SFErrorTypeErrorCode = 7,
  SFErrorTypeEncodeError = 8,
  SFErrorTypeInvalidValue = 9,
  SFErrorTypeOutOfRange = 10,
  SFErrorTypeUnzipFailed = 11,
  SFErrorTypeInvalidFile = 12,
  SFErrorTypeLoadFileFailed = 13,
  SFErrorTypeDeviceAbort = 14,
  SFErrorTypeFileSliceTooLarge = 15,
  SFErrorTypeInsufficientDeviceSpace = 16,
};


SWIFT_CLASS("_TtC14SFDialPlateSDK6SFFile")
@interface SFFile : NSObject
/// 文件名。包含文件后缀。
@property (nonatomic, readonly, copy) NSString * _Nonnull fileName;
/// 文件内容。
@property (nonatomic, readonly, copy) NSData * _Nonnull file;
/// 构造函数
/// \param fileName 文件名。包含文件后缀
///
/// \param file 文件内容。
///
- (nonnull instancetype)initWithFileName:(NSString * _Nonnull)fileName file:(NSData * _Nonnull)file OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14SFDialPlateSDK12SFLogManager")
@interface SFLogManager : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) SFLogManager * _Nonnull share;)
+ (SFLogManager * _Nonnull)share SWIFT_WARN_UNUSED_RESULT;
/// SDK内部日志开关。当关闭时，控制台不再打印内容，但QBleLogManagerDelegate的回调不受影响。
@property (nonatomic) BOOL openLog;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC14SFDialPlateSDK19SFResponseBaseModel")
@interface SFResponseBaseModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
#endif

#endif
