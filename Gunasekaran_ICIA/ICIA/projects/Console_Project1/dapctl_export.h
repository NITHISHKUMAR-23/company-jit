#pragma once
#ifndef DAPCTL_EXPORT_H
#define DAPCTL_EXPORT_H

#ifdef WIN32

#if defined(dapctl_lambic)
#define DAPCTL_EXPORT
#elif defined(dapctl_acs_import)
/* We are the ACS */
#define DAPCTL_EXPORT __declspec(dllimport)
#else
/* We are the dapctl_impl author */
#define DAPCTL_EXPORT __declspec(dllexport)
#endif

#define DAPCTL_DEPRECATED __declspec(deprecated)

#else

#ifdef dapctl_acs_import
/* We are the ACS */
#define DAPCTL_EXPORT __attribute__((visibility("default")))
#else
/* We are the dapctl_impl author */
#define DAPCTL_EXPORT __attribute__((visibility("default")))
#endif

#define DAPCTL_DEPRECATED __attribute__((__deprecated__))

#endif

#endif
