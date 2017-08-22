#!/bin/env mayapy
import maya.cmds
import maya.standalone

if __name__ == "__main__":
    maya.standalone.initialize()
    try:
        maya.cmds.loadPlugin(sys.argv[1])
        print("PASS")
    except:
        print("FAIL")
