package com.dsr_corporation.pigeon_example

import PlatformInfo
import PlatformInfoApi
import VersionFlutterApi

// Android implementation for platform interface
class DefaultPlatformInfoApi(
    // Flutter interface
    private val api: VersionFlutterApi
) : PlatformInfoApi {

    // Get platform information
    override fun getPlatformInfo(callback: (Result<PlatformInfo>) -> Unit) {
        // Call flutter api to get app version
        api.getAppVersion { version ->
            version.onSuccess {
                callback(
                    Result.success(
                        PlatformInfo(
                            name = "Android",
                            version = android.os.Build.VERSION.RELEASE,
                            appVersion = it,
                        )
                    )
                )
            }.onFailure {
                callback(Result.failure(it))
            }
        }
    }
}