#!/usr/bin/env mayapy
import maya.cmds
import maya.standalone

if __name__ == "__main__":
    maya.standalone.initialize()
    success = False
    try:
        success = bool(maya.cmds.loadPlugin(sys.argv[1]))
    except:
        pass

    if success:
        print("PASS")
    else:
        print("FAIL")
