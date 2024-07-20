package states;

import vlc.VLC;
import vlc.MediaPlayer;
import vlc.Media;

class Main {
    static function main() {
        var instance = new VLC([]);
        var player = new MediaPlayer(instance);
        var media = new Media(instance, "path/to/your/video.mp4");
        player.media = media;
        player.play();
    }
}
