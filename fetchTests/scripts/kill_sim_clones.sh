#!/bin/sh

#  kill_sim_clones.sh
#  fetch
#
#  Created by Jason Kim on 4/17/23.
#  
xcrun simctl --set testing list | grep Booted | grep Clone | sed 's/^.*(\([A-Z0-9\-]*\)).*$/\1/g' | xargs -I {} xcrun simctl --set testing shutdown "{}"
