/** @brief YNCSDKCamera  implementation file */

#import "YNCSDKCamera.h"

#import "YNCSDKInternal.h"

#include <dronecore/dronecore.h>
#include <functional>

using namespace dronecore;
using namespace std::placeholders;

//MARK: C Functions
//MARK: receive camera operate result
void receive_camera_result(YNCCameraCompletion completion, Camera::Result result) {
    if (completion) {
        NSError *error = nullptr;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
        }

        completion(error);
    }
}

//MARK: receive color mode result
void receive_color_mode_result(YNCColorModeCompletion completion, Camera::Result result, Camera::ColorMode colorMode) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraColorMode tmpColorMode = YNCCameraColorMode::YNCCameraColorModeUnknown;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpColorMode, error);
        }
        else {
            switch (colorMode) {
                case Camera::ColorMode::ENHANCED:
                    tmpColorMode = YNCCameraColorModeEnhanced;
                    break;
                case Camera::ColorMode::NEUTRAL:
                    tmpColorMode = YNCCameraColorModeNeutral;
                    break;
                case Camera::ColorMode::NIGHT:
                    tmpColorMode = YNCCameraColorModeNight;
                    break;
                case Camera::ColorMode::UNPROCESSED:
                    tmpColorMode = YNCCameraColorModeUnprocessed;
                    break;
                default:
                    tmpColorMode = YNCCameraColorModeUnknown;
                    break;
            }
            completion(tmpColorMode, error);
        }
    }
}

Camera::ColorMode getColorModeEnum(YNCCameraColorMode colorMode) {
    Camera::ColorMode cameraColorMode;
    switch (colorMode) {
    case YNCCameraColorModeEnhanced:
            cameraColorMode = Camera::ColorMode::ENHANCED;
        break;
    case YNCCameraColorModeNight:
            cameraColorMode = Camera::ColorMode::NIGHT;
        break;
    case YNCCameraColorModeNeutral:
            cameraColorMode = Camera::ColorMode::NEUTRAL;
        break;
    case YNCCameraColorModeUnprocessed:
            cameraColorMode = Camera::ColorMode::UNPROCESSED;
        break;
    default:
        cameraColorMode = Camera::ColorMode::UNKNOWN;
        break;
    }
    return cameraColorMode;
}

//MARK: receive white balance result
void receive_white_balance_result(YNCWhiteBalanceSettingCompletion completion, Camera::Result result, Camera::WhiteBalance whiteBalance) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraWhiteBalance tmpWhiteBalalnce = YNCCameraWhiteBalance::YNCCameraWhiteBalanceUnknown;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpWhiteBalalnce, error);
        }
        else {
            switch (whiteBalance) {
                case Camera::WhiteBalance::AUTO:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceAuto;
                    break;
                case Camera::WhiteBalance::CLOUDY:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceCloudy;
                    break;
                case Camera::WhiteBalance::FLUORESCENT:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceFluorescent;
                    break;
                case Camera::WhiteBalance::INCANDESCENT:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceIncandescent;
                    break;
                case Camera::WhiteBalance::LOCK:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceLock;
                    break;
                case Camera::WhiteBalance::SUNNY:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceSunny;
                    break;
                case Camera::WhiteBalance::SUNSET:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceSunset;
                    break;
                default:
                    tmpWhiteBalalnce = YNCCameraWhiteBalanceUnknown;
                    break;
            }
            completion(tmpWhiteBalalnce, error);
        }
    }
}

