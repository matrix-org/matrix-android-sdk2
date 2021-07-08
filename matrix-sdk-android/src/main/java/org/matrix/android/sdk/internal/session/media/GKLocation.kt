package org.matrix.android.sdk.internal.session.media

import android.os.Parcelable
import kotlinx.parcelize.Parcelize

@Parcelize
data class GKLocation(val type: String, val geometry: Geometry, val properties: Properties) : Parcelable

@Parcelize
data class Geometry(val type: String, val coordinates: ArrayList<Double>) : Parcelable

@Parcelize
data class Properties(val visible: Boolean, val name: String) : Parcelable
