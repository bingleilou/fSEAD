#define ENSEMBLE 140
#define DIM_MAX 3
#define BATCH_SIZE 128
#define K_NUM 20
#define HASH_NUM 2
#define MATRIX_COL 128
const static param_t bottom_xstream = -7.964051379979506;
const static param_t delta_xstream = 0.1435945752604345;

static param_t xstream_fs[20][2] = {{11,16},
{18,7},
{10,14},
{0,18},
{19,8},
{13,0},
{9,2},
{10,16},
{11,8},
{3,11},
{10,17},
{2,12},
{15,11},
{9,17},
{12,17},
{3,16},
{9,8},
{0,4},
{5,15},
{10,1}};

static param_t xstream_R_T[3][20] = {{0.0,0.0,0.38729833462074165,-0.38729833462074165,0.0,0.0,0.38729833462074165,0.0,0.0,0.0,0.0,0.0,0.0,0.38729833462074165,0.38729833462074165,0.0,-0.38729833462074165,0.0,0.0,0.0},
{0.0,0.0,0.38729833462074165,0.0,0.0,0.0,0.38729833462074165,0.0,0.0,0.0,0.0,0.38729833462074165,0.0,-0.38729833462074165,0.0,-0.38729833462074165,-0.38729833462074165,0.38729833462074165,0.0,0.38729833462074165},
{-0.38729833462074165,0.0,0.0,0.0,0.0,0.0,0.0,0.38729833462074165,0.0,0.0,0.38729833462074165,-0.38729833462074165,0.0,0.0,0.0,0.38729833462074165,0.0,0.0,0.0,-0.38729833462074165}};

static param_t xstream_deltamax[20] = {0.2779276393653878,1.0,0.2774557911045441,0.4964907665775345,1.0,1.0,0.2774557911045441,0.2779276393653878,1.0,1.0,0.2779276393653878,0.20501063765127978,1.0,0.2981485530810293,0.4964907665775345,0.20501063765127978,0.2774557911045441,0.39093570056855725,1.0,0.20501063765127978};