Camera::WhiteBalance getWhiteBalanceEnum(YNCCameraWhiteBalance whiteBalance) {
    Camera::WhiteBalance cameraWhiteBalance;
    switch (whiteBalance) {
        case YNCCameraWhiteBalanceAuto:
            cameraWhiteBalance = Camera::WhiteBalance::AUTO;
            break;
        case YNCCameraWhiteBalanceSunset:
            cameraWhiteBalance = Camera::WhiteBalance::SUNSET;
            break;
        case YNCCameraWhiteBalanceSunny:
            cameraWhiteBalance = Camera::WhiteBalance::SUNNY;
            break;
        case YNCCameraWhiteBalanceIncandescent:
            cameraWhiteBalance = Camera::WhiteBalance::INCANDESCENT;
            break;
        case YNCCameraWhiteBalanceFluorescent:
            cameraWhiteBalance = Camera::WhiteBalance::FLUORESCENT;
            break;
        case YNCCameraWhiteBalanceCloudy:
            cameraWhiteBalance = Camera::WhiteBalance::CLOUDY;
            break;
        case YNCCameraWhiteBalanceLock:
            cameraWhiteBalance = Camera::WhiteBalance::LOCK;
            break;
        default:
            cameraWhiteBalance = Camera::WhiteBalance::UNKNOWN;
            break;
    }
    return cameraWhiteBalance;
}

//MARK: receive exposure mode result
void receive_exposure_mode_result(YNCExposureModeCompletion completion, Camera::Result result, Camera::ExposureMode exposureMode) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraExposureMode tmpExposureMode = YNCCameraExposureMode::YNCCameraExposureModeUnknown;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpExposureMode, error);
        }
        else {
            switch (exposureMode) {
                case Camera::ExposureMode::AUTO:
                    tmpExposureMode = YNCCameraExposureModeAuto;
                    break;
                case Camera::ExposureMode::MANUAL:
                    tmpExposureMode = YNCCameraExposureModeManual;
                    break;
                default:
                    tmpExposureMode = YNCCameraExposureModeUnknown;
                    break;
            }
            completion(tmpExposureMode, error);
        }
    }
}

Camera::ExposureMode getExposureModeEnum(YNCCameraExposureMode exposureMode) {
    Camera::ExposureMode cameraExposureMode;
    switch (exposureMode) {
        case YNCCameraExposureModeAuto:
            cameraExposureMode = Camera::ExposureMode::AUTO;
            break;
        case YNCCameraExposureModeManual:
            cameraExposureMode = Camera::ExposureMode::MANUAL;
            break;
        default:
            cameraExposureMode = Camera::ExposureMode::UNKNOWN;
            break;
    }
    return cameraExposureMode;
}

//MARK: receive camera resolution result
void receive_resolution_result(YNCCameraResolutionCompletion completion, Camera::Result result, Camera::Resolution resolution) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraResolution *tmpResolution = [YNCCameraResolution new];
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpResolution, error);
        }
        else {
            tmpResolution.widthPixels = resolution.width_pixels;
            tmpResolution.heightPixels = resolution.height_pixels;
            completion(tmpResolution, error);
        }
    }
}

//MARK: receive photo format result
void receive_photo_format_result(YNCPhotoFormatCompletion completion, Camera::Result result, Camera::PhotoFormat photoFormat) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraPhotoFormat tmpPhotoFormat = YNCCameraPhotoFormat::YNCCameraPhotoFormatUnknown;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpPhotoFormat, error);
        }
        else {
            switch (photoFormat) {
                case Camera::PhotoFormat::JPG:
                    tmpPhotoFormat = YNCCameraPhotoFormatJPG;
                    break;
                case Camera::PhotoFormat::JPG_AND_DNG:
                    tmpPhotoFormat = YNCCameraPhotoFormatJPG_AND_DNG;
                    break;
                default:
                    tmpPhotoFormat = YNCCameraPhotoFormatUnknown;
                    break;
            }
            completion(tmpPhotoFormat, error);
        }
    }
}

