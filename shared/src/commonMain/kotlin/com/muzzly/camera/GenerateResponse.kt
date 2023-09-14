package com.muzzly.camera

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class GenerateResponse(
    @SerialName("generation_id")
    val generationId: String
)