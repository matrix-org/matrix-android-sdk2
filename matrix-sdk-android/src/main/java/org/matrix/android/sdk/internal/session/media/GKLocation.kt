package org.matrix.android.sdk.internal.session.media

import android.os.Parcelable
import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass
import kotlinx.parcelize.Parcelize

@Parcelize
@JsonClass(generateAdapter = true)
data class GKLocation(val type: String,
                      @Json(name = "geometry") val geometry: Geometry,
                      @Json(name = "properties") val properties: Properties) : Parcelable

@Parcelize
@JsonClass(generateAdapter = true)
data class Geometry(val type: String, val coordinates: ArrayList<Double>) : Parcelable

@Parcelize
@JsonClass(generateAdapter = true)
data class Properties(val visible: Boolean, val name: String) : Parcelable