Camera::PhotoFormat getPhotoFormatEnum(YNCCameraPhotoFormat photoFormat) {
    Camera::PhotoFormat cameraPhotoFormat;
    switch (photoFormat) {
        case YNCCameraPhotoFormatJPG:
            cameraPhotoFormat = Camera::PhotoFormat::JPG;
            break;
        case YNCCameraPhotoFormatJPG_AND_DNG:
            cameraPhotoFormat = Camera::PhotoFormat::JPG_AND_DNG;
            break;
        default:
            cameraPhotoFormat = Camera::PhotoFormat::UNKNOWN;
            break;
    }
    return cameraPhotoFormat;
}

//MARK: receive video format result
void receive_video_format_result(YNCVideoFormatCompletion completion, Camera::Result result, Camera::VideoFormat videoFormat) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraVideoFormat tmpVideoFormat = YNCCameraVideoFormat::YNCCameraVideoFormatUnknown;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpVideoFormat, error);
        }
        else {
            switch (videoFormat) {
                case Camera::VideoFormat::H264:
                    tmpVideoFormat = YNCCameraVideoFormatH264;
                    break;
                case Camera::VideoFormat::H265:
                    tmpVideoFormat = YNCCameraVideoFormatH265;
                    break;
                default:
                    tmpVideoFormat = YNCCameraVideoFormatUnknown;
                    break;
            }
            completion(tmpVideoFormat, error);
        }
    }
}

Camera::VideoFormat getVideoFormatEnum(YNCCameraVideoFormat videoFormat) {
    Camera::VideoFormat cameraVideoFormat;
    switch (videoFormat) {
        case YNCCameraVideoFormatH264:
            cameraVideoFormat = Camera::VideoFormat::H264;
            break;
        case YNCCameraVideoFormatH265:
            cameraVideoFormat = Camera::VideoFormat::H265;
            break;
        default:
            cameraVideoFormat = Camera::VideoFormat::UNKNOWN;
            break;
    }
    return cameraVideoFormat;
}

//MARK: receive photo quality result
void receive_photo_quality_result(YNCPhotoQualityCompletion completion, Camera::Result result, Camera::PhotoQuality photoQuality) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraPhotoQuality tmpPhotoQuality = YNCCameraPhotoQuality::YNCCameraPhotoQualityUnknown;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpPhotoQuality, error);
        }
        else {
            switch (photoQuality) {
                case Camera::PhotoQuality::LOW:
                    tmpPhotoQuality = YNCCameraPhotoQualityLow;
                    break;
                case Camera::PhotoQuality::MEDIUM:
                    tmpPhotoQuality = YNCCameraPhotoQualityMedium;
                    break;
                case Camera::PhotoQuality::HIGH:
                    tmpPhotoQuality = YNCCameraPhotoQualityHigh;
                    break;
                case Camera::PhotoQuality::ULTRA:
                    tmpPhotoQuality = YNCCameraPhotoQualityUltra;
                    break;
                default:
                    tmpPhotoQuality = YNCCameraPhotoQualityUnknown;
                    break;
            }
            completion(tmpPhotoQuality, error);
        }
    }
}

Camera::PhotoQuality getPhotoQualityEnum(YNCCameraPhotoQuality photoQuality) {
    Camera::PhotoQuality cameraPhotoQuality;
    switch (photoQuality) {
        case YNCCameraPhotoQualityLow:
            cameraPhotoQuality = Camera::PhotoQuality::LOW;
            break;
        case YNCCameraPhotoQualityMedium:
            cameraPhotoQuality = Camera::PhotoQuality::MEDIUM;
            break;
        case YNCCameraPhotoQualityHigh:
            cameraPhotoQuality = Camera::PhotoQuality::HIGH;
            break;
        case YNCCameraPhotoQualityUltra:
            cameraPhotoQuality = Camera::PhotoQuality::ULTRA;
            break;
        default:
            cameraPhotoQuality = Camera::PhotoQuality::UNKNOWN;
            break;
    }
    return cameraPhotoQuality;
}

