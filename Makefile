.PHONY: pcapd-dist dist-abi clean

# Set this to point to the PCAPdroid root directory
PCAPDROID_LOCATION ?= ../PCAPdroid

ROOT_DIR=$(shell readlink -f $(PCAPDROID_LOCATION))
SRC_PATH=$(ROOT_DIR)/app/src/main/jni
PARALLEL_FLAGS=-j$(shell nproc)

ANDROID_ABI ?= x86
ANDROID_NATIVE_API_LEVEL ?= 21
ANDROID_NDK ?= ${HOME}/Android/Sdk/ndk-bundle
CMAKE_ANDROID_FLAGS += -DCMAKE_TOOLCHAIN_FILE=$(ANDROID_NDK)/build/cmake/android.toolchain.cmake\
	-DANDROID_NATIVE_API_LEVEL=$(ANDROID_NATIVE_API_LEVEL)\
	-DANDROID_ABI=$(ANDROID_ABI)
LIBS_DIST=./dist

pcapd-dist:
	rm -rf dist
	$(MAKE) ANDROID_ABI=x86 dist-abi
	$(MAKE) ANDROID_ABI=x86_64 dist-abi
	$(MAKE) ANDROID_ABI=armeabi-v7a dist-abi
	$(MAKE) ANDROID_ABI=arm64-v8a dist-abi
	mkdir -p dist/include
	cp $(SRC_PATH)/pcapd/pcapd.h dist/include
	#tar -C dist -czf pcapd.tar.gz .

dist-abi:
	rm -rf build
	mkdir -p build
	mkdir -p dist/$(ANDROID_ABI)
	cd build && cmake $(CMAKE_ANDROID_FLAGS) $(SRC_PATH)
	cd build && cmake --build . --target libpcapd.so -- $(PARALLEL_FLAGS)
	cp build/pcapd/libpcapd.so dist/$(ANDROID_ABI)

clean:
	rm -rf build
