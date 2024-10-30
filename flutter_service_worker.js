'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "bd8bc97e4848f4f71bad5bc711fa430a",
"version.json": "638d67793299407e12bb3807b19cb60c",
"index.html": "8ec7ef207c35278ea4538975f273c5e2",
"/": "8ec7ef207c35278ea4538975f273c5e2",
"main.dart.js": "6e2d6f6458b972f8cdec9f47d329b6f7",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "3d92482e14bada0c2ba5b0f0eabc2a2b",
".git/AUTO_MERGE": "61a46accc5521e9b8f88ccab6af7ae36",
".git/MERGE_MODE": "d41d8cd98f00b204e9800998ecf8427e",
".git/ORIG_HEAD": "94031358cb3cfc5af5f58165dd7ad6dc",
".git/MERGE_MSG": "3709b675572ed189befe0cff37967522",
".git/config": "5fc03cfb5419e8bb2f209b2ec4b085ec",
".git/objects/95/a20b0becbfd3711305d292daecb08bc9bea148": "5a47a573085c706b91c073d6c03eb1e6",
".git/objects/59/de5b1115503dbee3e2e211940f8b29817be2f4": "a85a1915cbf321aad50b628e2a10257d",
".git/objects/92/a9b06d20518c889fd900de415cd67b52c406ca": "db95abe9c101b59570e8055a3e74c9e9",
".git/objects/68/893addaa6c3eeeb09f76f7d9c2796dcaa57a2c": "4cc2558c9e12addcb402656321450f48",
".git/objects/68/0d38ff385f7203e06efcb671e394b83ef7eff3": "c4fe7cdf3b571413fcc0fc26525fbbc3",
".git/objects/57/a75b5adc70e0c0a03492122762596f4f59e7ed": "fb8e41b797cc37adb4e50cfb7a2f8a7a",
".git/objects/57/7637f537081cf83a7b9b8e6e873177ed937f8c": "84952f0b32156fc57ec4fab01243ea17",
".git/objects/03/eaddffb9c0e55fb7b5f9b378d9134d8d75dd37": "87850ce0a3dd72f458581004b58ac0d6",
".git/objects/69/dd618354fa4dade8a26e0fd18f5e87dd079236": "8cc17911af57a5f6dc0b9ee255bb1a93",
".git/objects/56/ddebc36a93d6299e65822018fe9e51b47c6782": "9bbaff25d9575d1e8d160599fafcad56",
".git/objects/58/183eff2686dc80ce5c05cf4220ca1f0ef0efa7": "c738e439d43d486b60d6ae1756755da8",
".git/objects/b5/32037cddf640b76577b13d32c26d725a25910f": "5246b8fa6e409c1e82fd33e1fb995812",
".git/objects/d9/da3fd2d29bee7e0ec794eed448bde3bde20fe8": "ed310b1af04f0c79482b60c448199e6c",
".git/objects/bb/655ef7e3877ead0d4c7bd6a5e29bbccce54c18": "e471a50fd0288bd1d3bf2eca3a85d96b",
".git/objects/d0/23371979cf1e985205df19078051c10de0a82d": "700b71074bad7afee32068791dec7442",
".git/objects/a2/c6026bf888fb5c479b18979a198c24e61bbad4": "7128209d4810574abc37f2e3f4d7e076",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/eb/9ee7288a1b8ebf63bdbec772591474cd272b72": "d70c75191e60498ea2cd212a4654e6c1",
".git/objects/c7/d29e22e02697c9cedfc8978a2ec999af4f4b0b": "bc02b867eca08a90ec2558280697923b",
".git/objects/fc/c4be8568a6e5b3aa761bb7025cc2079ab1a000": "9c451a058b2cbaca28a484bae929723e",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/ca/8482c88c44dcfdf9ead9d3726df9574ac9775c": "81cbf504c8b90bc81a07b514349a4ac5",
".git/objects/ed/6e0dcdab965853c1a33caa574a32c1e622b827": "e58c3c078635bb7518ea5cab04b31e8c",
".git/objects/7d/cbbcef4ed01735c07f1b071936fce3cd862960": "c58e148a1c10c10c16dcbfe89b7d7833",
".git/objects/7d/ce3a8f56d44a7c42d66b0fe8ccdfd6adfe9579": "b3966d4ec8440605e3415f0b3305d81e",
".git/objects/7c/09d499f23e8c9cfadbd067e09e62b423cd8b4a": "4f5d6ea007527788d254cd3ceeb9b8a8",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/74/0d0b0806304ae58386c6a226b656115265015f": "17b115a3efca1deac9198fa7f5805925",
".git/objects/17/835c46265ef234927562087921a102add582c7": "267d970039b2dacd8b433b13f2b7763a",
".git/objects/8f/e7af5a3e840b75b70e59c3ffda1b58e84a5a1c": "e3695ae5742d7e56a9c696f82745288d",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/10/14da44930c58444bed87be87a664e21a40ecb9": "8187cba826f8313ffad41d30c5f91979",
".git/objects/19/80a5ce571bfb2148bd6fb40b4e09cfb1231aa2": "86c6cf1d6140cf797c7e5bc5258fddeb",
".git/objects/44/a8b8e41b111fcf913a963e318b98e7f6976886": "5014fdb68f6b941b7c134a717a3a2bc6",
".git/objects/43/4f1b9bf564cab9065d8b33580a1f77a02b0eba": "deb85873581ec30442f7230633cb4c66",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/9a/79c9a4a646fc696463bad4c4d7c05bff375005": "bbdc9992c4b5bcc6e9409f1dfac14513",
".git/objects/5d/9e55b4a2f9176568d113a2cfa651d206ed9f36": "77f94a0c5a85b8f9539afea3910084d7",
".git/objects/65/f51cd94e6c4128457db982b97bda6e3e81b1ff": "6d797ea562f0f74783460de58199b2cf",
".git/objects/5b/766d15adb42473b694c783ab3625c3cd5f8e90": "8ec0d50884faa903c06235833e231a70",
".git/objects/08/32d0db2def1613c1c45aa4fe9156a1c6b7d589": "e05df183e5eeaddf39672a2516f9c41d",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "8f96f41fe1f2721c9e97d75caa004410",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/0200e8418b405cfe89b0cb7c534bbcc191feff": "c9389b144454741c4490e59493cd97da",
".git/objects/c4/52ea7ac9345eb76eb4220438cfdacb4f87db29": "01e806848ee4b90f33fbcb7df40e8ec9",
".git/objects/ea/f6f00422c5d8fa2a06129ca3caf79291aa23e3": "a6770ea09725a300adcc9a1234dcfed7",
".git/objects/e8/9ea6f49f4045acb613d7cb8e39c3d39dec2530": "c8dc4ea36c1cf935700b3d2f816106f0",
".git/objects/ff/3ad208ccc6d0a20193033bc91003cfb164dcaf": "ee523e436d490deacdda8fb421e312ca",
".git/objects/f6/3c937dde44d794232bdcea2af173c8929e0e85": "902a1d52e9eca8096da72beb2c439790",
".git/objects/f1/dcdb3d6e6704be0786e3524fc33e3be948a254": "5f4f42dd298a0e20689a81bdea08cf70",
".git/objects/cb/9d981600170e9173f88601b04556c4b526b7da": "67a07b19560b604b7baeb1f7552da612",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/83/660cc284f94300bd5007123ba4a6e887d783c5": "95e71fe91e79ed1dd6d805606866abb8",
".git/objects/83/0fdd5d37ff5550155e7f41ba4d54d134077f2a": "4529068f83fa0d17cb5e76ee28ca2282",
".git/objects/70/16c1978ce41fd8e7d10cbbaa24abd057c6e9c4": "3179909dcd151c312626e997add27eb8",
".git/objects/84/250d8846dab4f64a077e05818ffc80d772bfee": "5078a0be35852253005f6e4cc71802d1",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "05e38b9242f2ece7b4208c191bc7b258",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "42c8b67570e4e8d0a0e190f2d9e05eef",
".git/logs/refs/heads/main": "f31da4d0014dd7815d4954ff92e9aca3",
".git/logs/refs/remotes/origin/main": "07737326e63adea0e2653e850e27f3f5",
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
".git/refs/heads/main": "c46ce8bb8e98402a0323c31dca9c5c14",
".git/refs/remotes/origin/main": "c46ce8bb8e98402a0323c31dca9c5c14",
".git/index": "c108b0c84c75e5e23719e35e26f9ec0a",
".git/MERGE_HEAD": "485f126da9e2d590fc4bbc913260f89e",
".git/COMMIT_EDITMSG": "eb260e9ae827821beceeed4104f0ad89",
".git/FETCH_HEAD": "421ba7e466f569feb32159c136592b4a",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/NOTICES": "17c82c36d5eeb8ceb73ff149b43e9733",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "69a99f98c8b1fb8111c5fb961769fcd8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "693635b5258fe5f1cda720cf224f158c",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"FETCH_HEAD": "d41d8cd98f00b204e9800998ecf8427e",
"canvaskit/skwasm.js": "e95d3c5713624a52bf0509ccb24a6124",
"canvaskit/skwasm.js.symbols": "0b8baeff2b4484d2d6be67a7e082f9db",
"canvaskit/canvaskit.js.symbols": "9a39ab8aa3d828142935da9efe99b3a2",
"canvaskit/skwasm.wasm": "ee4afa1790abb925360fd9519c5194f7",
"canvaskit/chromium/canvaskit.js.symbols": "43ec75ce562f82c5dc5be1a738d87e37",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "3909da2fbccad1a2e4a1f42750d24977",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "afdcccf150b5cba228e27c813548b842",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
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
