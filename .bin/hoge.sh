#!/bin/bash

echo $(dirname "${BASH_SOURCE[0]}")
script_dir=$(cd $(dirname "${BASH_SOURCE[0]}"))

echo $(dirname "${script_dir}")
