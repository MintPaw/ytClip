package;

import sys.FileSystem;

class Main
{
	public static var prog:String = "avconv";

	public static function main():Void
	{
		// https://www.youtube.com/watch?v=F3xHo9SXoQI
		// 00:00:17 - 00:00:20

		Sys.println("ytClip by MintPaw");
		Sys.println("");

		var url:String = input("Youtube link");
		Sys.println("Downloading...");
		Sys.command("youtube-dl", [url, "-oraw.mp4" ]);

		Sys.println("");
		Sys.println("Download complete");

		while (true) {
			var startString:String = input("Where would you like to start the split (hh:mm:ss)");
			var lengthString:String = input("How long do you want the clip to be? (in seconds)");

			Sys.println("Splitting...");
			Sys.command('ffmpeg -i raw.mp4 -ss $startString -t $lengthString split.mp4');
			Sys.println("Split complete, review this file at split.mp4");

			var ans:String = input("Is this correct? (y/n)");

			if (ans.toLowerCase() == "y") break;
			FileSystem.deleteFile("split.mp4");
		}

		Sys.command("mkdir parts");
		Sys.println("Converting... 00%");
		// Sys.command("ffmpeg -i split.mp4 -s 480x270 parts/image-%03d.png");
		Sys.command("ffmpeg -i split.mp4 -s 480x270 -pix_fmt rgb24 out_small.gif");
		Sys.command("ffmpeg -i split.mp4 -s 1280x720 -pix_fmt rgb24 out_medium.gif");
		Sys.println("Converting... 10%");

		// ffmpeg -i video.mkv -s 480x270 -f image2 %03d.png
		// ffmpeg -ss 14:55 -i video.mkv -t 5 -s 480x270 -f image2%05d.png
	}

	public static function input(prompt:String):String
	{
		Sys.print(prompt + "> ");
		return Sys.stdin().readLine();
	}
}