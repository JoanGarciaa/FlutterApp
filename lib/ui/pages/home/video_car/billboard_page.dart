import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

class BillBoardPage extends StatefulWidget {
  const BillBoardPage({Key? key}) : super(key: key);

  @override
  State<BillBoardPage> createState() => _BillBoardPageState();
}

class _BillBoardPageState extends State<BillBoardPage> {
  late VideoPlayerController _controller;

  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/videomercedes.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.secondaryColor,
        appBar: AppBar(
          title: const Text(
            "AutoSpecs",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 5.0,
          iconTheme: IconThemeData(color: Colors.secondaryColor),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                alignment: Alignment.center,
                height: 100,
                margin: EdgeInsets.all(5),
                child: Text(
                  'Las ultimas novedades',
                  style: GoogleFonts.montserrat(
                      fontSize: 30, color: Colors.mainColor),
                ),
              ),
              Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Descubre las últimas novedades sobre este impresionante y magnifico Mercedes Clase A.\n \n Más Deportivo\n\n Más Elegante\n\n Más Mercedes',
                  style: GoogleFonts.montserrat(
                      color: Colors.mainColor, fontSize: 17),
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.terciaryColor,
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
