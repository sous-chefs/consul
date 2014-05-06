#!/usr/bin/env bash

export PATH=$PATH:/usr/local/bin
@test "consul is installed and in the PATH" {
    which consul
}
