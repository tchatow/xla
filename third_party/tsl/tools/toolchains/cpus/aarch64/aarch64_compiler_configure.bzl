"""Configurations of AARCH64 builds used with Docker container."""

load("//third_party/remote_config:remote_platform_configure.bzl", "remote_platform_configure")
load("//tools/toolchains:cpus/aarch64/aarch64.bzl", "remote_aarch64_configure")

def ml2014_tf_aarch64_configs(name_container_map, env):
    for name, container in name_container_map.items():
        exec_properties = {
            "container-image": container,
            "Pool": "default",
        }

        remote_aarch64_configure(
            name = "%s_config_aarch64" % name,
            environ = env,
            exec_properties = exec_properties,
        )

        remote_platform_configure(
            name = "%s_config_aarch64_platform" % name,
            platform = "linux",
            platform_exec_properties = exec_properties,
        )

def aarch64_compiler_configure():
    ml2014_tf_aarch64_configs(
        name_container_map = {
            "ml2014_aarch64": "docker://localhost/tensorflow-build-aarch64",
            "ml2014_aarch64-python3.9": "docker://localhost/tensorflow-build-aarch64:latest-python3.9",
            "ml2014_aarch64-python3.10": "docker://localhost/tensorflow-build-aarch64:latest-python3.10",
            "ml2014_aarch64-python3.11": "docker://localhost/tensorflow-build-aarch64:latest-python3.11",
        },
        env = {
            "CC_TOOLCHAIN_NAME": "linux_gnu_aarch64",
            "CLEAR_CACHE": "1",
            "GCC_HOST_COMPILER_PATH": "/dt10/usr/bin/gcc",
            "GCC_HOST_COMPILER_PREFIX": "/usr/bin",
            "TF_SYSROOT": "/dt10",
        },
    )

    ml2014_tf_aarch64_configs(
        name_container_map = {
            "ml2014_clang_aarch64": "docker://localhost/tensorflow-build-aarch64",
            "ml2014_clang_aarch64-python3.9": "docker://localhost/tensorflow-build-aarch64:latest-python3.9",
            "ml2014_clang_aarch64-python3.10": "docker://localhost/tensorflow-build-aarch64:latest-python3.10",
            "ml2014_clang_aarch64-python3.11": "docker://localhost/tensorflow-build-aarch64:latest-python3.11",
            "ml2014_clang_aarch64-python3.12": "docker://localhost/tensorflow-build-aarch64:latest-python3.12",
        },
        env = {
            "CC_TOOLCHAIN_NAME": "linux_llvm_aarch64",
            "CLEAR_CACHE": "1",
            "CLANG_COMPILER_PATH": "/usr/lib/llvm-18/bin/clang",
            "TF_SYSROOT": "/dt10",
        },
    )
