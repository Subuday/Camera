package com.muzzly.camera

interface Platform {
    val name: String
}

expect fun getPlatform(): Platform