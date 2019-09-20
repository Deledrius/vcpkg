include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "${PORT} currently only supports being built for desktop")
endif()

vcpkg_download_distfile(ARCHIVE
    URLS "https://ftp.postgresql.org/pub/source/v9.6.15/postgresql-9.6.15.tar.bz2"
    FILENAME "postgresql-9.6.15.tar.bz2"
    SHA512 cc35a059bf59ea3487c17a8432b791ca2a19afaa24b07403a8d33904b3a97ebe601e3036ca8ec766c54cb87a7def7d4618a425a4446e6832391185d7c71117db
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        "-DPORT_DIR=${CMAKE_CURRENT_LIST_DIR}"
    OPTIONS_DEBUG
        -DINSTALL_INCLUDES=OFF
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/COPYRIGHT DESTINATION ${CURRENT_PACKAGES_DIR}/share/libpq RENAME copyright)
