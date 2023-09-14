package com.muzzly.camera

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking
import platform.Foundation.NSUserDefaults

class IOSStorage : Storage {

    override fun readId(): String {
        val id = NSUserDefaults.standardUserDefaults.stringForKey("id")
        if (id == null) {
            NSUserDefaults.standardUserDefaults.setObject("max", "id")
        }
        return NSUserDefaults.standardUserDefaults.stringForKey("id")!!
    }

    override fun writeGenerationId(id: String?) {
        NSUserDefaults.standardUserDefaults.setObject(id, "generationId")
    }

    override fun readGenerationId(): String? {
        return NSUserDefaults.standardUserDefaults.stringForKey("generationId")
    }

    override fun writeGender(isMale: Boolean) {
        NSUserDefaults.standardUserDefaults.setBool(isMale, "gender")
    }

    override fun readGender(): Boolean {
        return NSUserDefaults.standardUserDefaults.boolForKey("gender")
    }

    override fun writeModelStatus(status: ModelStatus.Status) {
        NSUserDefaults.standardUserDefaults.setObject(status.name, "modelStatus")
        runBlocking(Dispatchers.Main.immediate) {
            onModelStatusChangeListener?.invoke(status)
        }
    }

    override fun readModelStatus(): ModelStatus.Status {
        return NSUserDefaults.standardUserDefaults
            .stringForKey("modelStatus")
            ?.run { ModelStatus.Status.valueOf(this) } ?: ModelStatus.Status.NOT_TRAINED
    }

    override fun setOnModelStatusChangeListener(listener: (ModelStatus.Status) -> Unit) {
        onModelStatusChangeListener = listener
    }

    private companion object {
        var onModelStatusChangeListener: ((ModelStatus.Status) -> Unit)? = null
    }
}