static param_t xstream_shift_deltamax[20][20] = {{-0.355230542591919,-0.8284749475371015,-0.3391068836231357,-0.5525325215055888,-0.15731257768855866,-0.6382550561785264,-0.13055452489426733,-0.025104324960424473,-0.935816919505304,-0.38100436730374276,-0.07331521562051448,-0.33682260535002684,-0.5855779848859234,-0.9284146754190584,-0.4726081792181248,-0.5215525009285631,-0.21752559537712557,-0.7013221901173361,-0.8734507981906742,-0.29179480978756633},
{-0.5820313158624237,-0.23580147771600624,-0.5160545857674557,-0.1945494616776149,-0.07708667903949917,-0.9574289608684767,-0.04617924098661175,-0.5568076044762006,-0.13974232489082128,-0.039221577307446465,-0.46645600500518447,-0.28552813026883683,-0.9301540673845178,-0.700772661894204,-0.6243178954483116,-0.8458516083358052,-0.8933709821132877,-0.7929768152123396,-0.28582823572400995,-0.2364877129508438},
{-0.19816710135044546,-0.5774152668594411,-0.14970258217681998,-0.5777582648941906,-0.9067956373207477,-0.9199401769269269,-0.37910865313054454,-0.17436447269601762,-0.7048399026531164,-0.7852907404251569,-0.1340649063809648,-0.9172029680643259,-0.44382040095845754,-0.6816954226260151,-0.890201416251259,-0.8280427808577008,-0.11036593626744617,-0.825652131376054,-0.6215510024610948,-0.9574739250738469},
{-0.8451905166626629,-0.04786203844311909,-0.004082711177307186,-0.8695524891702477,-0.2711543917933037,-0.8843864831192378,-0.11542860818183485,-0.5956211106609322,-0.6798633030403627,-0.21186649973217997,-0.06688093836921971,-0.012813357997848883,-0.3671796145101365,-0.20752654019066963,-0.4854177726381772,-0.8885579520053312,-0.32983460271106957,-0.8803470308958357,-0.491734074251985,-0.7814017656957256},
{-0.15807744505981458,-0.5464678331264038,-0.02841790080588047,-0.43952304932270203,-0.6166659925795918,-0.14248530017877448,-0.49415882224515784,-0.9421371043183211,-0.9006976196861302,-0.4394962832075858,-0.05846923913492741,-0.19010290866489532,-0.31910570820087103,-0.3459011233281798,-0.10217451638439334,-0.33344752923762067,-0.33343685200880135,-0.637964136986836,-0.5262114000145023,-0.1814109257119333},
{-0.9915754373898344,-0.4770740685578212,-0.44340036472607336,-0.20042083232814667,-0.528597282405071,-0.19686743569896004,-0.8746148470396348,-0.4759701397054861,-0.37028168175149034,-0.1184619156897243,-0.6864002904286536,-0.5685844022168323,-0.0005219339509220378,-0.7986437148177239,-0.7825021568792384,-0.910053687039949,-0.4728437761082458,-0.975719976406538,-0.6224130434306314,-0.0024943209585631676},
{-0.7429240447619408,-0.01157076978161975,-0.27775971845362313,-0.12406774198378123,-0.8249672566562173,-0.2907640672817442,-0.8683612023407777,-0.056020960711633316,-0.3893145534240219,-0.5547671837066864,-0.7929196165333792,-0.8839447790756033,-0.2594799471383714,-0.6670165393891451,-0.5072619770550646,-0.5302658092680326,-0.8708143284739843,-0.8862557709715255,-0.7466504155862835,-0.7607790589251882},
{-0.8344948469828283,-0.37512675370649395,-0.36796048395472325,-0.3523627414075724,-0.5154166133155601,-0.3345823249589337,-0.7161359385167945,-0.6860058787299331,-0.1476639595706677,-0.2764555443985488,-0.34088123399735704,-0.4181714793604007,-0.938395026467798,-0.537871010702173,-0.1309295726687142,-0.08091238222668451,-0.74159282166504,-0.18171620711247471,-0.5545466852079236,-0.3808008042601415},
{-0.9168555410255994,-0.5999835547004435,-0.5267849538462342,-0.8196783420873862,-0.7838336274285281,-0.09666778146259969,-0.5237832699527301,-0.22387536665255758,-0.8751615051182592,-0.0820509047877771,-0.29812920016087624,-0.6498387657743357,-0.8274288670869495,-0.2962023679545831,-0.002018489765275744,-0.6494578052775297,-0.02837348340940926,-0.058342869609334776,-0.9446741308229222,-0.13320869961221615},
{-0.09895693172152065,-0.89619091583804,-0.2068003033004463,-0.3291035443572018,-0.22412182564391936,-0.20524415601412893,-0.9444375924319237,-0.8359427631462221,-0.8273128631129787,-0.585855618784836,-0.37134186681126935,-0.6661117466824021,-0.1256412433124945,-0.10300377740623479,-0.1726596694196132,-0.9461470308096626,-0.8517116018767187,-0.5522958581982842,-0.1869196520572325,-0.5700136848312303},
{-0.01777368650618394,-0.09852898341517657,-0.13881971212690236,-0.8868541243649296,-0.05631261631357387,-0.6142089924730297,-0.4736766374058252,-0.6557553960453164,-0.8691330708609594,-0.28853231380000266,-0.1412743668674873,-0.47119901806407316,-0.5550790811868057,-0.3872128161486894,-0.12533813722005038,-0.32805952229777313,-0.9937090968279777,-0.11967332096384019,-0.9136896329523937,-0.031301527561093945},
{-0.23061188355585194,-0.2664078228467295,-0.7247927749802549,-0.5388479532328183,-0.7272694218622496,-0.9517546542263055,-0.9018709427553064,-0.7990103113706276,-0.22861401704973194,-0.36713568598123036,-0.8011179179098663,-0.10289648585057332,-0.18115697981924395,-0.31892652113206865,-0.8606577443927758,-0.834635611232461,-0.4530003723087528,-0.24423200381242718,-0.3344353715500452,-0.48762935156448467},
{-0.42962944621733523,-0.812981115646034,-0.6614665679095173,-0.9064483092248904,-0.7379258487029349,-0.5484971072776709,-0.457213960986645,-0.5512483847631702,-0.06050036331509312,-0.7499019017798144,-0.8326975654937399,-0.19570522507270838,-0.06793897760699608,-0.5131400792628408,-0.3073365413835344,-0.7263218228504076,-0.1423847289961394,-0.23874424436030084,-0.7091317199219603,-0.38469671854622334},
{-0.34125843190621485,-0.9170070670912768,-0.4651989323962953,-0.5720716017649796,-0.4833640504501697,-0.1341511554757694,-0.38214086362077315,-0.8918794743316012,-0.594871391608231,-0.5180044259637879,-0.34580143174958056,-0.6626876992616881,-0.01306437377835945,-0.2983656286494766,-0.17551745088462467,-0.9545206971714586,-0.5788350506871488,-0.20834633353276644,-0.6939919101063049,-0.4766697793784571},
{-0.18099058551752845,-0.7286314581834723,-0.45920698366566626,-0.6825603089390165,-0.35543771176981265,-0.7419975726504922,-0.7179130944879824,-0.8721620334246641,-0.6856728870324489,-0.15247351216014804,-0.4026131258484934,-0.20843319436313512,-0.2578903367348788,-0.316673517427829,-0.5294225446929467,-0.3239525371483193,-0.5078634815992307,-0.794535175336649,-0.3513801534747426,-0.8667113420797262},
{-0.6014582483152974,-0.7837275803446664,-0.9246620923225554,-0.679123885493013,-0.4209069758075118,-0.22583590619809124,-0.24275284409802622,-0.8095612161318523,-0.5744242664326049,-0.061406108986749586,-0.12414357877357085,-0.8664302949806033,-0.47678133520853994,-0.8278246534245282,-0.37563798881848487,-0.8784567692285847,-0.5528611476410681,-0.2224867748691214,-0.9226083559264974,-0.15308310738313857},
{-0.20430165121145238,-0.4275424656662432,-0.7791260116368547,-0.4143305499987677,-0.6862679820088845,-0.982961826119152,-0.09912640435074305,-0.30686016510059366,-0.5612173523129719,-0.5850997878334137,-0.6772547457221006,-0.2448401681869372,-0.28233955651130915,-0.7367418226355863,-0.18538626711195516,-0.6450791773068809,-0.562502904726287,-0.33967678222427045,-0.3614321650739517,-0.05726611739857256},
{-0.42386603095736886,-0.07729309599122347,-0.26515601017215507,-0.9322437585690666,-0.9778318710739954,-0.974348240101296,-0.26312840446413976,-0.5564515527088351,-0.41618861975806687,-0.14221471804920638,-0.14228620798668956,-0.8830274089481286,-0.3623168915701246,-0.31895619202849024,-0.47593035251736293,-0.9499682594651875,-0.11875061612079463,-0.9378928201055374,-0.23424042379844723,-0.43458999585380775},
{-0.4165339558867087,-0.33313878521771645,-0.36367158138588584,-0.08952880851033729,-0.10304204341200829,-0.31060538082774725,-0.6869396901169397,-0.1488087565064865,-0.7556897311900422,-0.030483763189367963,-0.07760987424064858,-0.8410652941101823,-0.10964651861603991,-0.7921445540578599,-0.5778658024904171,-0.10935153257337438,-0.5837852952583287,-0.6289857381747557,-0.7638873831692905,-0.9140143365888063},
{-0.5218878120801892,-0.3045431457489157,-0.622041318972509,-0.9548719515528336,-0.49980441524078434,-0.9255249352509456,-0.127779189975067,-0.2834737187833952,-0.2780091893865183,-0.0382632714307618,-0.05147079387629738,-0.6023104846660567,-0.23656914407757723,-0.9649247820805456,-0.8157940684748743,-0.52896034014487,-0.2418506237457948,-0.6386575006629757,-0.9776778022170265,-0.08515069379967588}};

