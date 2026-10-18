package com.syntax.gallery

import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.delay

data class ConnectionConfig(
    val host: String,
    val port: Int = 443,
    val secure: Boolean = true
)

sealed interface NetworkResult<out T> {
    data class Success<out T>(val value: T) : NetworkResult<T>
    data class Failure(val cause: Throwable) : NetworkResult<Nothing>
}

class ApiClient(private val config: ConnectionConfig) {
    fun pollStatus(): Flow<NetworkResult<String>> = flow {
        repeat(3) { index ->
            delay(100)
            emit(NetworkResult.Success("Pulse #$index from ${config.host}"))
        }
    }
}
