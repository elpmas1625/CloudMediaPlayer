'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "2a01b6a8043fbf867101cc519bbb479a",
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
