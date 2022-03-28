#!/usr/bin/env bash

set -e

dart compile exe bin/cli.dart
bin/cli.exe "$@"
