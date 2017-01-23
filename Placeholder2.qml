import QtQuick 2.7
import QtQuick.Controls 2.0

Rectangle {
    anchors.fill: parent

    Text{
        anchors.centerIn: parent
        text: "Placeholder2"
    }

    ComboBox{
        id: box2
        anchors.verticalCenter: parent.verticalCenter
        width: 100
        height: 50

        model: ["Test", "test2", "test3"]

    }

}
