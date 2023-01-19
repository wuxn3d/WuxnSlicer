// Copyright (c) 2019 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.2
import QtQuick.Controls 2.0
import UM 1.5 as UM

/**
 * This component comprises a buildplate icon and the buildplate name. It is
 * used by the MonitorPrinterConfiguration component along with two instances
 * of MonitorExtruderConfiguration.
 *
 * NOTE: For most labels, a fixed height with vertical alignment is used to make
 * layouts more deterministic (like the fixed-size textboxes used in original
 * mock-ups). This is also a stand-in for CSS's 'line-height' property. Denoted
 * with '// FIXED-LINE-HEIGHT:'.
 */
Item
{
    // The buildplate name
    property var buildplate: null

    // Height is one 18px label/icon
    height: 18 * screenScaleFactor // TODO: Theme!
    width: childrenRect.width

    Row
    {
        height: parent.height
        spacing: UM.Theme.getSize("print_setup_slider_handle").width // TODO: Theme! (Should be same as extruder spacing)

        // This wrapper ensures that the buildplate icon is located centered
        // below an extruder icon.
        Item
        {
            height: parent.height
            width: 32 * screenScaleFactor // Ensure the icon is centered under the extruder icon (same width)

            Rectangle
            {
                anchors.centerIn: parent
                height: parent.height
                width: height
                color: buildplateIcon.visible > 0 ? "transparent" : UM.Theme.getColor("monitor_skeleton_loading")
                radius: Math.floor(height / 2)
            }

            UM.ColorImage
            {
                id: buildplateIcon
                anchors.centerIn: parent
                color: UM.Theme.getColor("monitor_icon_primary")
                height: UM.Theme.getSize("medium_button_icon").width
                source: UM.Theme.getIcon("Buildplate")
                width: height
                visible: buildplate
            }
        }

        UM.Label
        {
            id: buildplateLabel
            elide: Text.ElideRight
            text: buildplate ? buildplate : ""
            visible: text !== ""

            // FIXED-LINE-HEIGHT:
            height: 18 * screenScaleFactor // TODO: Theme!
        }
    }
}