//MARK: receive video resolution result
void receive_video_resolution_result(YNCVideoResolutionCompletion completion, Camera::Result result, Camera::VideoResolution videoResolution) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraVideoResolution tmpVideoResolution = YNCCameraVideoResolution::YNCCameraVideoResUnknown;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpVideoResolution, error);
        }
        else {
            switch (videoResolution) {
                case Camera::VideoResolution::FHD_1920_X_1080_120FPS:
                    tmpVideoResolution = YNCCameraVideoResFHD_1920_X_1080_120FPS;
                    break;
                case Camera::VideoResolution::FHD_1920_X_1080_24FPS:
                    tmpVideoResolution = YNCCameraVideoResFHD_1920_X_1080_24FPS;
                    break;
                case Camera::VideoResolution::FHD_1920_X_1080_25FPS:
                    tmpVideoResolution = YNCCameraVideoResFHD_1920_X_1080_25FPS;
                    break;
                case Camera::VideoResolution::FHD_1920_X_1080_30FPS:
                    tmpVideoResolution = YNCCameraVideoResFHD_1920_X_1080_30FPS;
                    break;
                case Camera::VideoResolution::FHD_1920_X_1080_48FPS:
                    tmpVideoResolution = YNCCameraVideoResFHD_1920_X_1080_48FPS;
                    break;
                case Camera::VideoResolution::FHD_1920_X_1080_50FPS:
                    tmpVideoResolution = YNCCameraVideoResFHD_1920_X_1080_50FPS;
                    break;
                case Camera::VideoResolution::FHD_1920_X_1080_60FPS:
                    tmpVideoResolution = YNCCameraVideoResFHD_1920_X_1080_60FPS;
                    break;
                case Camera::VideoResolution::HD_1280_X_720_120FPS:
                    tmpVideoResolution = YNCCameraVideoResHD_1280_X_720_120FPS;
                    break;
                case Camera::VideoResolution::HD_1280_X_720_24FPS:
                    tmpVideoResolution = YNCCameraVideoResHD_1280_X_720_24FPS;
                    break;
                case Camera::VideoResolution::HD_1280_X_720_30FPS:
                    tmpVideoResolution = YNCCameraVideoResHD_1280_X_720_30FPS;
                    break;
                case Camera::VideoResolution::HD_1280_X_720_48FPS:
                    tmpVideoResolution = YNCCameraVideoResHD_1280_X_720_48FPS;
                    break;
                case Camera::VideoResolution::HD_1280_X_720_60FPS:
                    tmpVideoResolution = YNCCameraVideoResHD_1280_X_720_60FPS;
                    break;
                case Camera::VideoResolution::UHD_2720_X_1530_24FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_2720_X_1530_24FPS;
                    break;
                case Camera::VideoResolution::UHD_2720_X_1530_30FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_2720_X_1530_30FPS;
                    break;
                case Camera::VideoResolution::UHD_2720_X_1530_48FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_2720_X_1530_48FPS;
                    break;
                case Camera::VideoResolution::UHD_2720_X_1530_60FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_2720_X_1530_60FPS;
                    break;
                case Camera::VideoResolution::UHD_3840_X_2160_24FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_3840_X_2160_24FPS;
                    break;
                case Camera::VideoResolution::UHD_3840_X_2160_25FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_3840_X_2160_25FPS;
                    break;
                case Camera::VideoResolution::UHD_3840_X_2160_30FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_3840_X_2160_30FPS;
                    break;
                case Camera::VideoResolution::UHD_3840_X_2160_48FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_3840_X_2160_48FPS;
                    break;
                case Camera::VideoResolution::UHD_3840_X_2160_50FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_3840_X_2160_50FPS;
                    break;
                case Camera::VideoResolution::UHD_3840_X_2160_60FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_3840_X_2160_60FPS;
                    break;
                case Camera::VideoResolution::UHD_4096_X_2160_24FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_4096_X_2160_24FPS;
                    break;
                case Camera::VideoResolution::UHD_4096_X_2160_25FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_4096_X_2160_25FPS;
                    break;
                case Camera::VideoResolution::UHD_4096_X_2160_30FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_4096_X_2160_30FPS;
                    break;
                case Camera::VideoResolution::UHD_4096_X_2160_48FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_4096_X_2160_48FPS;
                    break;
                case Camera::VideoResolution::UHD_4096_X_2160_50FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_4096_X_2160_50FPS;
                    break;
                case Camera::VideoResolution::UHD_4096_X_2160_60FPS:
                    tmpVideoResolution = YNCCameraVideoResUHD_4096_X_2160_60FPS;
                    break;
                default:
                    tmpVideoResolution = YNCCameraVideoResUnknown;
                    break;
            }
            completion(tmpVideoResolution, error);
        }
    }
}



