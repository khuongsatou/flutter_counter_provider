import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider_test/app_model.dart';
import 'package:provider_test/domain/meme_controller.dart';
import 'package:provider_test/domain/models/meme.dart';
import 'package:provider_test/locator.dart';
import 'package:provider_test/main.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Meme meme;

  @override
  void initState() {
    // Access the instance of the registered AppModel
    // As we don't know for sure if AppModel is already ready we use getAsync
    // getIt
    //     .isReady<AppModel>()
    //     .then((_) => getIt<AppModel>().addListener(update));

    getIt
        .isReady<AppModelNew>()
        .then((_) => locator<AppModelNew>().addListener(update));
    // Alternative
    // getIt.getAsync<AppModel>().addListener(update);

    super.initState();
    meme = Meme(id: 0, imageUrl: "", caption: "", category: "");
  }

  @override
  void dispose() {
    locator<AppModelNew>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() => {});

  @override
  Widget build(BuildContext context) {
    print("In File: counter.dart, Line: 43 ${meme.imageUrl} ");
    return Material(
      child: FutureBuilder(
          future: locator.allReady(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.skip_next),
                  onPressed: () async {
                    var memeNew =
                        await locator.get<AppModelNew>().getNextMeme();
                    print("In File: counter.dart, Line: 53 ${memeNew} ");
                    setState(() {
                      meme = memeNew;
                    });
                  },
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'You have pushed the button this many times:',
                      ),
                      Text(
                        getIt<AppModel>().counter.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          height: 150,
                          width: 200,
                          fit: BoxFit.fill,
                          imageUrl: meme.imageUrl,
                          placeholder: (context, url) => Stack(
                            children: const [
                              Positioned(
                                child: Center(
                                  child: SizedBox(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                    width: 10,
                                    height: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    ],
                  ),
                ),
                // floatingActionButton: FloatingActionButton(
                //   onPressed: getIt<AppModel>().incrementCounter,
                //   tooltip: 'Increment',
                //   child: Icon(Icons.add),
                // ),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Waiting for initialisation'),
                  SizedBox(
                    height: 16,
                  ),
                  CircularProgressIndicator(),
                ],
              );
            }
          }),
    );
  }
}
