#!/usr/bin/env bash

set -e

dart compile exe bin/runner_dart.dart
bin/runner_dart.exe
