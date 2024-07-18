import 'package:flutter/material.dart';
import 'ArticlePage.dart';

class ShopPage extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {
      'title': 'Decathlon',
      'url': 'https://www.decathlon.it/deals',
    },
    {
      'title': 'Nike',
      'url':
          'https://www.nike.com/it/?cp=10371701324_search_&Macro=-nike-g-10574001725-104726557135-e-c-IT-pure-452221806664-kwd-11642601-9181218&ds_rl=1252249&gad_source=1&gclid=Cj0KCQjw-uK0BhC0ARIsANQtgGOCxJ_jBzFjCeRtSC_HoQzdbjZZumTlZjIPTxDAJ53t18r5vnTuoZ4aArIUEALw_wcB&gclsrc=aw.ds',
    },
    {
      'title': 'Under Armour',
      'url':
          'https://www.underarmour.it/it-it/?cid=PS_OMD_IT_1656_27AH83HFZ4_under+armour_p79676503427&gad_source=1&gclid=Cj0KCQjw-uK0BhC0ARIsANQtgGO9Anui6aK_nfQT5enPsfOJRvxE0pFynjNpY4tNAgSLCSep8gLWIKoaArcGEALw_wcB&gclsrc=aw.ds',
    },
    {
      'title': 'Adidas',
      'url': 'https://www.adidas.it/',
    },
    {
      'title': 'New Balance',
      'url':
          'https://www.newbalance.it/it?cq_src=google_ads&cq_cmp=19614965000&cq_con=145968750456&cq_term=new%20balance&cq_net=g&cq_plt=gp&gad_source=1&gclid=Cj0KCQjw-uK0BhC0ARIsANQtgGMRZg4CdbKQCwc-B2dDxjlsBVo_J-DdJrS48wq4Vzw1A1BOP2w87vkaAvxjEALw_wcB&gclsrc=aw.ds',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                title: Text(
                  articles[index]['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.deepOrange,
                  ),
                ),
                trailing:
                    const Icon(Icons.arrow_forward, color: Colors.deepOrange),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ArticlePage(
                        title: articles[index]['title']!,
                        url: articles[index]['url']!,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
