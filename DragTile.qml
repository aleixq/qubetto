/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.0
import "colorkeys.js" as ColorKey

//! [0]
Item {
    id: root
    property string colorKey

    width: 96; height: 96

    MouseArea {
        id: mouseArea

        width: 96; height: 96
        anchors.centerIn: parent

        drag.target: tile

        onReleased: parent = tile.Drag.target !== null ? tile.Drag.target : root

        Image {
            id: tile
            sourceSize.height: 96
            sourceSize.width: 96
            fillMode: Image.PreserveAspectFit
            source: "images/fb.svg"

            property string color
            property string order : colorKey
            //WORKAROUND- for not emitting onDropped
            //http://stackoverflow.com/questions/24532317/new-drag-and-drop-mechanism-does-not-work-as-expected-in-qt-quick-qt-5-3
            //Drag.active: mouseArea.drag.active
            property bool dragActive: mouseArea.drag.active
            //EOW

            width: 96; height: 96
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            color: colorKey

            Drag.keys: [ colorKey ]
            //WORKAROUND- for not emitting onDropped
            //http://stackoverflow.com/questions/24532317/new-drag-and-drop-mechanism-does-not-work-as-expected-in-qt-quick-qt-5-3
            //Drag.active: mouseArea.drag.active
            //EOW
            Drag.hotSpot.x: 32
            Drag.hotSpot.y: 32
            //WORKAROUND- for not emitting onDropped
            //http://stackoverflow.com/questions/24532317/new-drag-and-drop-mechanism-does-not-work-as-expected-in-qt-quick-qt-5-3
            //Drag.active: mouseArea.drag.active
            Drag.dragType: Drag.Automatic
            onDragActiveChanged: {
                if (dragActive) {
                    print("drag started")
                    Drag.start();
                } else {
                    print("drag finished")
                    Drag.drop();
                }

            }
            onColorChanged:{
                console.log(color)
                switch(color){
                    case (ColorKey.front):
                        tile.source = 'images/fg.svg'
                        break;
                    case (ColorKey.back):
                        tile.source = 'images/bb.svg'
                        break
                    case (ColorKey.right):
                        tile.source = 'images/rr.svg'
                        break;
                    case (ColorKey.left):
                        tile.source = 'images/ly.svg'
                        break;
                    case (ColorKey.functionKey):
                        tile.source = 'images/fb.svg'
                        break;
                    default:
                        console.log("no color")
                }
            }


            // EOW
            //! [0]
            /* DBG item #
            Text {
                anchors.fill: parent
                color: "white"
                font.pixelSize: 48
                text: modelData + 1
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }*/
            //! [1]
            states: State {
                when: mouseArea.drag.active
                ParentChange { target: tile; parent: root }
                AnchorChanges { target: tile; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
            }

        }

    }

}
//! [1]

