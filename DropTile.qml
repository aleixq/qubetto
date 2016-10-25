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
DropArea {
    id: dragTarget

    property string colorKey
    property alias dropProxy: dragTarget
    property string order : ""

    //keys: [ colorKey ] //RESTRICT to these keys
    onDropped: {
            switch(drop.source.color.toString()){
                case (ColorKey.front):
                    dragTarget.order = 'e'
                    break;
                case (ColorKey.back):
                    dragTarget.order = 'd'
                    break
                case (ColorKey.right):
                    dragTarget.order = 'f'
                    break;
                case (ColorKey.left):
                    dragTarget.order = 's'
                    break;
                case (ColorKey.functionKey):
                    dragTarget.order = 'x'
                    break;
                default:
                    console.log("no color")
            }
    }
    onChildrenChanged: {
        //RESET if no children!
        //console.log("cl "+children.length)
        if (!children[3]){
            dragTarget.order = ''
        }
    }

//    onContainsDragChanged: {
//        if (dragTarget.containsDrag){
//            console.log(drag.source.color)
//            console.log(drag.source.color)
//            switch(drag.source.color){
//                case (ColorKey.front):
//                    dragTarget.order = 'e'
//                    break;
//                case (ColorKey.back):
//                    dragTarget.order = 'd'
//                    break
//                case (ColorKey.right):
//                    dragTarget.order = 'f'
//                    break;
//                case (ColorKey.right):
//                    dragTarget.order = 's'
//                    break;
//                case (ColorKey.functionKey):
//                    dragTarger.order = 'x'
//                    break;
//            }
//        }
//    }
    Rectangle {
        id: dropRectangle

        anchors.fill: parent
        color: "grey" //colorKey
        opacity:0.2
        radius:parent.width

        states: [
            State {
                when: dragTarget.containsDrag
                PropertyChanges {
                    target: dropRectangle
                    color: "blue"
                }
            }
        ]

    }
    Rectangle{
        color:"white"
        width:parent.width-(parent.width/5)
        height:parent.width-(parent.width/5)
        radius:parent.width-(parent.width/5)
        anchors.centerIn: dropRectangle
    }
    /*
    Text{
        color:ColorKey.functionKey
        width:48
        height:48
        text: ">"
        style: Text.Normal
        font.bold: false
        transformOrigin: Item.Center
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenterOffset: 0
        anchors.verticalCenterOffset: -5
        font.pointSize: 35
        anchors.centerIn: dropRectangle
    }
    */
}
//! [0]
