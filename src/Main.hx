package;

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
		Sys.command("youtube-dl", ["https://www.youtube.com/watch?v=hICY79NlJNM", "-oraw.mp4" ]);

		Sys.println("");
		Sys.println("Download complete");

		while (true) {
			var startString:String = input("Where would you like to START the split (hh:mm:ss)");
			var endString:String = input("Where would you like to END the split (hh:mm:ss)");

			var startSec:Int = Std.parseInt(startString.split(":")[0]) * 3600 + Std.parseInt(startString.split(":")[1]) * 60 + Std.parseInt(startString.split(":")[3]);
			var endSec:Int = Std.parseInt(endString.split(":")[0]) * 3600 + Std.parseInt(endString.split(":")[1]) * 60 + Std.parseInt(endString.split(":")[3]);

			Sys.println("Splitting...");
			Sys.command("ffmpeg", ["-ss " + Std.string(startSec), "-t " + Std.string(endSec - startSec), "-i raw.mp4" ,"-vcodec copy", "-acodec copy", "split.mp4"]);
			Sys.println("Split complete, review this file at split.mp4");

			var ans:String = input("Is this correct? (y/n)");

			if (ans.toLowerCase() == "y") break;
		}

		Sys.println("Converting... 00%");
		Sys.command("mkdir", ["parts"]);
		Sys.command("ffmpeg", ["-i raw.mp4", "-s 480x270", "-f parts/image2 %03d.png"]);
		Sys.println("Converting... 10%");

		// ffmpeg -i video.mkv -s 480x270 -f image2 %03d.png
		// ffmpeg -ss 14:55 -i video.mkv -t 5 -s 480x270 -f image2 %03d.png
	}

	public static function input(prompt:String):String
	{
		Sys.print(prompt + "> ");
		return Sys.stdin().readLine();
	}
}