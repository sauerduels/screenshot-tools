#!/bin/bash

for i in media/*.png ; do convert "$i" "${i%.*}.jpg" ; done

