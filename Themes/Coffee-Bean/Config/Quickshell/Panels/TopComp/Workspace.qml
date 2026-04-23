import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../../Constants.js" as Const

Rectangle {
        width: workspaceRow.implicitWidth
        height: 40
        anchors.verticalCenter: parent.verticalCenter
        radius: height/2
        color: Const.color.background
        RowLayout {
                id: workspaceRow
                spacing: 20
                anchors.fill: parent
                Item {}
                Repeater {
                        model: 6
                        anchors.fill: parent
                        Rectangle {
                                anchors.rightMargin: 10
                                anchors.leftMargin: 10
                                height: 12
                                width: 12
                                radius: height/2
                                color: (( index + 1 ) === Hyprland.focusedWorkspace.id) ? Const.color.accent2 : Const.color.accent3
                                Rectangle {
                                        height: 6
                                        width: 6
                                        radius: height/2
                                        color: Const.color.background
                                        anchors.centerIn: parent
                                        visible: Hyprland.workspaces.values.some(ws => ws.id === (index + 1)) ? false : true
                                }
                        }

                }
                Item {}
        }
}
