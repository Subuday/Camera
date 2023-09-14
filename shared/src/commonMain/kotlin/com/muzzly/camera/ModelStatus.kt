package com.muzzly.camera

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class ModelStatus(
    @SerialName("code")
    val status: Status,
    val progress: String? = null,
    val eta: String? = null
) {

    enum class Status {
        @SerialName("READY")
        TRAINED,

        @SerialName("IN_PROGRESS")
        TRAINING,

        @SerialName("NOT_TRAINED")
        NOT_TRAINED
    }
}