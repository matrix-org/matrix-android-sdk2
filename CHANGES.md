Please also refer to the Changelog of Element Android: https://github.com/vector-im/element-android/blob/main/CHANGES.md

Changes in Matrix-SDK 1.4.27 (2022-07-20)
===================================================

Imported from Element 1.4.27-RC2. (https://github.com/vector-im/element-android/releases/tag/v1.4.27-RC2)

SDK API changes ⚠️
------------------
- Group all location sharing related API into LocationSharingService ([#5864](https://github.com/vector-im/element-android/issues/5864))
- Add support for MSC2457 - opting in or out of logging out all devices when changing password ([#6191](https://github.com/vector-im/element-android/issues/6191))
- Create `QueryStateEventValue` to do query on `stateKey` for State Event. Also remove the default parameter values for those type. ([#6319](https://github.com/vector-im/element-android/issues/6319))

Changes in Matrix-SDK 1.4.25 (2022-06-29)
===================================================

Imported from Element 1.4.25. (https://github.com/vector-im/element-android/releases/tag/v1.4.25)

SDK API changes ⚠️
------------------
- Some methods from `Session` have been moved to a new `SyncService`, that you can retrieve from a `Session`.
- `SyncStatusService` method has been moved to the new `SyncService`
- `InitSyncStep` have been moved and renamed to `InitialSyncStep`
- `SyncStatusService.Status` has been renamed to `SyncRequestState`
- The existing `SyncService` has been renamed to `SyncAndroidService` because of name clash with the new SDK Service ([#6029](https://github.com/vector-im/element-android/issues/6029))
- Allows `AuthenticationService.getLoginFlow` to fail without resetting state from previously successful calls ([#6093](https://github.com/vector-im/element-android/issues/6093))
- Allows new passwords to be passed at the point of confirmation when resetting a password ([#6169](https://github.com/vector-im/element-android/issues/6169))
- Notifies other devices when a verification request sent from an Android device is accepted.` ([#5724](https://github.com/vector-im/element-android/issues/5724))
- Some `val` have been changed to `fun` to increase their visibility in the generated documentation. Just add `()` if you were using them.
- `KeysBackupService.state` has been replaced by `KeysBackupService.getState()`
- `KeysBackupService.isStucked` has been replaced by `KeysBackupService.isStuck()`
- SDK documentation improved ([#5952](https://github.com/vector-im/element-android/issues/5952))
- Improve replay attacks and reduce duplicate message index errors ([#6077](https://github.com/vector-im/element-android/issues/6077))
- Remove `RoomSummaryQueryParams.roomId`. If you need to observe a single room, use the new API `RoomService.getRoomSummaryLive(roomId: String)`
- `ActiveSpaceFilter` has been renamed to `SpaceFilter`
- `RoomCategoryFilter.ALL` has been removed, just pass `null` to not filter on Room category. ([#6143](https://github.com/vector-im/element-android/issues/6143))


Changes in Matrix-SDK 1.4.16 (2022-05-23)
===================================================

Imported from Element 1.4.16. (https://github.com/vector-im/element-android/releases/tag/v1.4.16)

SDK API changes ⚠️
------------------
- New API to enable/disable key forwarding CryptoService#enableKeyGossiping()
- New API to limit room key request only to own devices MXCryptoConfig#limitRoomKeyRequestsToMyDevices
- Event Trail API has changed, now using AuditTrail events
- New API to manually accept an incoming key request CryptoService#manuallyAcceptRoomKeyRequest() ([#5559](https://github.com/vector-im/element-android/issues/5559))
- Small change in the Matrix class: deprecated methods have been removed and the constructor is now public. Also the fun `workerFactory()` has been renamed to `getWorkerFactory()` ([#5887](https://github.com/vector-im/element-android/issues/5887))
- Including SSL/TLS error handing when doing WellKnown lookups without a custom HomeServerConnectionConfig ([#5965](https://github.com/vector-im/element-android/issues/5965))


Changes in Matrix-SDK 1.4.14 (2022-05-10)
===================================================

Imported from Element 1.4.14. (https://github.com/vector-im/element-android/releases/tag/v1.4.14)

Bugfixes 🐛
----------
- Fixes crash when accepting or receiving VOIP calls ([#5421](https://github.com/vector-im/element-android/issues/5421))
- Improve/fix crashes on messages decryption ([#5592](https://github.com/vector-im/element-android/issues/5592))
- Don't pause timer when call is held. ([#5885](https://github.com/vector-im/element-android/issues/5885))

SDK API changes ⚠️
------------------
- Added registrationCustom into RegistrationWizard to send custom auth params for sign up
- Moved terms converter into api package to make it accessible in sdk ([#5575](https://github.com/vector-im/element-android/issues/5575))
- Move package `org.matrix.android.sdk.api.pushrules` to `org.matrix.android.sdk.api.session.pushrules` ([#5812](https://github.com/vector-im/element-android/issues/5812))
- Some `Session` apis are now available by requesting the service first. For instance `Session.updateAvatar(...)` is now `Session.profileService().updateAvatar(...)`
- The shortcut `Room.search()` has been removed, you have to use `Session.searchService().search()` ([#5816](https://github.com/vector-im/element-android/issues/5816))
- Add return type to RoomApi.sendStateEvent() to retrieve the created event id ([#5855](https://github.com/vector-im/element-android/issues/5855))
- `Room` apis are now available by requesting the service first. For instance `Room.updateAvatar(...)` is now `Room.stateService().updateAvatar(...)` ([#5858](https://github.com/vector-im/element-android/issues/5858))
- Remove unecessary field `eventId` from `EventAnnotationsSummary` and `ReferencesAggregatedSummary` ([#5890](https://github.com/vector-im/element-android/issues/5890))
- Replace usage of `System.currentTimeMillis()` by a `Clock` interface ([#5907](https://github.com/vector-im/element-android/issues/5907))

Changes in Matrix-SDK 1.4.13 (2022-04-26)
===================================================

Imported from Element 1.4.13. (https://github.com/vector-im/element-android/releases/tag/v1.4.13)

SDK API changes ⚠️
------------------
 - Include original event in live decryption listeners and update sync status naming to InitialSyncProgressing for clarity. ([#5639](https://github.com/vector-im/element-android/issues/5639))
 - KeysBackupService.getCurrentVersion takes a new type `KeysBackupLastVersionResult` in the callback. ([#5703](https://github.com/vector-im/element-android/issues/5703))
 - A lot of classes which were exposed to the clients and were located in the package `org.matrix.android.sdk.internal` have been moved to the package `org.matrix.android.sdk.api`.
  All the classes which are in the package `org.matrix.android.sdk.internal` should now be declared `internal`.
  Some unused code and classes have been removed. ([#5744](https://github.com/vector-im/element-android/issues/5744))
 - Some data classes are now immutable, using `val` instead of `var` ([#5762](https://github.com/vector-im/element-android/issues/5762))


Changes in Matrix-SDK 1.4.11 (2022-04-12)
===================================================

Imported from Element 1.4.11. (https://github.com/vector-im/element-android/releases/tag/v1.4.11)

SDK API changes ⚠️
------------------
 - Adds support for MSC3440, additional threads homeserver capabilities ([#5271](https://github.com/vector-im/element-android/issues/5271))

Changes in Matrix-SDK 1.4.4 (2022-03-16)
===================================================

Bugfixes 🐛
----------
- Overflowing media size ([#5394](https://github.com/vector-im/element-android/issues/5394))
- Updating avatar failing due to wrong thread on some devices ([#5402](https://github.com/vector-im/element-android/issues/5402))

SDK API changes ⚠️
------------------
- Change name of getTimeLineEvent and getTimeLineEventLive methods to getTimelineEvent and getTimelineEventLive. ([#5330](https://github.com/vector-im/element-android/issues/5330))

Changes in Matrix-SDK 1.4.2 (2022-02-28)
===================================================

SDK API changes ⚠️
------------------
 - `join` and `leave` methods moved from MembershipService to RoomService and SpaceService to split logic for rooms and spaces ([#5183](https://github.com/vector-im/element-android/issues/5183))
 - Deprecates Matrix.initialize and Matrix.getInstance in favour of the client providing its own singleton instance via Matrix.createInstance ([#5185](https://github.com/vector-im/element-android/issues/5185))
 - Adds support for MSC3283, additional homeserver capabilities ([#5207](https://github.com/vector-im/element-android/issues/5207))


Changes in Matrix-SDK 1.3.18 (2022-02-04)
===================================================

**Warning**: This release may trigger an initial sync.

Imported from Element 1.3.18. (https://github.com/vector-im/element-android/releases/tag/v1.3.18)

Bugfixes 🐛
----------
 - Avoid deleting root event of CurrentState on gappy sync. In order to restore lost Events an initial sync may be triggered. ([#5137](https://github.com/vector-im/element-android/issues/5137))

SDK API changes ⚠️
------------------
 - `StateService.sendStateEvent()` now takes a non-nullable String for the parameter `stateKey`. If null was used, just now use an empty string. ([#4895](https://github.com/vector-im/element-android/issues/4895))
 - 429 are not automatically retried anymore in case of too long retry delay ([#4995](https://github.com/vector-im/element-android/issues/4995))


Changes in Matrix-SDK 1.3.14 (2022-01-12)
===================================================

Imported from Element 1.3.14. (https://github.com/vector-im/element-android/releases/tag/v1.3.14)

Changes in Matrix-SDK 1.3.13 (2022-01-11)
===================================================

Imported from Element 1.3.13. (https://github.com/vector-im/element-android/releases/tag/v1.3.13)

SDK API changes ⚠️
------------------
 - Introduce method onStateUpdated on Timeline.Callback ([#4405](https://github.com/vector-im/element-android/issues/4405))
 - Support tagged events in Room Account Data (MSC2437) ([#4753](https://github.com/vector-im/element-android/issues/4753))

Changes in Matrix-SDK 1.3.10 (2021-12-14)
===================================================

Imported from Element 1.3.10. (https://github.com/vector-im/element-android/releases/tag/v1.3.10)

SDK API changes ⚠️
------------------

- New API TermsService.getHomeserverTerms() to get the terms of service from a homeserver
- API SendService.sendOptionsReply() is replaced by SendService.voteToPoll()
- New API SendService.endPoll()

Changes in Matrix-SDK 1.3.9 (2021-12-01)
===================================================

Imported from Element 1.3.9. (https://github.com/vector-im/element-android/releases/tag/v1.3.9)

Changes in Matrix-SDK 1.3.8 (2021-11-17)
===================================================

Imported from Element 1.3.8. (https://github.com/vector-im/element-android/releases/tag/v1.3.8)

SDK API changes ⚠️
------------------
 - Add content scanner API from MSC1453
  API documentation : https://github.com/matrix-org/matrix-content-scanner#api ([#4392](https://github.com/vector-im/element-android/issues/4392))
 - Breaking SDK API change to PushRuleListener, the separated callbacks have been merged into one with a data class which includes all the previously separated push information ([#4401](https://github.com/vector-im/element-android/issues/4401))

Changes in Matrix-SDK 1.3.7 (2021-11-05)
===================================================

Imported from Element 1.3.7. (https://github.com/vector-im/element-android/releases/tag/v1.3.7-RC2)

SDK API changes ⚠️
------------------
 - Add API `LoginWizard.loginCustom(data: JsonDict): Session` to be able to login to a homeserver using arbitrary request content ([#4266](https://github.com/vector-im/element-android/issues/4266))
 - Add optional deviceId to the login API ([#4334](https://github.com/vector-im/element-android/issues/4334))

Changes in Matrix-SDK 1.3.4 (2021-10-20)
===================================================

Imported from Element 1.3.4. (https://github.com/vector-im/element-android/releases/tag/v1.3.4)

SDK API changes ⚠️
------------------
Add Presence support:
- PresenceService has been added, with the ability to set the presence of the current user
- For DM, the presence of the other user is added to the RoomSummary

Changes in Matrix-SDK 1.3.2 (2021-10-08)
===================================================

Imported from Element 1.3.2. (https://github.com/vector-im/element-android/releases/tag/v1.3.2)
Note that Element 1.3.1 do not contain any changes in the SDK, that's why SDK 1.3.1 has not been released.

SDK API changes ⚠️
------------------
- Create extension `String.isMxcUrl()` ([#4158](https://github.com/vector-im/element-android/issues/4158))


Changes in Matrix-SDK 1.3.0 (2021-09-27)
===================================================

Imported from Element 1.3.0. (https://github.com/vector-im/element-android/releases/tag/v1.3.0)

SDK API changes ⚠️
------------------
 - InitialSyncProgressService has been renamed to SyncStatusService and its function getInitialSyncProgressStatus() has been renamed to getSyncStatusLive() ([#4046](https://github.com/vector-im/element-android/issues/4046))


Changes in Matrix-SDK 1.2.2 (2021-09-13)
===================================================

Fix a security issue with message key sharing. See https://matrix.org/blog/2021/09/13/vulnerability-disclosure-key-sharing for details.

Changes in Matrix-SDK 1.2.1 (2021-09-08)
===================================================

Imported from Element 1.2.1. (https://github.com/vector-im/element-android/releases/tag/v1.2.1)
Still an issue with Jitpack: https://github.com/jitpack/jitpack.io/issues/4721
We are working to make the library available in MavenCentral. In the mean time, you can get the library from GitHub here:
https://github.com/matrix-org/matrix-android-sdk2/releases/tag/v1.2.1

Changes in Matrix-SDK 1.2.0 (2021-09-08)
===================================================

Imported from Element 1.2.0. (https://github.com/vector-im/element-android/releases/tag/v1.2.0)
Still an issue with Jitpack: https://github.com/jitpack/jitpack.io/issues/4721
We are working to make the library available in MavenCentral. In the mean time, you can get the library from GitHub here:
https://github.com/matrix-org/matrix-android-sdk2/releases/tag/v1.2.0

Changes in Matrix-SDK 1.1.9 (2021-06-10)
===================================================

Fix error with Jitpack on 1.1.8
Imported from Element 1.1.9. (https://github.com/vector-im/element-android/releases/tag/v1.1.9)

Changes in Matrix-SDK 1.1.8 (2021-05-26)
===================================================

Imported from Element 1.1.8. (https://github.com/vector-im/element-android/releases/tag/v1.1.8)

Changes in Matrix-SDK 1.1.5 (2021-04-15)
===================================================

Imported from Element 1.1.5. (https://github.com/vector-im/element-android/releases/tag/v1.1.5)

Changes in Matrix-SDK 1.1.4 (2021-04-09)
===================================================

Imported from Element 1.1.4. (https://github.com/vector-im/element-android/releases/tag/v1.1.4)

Changes in Matrix-SDK 1.1.1 (2021-03-10)
===================================================

Imported from Element 1.1.1. (https://github.com/vector-im/element-android/releases/tag/v1.1.1)

Changes in Matrix-SDK 1.0.16 (2021-02-08)
===================================================

Imported from Element 1.0.16. (https://github.com/vector-im/element-android/releases/tag/v1.0.16)

Changes in Matrix-SDK 1.0.13 (2020-12-21)
===================================================

Imported from Element 1.0.13. (https://github.com/vector-im/element-android/releases/tag/v1.0.13)

Changes in Matrix-SDK 1.0.12 (2020-12-15)
===================================================

Imported from Element 1.0.12. (https://github.com/vector-im/element-android/releases/tag/v1.0.12)

SDK API changes ⚠️:
 - StateService now exposes suspendable function instead of using MatrixCallback.
 - RawCacheStrategy has been moved and renamed to CacheStrategy
 - FileService: remove useless FileService.DownloadMode

Other important changes:
 - Upgrade Realm dependency to 10.1.2
 - Log HTTP requests and responses in production (level BASIC, i.e. without any private data)

Changes in Matrix-SDK 1.0.11 (2020-11-30)
===================================================

Imported from Element 1.0.11. (https://github.com/vector-im/element-android/releases/tag/v1.0.11)

SDK API changes ⚠️:
 - AccountService and some other services now expose suspendable function instead of using MatrixCallback (vector-im/element-android##2354).
   Note: We will incrementally migrate all the SDK API in a near future (vector-im/element-android#2449)

Other important changes:
 - Upgrade Realm dependency to 10.0.0

Changes in Matrix-SDK 1.0.10 (2020-11-04)
===================================================

Imported from Element 1.0.10. (https://github.com/vector-im/element-android/releases/tag/v1.0.10)

Changes in Matrix-SDK 1.0.9 (2020-10-16)
===================================================

Imported from Element 1.0.9. (https://github.com/vector-im/element-android/releases/tag/v1.0.9)

- Setup CI

Changes in Matrix-SDK 1.0.8
===================================================

This release has not been done.

Changes in Matrix-SDK 1.0.7 (2020-09-23)
===================================================

Imported from Element 1.0.7. (https://github.com/vector-im/element-android/releases/tag/v1.0.7)

Changes in Matrix-SDK 1.0.6 (2020-09-08)
===================================================

Imported from Element 1.0.6.

Changes in Matrix-SDK 1.0.5 (2020-08-21)
===================================================

SDK API changes ⚠️:
- PermalinkFactory is now internal, you should use session.permalinkService() to create permalinks

Changes in Matrix-SDK 0.0.1 (2020-08-14)
===================================================

This is the first release of the Matrix SDK.

This first release has been created from the develop branch of Element Android ([at this commit](https://github.com/vector-im/element-android/commit/5a3894036cb34d00177603e69c5b15431212152d)).
Next releases will be done from main branch of Element Android and the version name will be the same between the SDK and Element Android
