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

#include "qubetto.h"
#include <QFile>
#include <QBluetoothTransferReply>
#include <QDebug>

Qubetto::Qubetto(QObject *parent) :
    QObject(parent), m_progress(0)
{
}

//! [Transfer-1]
void Qubetto::initTransfer(QString address, QString fileName)
{
    qDebug() << "Begin sharing file: " << address << fileName;
    QBluetoothAddress btAddress = QBluetoothAddress(address);
    QBluetoothTransferRequest request(btAddress);
    QFile *file = new QFile(fileName);
    reply = manager.put(request, file);
    connect(reply, SIGNAL(transferProgress(qint64,qint64)), this, SLOT(updateProgress(qint64,qint64)));
}
//! [Transfer-1]

void Qubetto::updateProgress(qint64 transferred, qint64 total)
{
    m_progress = ((float)transferred)/((float)total);
    emit progressChanged();
}
