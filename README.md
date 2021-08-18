This repo contains pre-compiled pcapd binaries, which can be integrated into other projects to implement the ability to capture as root in Android.

pcapd is part of [PCAPdroid](https://github.com/emanuele-f/PCAPdroid). You are allowed to bundle the pcapd binaries of this repo into your proprietary app as long as you provide proper attribution to the PCAPdroid project.

You can get a changelog from the [pcapd history](https://github.com/emanuele-f/PCAPdroid/commits/master/app/src/main/jni/pcapd).

Integrate pcapd
---------------

Check out the [pcapd readme](https://github.com/emanuele-f/PCAPdroid/tree/master/app/src/main/jni/pcapd) for general usage and integration information.

In order to add the pcapd binaries to the app, you need to specify its dist path into the `srcDirs` in the `build.gradle` file:

```
sourceSets {
    main {
        jniLibs.srcDirs = ["libs", "libs/pcapd/dist"]
    }
}
```

This repo can be linked as a submodule with:

```
git submodule add -f https://github.com/emanuele-f/pcapd-bin app/libs/pcapd
```

In order to have access to the `pcapd_hdr_t` structure, ensure to add `pcapd/dist/include` to your include path.
