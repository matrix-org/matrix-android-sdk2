package org.matrix.android.sdk.api.auth.registration

import org.matrix.android.sdk.api.failure.Failure

sealed class RegistrationAvailability {
    data class Available(val available: Boolean): RegistrationAvailability()
    data class NotAvailable(val failure: Failure.ServerError): RegistrationAvailability()
}