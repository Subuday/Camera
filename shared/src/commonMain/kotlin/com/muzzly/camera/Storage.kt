package com.muzzly.camera

interface Storage {
    fun readId(): String

    fun writeGenerationId(id: String?)
    fun readGenerationId(): String?

    fun writeGender(isMale: Boolean)
    fun readGender(): Boolean

    fun writeModelStatus(status: ModelStatus.Status)
    fun readModelStatus(): ModelStatus.Status
    fun setOnModelStatusChangeListener(listener: (ModelStatus.Status) -> Unit)
}