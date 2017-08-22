#!/usr/bin/env mayapy
import maya.cmds
import maya.standalone
import sys
import traceback

if __name__ == "__main__":
    maya.standalone.initialize()
    success = False
    try:
        success = bool(maya.cmds.loadPlugin(sys.argv[1]))
    except:
        traceback.print_exc()

    if success:
        print("PASS")
        sys.exit(0)
    else:
        print("FAIL")
        sys.exit(1)