Camera::VideoResolution getVideoResolutionEnum(YNCCameraVideoResolution videoResolution) {
    Camera::VideoResolution cameraVideoResolution;
    switch (videoResolution) {
        case YNCCameraVideoResUHD_2720_X_1530_24FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_2720_X_1530_24FPS;
            break;
        case YNCCameraVideoResUHD_2720_X_1530_30FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_2720_X_1530_30FPS;
            break;
        case YNCCameraVideoResUHD_2720_X_1530_48FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_2720_X_1530_48FPS;
            break;
        case YNCCameraVideoResUHD_2720_X_1530_60FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_2720_X_1530_60FPS;
            break;
        case YNCCameraVideoResUHD_3840_X_2160_24FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_3840_X_2160_24FPS;
            break;
        case YNCCameraVideoResUHD_3840_X_2160_25FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_3840_X_2160_25FPS;
            break;
        case YNCCameraVideoResUHD_3840_X_2160_30FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_3840_X_2160_30FPS;
            break;
        case YNCCameraVideoResUHD_3840_X_2160_48FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_3840_X_2160_48FPS;
            break;
        case YNCCameraVideoResUHD_3840_X_2160_50FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_3840_X_2160_50FPS;
            break;
        case YNCCameraVideoResUHD_3840_X_2160_60FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_3840_X_2160_60FPS;
            break;
        case YNCCameraVideoResUHD_4096_X_2160_24FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_4096_X_2160_24FPS;
            break;
        case YNCCameraVideoResUHD_4096_X_2160_25FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_4096_X_2160_25FPS;
            break;
        case YNCCameraVideoResUHD_4096_X_2160_30FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_4096_X_2160_30FPS;
            break;
        case YNCCameraVideoResUHD_4096_X_2160_48FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_4096_X_2160_48FPS;
            break;
        case YNCCameraVideoResUHD_4096_X_2160_50FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_4096_X_2160_50FPS;
            break;
        case YNCCameraVideoResUHD_4096_X_2160_60FPS:
            cameraVideoResolution = Camera::VideoResolution::UHD_4096_X_2160_60FPS;
            break;
        case YNCCameraVideoResHD_1280_X_720_24FPS:
            cameraVideoResolution = Camera::VideoResolution::HD_1280_X_720_24FPS;
            break;
        case YNCCameraVideoResHD_1280_X_720_30FPS:
            cameraVideoResolution = Camera::VideoResolution::HD_1280_X_720_30FPS;
            break;
        case YNCCameraVideoResHD_1280_X_720_48FPS:
            cameraVideoResolution = Camera::VideoResolution::HD_1280_X_720_48FPS;
            break;
        case YNCCameraVideoResHD_1280_X_720_60FPS:
            cameraVideoResolution = Camera::VideoResolution::HD_1280_X_720_60FPS;
            break;
        case YNCCameraVideoResHD_1280_X_720_120FPS:
            cameraVideoResolution = Camera::VideoResolution::HD_1280_X_720_120FPS;
            break;
        case YNCCameraVideoResFHD_1920_X_1080_24FPS:
            cameraVideoResolution = Camera::VideoResolution::FHD_1920_X_1080_24FPS;
            break;
        case YNCCameraVideoResFHD_1920_X_1080_25FPS:
            cameraVideoResolution = Camera::VideoResolution::FHD_1920_X_1080_25FPS;
            break;
        case YNCCameraVideoResFHD_1920_X_1080_30FPS:
            cameraVideoResolution = Camera::VideoResolution::FHD_1920_X_1080_30FPS;
            break;
        case YNCCameraVideoResFHD_1920_X_1080_48FPS:
            cameraVideoResolution = Camera::VideoResolution::FHD_1920_X_1080_48FPS;
            break;
        case YNCCameraVideoResFHD_1920_X_1080_50FPS:
            cameraVideoResolution = Camera::VideoResolution::FHD_1920_X_1080_50FPS;
            break;
        case YNCCameraVideoResFHD_1920_X_1080_60FPS:
            cameraVideoResolution = Camera::VideoResolution::FHD_1920_X_1080_60FPS;
            break;
        case YNCCameraVideoResFHD_1920_X_1080_120FPS:
            cameraVideoResolution = Camera::VideoResolution::FHD_1920_X_1080_120FPS;
            break;
        default:
            cameraVideoResolution = Camera::VideoResolution::UNKNOWN;
            break;
    }
    return cameraVideoResolution;
}

