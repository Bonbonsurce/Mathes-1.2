import QtQuick 2.0
import QtQuick.Layouts 1.12

RowLayout {

    spacing: 20

    Repeater {
        id:candles
        model: 40

        Candle {

        }
    }

    property int value: 0
    property int player: 0

    function newGame() {
        for(var j=0;j<40;j++)
            candles.itemAt(j).visible = false
        var i = helper.randboxvalue()
        for(j=0;j<i;j++)
            candles.itemAt(j).visible = true
        value = i
        player = helper.randplayer()
        remotecontrol.count = 0
        remotecontrol.turn = 1 //Установка текущего значения хода
    }


    function one() {
        value -=1
        for (var j = 0;j<40;j++)
            if(candles.itemAt(j).visible == true) {
                candles.itemAt(j).visible = false
                break
            }
    }
    function two() {
        value -=2
        for(var j=0;j<40;j++)
            candles.itemAt(j).visible = false
        for(j=0;j<value;j++)
            candles.itemAt(j).visible = true
    }
    function three() {
        value -=3
        for(var j=0;j<40;j++)
            candles.itemAt(j).visible = false
        for(j=0;j<value;j++)
            candles.itemAt(j).visible = true
    }

}
