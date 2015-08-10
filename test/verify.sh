#!/usr/bin/env bash

build/cpp/Test          && echo '> C++ passed'
node build/test.js      && echo '> JavaScript passed'
python3 build/test.py   && echo '> Python passed'
php build/php/index.php && echo '> PHP passed'