import 'dart:convert';
import 'package:bs_project/model/recipse_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final recipeController = TextEditingController();
  final _fieldKey = GlobalKey<FormFieldState>();
  List<RecipeModel> list = [
    RecipeModel(
      energy: 2676.1262775,
      image:
          "https://www.edamam.com/web-img/284/2849b3eb3b46aa0e682572d48f86d487.jpg",
      label: "Pizza Dough",
      url: "http://www.lottieanddoof.com/2010/01/pizza-pulp-fiction-jim-lahey/",
    ),
    RecipeModel(
      energy: 2676.1262775,
      image:
          "https://www.edamam.com/web-img/284/2849b3eb3b46aa0e682572d48f86d487.jpg",
      label: "Pizza Dough",
      url: "http://www.lottieanddoof.com/2010/01/pizza-pulp-fiction-jim-lahey/",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Image.asset(
          "assets/images/logo2.png",
          height: 30,
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/chef.png"),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                    ),
                    child: TextFormField(
                      controller: recipeController,
                      onSaved: (value) {
                        recipeController.text = value!;
                      },
                      key: _fieldKey,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Something";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        hintText: "Search Recipe",
                        filled: true,
                        fillColor: Colors.white,
                        iconColor: Theme.of(context).primaryColor,
                        contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    print("search done");
                    searchRecipe();
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(5),
              height: double.maxFinite,
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      dense: true,
                      tileColor: Colors.white,
                      title: Text(list[index].label!),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(list[index].image!),
                      ),
                      subtitle: Text("Energy:" +
                          list[index].energy!.toStringAsFixed(2) +
                          " Kcal"),
                      onTap: () async {
                        final recipeUrl = list[index].url;
                        print(recipeUrl);
                        if (await canLaunch(recipeUrl!)) {
                          await launch(
                            recipeUrl,
                            // forceWebView: true,
                            // forceSafariVC: true,
                            // enableJavaScript: true,
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 4,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchRecipe() async {
    final appId = "21dd5533";
    final apiKey = "46c521567e3359c41486c1ee95518b02";
    if (_fieldKey.currentState!.validate()) {
      final url = Uri.parse(
          "https://api.edamam.com/search?app_id=${appId}&app_key=${apiKey}&q=${recipeController.text}&from=0&to=15");
      var response = await http.get(url);
      print("called method");
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body)["hits"];
        print(body[4]["recipe"]["calories"]);
        var list1 = [];
        for (int i = 0; i < 10; i++) {
          print(body[i]["recipe"]["label"]);
          print(body[i]["recipe"]["url"]);
          print(body[i]["recipe"]["image"]);
          print(body[i]["recipe"]["calories"]);
          list1.add(RecipeModel(
              energy: body[i]["recipe"]["calories"],
              image: body[i]["recipe"]["image"],
              label: body[i]["recipe"]["label"],
              url: body[i]["recipe"]["url"]));
        }
        setState(() {
          list = list1.cast<RecipeModel>();
        });
      }
      // print(list[4].energy);
    }
  }
}
