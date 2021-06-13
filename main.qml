import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12

Window {
    id:w
    width: 1920
    height: 1080
    maximumHeight: 1080
    maximumWidth: 1920
    minimumHeight: 1080
    minimumWidth: 1920
    visible: true
    title: qsTr("Candles")

    Image {
        id: previous
        source: "qrc:/previous.jpg"
        anchors.fill: parent
        visible: true
        Text {
            text: 'Приветствуем вас, дорогие друзья, в захватывающей игре - "Спички"'
            color: "White"
            font.pointSize: 35
            anchors {
                horizontalCenter: names.horizontalCenter
            }
            visible: true
        }
        Text {
            id:names
            text: "Введите имена:"
            color: "White"
            font.pointSize: 40
            anchors.centerIn: parent
            visible: true
        }
        Toolbar {
            anchors {
                horizontalCenter: names.horizontalCenter
                top: names.bottom
                topMargin: 50
            }

            onChangeNames: change.visible = true
            onStart: {previous.visible = false;fon.visible = true;gameplay.newGame();remotecontrol.playerturn()}
            onRule: rules.visible = true
        }
        Button {
            id:exit
            text: "Quit"
            anchors.right: previous.right
            onClicked: Qt.quit()
        }
        Button {
            id:fs
            Rectangle {
                color: "lightgreen"
                anchors.fill: parent
            }

            text: "fullscreen"
            anchors.right: exit.left
            onClicked: showFullScreen()
        }
        Button {
            id: ns
            text: "window"
            anchors.right: fs.left
            onClicked: showNormal()

        }
    }

    Image {
        id: rules
        anchors.centerIn: parent
        source: "qrc:/rules.jpg"
        visible: false
        Button {
            text: "Quit"
            palette {
                button: "#FFB6C1"
            }

            font.pixelSize: 30
            onClicked: rules.visible = false
            anchors.top: rules.top
            anchors.right: rules.right
        }
    }

    Dialog {
        id: change
        width: 500
        height: 200
        Image {
            source: "qrc:/enternames.jpg"
            anchors.centerIn: change.contentItem
        }
        modal: true
        Text {
            text: "Enter your names: "
            font.pixelSize: 20
            anchors.bottom: player1text.top
            anchors.topMargin: 15

        }

        standardButtons: Dialog.Ok

        property bool vis: false
        property string player1newname: "Hunter "
        property string player2newname: "Bonbon "
        Text {
            id: player1text
            font.pixelSize: 20
            text: "Enter the name of the first player: "
        }
        TextInput{
            Rectangle {
                anchors.fill: parent
                color: "white"
                opacity: 0.5
            }

            id: player1textinput
            font.pixelSize: 20
            text: "Hunter "
            color: "black"
            anchors.left: player2textinput.left
            selectionColor: "white"
            onAccepted: {
               change.player1newname=player1textinput.text
               remotecontrol.name1()
            }
        }

        Text {
            id: player2text
            font.pixelSize: 20
            anchors.top: player1text.bottom
            text: "Enter the name of the second player: "
        }
        TextInput{
            id: player2textinput
            font.pixelSize: 20
            text: "Bonbon "
            anchors.left: player2text.right
            anchors.top: player1textinput.bottom
            Rectangle {
                anchors.fill: parent
                color: "white"
                opacity: 0.5
            }
            onAccepted: {
                change.player2newname=player2textinput.text
                remotecontrol.name2()
            }
        }
        Text {
            anchors.top: player2text.bottom
            font.pixelSize: 20
            text: "Press Enter after you enter the name !!!"
        }
        onClosed: {
            vis=false
        }

        onAccepted: {
            change.player1newname=player1textinput.text
            remotecontrol.name1()
            change.player2newname=player2textinput.text
            remotecontrol.name2()
        }

        anchors.centerIn: parent
        visible:  vis
    }


    Image {
        id: fon
        source: "qrc:/fon.jpg"
        visible: false
        Gameplay {
            id:gameplay
            anchors.centerIn: parent
        }
        Remotecontrol {
            id:remotecontrol
            anchors.top: gameplay.bottom
            anchors.topMargin: 100
            anchors.horizontalCenter: gameplay.horizontalCenter
            onOne: gameplay.one()
            onTwo: gameplay.two()
            onThree: gameplay.three()
            onGameover: {gameover.visible = true;fon.visible = false}
        }
        RemoteControlTop {
            id:remotecontroltop
            anchors.horizontalCenter: gameplay.horizontalCenter
            onNewgame: {fon.visible = false; previous.visible = true}
        }
    }

    Image {
        id:gameover
        source: "qrc:/gameover"
        visible: false
        anchors.fill: parent
        anchors.centerIn: parent
        Button {
            id:newgame
            anchors.left:  gameover.left
            width: 200
            font.pixelSize: 30
            text: "New game"
            palette {button: "ivory"}
            onClicked: {fon.visible = false; gameover.visible = false;previous.visible = true}
        }
        Button {
            id:quit
            anchors.right: gameover.right
            width: 200
            font.pixelSize: 30
            text: "Quit"
            palette {button: "darkorange"}
            onClicked: Qt.quit()
        }
        Text {
            id: winner
            anchors.horizontalCenter: gameover.horizontalCenter
            anchors.top: gameover.top
            anchors.topMargin: 100
            color: "white"
            font.pixelSize: 40
            text: "Выиграл игрок - " + qsTr(remotecontrol.winner)
        }
    }
}
