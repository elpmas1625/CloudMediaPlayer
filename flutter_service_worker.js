'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "5a7018b4211b9349b80a993b3165f8e8",
"version.json": "9866adfa6e7bd32fd681b6c1dc17e897",
"index.html": "12c713e33125518a840188a0f3b3f5e4",
"/": "12c713e33125518a840188a0f3b3f5e4",
"main.dart.js": "0d2494b78f16edeef972db4581c8a5cd",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "8fec9ad037728a9b96c732c8dd940976",
".git/config": "e4326069041f3a54e3c33a6d1a3a884d",
".git/objects/0c/7eaca173a071cdc3432e523e2aa9c7f3815a7b": "9933ac9f40bb342fa2558c58f09ee536",
".git/objects/0c/27355f7db48c523fc166a5e278fd868426b481": "e4d0488b6d6a901159dad7491435359d",
".git/objects/57/7946daf6467a3f0a883583abfb8f1e57c86b54": "846aff8094feabe0db132052fd10f62a",
".git/objects/6f/76b99d08091270d38070be30999a1a83a33e05": "59e2f11086e9fee87d76639c2647de0d",
".git/objects/6f/f07c3b644f25f0f8e011396396db16d021d1e2": "69a10c55f7e33423132ff96703fabd8a",
".git/objects/03/0a394d87f12ff62b561224c3f32fb161133dfd": "8f59c25f7dae6477b56507f9e45baf86",
".git/objects/9b/6f1083cf23047337e9585be6b2e8ca26c97d2c": "207de6e44cbe7e690108573de105dab8",
".git/objects/9e/700a4cb2c5744ad899ba206c5b7e7e0053adda": "5acdf10b005a6a6977286b3ab36c4e8a",
".git/objects/6a/8f23feb8809abbb4b013524f5b738568e49846": "0897a23abad3ee182e5aa776a7a6b5a6",
".git/objects/35/96d08a5b8c249a9ff1eb36682aee2a23e61bac": "e931dda039902c600d4ba7d954ff090f",
".git/objects/0b/09dc05a86b930e9a3d6d34caf33a9817cdf032": "0a11268f73ad453d1bcb8d65ee1eab90",
".git/objects/0e/8c476a2d19689acbf89af9fa9b62202721f127": "7aa07801ba2de132f36d10e0e63bdef4",
".git/objects/34/1d861fe3253f116428db6c09de3a622c352257": "f6482cc1d41128beb6bdd604f6965ca6",
".git/objects/5f/2f81c89896db4f3b5a49124f4b47a5d5a7d0e3": "6dad6cab608c454fd26cef80fb98fdf6",
".git/objects/5f/339a99d976897c3af671f4cd9331c2ff744cab": "87accb7528510883cbb3fcc11ae45180",
".git/objects/5f/bf1f5ee49ba64ffa8e24e19c0231e22add1631": "f19d414bb2afb15ab9eb762fd11311d6",
".git/objects/9d/d35d9c2773af74b3b958737ed4daac6f058012": "eed08eabbaaa0221702d032698f04673",
".git/objects/02/1db9747e0154ff454629c9cef6e35b4ffb41e9": "4b51be9502ac373c18e689b98bbd6720",
".git/objects/02/4a5178dbb2b8bc4e935329a9b13edb8c26b703": "e559dedaddc648491bd6d3bb58e0ae7c",
".git/objects/d9/3952e90f26e65356f31c60fc394efb26313167": "1401847c6f090e48e83740a00be1c303",
".git/objects/d9/d183ac9764ac21ccfedb3e133a3888a09f754f": "55e8310ce6ff24d0969b91587d440b0f",
".git/objects/ac/fd36bb6c93fb705b242aefb95f1328474123ff": "6d607d97ec2b63ad68f624f3ac1c0870",
".git/objects/ad/0aa9e3d0bc098d997fb67a966bd18f225b9067": "767272c7ce5cd210bd915fbfd5917523",
".git/objects/d7/7cfefdbe249b8bf90ce8244ed8fc1732fe8f73": "9c0876641083076714600718b0dab097",
".git/objects/d7/4dfbd7737e5898f17972aee2d7b7e963754355": "c9f99f1e9778fc3d6f48888e56ef8bfc",
".git/objects/da/e9f5ff9e2282899ed9693e09dfe001b333a4e2": "b023442fa36a13b72fc1cb2d17ac8c48",
".git/objects/a2/2e2e03dda631c45a88e4859950febcf69d5dcf": "bfa5318db50cb3a0af8a74278753b023",
".git/objects/a5/cd648011d6f1a12a9fe0e86a85947233d43121": "d51c00dda38a3210ee5acd4f655c636c",
".git/objects/a5/de584f4d25ef8aace1c5a0c190c3b31639895b": "9fbbb0db1824af504c56e5d959e1cdff",
".git/objects/d6/bc42012b6ae7b112cddb7744229b93989e66d0": "a34fbb8f71bd3ce33319f449298d0362",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d6/e0911119206ebc5650e6826bd76ded7bd72047": "4606c1c54679edb8d9585cab88df4996",
".git/objects/bc/b96919a96c30a4a92e2414fb6a758c11d8c39e": "7a32e6f422b3f9b7f3d21eda05b92fd2",
".git/objects/d8/117caf24e437fb3f63e41476126dc0b8a01373": "8fb7dccb88fb9bde4528b75ba0b903ba",
".git/objects/d8/9338aef09894e9a7bbaccb0ff1a74be0833ca5": "d9809d0cfaa3075f6107a713d1241f6e",
".git/objects/f3/709a83aedf1f03d6e04459831b12355a9b9ef1": "538d2edfa707ca92ed0b867d6c3903d1",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/fd/c9de7160241270a5c2aec96bd795f504a9691e": "f2a6783dacb78d39a80e71a49dad7036",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/cf/26cc77a249d3585ddf3f98d0a82175e287809d": "8b6040489eff8806e6560be9de19e675",
".git/objects/fe/a43ba4bb6e28de77330f13821c1ee920d44071": "abdd4a17b9129b53d658d64753a78309",
".git/objects/c8/ac2527eede7fb458d7741a869d9b6796de0c74": "346c52028145790926d6d76a1a9dc09b",
".git/objects/c1/aaaff88c7e6fc214f389387bca1d0dacf34407": "2d792a417c1761e3dbe4a65d477597f4",
".git/objects/20/886034fe349625d023e39b3ba55daa05096b55": "839331f9f79b3a0874bbf3609764f4ee",
".git/objects/27/e28dfb94a09d5221af254118fdb6a100cf2fbe": "4e6b636f2b26d988ccc916e13e050744",
".git/objects/4b/9ca146bfca909bd5295f3907f463f9793c8c27": "cbd29a9d33ab10b5bd8ab646968cfb92",
".git/objects/7d/c5537e3409f1a23bd3389ab79be2b2cdec676b": "7320b61416900b658fe6aa92308ba711",
".git/objects/7c/80bd2cb9a9d3139a900a7bf038940d56367ed6": "78312d5c7e32dde550d431e18d7f52af",
".git/objects/45/edf9bbff928349b3fef1915d7c66b19b64c10a": "0536a2410a1e4a9dc3f0aa3a6204f3c7",
".git/objects/8f/c8be62f202c40e7d3e2e16242fb065cfc4e1a7": "6fda1b80da67a8d96186cf8ab8b24087",
".git/objects/8a/51a9b155d31c44b148d7e287fc2872e0cafd42": "9f785032380d7569e69b3d17172f64e8",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/7e/605da6e2e6fefc3eb5c3a66255c47047b4f5e1": "e5d70024630d906e3b8a7ad415280f12",
".git/objects/26/66251fab0a3754e17794ebffe343d1ce5bdff6": "a4fb4869e50ceae5ac6bafd2c72505ca",
".git/objects/26/276be5ee9c0e96e845ed513268e9956aa50367": "f7a7f20da565ca8c300695b8cbdc38ab",
".git/objects/21/b7017e1d23008500e566b6f31f3e9375bb3aa3": "2c6091dbc26ae5067238ffebd96eb57b",
".git/objects/81/090afcd666bdc1200742f40d5e7048521bd995": "e0a76a6d5e313756e6644bdc4ee965ce",
".git/objects/86/eb6f75a9e6dd466022e0f6783bd3bd3c49c955": "81383a62809d7fce992b185082d4ee92",
".git/objects/44/0c3a067ea3a65b2df8e25f8a48aa6338dc6a67": "35ad3636d200570a1a77db8dbb4cb887",
".git/objects/44/437396026404f9ada7b8ca84fb92455f21157f": "33f98c04d165d14000f45e47fd949721",
".git/objects/2a/e0b76495938a4d75b707a86441b55a0c5e3fe2": "182592139520e7126111428fa848e39a",
".git/objects/2f/2c539513ee778473b93290ccc54ef657fb0849": "95a6ccab451303b8acc3aba719cc5568",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/88/c9193a572cbcd385a7f2c67c20a094729eb486": "731c4df147850ad106136f9b62594b50",
".git/objects/9f/0941e83510f21c79e890b02ad0225371b35ce1": "4a56d92534535a97d32d522e0d1b4cc0",
".git/objects/6b/57605f6b783abb4e9e840266f06d587273009f": "2bd60b7b838e02d086e9b2ce9abbaad0",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/07/8f1df65cdf1d64e0a6dd1291a590487a5a90ce": "45785bea1268b489fedd3193a18ef025",
".git/objects/6e/bd0b4bee3ad8a685ffcdf9c703c3794cb4c9de": "9ff2ff7c42a7c66c35778d19825564f3",
".git/objects/6e/f7ce10a4d344f36384f8473e92a877d20656e0": "4ccaffd56683e7832524d34d843ec053",
".git/objects/5c/30c9f1e9a5906bf17f6d60239b0f11496ca2d1": "c33f94a2ed1e7a481d0bb3ae1d59ac76",
".git/objects/91/4a40ccb508c126fa995820d01ea15c69bb95f7": "8963a99a625c47f6cd41ba314ebd2488",
".git/objects/65/92ea97fb9ac83e441b873162f02881a1b55879": "aa1c175fc8b1fbbf012c48d70b79bdec",
".git/objects/62/3a2f23873cf4f1392a6c0339775c7202894843": "74c08d0d02998461f2535f008dbf2814",
".git/objects/96/ed1586d98c97120e5b55b500858e3d2bcce54a": "8160a72e390047a7459a5d7c81ab3cec",
".git/objects/54/fd69d0dc19df2e9fb231939758298054bccddd": "9ee322ff9734c7e8fb7baf749c703e24",
".git/objects/98/001f8429113eeb6b474640d286fcdac3e6d09a": "b0cef4b6ce642b182032b96bf952b19e",
".git/objects/53/36c01676c31574be50df68b1a89957172da6cc": "0f8dc735eb85c5b75fe2169ae2006c71",
".git/objects/53/041d66d150d4728b0eb37239ef3c270b6be4a5": "fd12d1ea180409f0e9c612d491928775",
".git/objects/3f/f845bda59bfd7a3b96475fb80e3a501a74d0e1": "62a37699c1b3b8cd6822f59f367f45d0",
".git/objects/08/3b94153a6bc1f550d41cd5f803a059f07b2f17": "c9c0e3be58ec2e7dde01fdcf188d2442",
".git/objects/06/74265a8444bbdaa7668c5b7549c25e6bad6bb7": "6682304ff708ba6dd9d75408ad2c3598",
".git/objects/39/f72a7d1bb997a564c848154a942482f831b8a4": "aaa492f6b3a3344e43a41de77098746f",
".git/objects/63/babeec2f04302b5f212614a0fd786b70a076b3": "a61001ca6b977cbd2623ceb0754acb15",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/dc/8c6257c1e4698da28e595d368950d67405d8b5": "a03135d2e11ee2813e537101368b25ff",
".git/objects/b7/da216c89009ceb5fa7f1b4ccb9e5ea584fa5b6": "87b0c4cbc0d8b799df3a50cce3dd305e",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/a8/8c9340e408fca6e68e2d6cd8363dccc2bd8642": "11e9d76ebfeb0c92c8dff256819c0796",
".git/objects/b0/61ab34af9cccd8f22eee9c95223ec459b5471c": "325958053518b5452fe23cf3735938f9",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ef/b875788e4094f6091d9caa43e35c77640aaf21": "27e32738aea45acd66b98d36fc9fc9e0",
".git/objects/ea/f7fce6a7d1f3458a29bab7e10348764cc6b985": "d6972a43db3661c00d9893ef2126ac97",
".git/objects/ea/1ffc097d084c9a9e1a725de6b065c66fcd5b65": "a014b8fddeb37d71fb6caa500c9be993",
".git/objects/cd/7a136f5de3ab8ea4d719cb0716d5046b306d19": "61d5d36a23c03496e7c0a9a9131cd267",
".git/objects/e6/cc1238dbc0b7ccf7f9688c5ed49177fcfbf8c9": "9cc5a5efdd3c45e2b3243d052fb3b9f1",
".git/objects/e6/13a277e678fd22323faab32b480126ca7693c7": "284715a9d6d3b387d9f085eccc4ab534",
".git/objects/f7/a8e91689d710cc251f86240a394ae3c91c7f24": "6c2e96977c951b7f265dfb01f9fc5194",
".git/objects/e8/a0c57cd7afe5f1f09afcd5364fb30e2fca2c79": "5c0e9d370cf7f03964780e7e6bad5662",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/ce/9c1b988f2eadb6e84939fae6c48f80db902562": "1ac4f563841abeee710a9c2f4fb6e956",
".git/objects/e0/d26703885ad728cccac8169c46ead0e698ee3d": "8f11ab4d27508ebf84b76bb772f4a0f9",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/4a/eb7dd389b09b03f967e4e58d11551257097841": "558eed8672898d53805b5eaaccd05d04",
".git/objects/8d/8dc6facf53d70a288c67e14a15070c4349d486": "57083411777bc0298671041d01a57540",
".git/objects/8c/7ebab9a3e3fb605e7d4de27cf2a55dfdae68f0": "9adf5238c375081da7f9fd170f3e3376",
".git/objects/1d/468b85698a60041b450286f31b3264b3bbd6f7": "5c8c497111befde32ac151f14cf92f85",
".git/objects/82/d26b1b6ed10d3c103edb8e2e59aa865b435414": "d7ed9cdc3d0bdc09b1fb01102089ea23",
".git/objects/40/d188d5ee7ec4c51a0fd7506e58724fce070cc4": "8e18246bd3cf1a10b1c132d52dc9c38c",
".git/objects/40/1184f2840fcfb39ffde5f2f82fe5957c37d6fa": "1ea653b99fd29cd15fcc068857a1dbb2",
".git/objects/47/7271464474134b97a927625cd7a6973c7cb5e8": "638148866020ccbf55f87eb75daef4a6",
".git/objects/47/4230ce50f9db162e49cdd7065f62542d66a318": "ab35feab9131b0155916c520dc6e4b88",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "4d7b3f8709b049a036576c07c26b79c9",
".git/logs/refs/heads/gh-pages": "4d7b3f8709b049a036576c07c26b79c9",
".git/logs/refs/remotes/origin/gh-pages": "5958c824b0fd6e1cafad0bb6ebe1f644",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/gh-pages": "16de9a871665793e82c4eb79d30be23d",
".git/refs/remotes/origin/gh-pages": "16de9a871665793e82c4eb79d30be23d",
".git/index": "25ab77fd2bf9127391a2ef32fa318d11",
".git/COMMIT_EDITMSG": "560b4c8e1b31f3eabc8cf2ee0fcc716d",
"assets/AssetManifest.json": "af8908a221aec821fd6abe2f2a913f28",
"assets/NOTICES": "7400b3624db47e3fbd76fec5659433b7",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "f0fd10570c0579ab2a1a45fab4ac9658",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "0081d91a94c16e8b6d1c2207dd8aac4e",
"assets/fonts/MaterialIcons-Regular.otf": "4893077ba5db81778be22dbb1a593980",
"assets/assets/music/Mr.FanTastiC-Sweet%2520sweet%2520candy%2520time%255BMV%255D.mp3": "cd05f6a1e0da4244b8684b6daf215612",
"assets/assets/music/%25E8%258F%2585%25E5%258E%259F%25E5%259C%25AD%25C2%25A0-%25C2%25A0%25E6%25B7%25B1%25E9%25A6%2599%25C2%25A0(Official%25C2%25A0Video).mp3": "d628f297656a8c1dc4084f0a3dc7ad12",
"assets/assets/music/%25E6%259D%25B1%25E4%25BA%25AC%25E3%2582%25B5%25E3%2583%259E%25E3%2583%25BC%25E3%2582%25BB%25E3%2583%2583%25E3%2582%25B7%25E3%2583%25A7%25E3%2583%25B3.mp3": "4910e308484f5d78befb72d87ad065fe",
"assets/assets/music/%25E5%2588%259D%25E6%2581%258B%25E3%2581%25AE%25E7%25B5%25B5%25E6%259C%25AC.mp3": "9005406033e300e67108d5a373a76bab",
"assets/assets/music/%25E6%25A4%258E%25E5%2590%258D%25E6%259E%2597%25E6%25AA%258E%2520-%2520%25E9%2595%25B7%25E3%2581%258F%25E7%259F%25AD%25E3%2581%2584%25E7%25A5%25AD%2520from%25E7%2599%25BE%25E9%25AC%25BC%25E5%25A4%259C%25E8%25A1%258C.mp3": "e1e12deef649449ff9437ad26dad5a36",
"assets/assets/music/%25E3%2580%2590FUJIROCK%25E3%2580%2591KOTORI%25E2%25A7%25B8RED%25E3%2580%25902023%25E3%2580%2591.mp3": "39a5c5f9db4d3f4e241bdc4eaa840ef3",
"assets/assets/music/%25E3%2581%2582%25E3%2582%258B%25E5%2591%25AA%25E6%2596%2587.mp3": "7ad378a208ab7997b957430242bbc065",
"assets/assets/music/%25E5%25BF%2583%25E5%2581%259A%25E3%2581%2597.mp3": "34edb243172bc0d28cb6f5ee58369b94",
"assets/assets/music/%25E3%2583%259B%25E3%2582%2599%25E3%2582%25A4%25E3%2583%25AB.mp3": "a6b73c751e43436583453022e245378c",
"assets/assets/music/%25E5%258F%25A4%25E5%25B7%259D%25E6%259C%25AC%25E8%2588%2597%25E3%2580%258Cdepends%2520feat.%25E3%2582%25AD%25E3%2582%25AF%25E3%2583%2581%25E3%2583%25AA%25E3%2583%25A7%25E3%2582%25A6%25E3%2582%25BF%2520%2520(Music%2520Video)%25E3%2580%258D.mp3": "3512fcb3b68e6a2aa6df4716f0f268c9",
"assets/assets/music/I%2520believe%2520%25EF%25BD%259E%25E6%25B5%25B7%25E3%2581%25AE%25E5%25BA%2595%25E3%2581%258B%25E3%2582%2589%25EF%25BD%259E.mp3": "fe8c1ba59157bf99439f061a0ec7189a",
"assets/assets/music/%25E5%258F%25A4%25E5%25B7%259D%25E6%259C%25AC%25E8%2588%2597%25E3%2580%258COrdinaries%2520feat.%25E5%258F%25A4%25E5%25B7%259D%25E4%25BA%25AE%2520(Music%2520Video)%25E3%2580%258D.mp3": "b2be5feea18016bc0b634b59ec0f3d0c",
"assets/assets/music/11%2520vapor%2520lamp%2520(feat.%2520%25E8%258F%2585%25E5%258E%259F%25E5%259C%25AD).mp3": "0dce6cfba26c1b5fefd972d044ee57e0",
"assets/assets/music/%25E3%2582%25BD%25E3%2583%25AF%25E3%2583%25AC%2520%25E2%25A7%25B8%2520%25E6%2598%259F%25E8%25A1%2597%25E3%2581%2599%25E3%2581%2584%25E3%2581%259B%25E3%2581%2584(official).mp3": "e430c76c47263e5c214731231b2b3f92",
"assets/assets/music/%25E3%2582%25BB%25E3%2583%2595%25E3%2582%259A%25E3%2583%2586%25E3%2583%25B3%25E3%2583%258F%25E3%2582%2599%25E3%2583%25BC%2520-%2520%25E6%259C%25AD%25E5%25B9%258C%2520version%2520-.mp3": "e848654b4a39f33cd5f9986d53563f66",
"assets/assets/music/%25E8%25BB%25A2%25E6%25A0%25A1%25E5%2589%258D%25E5%25A4%259C.mp3": "b6675f4880222ee52192c72d36250d84",
"assets/assets/music/Orangestar%2520-%2520Nadir%2520(feat.%2520IA)%2520Official%2520Video.mp3": "654bf6933e7186a6ce19ffcadb695324",
"assets/assets/music/%25E7%2599%25BD%25E6%25B3%25A2%25E3%2583%2588%25E3%2583%2583%25E3%2583%2595%25E3%2582%259A%25E3%2582%25A6%25E3%2582%25A9%25E3%2583%25BC%25E3%2582%25BF%25E3%2583%25BC.mp3": "81e29a5cd884811455f3993bc09a30f4",
"assets/assets/music/kazama.mp3": "82ee09b1da9ecc41d0c9e64f9716a453",
"assets/assets/music/%25E3%2581%2595%25E3%2582%2588%25E3%2581%25AA%25E3%2582%2589%25E3%2581%25AF%25E3%2582%25A8%25E3%2583%25A2%25E3%2583%25BC%25E3%2582%25B7%25E3%2583%25A7%25E3%2583%25B3.mp3": "fc4f818d0dff7e9bfb66d061d40b84c1",
"assets/assets/music/ARARE%2520-%2520ADVISE%2520(unofficial).mp3": "5d92d4a4cae827d9db15d9ddb04165e2",
"assets/assets/music/Eric%2520Clapton%2520-%2520Tears%2520In%2520Heaven%2520(Official%2520Video).mp3": "712c5f85e231447f6b3a581868318982",
"assets/assets/music/%25E7%2594%259F%25E3%2581%258D%25E3%2582%258B%25E3%2582%2588%25E3%2581%2599%25E3%2581%258B%25E3%2582%2599%2520%25E2%25A7%25B8%2520Covered%2520by%2520%25E5%25B0%258F%25E9%259B%2580%25E3%2581%25A8%25E3%2581%25A8.mp3": "2106abba0b6d83833c3ea15cade2eef0",
"assets/assets/music/UVERworld%25E3%2580%2580%25E3%2580%258ETHE%2520OVER%25E3%2580%258F.mp3": "95ac08b54e1a3b8884bd6acf0f08132d",
"assets/assets/music/etxrnall%2520-%2520your%2520love%2520is%2520my%2520drug%2520(8bit%2520slowed).mp3": "aeeb2a67f87b3901d7444cb4609769c2",
"assets/assets/music/Parting%2520Gift.mp3": "ce6adc355e25f1da6e88d9f968affa48",
"assets/assets/music/%25E3%2583%258F%25E3%2583%258A%25E3%2583%25AC%25E3%2582%25AF%25E3%2582%2599%25E3%2583%259F%25E3%2580%258C%25E5%25AE%25B6%25E6%2597%258F%25E3%2581%25AE%25E9%25A2%25A8%25E6%2599%25AF%25E3%2580%258D.mp3": "88e6e491b0d7cbf6f0360087222de2da",
"assets/assets/music/rikkenbakka-.mp3": "42210620be62a769d394a3789f56b729",
"assets/assets/music/%25E3%2580%258E%2520%25E3%2583%258F%25E3%2583%258A%25E3%2582%25BF%25E3%2583%258F%25E3%2582%2599%2520%25E3%2580%258F%25E2%25A7%25B8%2520MIMI%2520feat.%2520%25E5%258F%25AF%25E4%25B8%258D.mp3": "67eb253242dbfa53e9892d92cc015817",
"assets/assets/music/mugs%2520(feat.%2520630).mp3": "5d12b04ef28a504bffb5cd214222ec57",
"assets/assets/music/%25E3%2583%2595%25E3%2582%259A%25E3%2583%25A9%25E3%2583%2588%25E3%2583%258B%25E3%2583%2583%25E3%2582%25AF%25E3%2583%25BB%25E3%2583%25A9%25E3%2582%25A6%25E3%2582%2599.mp3": "cfcae9a48416fd6087e7696f9fbad79e",
"assets/assets/music/%25E3%2582%25B5%25E3%2583%25A8%25E3%2583%258A%25E3%2583%25A9COLOR%2520%25E2%25A7%25B8%2520SUPER%2520BUTTER%2520DOG%2520%2520full%2520covered%2520by%2520%25E6%2598%25A5%25E8%258C%25B6.mp3": "1e98e31abeaa9fcec27f1362937e0770",
"assets/assets/music/%25E5%2590%259B%25E3%2581%25AB%25E4%25B8%2596%25E7%2595%258C%2520-%2520Eve%2520MV.mp3": "fb02b21add425893498268bacd2d4706",
"assets/assets/music/Butter-Fly%25E3%2580%2580%25E6%25AD%258C%25E3%2581%25A3%25E3%2581%25A6%25E3%2581%25BF%25E3%2581%259F%25E3%2581%25AE%25E3%2581%25AF%25E3%2583%25A1%25E3%2582%25AB%25E3%2582%2599%25E3%2583%2586%25E3%2583%25A9%25E3%2583%25BB%25E3%2582%25BB%25E3%2582%2599%25E3%2583%25AD.mp3": "f37b19110155d04e9b518ffe5e342f6a",
"assets/assets/music/%25E5%258F%25A4%25E5%25B7%259D%25E6%259C%25AC%25E8%2588%2597%25E3%2580%258C%25E4%25B8%2589%25E5%2588%2586%25E5%258D%258A%2520(feat.%2520mm.)%25E3%2580%258DMusic%2520Video.mp3": "c06b7d23d4287c3f34d8e5edbd2eb113",
"assets/assets/music/%25E5%2583%2595%25E3%2581%25AF%25E4%25BB%258A%25E6%2597%25A5%25E3%2582%2582%2520%25E2%25A7%25B8%2520Vaundy%2520%25EF%25BC%259AMUSIC%2520VIDEO.mp3": "b52230f3206fe2f9d88f250a51cdebe0",
"assets/assets/music/kawaranaimono.mp3": "62fa311e3631a035ac72019197dfef55",
"assets/assets/music/%25E3%2582%25A2%25E3%2582%25A4%25E3%2583%2586%25E3%2582%2599%25E3%2583%25B3%25E3%2583%2586%25E3%2582%25A3.mp3": "6ebca63eaeb7c5aa8ff6201c1860d376",
"assets/assets/music/Mr.FanTastiC%2520-%2520%25E3%2583%25A8%25E3%2583%25AB%25E3%2583%258E%25E3%2583%2595%25E3%2582%2599%25E3%2583%25AB%25E3%2583%25BC%25E3%2582%25B9%255BLyric%2520Video%255D.mp3": "1ff2a1f4b74ea22fef6373d8fdfb678e",
"assets/assets/music/KOTORI%2520%25E3%2580%258CRED%25E3%2580%258D%2520Official%2520Music%2520Video.mp3": "ae7d0c9cf2e5643b6f9e9ff240c13b57",
"assets/assets/music/%25E3%2583%25A2%25E3%2583%258E%25E3%2582%25AF%25E3%2583%25AD%25E3%2583%2588%25E3%2582%25A6%25E3%2582%25AD%25E3%2583%25A7%25E3%2583%25BC.mp3": "5b7d784b710cf85e086e2030ca36a395",
"assets/assets/music/%25E3%2582%25BF%25E3%2583%2595%25E3%2582%2599%25E3%2583%25AC%25E3%2583%2583%25E3%2583%2588.mp3": "5476e37bc2c2d84b63a82a74049190e2",
"assets/assets/music/RADWIMPS%2520-%2520%25E6%2598%25A5%25E7%2581%25AF.mp3": "573ce86a34089ca795f643da33f109e2",
"assets/assets/music/Franchouchou%2520%25E3%2583%2595%25E3%2583%25A9%25E3%2583%25B3%25E3%2582%25B7%25E3%2583%25A5%25E3%2582%25B7%25E3%2583%25A5%2520-%2520TO%2520MY%2520DEAREST%2520%25EF%25BD%259C%2520Zombie%2520Land%2520Saga%2520%25EF%25BD%259CLYRICS%25EF%25BD%259C%2520Kan%25E2%25A7%25B8Rom%25E2%25A7%25B8Eng.mp3": "3de9c8c0365a4aaebb4e0ba3d2232244",
"assets/assets/music/%25E3%2583%25A8%25E3%2583%25AB%25E3%2582%25B7%25E3%2582%25AB%2520-%2520%25E5%25BF%2598%25E3%2582%258C%25E3%2581%25A6%25E3%2581%258F%25E3%2581%259F%25E3%2582%2599%25E3%2581%2595%25E3%2581%2584%25EF%25BC%2588OFFICIAL%2520VIDEO%25EF%25BC%2589.mp3": "8172dcad88d5444abe38a249e4f96c69",
"assets/assets/music/lovesong.mp3": "e9b5d448d7dec2413c59180842d5341e",
"assets/assets/music/%25E5%25A5%25A5%2520%25E8%258F%25AF%25E5%25AD%2590%25EF%25BC%258F%25E3%2582%25AB%25E3%2582%2599%25E3%2583%25BC%25E3%2583%258D%25E3%2583%2583%25E3%2583%2588(%25E5%25BC%25BE%25E3%2581%258D%25E8%25AA%259E%25E3%2582%258A).mp3": "05efd973edbd1885ef860402abe82571",
"assets/assets/music/%25E3%2582%25B5%25E3%2582%25AB%25E3%2583%258A%25E3%2582%25AF%25E3%2582%25B7%25E3%2583%25A7%25E3%2583%25B3%25E3%2580%258Cyears%25E3%2580%258D%25E3%2580%2580-Music%2520Video-.mp3": "2f182c57c9207324f161c0811e366430",
"assets/assets/music/SKIP.mp3": "7802988511d3d856dac880eeba33059e",
"assets/assets/music/%25E3%2582%25B5%25E3%2582%25AB%25E3%2583%258A%25E3%2582%25AF%25E3%2582%25B7%25E3%2583%25A7%25E3%2583%25B3%2520%25E2%25A7%25B8%2520%25E3%2583%2595%25E3%2582%259A%25E3%2583%25A9%25E3%2583%2588%25E3%2583%25BC%25E3%2580%2580-Music%2520Live%2520Video-.mp3": "e990c03d960a9e308ca69c4a1962c27e",
"assets/assets/music/%25E6%259C%25AA%25E6%2598%258E.mp3": "37726e5307e9b1caa36a13c6dd2a8736",
"assets/assets/music/%25E9%2599%25BD%25E7%2582%258E.mp3": "0a26644ee5dd8b225dca435245c6d78d",
"assets/assets/music/Ryrie.mp3": "7b1041e9bde25182e8efe3d9bb595219",
"assets/assets/music/%25E3%2581%25AF%25E3%2581%2584%25E3%2582%2588%25E3%2582%258D%25E3%2581%2593%25E3%2582%2593%25E3%2581%25A6%25E3%2582%2599%2520%25E2%25A7%25B8%2520%25E3%2581%2593%25E3%2581%25A3%25E3%2581%25A1%25E3%2581%25AE%25E3%2581%2591%25E3%2582%2593%25E3%2581%25A8%2520MV.mp3": "38a357515c69238f6bc8f73175feff02",
"assets/assets/music/%255BBUMP%2520OF%2520CHICKEN%255D%2520voyager%2520+%2520flyby%2520LIVE%2520KOR%25E2%25A7%25B8JPN.mp3": "f95e6c5a39b1316b2c637394a4c9ecc3",
"assets/assets/music/%25E6%259C%25AA%25E6%2598%258E%2520(%25E5%25BC%25BE%25E3%2581%258D%25E8%25AA%259E%25E3%2582%258AVer.).mp3": "c46ff9cb3c684d42eb76ada733a6b9f7",
"assets/assets/music/%25E3%2583%2592%25E3%2582%2599%25E3%2582%25AA%25E3%2583%2588%25E3%2583%25BC%25E3%2583%2595%25E3%2582%259A.mp3": "75dff8b157a9726c368e1a418eefd377",
"assets/assets/music/W%25E2%25A7%25B8X%25E2%25A7%25B8Y%2520%25E2%25A7%25B8%2520%25E5%25B8%25B8%25E9%2597%2587%25E3%2583%2588%25E3%2583%25AF(cover).mp3": "7de21ba0dc4e173620c0beb4d26a330b",
"assets/assets/music/%25E3%2582%25B5%25E3%2582%25AB%25E3%2583%258A%25E3%2582%25AF%25E3%2582%25B7%25E3%2583%25A7%25E3%2583%25B3%2520%25E2%25A7%25B8%2520%25E7%259B%25AE%25E3%2581%258B%25E3%2582%2599%25E6%2598%258E%25E3%2581%258F%25E8%2597%258D%25E8%2589%25B2%25E3%2580%2580-Music%2520Video-.mp3": "263a9caabdaaa9e72c2f519e96c8ef04",
"assets/assets/music/%25E3%2582%25B5%25E3%2582%25AB%25E3%2583%258A%25E3%2582%25AF%25E3%2582%25B7%25E3%2583%25A7%25E3%2583%25B3%2520-%2520%25E3%2582%25A8%25E3%2583%25B3%25E3%2583%2588%25E3%2582%2599%25E3%2583%25AC%25E3%2582%25B9%25EF%25BC%2588MUSIC%2520VIDEO%25EF%25BC%2589%2520-BEST%2520ALBUM%25E3%2580%258C%25E9%25AD%259A%25E5%259B%25B3%25E9%2591%2591%25E3%2580%258D(3%25E2%25A7%25B828release)-.mp3": "a355b55b1cc5b554793c7e039bb400ed",
"assets/assets/music/%25E3%2583%258D%25E3%2583%2595%25E3%2582%259A%25E3%2583%2588%25E3%2582%25A5%25E3%2583%25BC%25E3%2583%258C%25E3%2582%25B9.mp3": "c1ed3ff3bb9e6aebe72a8f0f55d16572",
"assets/assets/music/%25E9%2587%2591%25E6%259B%259C%25E6%2597%25A5%25E3%2581%25AE%25E3%2581%258A%25E3%2581%25AF%25E3%2582%2588%25E3%2581%2586.mp3": "7f72b8b88a6062891c0c24ada629fe40",
"assets/assets/music/cinema.mp3": "0bc342eb78c7fafaf7bd411d676fb340",
"assets/assets/music/%25E3%2580%2590%25E5%258F%25A4%25E5%25B7%259D%25E6%259C%25AC%25E8%2588%2597%2520%25C3%2597%2520%25E5%2588%259D%25E9%259F%25B3%25E3%2583%259F%25E3%2582%25AF%25E3%2580%2591%25E3%2581%25AF%25E3%2581%25AA%25E3%2582%258C%25E3%2580%2581%25E3%2581%25AF%25E3%2582%2599%25E3%2581%25AA%25E3%2582%258C-reprise-%2520%25E3%2580%2590English%2520&%2520Romaji%25E3%2580%2591.mp3": "2b2ff9aab12c83aa082c4d6379f39e09",
"assets/assets/music/%25E3%2582%25B1%25E3%2583%2595%25E3%2582%259A%25E3%2583%25A9%2520%25E2%25A7%25B8%2520%25E3%2581%2593%25E3%2582%258C%25E3%2581%258B%25E3%2582%2589%25E3%2581%25AE%25E3%2581%2593%25E3%2581%25A8%25EF%25BC%2588Lyric%2520Video%25EF%25BC%2589.mp3": "1df4b95137f8b6bc7897f76fa2ac0ac0",
"assets/assets/music/MOROHA%25E3%2580%258C%25E3%2582%25A8%25E3%2583%25AA%25E3%2582%25B5%25E3%2582%2599%25E3%2583%2598%25E3%2582%2599%25E3%2582%25B9%25E3%2580%258D.mp3": "d4aae8529d79b7a3d9a3a2e730b52501",
"assets/assets/music/%25E3%2583%258A%25E3%2582%25A4%25E3%2583%2588%25E3%2583%25BB%25E3%2582%25A2%25E3%2583%25B3%25E3%2583%2588%25E3%2582%2599%25E3%2583%25BB%25E3%2582%25BF%25E3%2582%2599%25E3%2583%25BC%25E3%2582%25AF.mp3": "8fe3eaca7d4c62dbf5b192d81c77235d",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "80806576fa1056b43dd6d0b445b4b6f7",
"canvaskit/canvaskit.js.symbols": "68eb703b9a609baef8ee0e413b442f33",
"canvaskit/skwasm.wasm": "f0dfd99007f989368db17c9abeed5a49",
"canvaskit/chromium/canvaskit.js.symbols": "5a23598a2a8efd18ec3b60de5d28af8f",
"canvaskit/chromium/canvaskit.js": "ba4a8ae1a65ff3ad81c6818fd47e348b",
"canvaskit/chromium/canvaskit.wasm": "64a386c87532ae52ae041d18a32a3635",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "6cfe36b4647fbfa15683e09e7dd366bc",
"canvaskit/canvaskit.wasm": "efeeba7dcc952dae57870d4df3111fad",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
