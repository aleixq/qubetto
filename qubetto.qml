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

import QtQuick 2.1
import QtBluetooth 5.2

//! [Root-1]
Item {
    id: root
//! [Root-1]
    width:  1080; height: 1920
   // fillMode: Image.PreserveAspectCrop
   // source: "background.png"
//! [Root-2]
    property string remoteDevice;
    property string remoteDeviceName;
    property string fileName;
//! [Root-2]
    onRemoteDeviceChanged: {
        loader.source = "Panel.qml"
    }

//! [Root-3]
    onFileNameChanged: {
        fileTransfer.initTransfer(remoteDevice, fileName);
        loader.source = "FileSending.qml"
    }
//! [Root-3]

    Loader {
        id: loader
        width: 766
        height: 1720
        anchors.fill: parent
        //DEVELOPMENT
        source: "Panel.qml"
        //PRODUCTION:
        //source: "DeviceDiscovery.qml"
    }
//! [Root-4]
    //! [BluetoothSocket-1]
    BluetoothSocket {
        id: socket
        connected: true

        onSocketStateChanged: {
            console.log("Socket state changed: " + socketState)
            switch(socketState){
                case(BluetoothSocket.NoServiceSet):
                  console.log("NoServiceSet")
                  break
                case(BluetoothSocket.Unconnected):
                  console.log("Unconnected")
                  break
                case(BluetoothSocket.ServiceLookup):
                  console.log("ServiceLookup")
                  break
                case(BluetoothSocket.Connecting):
                  console.log("Connecting")
                  break
                case(BluetoothSocket.Connected):
                  console.log("Connected")
                  break
                case(BluetoothSocket.Closing):
                  console.log("Closing")
                  break
                case(BluetoothSocket.Listening):
                  console.log("Listening")
                  break
                case(BluetoothSocket.Bound):
                  console.log("Bound")
                  break
            }
            //top.state = "chatActive"
            loader.source = "Panel.qml"
        }
        onConnectedChanged: {
            console.log("socket connect: " + socket.connected)
        }

        onErrorChanged: {
            console.log("Error:" + error + ":")
            switch(error){
                case(BluetoothSocket.NetworkError):
                  console.log("Network error")
                  break
                case(BluetoothSocket.ServiceNotFoundError):
                  console.log("Service not found")
                  break
                case(BluetoothSocket.HostNotFoundError):
                  console.log("Host not found")
                  break
                case(BluetoothSocket.UnknownSocketError):
                  console.log("Unknown socket")
                  break
                case(BluetoothSocket.NoError):
                  console.log("No Error")
                  break
                case(BluetoothSocket.UnsupportedProtocolError):
                  console.log("Unsupported Protocol")
                  break
            }
            socket.connected = false;

        }

    //! [BluetoothSocket-1]
    //! [BluetoothSocket-3]
        onStringDataChanged: {
            console.log("Received data: " )
            var data = root.remoteDeviceName + ": " + socket.stringData;
            data = data.substring(0, data.indexOf('\n'))
            loader.item.chatModel.append({content: data})
    //! [BluetoothSocket-3]
            console.log(data);
    //! [BluetoothSocket-4]
        }
    //! [BluetoothSocket-4]
    //! [BluetoothSocket-2]
    }
    //! [BluetoothSocket-2]
}
//! [Root-4]
