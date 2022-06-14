#!/bin/sh
Xvfb :0 -screen 0 1024x768x16 & DISPLAY=:0.0 wine $@