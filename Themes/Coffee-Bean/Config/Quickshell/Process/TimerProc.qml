pragma Singleton

import Quickshell
import QtQuick

Singleton {
	id: root
	readonly property string h: Qt.formatDateTime(clock.date, "hh")
	readonly property string s: Qt.formatDateTime(clock.date, "ss")
	readonly property string m: Qt.formatDateTime(clock.date, "mm")

	SystemClock {
		id: clock
		precision: SystemClock.Seconds
	}
}
