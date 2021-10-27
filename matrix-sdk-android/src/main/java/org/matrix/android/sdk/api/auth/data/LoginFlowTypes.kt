/*
 * Copyright 2020 The Matrix.org Foundation C.I.C.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.matrix.android.sdk.api.auth.data

object LoginFlowTypes {
    const val PASSWORD = "m.login.password"
    const val OAUTH2 = "m.login.oauth2"
    const val EMAIL_CODE = "m.login.email.code"
    const val EMAIL_URL = "m.login.email.url"
    const val EMAIL_IDENTITY = "m.login.email.identity"
    const val MSISDN = "m.login.msisdn"
    const val RECAPTCHA = "m.login.recaptcha"
    const val DUMMY = "m.login.dummy"
    const val TERMS = "m.login.terms"
    const val TOKEN = "m.login.token"
    const val SSO = "m.login.sso"

    const val JWT = "org.matrix.login.jwt"
}
