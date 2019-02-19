/*
 * Copyright (c) 2018 Elastos Foundation
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#ifndef __TEST_CONFIG_H__
#define __TEST_CONFIG_H__

#include <limits.h>

#if defined(_WIN32) || defined(_WIN64)
#include <posix_helper.h>
#endif

#include "ela_carrier.h"

#define CARRIER_MAX_SERVER_URI_LEN 127
typedef struct TestConfig {
    int shuffle;
    int log2file;
    char data_location[PATH_MAX];
    bool udp_enabled;

    struct {
        int loglevel;
    } tests;

    struct {
        char host[CARRIER_MAX_SERVER_URI_LEN + 1];
        char port[32];
        int loglevel;
    } robot;

    int bootstraps_size;
    BootstrapNode **bootstraps;
} TestConfig;

extern TestConfig global_config;

const char *get_config_file(const char *candidates[]);

void load_config(const char *config_file);

#endif /* __TEST_CONFIG_H__ */
