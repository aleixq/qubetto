QT += quick bluetooth svg


TARGET = qml_picturetransfer
TEMPLATE = app

RESOURCES += \
    qmlqubetto.qrc

OTHER_FILES += \
    DeviceDiscovery.qml \
    ButtonDiscover.qml \
    Button.qml \
    InputBox.qml \
    Search.qml \

HEADERS += \
    theme.h \
    qubetto.h

SOURCES += \
    main.cpp \
    theme.cpp \
    qubetto.cpp

target.path = $$[QT_INSTALL_EXAMPLES]/bluetooth/picturetransfer
INSTALLS += target

EXAMPLE_FILES += \
    icon.png

DISTFILES += \
    images/clear.png \
    images/default.png \
    images/lineedit-bg.png \
    Panel.qml \
    DragTile.qml \
    DropTile.qml \
    colorkeys.js \
    DropTileFunction.qml \
    images/go.svg \
    images/fg.svg \
    images/rr.svg \
    images/ly.svg \
    images/bb.svg \
    images/fb.svg \
    images/gravat.svg \
    images/background.svg \
    qubetto.qml


