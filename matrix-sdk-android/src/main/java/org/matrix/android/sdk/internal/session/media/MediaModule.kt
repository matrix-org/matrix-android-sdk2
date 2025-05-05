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

package org.matrix.android.sdk.internal.session.media

import dagger.Binds
import dagger.Module
import dagger.Provides
import org.matrix.android.sdk.api.session.media.MediaService
import org.matrix.android.sdk.internal.session.SessionScope
import retrofit2.Retrofit

@Module
internal abstract class MediaModule {

    @Module
    companion object {
        @Provides
        @JvmStatic
        @SessionScope
        fun providesUnauthenticatedMediaAPI(retrofit: Retrofit): UnauthenticatedMediaAPI {
            return retrofit.create(UnauthenticatedMediaAPI::class.java)
        }

        @Provides
        @JvmStatic
        @SessionScope
        fun providesAuthenticatedMediaAPI(retrofit: Retrofit): AuthenticatedMediaAPI {
            return retrofit.create(AuthenticatedMediaAPI::class.java)
        }
    }

    @Binds
    abstract fun bindIsAuthenticatedMediaSupported(isAuthenticatedMediaSupported: DefaultIsAuthenticatedMediaSupported): IsAuthenticatedMediaSupported

    @Binds
    abstract fun bindMediaService(service: DefaultMediaService): MediaService

    @Binds
    abstract fun bindGetRawPreviewUrlTask(task: DefaultGetRawPreviewUrlTask): GetRawPreviewUrlTask

    @Binds
    abstract fun bindGetPreviewUrlTask(task: DefaultGetPreviewUrlTask): GetPreviewUrlTask

    @Binds
    abstract fun bindClearMediaCacheTask(task: DefaultClearPreviewUrlCacheTask): ClearPreviewUrlCacheTask
}
