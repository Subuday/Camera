package com.muzzly.camera

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.onUpload
import io.ktor.client.request.forms.MultiPartFormDataContent
import io.ktor.client.request.forms.formData
import io.ktor.client.request.get
import io.ktor.client.request.parameter
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import io.ktor.http.Headers
import io.ktor.http.HttpHeaders
import io.ktor.http.parameters

class NetworkClient private constructor() {
    private val client = createHttpClient()

    @Throws(Exception::class)
    suspend fun photos(modelId: String): Images {
        return client.get("model/content") {
            parameter("model_id", modelId)
        }.body()
//        var images = mutableListOf<String>()
////        for (i in 1..9) {
////            images += "demo_man_$i"
////        }
//        for (i in 1..9) {
//            images += "woman_demo_$i"
//        }
//        return Images(images)
    }

    @Throws(Exception::class)
    suspend fun uploadPhotos(photos: List<ByteArray>, onUpload: (Int) -> Unit) {
        for (index in photos.indices) {
            onUpload(100 * index / photos.size)
        }
//        client.post("train/upload-photos") {
//            setBody(
//                MultiPartFormDataContent(
//                    parts = formData {
//                        for (index in photos.indices) {
//                            append(
//                                key = "image_${index}",
//                                value = photos[index],
//                                headers = Headers.build {
//                                    append(HttpHeaders.ContentType, "image/png")
//                                    append(HttpHeaders.ContentDisposition, "filename=\"image_${index}.png\"")
//                                }
//                            )
//                        }
//                    }
//                )
//            )
//            onUpload { bytesSentTotal, contentLength ->
//                onUpload((photos.count() * bytesSentTotal / contentLength).toInt())
//            }
//        }
    }

    @Throws(Exception::class)
    suspend fun train(id: String, gender: Boolean) {
//        client.post("train") {
//            url {
//                parameters {
//                    append("uid", id)
//                    if (gender) {
//                        append("sex", "male")
//                    } else {
//                        append("sex", "female")
//                    }
//                }
//            }
//        }
    }

    @Throws(Exception::class)
    suspend fun generatePhotos(id: String, styleName: String, count: Int): GenerateResponse {
        return client.post("generate") {
            url {
                parameter("model_id", id)
                parameter("template_name", styleName)
                parameter("amount", count)
            }
        }.body()
    }

    private var modelStatusCounter = 5

    @Throws(Exception::class)
    suspend fun modelStatus(id: String): ModelStatus {
        if (modelStatusCounter == 0) {
            return ModelStatus(ModelStatus.Status.TRAINED, "100", "")
        }
        modelStatusCounter--
        return ModelStatus(ModelStatus.Status.TRAINING, "${(5 - modelStatusCounter) * 20}", "")
//        return client.get("model") {
//            parameter("uid", id)
//        }.body()
    }

    @Throws(Exception::class)
    suspend fun generationStatus(id: String, generationId: String): ModelStatus {
        return client.get("generation") {
            parameter("model_id", id)
            parameter("generation_id", generationId)
        }.body()
    }

    companion object {
        val shared = NetworkClient()
    }
}

expect fun createHttpClient(): HttpClient