#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Bash script to execute the cpp-ethereum tests.
#
# The documentation for cpp-ethereum is hosted at http://cpp-ethereum.org
#
# ------------------------------------------------------------------------------
# This file is part of cpp-ethereum.
#
# cpp-ethereum is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# cpp-ethereum is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with cpp-ethereum.  If not, see <http://www.gnu.org/licenses/>
#
# (c) 2016 cpp-ethereum contributors.
#------------------------------------------------------------------------------

set -e

TESTS=$1

# There is an implicit assumption here that we HAVE to run from build directory.
BUILD_ROOT=$(pwd)

if [[ "$TESTS" == "On" ]]; then

    # Run the tests for the Interpreter
    $BUILD_ROOT/test/testeth -- --testpath $BUILD_ROOT/../test/jsontests

    # Run the tests for the JIT (but only for Ubuntu, not macOS)
    # The whole automation process is too slow for macOS, and we don't have
    # enough time to build LLVM, build EVMJIT and run the tests twice within
    # the 48 minute absolute maximum run time for TravisCI.

    # Disabled until EVMJIT will catch up with Metropolis features.
    # if [[ "$OSTYPE" != "darwin"* ]]; then
    #     $BUILD_ROOT/test/testeth -t "VMTests*,StateTests*" -- --vm jit --testpath $BUILD_ROOT/../test/jsontests
    # fi

fi
