package com.dsr_corporation.pigeon_example

import PlatformInfo
import PlatformInfoApi
import VersionFlutterApi

class DefaultPlatformInfoApi(private val api: VersionFlutterApi) : PlatformInfoApi {
    override fun getPlatformInfo(callback: (Result<PlatformInfo>) -> Unit) {
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