import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../Process/"
import "../../Constants.js" as Const

Rectangle {
        height: 40
        width: mainRow.implicitWidth
        radius: height/2
        color: Const.color.background
        HoverHandler { id: mainHover }

        RowLayout {
                id: mainRow
                anchors.fill: parent

                Repeater {
                        model: 3
                        Rectangle {
                                visible: ( mainHover.hovered || modelData == 0)
                                color: "transparent"
                                height: 40
                                width: 40
                                radius: 20
                                clip: true

                                Text {
                                        text: (modelData == 0) ? SystemInfoProcess.settings.cpu_usage + "%\n "
                                        : (modelData == 1) ? SystemInfoProcess.settings.vram_usage  + "%\nvRAM" 
                                        : (modelData == 2) ? SystemInfoProcess.settings.ram_usage  + "%\n " 
                                        : "F"
                                        color: Const.color.text2
                                        anchors.centerIn: parent
                                        horizontalAlignment: Text.AlignHCenter
                                        font.family: Const.font.font1
                                        font.pointSize: 12
                                }
                        }
                }
        }
}
