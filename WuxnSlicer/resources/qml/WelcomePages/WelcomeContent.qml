// Copyright (c) 2019 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.10
import QtQuick.Controls 2.3

import UM 1.5 as UM
import Cura 1.1 as Cura

//
// This component contains the content for the "Welcome" page of the welcome on-boarding process.
//
Item
{
    UM.I18nCatalog { id: catalog; name: "cura" }

    // Arrange the items vertically and put everything in the center
    Column
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: UM.Theme.getSize("thick_margin").height
        width:parent.width


        // Filler item
        Item
        {
            height: UM.Theme.getSize("thick_margin").width
            width: parent.width
        }

        Image
        {
            id: curaImage
            anchors.horizontalCenter: parent.horizontalCenter
            source: UM.Theme.getImage("welcome_cura")
            fillMode: Image.PreserveAspectFit
            width: UM.Theme.getSize("welcome_wizard_content_image_big").width
            sourceSize.width: width
            sourceSize.height: height
        }

        // Filler item
        Item
        {
            height: UM.Theme.getSize("thick_margin").width
            width: parent.width
        }

        UM.Label
        {
            id: titleLabel
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            text: catalog.i18nc("@label", "Welcome to WuxnSlicer")
            color: UM.Theme.getColor("primary_button")
            font: UM.Theme.getFont("huge_bold")
        }

        UM.Label
        {
            id: textLabel
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            width: titleLabel.width + 2 * UM.Theme.getSize("thick_margin").width
            text: catalog.i18nc("@text", "Please follow these steps to set up WuxnSlicer. This will only take a few moments.")
            font: UM.Theme.getFont("medium")
        }

        // Filler item
        Item
        {
            height: UM.Theme.getSize("thick_margin").height
            width: parent.width
        }

        Cura.PrimaryButton
        {
            id: getStartedButton
            anchors.horizontalCenter: parent.horizontalCenter
            text: catalog.i18nc("@button", "Get started")
            onClicked: base.showNextPage()
        }

        // Filler item
        Item
        {
            height: UM.Theme.getSize("thick_margin").height
            width: parent.width
        }
    }
}
