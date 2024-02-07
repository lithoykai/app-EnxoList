import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/domain/response/product_response.dart';

List<Map<String, dynamic>> fakeProductHttpResponse = [
  {
    "id": "-NZTSmXLgyrj864irMYn",
    "category": 0,
    "image":
        "https://firebasestorage.googleapis.com/v0/b/enxoval-app.appspot.com/o/local_image%2FConjunto%20de%20Panelas?alt=media&token=2e7ab06e-dbc7-4510-8e59-fe84cb8c4c09",
    "name": "Conjunto de Panelas",
    "price": 820,
    "urlLink":
        "https://www.amazon.com.br/Panelas-8Pcs-C-L-Smart-Plus/dp/B07C4NLYSH/ref=mp_s_a_1_1?crid=3LF4HFUB8FTLM&keywords=jogo+de+panelas+ceramica&qid=1685408990&sprefix=jogo+de+panela%2Caps%2C228&sr=8-1&ufe=app_do%3Aamzn1.fos.25548f35-0de7-44b3-b28e-0f56f3f96147#aw-udpv3-customer-reviews_feature_div",
    "wasBought": false
  },
  {
    "id": "-NZcKUrmYS_UwnSZELQm",
    "category": 0,
    "image":
        "https://firebasestorage.googleapis.com/v0/b/enxoval-app.appspot.com/o/local_image%2FFaqueiro?alt=media&token=1d442323-efa5-484d-b600-9fad98482091",
    "name": "Faqueiro",
    "price": 200,
    "urlLink":
        "https://m.casasbahia.com.br/faqueiro-48-pecas-tramontina-laguna-em-aco-inox-com-alto-brilho-2182591/p/2182591?utm_medium=Cpc&utm_source=GP_PLA&IdSku=2182591&idLojista=10037&tipoLojista=1P&&utm_campaign=gg_pmax_inter_utld_apostas&gclid=CjwKCAjwoqGnBhAcEiwAwK-OkdbE0dyYxLMEwNkVljDqYpJp0aGoW7P3PKL5Jq58zSXMTig5wtWJ_BoCtQkQAvD_BwE&gclsrc=aw.ds",
    "wasBought": true
  },
];

List<ProductEntity> fakeProducts = [
  ProductEntity(
    name: 'Cama',
    wasBought: true,
    price: 2.500,
    category: 1,
    id: '-NZcKUrmYS_UwnSZELQm',
    image: 'http://google.com',
    urlLink: 'https://amazon.com',
  ),
  ProductEntity(
    name: 'Cozinha',
    wasBought: true,
    price: 3.500,
    category: 2,
    id: '-NZcKUrmYS_UwnSZELQm',
    image: 'http://google.com',
    urlLink: 'https://amazon.com',
  ),
];

ProductResponse responseProduct = ProductResponse(data: fakeProducts);
