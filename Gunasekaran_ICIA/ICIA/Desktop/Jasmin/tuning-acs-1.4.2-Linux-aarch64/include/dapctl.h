#ifndef dapctl_dapctl_h
#define dapctl_dapctl_h

#ifdef __cplusplus
extern "C" {
#endif

#include <stdbool.h>
#include <stdint.h>

#include "dapctl_export.h"

#define DAPCTL_MAX_MESSAGE_SIZE (1024)

typedef struct dapctl dapctl;

typedef enum {
    DAPCTL_STATUS_SUCCESS = 0,      /**< No error */
    DAPCTL_STATUS_ALREADY_LOADED,   /**< Indicates resource already loaded */
    DAPCTL_STATUS_FAILED,           /**< Generic error */
    DAPCTL_STATUS_INSUFFICIENT,     /**< Insufficient resources */
    DAPCTL_STATUS_BUSY,             /**< Resources busy */
    DAPCTL_STATUS_INVALID_ARGUMENT, /**< One or more arguments are incorrect */
    DAPCTL_STATUS_UNSUPPORTED,      /**< Operation not supported. */
    DAPCTL_STATUS_NOT_IMPLEMENTED,  /**< Functionality not implemented */
    DAPCTL_STATUS_OFF_LINE,         /**< Functionality implemented but off line */
} dapctl_status;

DAPCTL_EXPORT
dapctl_status dapctl_open(dapctl** ptr, const char* uri);

DAPCTL_EXPORT
dapctl_status dapctl_close(dapctl* handle);

// Dispatch message with the content 'payload'.
// At call 'payload' contains the request data of size '*size' that
// should be sent to dap. At return the response should be written
// to 'payload' and '*size' updated with the actual size of the response. The
// size of request and response are bounded by 'DAPCTL_MAX_MESSAGE_SIZE'.
DAPCTL_EXPORT
dapctl_status dapctl_dispatch_message(dapctl* handle, void* payload, int32_t* size);

#ifdef __cplusplus
}
#endif

#endif