static param_t xstream_shift[20][20] = {{1.278140394395615,0.8284749475371015,1.2222014983834368,1.1128757243853045,0.15731257768855866,0.6382550561785264,0.47054171900515485,0.09032683837327943,0.935816919505304,0.38100436730374276,0.2637924597493088,1.642951844884056,0.5855779848859234,3.1139331914407737,0.9518972174970346,2.544026529080489,0.7840009196101547,1.793957904323827,0.8734507981906742,1.4233154588002659},
{2.0941829218260475,0.23580147771600624,1.859952476439782,0.3918491032949211,0.07708667903949917,0.9574289608684767,0.1664381947220255,2.0034265240679177,0.13974232489082128,0.039221577307446465,1.6783361527852254,1.3927478765980728,0.9301540673845178,2.350414431505732,1.25746124092484,4.125891309965032,3.219867851944274,2.028407265079843,0.28582823572400995,1.1535387415023122},
{0.7130168910257889,0.5774152668594411,0.5395547217841732,1.1636838059987666,0.9067956373207477,0.9199401769269269,1.3663749876018918,0.627373632554706,0.7048399026531164,0.7852907404251569,0.4823734216830139,4.473928663274904,0.44382040095845754,2.286428746950006,1.7929868512715648,4.039023488460096,0.3977784562653471,2.1119895936218334,0.6215510024610948,4.670362162877112},
{3.041045210877721,0.04786203844311909,0.014714816948148824,1.7513971008249436,0.2711543917933037,0.8843864831192378,0.4160252259371363,2.1430798031493263,0.6798633030403627,0.21186649973217997,0.24064155159930758,0.06250094212010708,0.3671796145101365,0.6960508043594937,0.9776974826426543,4.334204128064592,1.1887825494577238,2.2518972547544345,0.491734074251985,3.811518146804065},
{0.5687719487733002,0.5464678331264038,0.1024231669223755,0.8852592614208544,0.6166659925795918,0.14248530017877448,1.7810362518580878,3.389864737705004,0.9006976196861302,0.4394962832075858,0.2103757628008299,0.9272831441471721,0.31910570820087103,1.1601636826799309,0.2057933868311673,1.6264889132475664,1.2017656963705754,1.6318901959043723,0.5262114000145023,0.884885427362607},
{3.5677467691013756,0.4770740685578212,1.5980937466142202,0.4036748431591385,0.528597282405071,0.19686743569896004,3.1522674064859717,1.7125685692589014,0.37028168175149034,0.1184619156897243,2.469708633498852,2.7734385333896006,0.0005219339509220378,2.6786771445463717,1.5760658798818545,4.439055931272882,1.7042130359790557,2.4958579505210188,0.6224130434306314,0.012166787963490815},
{2.6730844275089476,0.01157076978161975,1.0010954082013177,0.24988932390227278,0.8249672566562173,0.2907640672817442,3.129728159155932,0.2015667129744635,0.3893145534240219,0.5547671837066864,2.852971436536178,4.311702013137391,0.2594799471383714,2.2371952924013243,1.021694684378079,2.5865282667429543,3.138569661881252,2.2670116074909497,0.7466504155862835,3.710924797079372},
{3.0025615620248876,0.37512675370649395,1.3261950038594703,0.7097065345978507,0.5154166133155601,0.3345823249589337,2.581081244207866,2.4682895169992443,0.1476639595706677,0.2764555443985488,1.2265107377435212,2.0397550300375364,0.938395026467798,1.8040369646066778,0.26370998512470334,0.3946740674223712,2.672832377052859,0.46482377242138745,0.5545466852079236,1.8574685129650605},
{3.2989001853832236,0.5999835547004435,1.8986266307476134,1.6509437783459384,0.7838336274285281,0.09666778146259969,1.8878080283261085,0.8055167422849644,0.8751615051182592,0.0820509047877771,1.0726864044238857,3.169780715865595,0.8274288670869495,0.9934724314227437,0.004065513200154401,3.167922468405022,0.10226307872852529,0.1492390424422324,0.9446741308229222,0.6497648177593706},
{0.356052863067078,0.89619091583804,0.7453450601163515,0.6628593450504932,0.22412182564391936,0.20524415601412893,3.403920994664205,3.0077712495777336,0.8273128631129787,0.585855618784836,1.3361098869446055,3.2491569916262044,0.1256412433124945,0.3454780388561569,0.3477600814408092,4.61511188711605,3.0697200389513495,1.4127537019388428,0.1869196520572325,2.78041028193286},
{0.06395076987221522,0.09852898341517657,0.5003309232590345,1.786244949686157,0.05631261631357387,0.6142089924730297,1.7072148161699243,2.3594465003288265,0.8691330708609594,0.28853231380000266,0.5083134847259857,2.2984125285516943,0.5550790811868057,1.2987244517784218,0.2524480728696028,1.6002073163432513,3.5815042564873063,0.3061202156513036,0.9136896329523937,0.15268245550427195},
{0.8297551264869687,0.2664078228467295,2.6122820219209486,1.0853131407604317,0.7272694218622496,0.9517546542263055,3.250503221305932,2.874886114943679,0.22861401704973194,0.36713568598123036,2.8824694072857118,0.5019080328192471,0.18115697981924395,1.0696899845272516,1.7334818738434103,4.071181967894585,1.6326938807273417,0.6247370180242644,0.3344353715500452,2.3785563381054176},
{1.5458320273519364,0.812981115646034,2.384043112872997,1.8257103056987765,0.7379258487029349,0.5484971072776709,1.647880403456307,1.9834241244299249,0.06050036331509312,0.7499019017798144,2.9960948374731577,0.9546100988457009,0.06793897760699608,1.7210886115666717,0.6190176375325183,3.542849440261099,0.5131798778800385,0.6106995191615481,0.7091317199219603,1.8764719867882518},
{1.227867918014325,0.9170070670912768,1.6766596600645844,1.1522300922300073,0.4833640504501697,0.1341511554757694,1.3773036133053145,3.209034827799401,0.594871391608231,0.5180044259637879,1.2442138987657863,3.2324551879542494,0.01306437377835945,1.000728078557498,0.3535160423919283,4.655956920611529,2.0862244337478844,0.5329427146964526,0.6939919101063049,2.3250977843855387},
{0.6512147763741574,0.7286314581834723,1.6550636115309596,1.3747693912700882,0.35543771176981265,0.7419975726504922,2.5874864302885494,3.138090315220662,0.6856728870324489,0.15247351216014804,1.4486257169952905,1.0166945322987437,0.2578903367348788,1.062133336403498,1.0663290847127354,1.5801742819772993,1.8304302807212625,2.03239349637579,0.3513801534747426,4.227640828833429},
{2.1640821678932345,0.7837275803446664,3.332646576384296,1.367847966588433,0.4209069758075118,0.22583590619809124,0.8749244091522963,2.91284889110123,0.5744242664326049,0.061406108986749586,0.4466759011699478,4.2262699385111375,0.47678133520853994,2.77655096719368,0.7565860517565604,4.284932622485802,1.992609869270137,0.5691134745318676,0.9226083559264974,0.7467081178662094},
{0.7350893623892503,0.4275424656662432,2.8081086667363286,0.8345181378797379,0.6862679820088845,0.982961826119152,0.35726918496140764,1.104100930016423,0.5612173523129719,0.5850997878334137,2.436802425510918,1.1942803114607492,0.28233955651130915,2.471056173247161,0.37339318189113657,3.146564415862905,2.0273604760130537,0.8688814598673429,0.3614321650739517,0.2793324193058773},
{1.525094920120981,0.07729309599122347,0.9556694027418784,1.8776658526709635,0.9778318710739954,0.974348240101296,0.9483615512822154,2.002145428858465,0.41618861975806687,0.14221471804920638,0.5119541486107029,4.3072272691046685,0.3623168915701246,1.069789501684437,0.9585885268282008,4.6337510596941325,0.42799833316886843,2.3990973931045776,0.23424042379844723,2.1198411986456978},
{1.4987136825895069,0.33313878521771645,1.3107370364774833,0.1803232094878365,0.10304204341200829,0.31060538082774725,2.4758527741744047,0.535422661978752,0.7556897311900422,0.030483763189367963,0.2792448941669163,4.102544647174955,0.10964651861603991,2.6568787467587507,1.1639004013585712,0.533394431753243,2.104065995286294,1.608923762296435,0.7638873831692905,4.458375170480333},
{1.877783056308661,0.3045431457489157,2.2419475062898457,1.923242114118382,0.49980441524078434,0.9255249352509456,0.46053891852962026,1.019955120083311,0.2780091893865183,0.0382632714307618,0.18519494496417974,2.9379474722213117,0.23656914407757723,3.2363892834935317,1.6431203224551323,2.580160455110745,0.871672646597117,1.633663796205218,0.9776778022170265,0.4153476852480017}};