//MARK: receive shutter speed result
void receive_shutter_speed_result(YNCShutterSpeedCompletion completion, Camera::Result result, Camera::ShutterSpeedS shutterSpeed) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraShutterSpeed *tmpShutterSpeed = [YNCCameraShutterSpeed new];
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpShutterSpeed, error);
        }
        else {
            tmpShutterSpeed.numerator = shutterSpeed.numerator;
            tmpShutterSpeed.denominator = shutterSpeed.denominator;
            completion(tmpShutterSpeed, error);
        }
    }
}

//MARK: receive ISO value result
void receive_iso_value_result(YNCISOValueCompletion completion, Camera::Result result, int isoValue) {
    if (completion) {
        NSError *error = nullptr;
        int tmpISOValue = 0;
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpISOValue, error);
        }
        else {
            tmpISOValue = isoValue;
            completion(tmpISOValue, error);
        }
    }
}

//MARK: receive metering result
void receive_metering_result(YNCMeteringCompletion completion, Camera::Result result, Camera::Metering metering) {
    if (completion) {
        NSError *error = nullptr;
        YNCCameraMetering *tmpMetering = [YNCCameraMetering new];
        if (result != Camera::Result::SUCCESS) {
            NSString *message = [NSString stringWithFormat:@"%s", Camera::result_str(result)];
            error = [[NSError alloc] initWithDomain:@"Camera"
                                               code:(int)result
                                           userInfo:@{@"message": message}];
            completion(tmpMetering, error);
        }
        else {
            switch (metering.mode) {
                case Camera::Metering::Mode::AVERAGE:
                    tmpMetering.mode = YNCCameraMeteringAverage;
                    break;
                case Camera::Metering::Mode::CENTER:
                    tmpMetering.mode = YNCCameraMeteringCenter;
                    break;
                case Camera::Metering::Mode::SPOT:
                    tmpMetering.mode = YNCCameraMeteringSpot;
                    break;
                default:
                    tmpMetering.mode = YNCCameraMeteringUnknown;
                    break;
            }
            tmpMetering.spotScreenWidthPercent = metering.spot_screen_width_percent;
            tmpMetering.spotScreenHeightPercent = metering.spot_screen_height_percent;
            completion(tmpMetering, error);
        }
    }
}

