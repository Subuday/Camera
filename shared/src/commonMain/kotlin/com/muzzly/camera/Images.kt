package com.muzzly.camera

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Images(
    @SerialName("images")
    val images: List<String>
)