#!/bin/env mayapy
import maya.cmds
import maya.standalone
import sys

if __name__ == "__main__":
    maya.standalone.initialize()
    try:
        maya.cmds.loadPlugin(sys.argv[1])
        sys.exit(0)
    except:
        sys.exit(1)
