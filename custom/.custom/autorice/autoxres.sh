#!/bin/bash

xrdb -query | sed -e "s:\*\.:\*" > xres_patch