const static score_t log_LUT_xstream_d0[128] = {1.0,2.0,2.584962500721156,3.0,3.321928094887362,3.584962500721156,3.807354922057604,4.0,4.169925001442312,4.321928094887362,4.459431618637297,4.584962500721156,4.700439718141093,4.807354922057604,4.906890595608519,5.0,5.087462841250339,5.169925001442312,5.247927513443585,5.321928094887363,5.392317422778761,5.459431618637297,5.523561956057013,5.584962500721156,5.643856189774724,5.700439718141092,5.754887502163468,5.807354922057604,5.857980995127572,5.906890595608519,5.954196310386875,6.0,6.044394119358453,6.087462841250339,6.129283016944966,6.169925001442312,6.20945336562895,6.247927513443585,6.285402218862249,6.321928094887363,6.357552004618084,6.392317422778761,6.426264754702098,6.459431618637297,6.491853096329675,6.523561956057013,6.554588851677638,6.584962500721156,6.614709844115208,6.643856189774724,6.672425341971495,6.700439718141092,6.727920454563199,6.754887502163468,6.78135971352466,6.807354922057604,6.832890014164741,6.857980995127572,6.882643049361842,6.906890595608519,6.930737337562887,6.954196310386875,6.977279923499917,7.0,7.022367813028454,7.044394119358453,7.066089190457772,7.087462841250339,7.108524456778169,7.129283016944966,7.149747119504682,7.169925001442312,7.189824558880018,7.20945336562895,7.22881869049588,7.247927513443585,7.266786540694901,7.285402218862249,7.303780748177103,7.321928094887363,7.339850002884624,7.357552004618084,7.3750394313469245,7.392317422778761,7.409390936137702,7.426264754702098,7.442943495848728,7.459431618637297,7.475733430966398,7.491853096329675,7.507794640198696,7.523561956057013,7.539158811108031,7.554588851677638,7.569855608330948,7.584962500721156,7.599912842187128,7.614709844115208,7.6293566200796095,7.643856189774724,7.658211482751795,7.672425341971495,7.6865005271832185,7.700439718141092,7.714245517666122,7.727920454563199,7.7414669864011465,7.754887502163468,7.768184324776926,7.78135971352466,7.794415866350106,7.807354922057604,7.820178962415188,7.832890014164741,7.845490050944375,7.857980995127572,7.870364719583405,7.882643049361842,7.894817763307944,7.906890595608519,7.918863237274595,7.930737337562887,7.94251450533924,7.954196310386875,7.965784284662087,7.977279923499917,7.9886846867721655,8.0};