Camera::Metering::Mode getMeteringModeEnum(YNCCameraMeteringMode meteringMode) {
    Camera::Metering::Mode cameraMeteringMode;
    switch (meteringMode) {
        case YNCCameraMeteringCenter:
            cameraMeteringMode = Camera::Metering::Mode::CENTER;
            break;
        case YNCCameraMeteringAverage:
            cameraMeteringMode = Camera::Metering::Mode::AVERAGE;
            break;
        case YNCCameraMeteringSpot:
            cameraMeteringMode = Camera::Metering::Mode::SPOT;
            break;
        default:
            cameraMeteringMode = Camera::Metering::Mode::UNKNOWN;
            break;
    }
    return cameraMeteringMode;
}

@implementation YNCCameraResolution

@end

@implementation YNCCameraShutterSpeed

@end

@implementation YNCCameraMetering

@end

@implementation YNCSDKCameraSettings

//MARK: get Camera Mode
+ (void)getColorModeWithCompletion:(YNCColorModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_color_mode_async(std::bind(&receive_color_mode_result, completion, _1, _2));
}

//MARK: set Color Mode
+ (void)setColorMode:(YNCCameraColorMode)colorMode WithCompletion:(YNCColorModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::ColorMode cameraColorMode = getColorModeEnum(colorMode);
    dc->device().camera().set_color_mode_async(cameraColorMode, std::bind(&receive_color_mode_result, completion, _1, _2));
}

//MARK: get White Balance Setting
+ (void)getWhiteBalanceWithCompletion:(YNCWhiteBalanceSettingCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_white_balance_async(std::bind(&receive_white_balance_result, completion, _1, _2));
}

//MARK: set White Balance

+ (void)setWhiteBalance:(YNCCameraWhiteBalance)whiteBalance WithCompletion:(YNCWhiteBalanceSettingCompletion)completion{
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::WhiteBalance cameraWhiteBalance = getWhiteBalanceEnum(whiteBalance);
    dc->device().camera().set_white_balance_async(cameraWhiteBalance, std::bind(&receive_white_balance_result, completion, _1, _2));
}

//MARK: get Exposure Mode
+ (void)getExposureModeWithCompletion:(YNCExposureModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_exposure_mode_async(std::bind(&receive_exposure_mode_result, completion, _1, _2));
}

//MARK: set Exposure Mode
+ (void)setExposureMode:(YNCCameraExposureMode)exposureMode WithCompletion:(YNCExposureModeCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::ExposureMode cameraExposureMode = getExposureModeEnum(exposureMode);
    dc->device().camera().set_exposure_mode_async(cameraExposureMode, std::bind(&receive_exposure_mode_result, completion, _1, _2));
}

//MARK: get Resolution
+ (void)getResolutionWithCompletion:(YNCCameraResolutionCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_resolution_async(std::bind(&receive_resolution_result,completion, _1, _2));
}

//MARK: get Photo Format
+ (void)getPhotoFormatWithCompletion:(YNCPhotoFormatCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_photo_format_async(std::bind(&receive_photo_format_result,completion, _1, _2));
}

//MARK: set Photo Format
+ (void)setPhotoFormat:(YNCCameraPhotoFormat)photoFormat WithCompletion:(YNCPhotoFormatCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::PhotoFormat cameraPhotoFormat = getPhotoFormatEnum(photoFormat);
    dc->device().camera().set_photo_format_async(cameraPhotoFormat, std::bind(&receive_photo_format_result, completion, _1, _2));
}

//MARK: get Video Format
+ (void)getVideoFormatWithCompletion:(YNCVideoFormatCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_video_format_async(std::bind(&receive_video_format_result,completion, _1, _2));
}

//MARK: set Video Format
+ (void)setVideoFormat:(YNCCameraVideoFormat)videoFormat WithCompletion:(YNCVideoFormatCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::VideoFormat cameraVideoFormat = getVideoFormatEnum(videoFormat);
    dc->device().camera().set_video_format_async(cameraVideoFormat, std::bind(&receive_video_format_result, completion, _1, _2));
}

//MARK: get Photo Quality
+ (void)getPhotoQualityWithCompletion:(YNCPhotoQualityCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_photo_quality_async(std::bind(&receive_photo_quality_result,completion, _1, _2));
}

