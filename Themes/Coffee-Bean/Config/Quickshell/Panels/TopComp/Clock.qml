import Quickshell
import QtQuick
import "../../Process"
import "../../Constants.js" as Const

Rectangle {
        width: 80 
        height: 40
        anchors.verticalCenter: parent.verticalCenter
        radius: height/2
        color: Const.color.background
        Text {
                text: TimerProc.h + ":" + TimerProc.m
                font.family: Const.font.font2
                color: Const.color.text2
                font.bold: true
                font.pointSize: 14
                anchors.centerIn: parent
        }
}
