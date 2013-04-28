#
# QMake variables for Qt
#
inherit qmake5_base

QT5TOOLSDEPENDS ?= "qtbase-native "
DEPENDS_prepend = "${QT5TOOLSDEPENDS}"

export OE_QMAKE_INCDIR_QT = "${STAGING_INCDIR}/qt5"
export OE_QMAKE_LIBDIR_QT = "${STAGING_LIBDIR}"
export OE_QMAKE_LIBS_QT = "qt"
export OE_QMAKE_LIBS_X11 = "-lXext -lX11 -lm"
export OE_QMAKE_LIBS_X11SM = "-lSM -lICE"
export OE_QMAKE_LRELEASE = "${STAGING_BINDIR_NATIVE}/lrelease5"
export OE_QMAKE_LUPDATE = "${STAGING_BINDIR_NATIVE}/lupdate5"

qmake5_do_configure () {
    if [ ! -z "${EXTRA_QMAKEVARS_POST}" ]; then
        AFTER="-after"
        QMAKE_VARSUBST_POST="${EXTRA_QMAKEVARS_POST}"
        bbnote "qmake postvar substitution: ${EXTRA_QMAKEVARS_POST}"
    fi

    if [ ! -z "${EXTRA_QMAKEVARS_PRE}" ]; then
        QMAKE_VARSUBST_PRE="${EXTRA_QMAKEVARS_PRE}"
        bbnote "qmake prevar substitution: ${EXTRA_QMAKEVARS_PRE}"
    fi

    CMD="${OE_QMAKE_QMAKE} -makefile -o Makefile ${OE_QMAKE_DEBUG_OUTPUT} -r $QMAKE_VARSUBST_PRE $AFTER $QMAKE_VARSUBST_POST ${S}"
    $CMD || die "Error calling $CMD"
}

EXPORT_FUNCTIONS do_configure
