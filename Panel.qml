/****************************************************************************
**
** Copyright (C) Aleix Quintana Alsius
**
** This file is part of the examples of Qubetto.
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

import QtQuick 2.2
import QtBluetooth 5.3
import QtQuick.Layouts 1.3
import "colorkeys.js" as ColorKey

Item {
    id: panel


    property string remoteDeviceName: ""
    property bool serviceFound: true
    property alias chatModel: chatContent
    width: 720
    height: 1280
    //false


    ListModel {
        id: chatContent
        ListElement {
            content: "Connected to chat server"
        }
    }

    Rectangle {
        id: background
        z: 0
        anchors.fill: parent
        color: "#3d3d3d"
    }

    Rectangle {
        id: chatBox
        width: 960
        height: 419
        opacity: 0

        color: "#5d5b59"
        border.color: "black"
        border.width: 1
        radius: 2
        anchors.fill: parent

        function sendMessage()
        {
            // toogle focus to force end of input method composer
            var hasFocus = input.focus;
            input.focus = false;

            var data = input.text
            input.clear()
            chatContent.append({content: "Me: " + data})
            //! [BluetoothSocket-5]
            socket.stringData = data
            //! [BluetoothSocket-5]
            chatView.positionViewAtEnd()

            input.focus = hasFocus;
        }

        Item {
            anchors.fill: parent
            anchors.margins: 10

            InputBox {
                id: input
                Keys.onReturnPressed: chatBox.sendMessage()
                height: sendButton.height
                width: parent.width - sendButton.width - 15
                anchors.left: parent.left
            }

            Button {
                id: sendButton
                anchors.right: parent.right
                label: "Send"
                onButtonClick: chatBox.sendMessage()
            }


            Rectangle {
                height: parent.height - input.height - 15
                width: parent.width;
                color: "#d7d6d5"
                anchors.bottom: parent.bottom
                border.color: "black"
                border.width: 1
                radius: 5

                ListView {
                    id: chatView
                    width: parent.width-5
                    height: parent.height-5
                    anchors.centerIn: parent
                    model: chatContent
                    clip: true
                    delegate: Component {
                        Text {
                            font.pointSize: 14
                            text: modelData
                        }
                    }
                }
            }
        }
    }
    GridLayout {
        rows: 2
        columns: 2
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        flow:  width > height ? GridLayout.LeftToRight : GridLayout.TopToBottom
        anchors.fill: parent
        anchors.margins: 20
        rowSpacing: 5
        columnSpacing: 5

        Item {
            id: plywood
            width: 720
            height: 720
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.rowSpan: 1
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.minimumHeight: 720
            Layout.preferredHeight: 720
            Layout.preferredWidth: 720
            Layout.minimumWidth: 720

            Image {
                id: gravat_function
                anchors.left: parent.left
                anchors.leftMargin: 80
                anchors.right: parent.right
                anchors.rightMargin: 80
                sourceSize.height: 150
                sourceSize.width: 535
                anchors.bottom: gravat_snake.top
                anchors.bottomMargin: 40
                fillMode: Image.PreserveAspectFit
                scale: 1
                opacity: 1
                z: -2
                source: "images/gravat-function.svg"
                Row {
                    id: functionLine
                    layoutDirection: Qt.LeftToRight
                    spacing: redDestination.columnSpacing
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                    //anchors.left: redSource.right
                    Repeater {
                        id:functionLineSequence
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.top: parent.top
                        model: 4
                        delegate: DropTileFunction {
                            colorKey: "red"
                            width:redDestination.droptile_scale
                            height:redDestination.droptile_scale
                        }
                    }
                }
            }

            Image {
                id: image1
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
                z: -3
                source: "images/background.svg"
            }

            Image {
                id: gravat_snake
                sourceSize.height: 319
                sourceSize.width: 560
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 80
                anchors.left: parent.left
                anchors.leftMargin: 80
                fillMode: Image.PreserveAspectFit
                scale: 1
                z: -2
                source: "images/gravat-snake.svg"
                onPaintedGeometryChanged: {
                    //SETS the dropTile geometry ,(so also grid spacings...)
                    redDestination.droptile_scale = gravat_snake.paintedHeight/5
                }

                Grid {
                    id: redDestination
                    property int droptile_scale: 60
                    anchors.horizontalCenter: parent.horizontalCenter
                    //anchors.verticalCenter: parent.verticalCenter
                    anchors.top:parent.top
                    anchors.bottom:parent.bottom
                    rowSpacing:((parent.paintedHeight-(droptile_scale*(redDestination.rows/1.5)))/(redDestination.rows)) //adding 1,5 bias (as there are two lines to not fill with droptiles
                    columnSpacing: ((parent.paintedWidth-(droptile_scale*redDestination.columns))/redDestination.columns)
                    rows: 3

                    opacity: 1
                    columns: 4
                    onDroptile_scaleChanged: { console.log(droptile_scale) }
                    onWindowChanged: {console.log(" cs "+ gravat_snake.height +" "+ droptile_scale+" " +redDestination.rows)
                        console.log((parent.height-(droptile_scale*(redDestination.rows+2)))/(redDestination.rows))
                    }

                    Repeater {
                        id: sequence
                        model: 12
                        delegate: DropTile {
                            colorKey: "red"
                            width:redDestination.droptile_scale
                            height:redDestination.droptile_scale
                        }
                    }
                }

            }

            Image {
                id: gravat_send
                width: 166
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: gravat_snake.bottom
                anchors.topMargin: 50
                sourceSize.height: 100
                sourceSize.width: 166
                fillMode: Image.PreserveAspectFit
                source: "images/gravat-send.svg"


                Button {
                    id: senderButton
                    width: 100
                    radius: 49
                    border.color: "#ffffff"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    border.width: 14
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    label: ""
                    color: "#60b1e9"
                    onButtonClick: {
                        var serialFunctionOrder = ""

                        for (var i = 0; i < functionLineSequence.count; ++i){
                            serialFunctionOrder += functionLineSequence.itemAt(i).order
                        }
                        console.log("Function is: " + serialFunctionOrder)

                        console.log(sequence.count)
                        var serialOrder = ""
                        for (var i = 0; i < sequence.count; ++i){
                            if (sequence.itemAt(i).order === "x"){
                                serialOrder += serialFunctionOrder
                            }else{
                                serialOrder += sequence.itemAt(i).order
                            }
                        }
                        console.log("Order is: " + serialOrder)
                        input.text = serialOrder
                        chatBox.sendMessage()
                    }
                }
            }
        }


        Column {
            id: redSource
            width: 640
            height: 100
            Layout.preferredHeight: 100
            Layout.preferredWidth: 640
            Layout.minimumHeight: 100
            Layout.minimumWidth: 640
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            transformOrigin: Item.Center
            Layout.fillHeight: false
            Layout.fillWidth: false


            Grid {
                id: gridTiles
                width: 510
                height: 110
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                spacing: 14
                columns: 4

                Flickable {
                    id: flickable1
                    width: 96
                    height: 100
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    contentHeight: 0
                    contentWidth: 0

                    Repeater {
                        x: 0
                        y: 0
                        clip: false
                        model: 12
                        delegate: DragTile {  colorKey: ColorKey.left }
                    }
                }

                Flickable {
                    id: flickable2
                    width: 96
                    height: 100
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    contentHeight: 64
                    contentWidth: 64
                    anchors.left: flickable1.right
                    anchors.leftMargin: 5

                    Repeater {
                        x: 0
                        y: -1152
                        model: 12
                        delegate: DragTile { colorKey: ColorKey.right }
                    }
                }

                Flickable {
                    id: flickable3
                    width: 96
                    height: 100
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: flickable2.right
                    anchors.leftMargin: 5

                    Repeater {
                        x: 0
                        y: 0
                        model: 12
                        delegate: DragTile { colorKey: ColorKey.front }
                    }
                }

                Flickable {
                    id: flickable4
                    width: 96
                    height: 100
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: flickable3.right
                    anchors.leftMargin: 5

                    Repeater {
                        x: 0
                        y: 0
                        model: 12
                        delegate: DragTile { colorKey: ColorKey.back }
                    }
                }

                Flickable {
                    id: flickable5
                    width: 96
                    height: 100
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: flickable4.right
                    anchors.leftMargin: 5

                    Repeater {
                        x: 0
                        y: 0
                        model: 12
                        delegate: DragTile { colorKey: ColorKey.functionKey }
                    }
                }
            }


        }

    }

}