//MARK: set Photo Quality
+ (void)setPhotoQuality:(YNCCameraPhotoQuality)photoQuality WithCompletion:(YNCPhotoQualityCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::PhotoQuality cameraPhotoQuality = getPhotoQualityEnum(photoQuality);
    dc->device().camera().set_photo_quality_async(cameraPhotoQuality, std::bind(&receive_photo_quality_result, completion, _1, _2));
}

//MARK: get Video Resolution
+ (void)getVideoResolutionWithCompletion:(YNCVideoResolutionCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_video_resolution_async(std::bind(&receive_video_resolution_result,completion, _1, _2));
}

//MARK: set Video Resolution
+ (void)setVideoResolution:(YNCCameraVideoResolution)videoResolution WithCompletion:(YNCVideoResolutionCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::VideoResolution cameraVideoResolution = getVideoResolutionEnum(videoResolution);
    dc->device().camera().set_video_resolution_async(cameraVideoResolution, std::bind(&receive_video_resolution_result, completion, _1, _2));
}

//MARK: get Shutter Speed
+ (void)getShutterSpeedWithCompletion:(YNCShutterSpeedCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_shutter_speed_async(std::bind(&receive_shutter_speed_result,completion, _1, _2));
}

//MARK: set Shutter Speed
+ (void)setShutterSpeed:(YNCCameraShutterSpeed *)shutterSpeed WithCompletion:(YNCShutterSpeedCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::ShutterSpeedS tmpShutterSpeed;
    tmpShutterSpeed.numerator = shutterSpeed.numerator;
    tmpShutterSpeed.denominator = shutterSpeed.denominator;
    dc->device().camera().set_shutter_speed_async(tmpShutterSpeed, std::bind(&receive_shutter_speed_result, completion, _1, _2));
}

//MARK: get ISO value
+ (void)getISOValueWithCompletion:(YNCISOValueCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_iso_value_async(std::bind(&receive_iso_value_result, completion, _1, _2));
}

//MARK: set ISO value
+ (void)setISOValue:(int)isoValue WithCompletion:(YNCISOValueCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().set_iso_value_async(isoValue, std::bind(&receive_iso_value_result, completion, _1, _2));
}

//MARK: get Metering
+ (void)getMeteringWithCompletion:(YNCMeteringCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().get_metering_async(std::bind(&receive_metering_result,completion, _1, _2));
}

//MARK: set Metering
+ (void)setMetering:(YNCCameraMetering *)metering WithCompletion:(YNCMeteringCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    Camera::Metering tmpMetering;
    tmpMetering.spot_screen_width_percent = metering.spotScreenWidthPercent;
    tmpMetering.spot_screen_height_percent = metering.spotScreenHeightPercent;
    tmpMetering.mode = getMeteringModeEnum(metering.mode);
    dc->device().camera().set_metering_async(tmpMetering, std::bind(&receive_metering_result, completion, _1, _2));
}

@end

@implementation YNCSDKCamera

//MARK: Camera TakePhoto
+ (void)takePhotoWithCompletion:(YNCCameraCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().take_photo_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StartVideo
+ (void)startVideoWithCompletion:(YNCCameraCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().start_video_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StopVideo
+ (void)stopVideoWithCompletion:(YNCCameraCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().stop_video_async(std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StartPhotoInterval
+ (void)startPhotoInterval:(double)intervalS Completion:(YNCCameraCompletion)completion{
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().start_photo_interval_async(intervalS, std::bind(&receive_camera_result, completion, _1));
}

//MARK: Camera StopPhotoInterval
+ (void)stopPhotoIntervalWithCompletion:(YNCCameraCompletion)completion {
    DroneCore *dc = [[YNCSDKInternal instance] dc];
    dc->device().camera().stop_photo_interval_async(std::bind(&receive_camera_result, completion, _1));
}

@end
