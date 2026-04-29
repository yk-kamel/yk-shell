import Quickshell
import QtQuick
import QtQuick.Layouts
import "TopComp" 

PanelWindow {
        implicitHeight: 45
        anchors.top: true
        anchors.left: true
        anchors.right: true
        color: 'transparent'
        HoverHandler { id: panelHoverHandler }
        RowLayout {
                anchors.fill: parent
                Clock {
                        id: clock
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                }
                SystemInfo {
                        id: systemInfo
                        anchors.left: clock.right
                        anchors.leftMargin: 10
                }
                Workspace {
                        anchors.left: systemInfo.right
                        anchors.leftMargin: 10
                }
                Island {
                        anchors.horizontalCenter: parent.horizontalCenter
                }
                Volume {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                }
        }
}
