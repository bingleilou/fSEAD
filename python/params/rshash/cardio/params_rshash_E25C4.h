#define ENSEMBLE 25
#define DIM_MAX 21
#define BATCH_SIZE 128
#define HASH_NUM 2
#define MATRIX_COL 128
const static param_t bottom_rshash = -1.3833949602465134;
const static param_t delta_rshash = 0.7228593631870723;
static param_t rshash_f[25] = {1.857902696092897,2.234695966622457,1.1280196220693988,1.7642260562290877,3.521750542726384,1.2802647043982611,4.633103295776103,1.8316414375744137,1.3049060026650683,3.5664003148388423,2.1267687818986145,1.3379439154057882,1.9285111042600063,3.7368281121475024,1.1942330083965926,1.2595328994122275,1.5269496653326449,3.573964197795899,1.6711738394604205,1.3710210054648315,1.230365731039754,2.315916415433478,1.2712137056245878,1.548224001738323,2.9559289559935715};

static param_t rshash_alpha[25][21] = {{0.19583638858106842,0.09609938173702534,0.49239562400204007,0.025578251087480658,0.11734803318826678,0.08865570738335034,0.5340956366552609,0.3443947313560581,0.32739072813370496,0.3878878972645529,0.37600423444592196,0.27686572933095366,0.3863231095504091,0.37060397710415,0.1517596318875033,0.39760159576993637,0.5041511634939357,0.054501416635263235,0.24550251972291526,0.3403631949019554,0.26187148066337335},
{0.10878830292483459,0.05668515509612247,0.14525244294705614,0.16650721043157415,0.30367888526566744,0.3766836968525104,0.21875481473904565,0.028358146391429043,0.14844815199036387,0.0032241466735112786,0.30696931053904497,0.31694110836716793,0.13853481122078892,0.13823126847002665,0.16778314403951405,0.3773609188910182,0.24514262466306236,0.05807623164110578,0.29395883994477234,0.31187361309560085,0.1686561644604358},
{0.5623146347342407,0.7599863288761586,0.6771438107276653,0.3111739803421454,0.35975250463990693,0.5817676483300298,0.46214801743819006,0.670960104269194,0.8266781796315177,0.5564871623401404,0.09389167037720136,0.5002027570385601,0.45317088724940696,0.3968298420099352,0.7438894268148278,0.25723850690622163,0.8582073336944347,0.41486464150351093,0.06154619622314021,0.13880622583122929,0.849613989552606},
{0.21949599702175382,0.40299055368831893,0.528172952605541,0.44736505156110085,0.02036661749618423,0.06600202062674598,0.11943463710256719,0.33212189625175886,0.3710218786192522,0.09686398595108948,0.46174796432700205,0.018110078749082943,0.10046765265731844,0.05899992400903304,0.2219442328052166,0.2469519367862073,0.11035605759452526,0.07920648090826561,0.07834635900364573,0.33088471219908855,0.34596639487155},
{0.03821957934648167,0.1868210902262476,0.07883631962199075,0.26031474517727443,0.1861143083921632,0.05217444656547306,0.12687444459244876,0.10469855560814162,0.1582524665447446,0.09347073965692443,0.12530325380804375,0.21956323403690584,0.17548926539847012,0.27496315847223146,0.06275579081179479,0.14158198721439125,0.054645103402935054,0.16122401368407008,0.09296723355218962,0.06558090828932989,0.15779040720269866},
{0.13496870816189188,0.3145534396514968,0.1965206450698486,0.5299139298976083,0.034786386173305546,0.48108603621534984,0.3685783786440979,0.07439047177323908,0.43104595257556766,0.6844132538736004,0.6159210299690433,0.778595195324541,0.5371133482728089,0.5295889946577523,0.12155551981203942,0.05497463027722739,0.23443862943980573,0.6281875387013236,0.01674177201298902,0.6478494979590212,0.5632013332414557},
{0.011228774504154758,0.14683646479321372,0.10943451328321525,0.14531705226226585,0.1176765530197262,0.17096241491134534,0.09023868409651364,0.012403205840034853,0.010710660396160806,0.1514162003736812,0.019738934206332517,0.001953356173585482,0.10113397718678883,0.09162347951386271,0.1549260475477398,0.019684344490173103,0.0712009004899644,0.03889863530068639,0.18443957825532298,0.0586054457660568,0.11288885854051403},
{0.38437863246824233,0.5183108734572548,0.03262747396849329,0.20956752329253378,0.5247559222194836,0.2666884883163332,0.20071656159736564,0.004793298537417152,0.07020111470687601,0.018530402934768837,0.017334585312440056,0.30906299406927,0.4099820856335118,0.23999025303445304,0.03246233025526078,0.2703416186968641,0.5412822048786144,0.02556822261679331,0.012685613906792587,0.1906680248134582,0.2978037927458899},
{0.3909712845840069,0.1777663245454242,0.18978139526554283,0.6329102623275255,0.7168659767457211,0.7350056561746786,0.06627019406018592,0.34926657336132955,0.16146115090878332,0.0014026560782988376,0.4090711634869101,0.00961015912194186,0.030926842397460894,0.6800058626764552,0.40353879111249824,0.5958646632613535,0.7069293940491435,0.4061769770041131,0.4736573297512865,0.347175463942476,0.18060146043514375},
{0.14228249262227752,0.19391218515057354,0.10869555150659727,0.24959357855481995,0.21961299998596875,0.16154590573175626,0.2793853078081858,0.021827568280771852,0.15153855515428136,0.11972212375815587,0.1727998709300894,0.09040508318452761,0.26444985509515484,0.19454705523860072,0.2558593282024831,0.246158094406806,0.09846175088886568,0.12232615036018403,0.01200391450377131,0.18258802596450885,0.24855186392572065},
{0.37285704221166094,0.031434428337589,0.20792146797759875,0.21006042907281763,0.26231801838280305,0.38446621607535525,0.4612952969663796,0.2959126967930582,0.3738407658446935,0.02213543631453027,0.374481101025005,0.07275252409084776,0.2046665011651336,0.010914263241419206,0.15350372857977979,0.19694070939024216,0.42938132428599435,0.17857510242557634,0.1781302008297687,0.16619929052310106,0.09859507501697692},
{0.02949756542929487,0.08979915777279691,0.19768102788938108,0.5341463581689088,0.25146919656341477,0.31879512861698883,0.05070852022826625,0.5155316573762865,0.22722834721944293,0.6154835573619654,0.1541049920017935,0.6220920088737758,0.2212011895366912,0.37385192036142734,0.030007619862859443,0.20932375406817638,0.14533004870920369,0.4576759594428454,0.6890313850794737,0.5312669675424446,0.3445391934542844},
{0.44391267814061725,0.09094347943621665,0.4273949072366752,0.39664071743007445,0.1648377661110817,0.26410507595090654,0.37572497204665334,0.4595516031489579,0.2771941728702936,0.07329864105475974,0.22011349169468736,0.46279373956579406,0.45504080667062025,0.30769023908350174,0.3291107927873981,0.4635249497691142,0.5098500839621894,0.3814042459720177,0.4266278946427504,0.3466591090232521,0.09352323129973021},
{0.15091696164992643,0.1425812531732153,0.09606331914171078,0.19257276543101862,0.17822793964049208,0.07825765490029396,0.2074085182522534,0.06615408146279508,0.19026972505804057,0.24519239694300782,0.22857669185172494,0.17724906229781104,0.06918983812846448,0.22305057301680692,0.15612727500792686,0.04714923489461224,0.050850461325618594,0.07812287878331352,0.0973954321443394,0.1734037142059263,0.1516940459450841},
{0.37243896553695033,0.2162480844913605,0.4660068918254914,0.6372790382484836,0.15642264149929955,0.5203475264937777,0.31288424139177473,0.07364005547705428,0.026151418574511434,0.4100080718787537,0.011736774005443897,0.47069070375276,0.19984685341761985,0.049092096050646426,0.7277277910122636,0.46324519245663365,0.4751268468019113,0.33323770139894765,0.5107318085686604,0.42224666739874517,0.5587619059892553},
{0.5957779984048014,0.26539122297059037,0.1902552161538562,0.7349816763885323,0.33854242756064656,0.23472517595649137,0.42041471177859124,0.4792683138954146,0.3942423499742353,0.5755315750559491,0.10106591326686022,0.3244259850261246,0.38429632735781993,0.7791648516966921,0.2258221479359377,0.39243015625714966,0.06517835188316765,0.00867700593958942,0.1612407502378559,0.5985934383487882,0.6773076870632775},
{0.034136434490065516,0.30489094707848874,0.2335746481471389,0.05953813100658025,0.42027685052371616,0.29661375094381603,0.24681702858017798,0.2772792790638706,0.467577054219791,0.6429378981314546,0.4281021170214739,0.05684906190660168,0.2895205070314286,0.5992792827822018,0.3134569312511964,0.518512574884991,0.5644997322331865,0.11508332535584156,0.1329706769098358,0.20563283281198216,0.28448627927695896},
{0.11586420699544608,0.17086746549786003,0.24047846330072184,0.23027579398513104,0.22837541600646766,0.124711436122993,0.047544459472196744,0.01768642615305286,0.2786910201605403,0.03296132093319836,0.12417800125538675,0.2080614472532562,0.22948474222131454,0.030604978367007592,0.12536431732270428,0.23543616961697061,0.23543976363669156,0.1229401966119014,0.12246787583467941,0.2127805618634163,0.2540434578781667},
{0.40582377164477007,0.17092137280468428,0.3689531301390017,0.04907158827753135,0.2896497253588848,0.08279586321283192,0.3528043161317887,0.390569565441682,0.3674470416841975,0.5369076081520333,0.36860770840271034,0.09529394451769137,0.1836795253643888,0.23479167273056456,0.3008024641683579,0.5817742912938262,0.3203608721342812,0.07959809494766212,0.21501607660297403,0.0807506692933198,0.46529833474151144},
{0.29437577050029506,0.5942105615096877,0.23980081022962635,0.6109842912780337,0.38778571561903313,0.1438792165250305,0.5154324546907965,0.03570920238512107,0.4044595682080511,0.6775694420807589,0.398092217802698,0.7067289677992002,0.12446672144172549,0.5779657050440447,0.21923995311299513,0.300942500329483,0.44042804022130466,0.48464579782728834,0.5022333455682321,0.642939469164887,0.17266170661292607},
{0.5535539583092749,0.5936989134108371,0.12378820008288241,0.019195668247664003,0.4987962913560251,0.10602712197729791,0.5220791401206367,0.09541254129595818,0.444778076238631,0.09278397858226128,0.38250468699133566,0.693407758027357,0.6512504228645968,0.7335118095132229,0.44669786663047184,0.30835535814450404,0.32790925123217207,0.34150156804349296,0.24360557639887526,0.3381771279614791,0.5042230242166309},
{0.1744231036867969,0.19982298681841648,0.3300952333214343,0.1099245761010249,0.3684310878350809,0.186345817365708,0.35531777855131286,0.4012629699777444,0.042669613818616746,0.2651705221399368,0.232776622063205,0.4176409180773638,0.36162425500203416,0.17488700856273096,0.29676520869798106,0.190741448836535,0.049291497462870086,0.08733966817285008,0.24049735350436033,0.12628511188429792,0.3379986241668431},
{0.31824392666462864,0.6985881451083825,0.6195877295169392,0.1874423178297418,0.38642883600239886,0.06044100006104543,0.4918267741606199,0.4496616532749772,0.21904133558494282,0.4402977279661937,0.6554044707295096,0.012132623473583574,0.13148797826609554,0.5551899769840937,0.5904821597841626,0.7390657279026961,0.05966208988416568,0.6856468348298693,0.06918914666338058,0.09532613355700395,0.23636494889802573},
{0.0172027976022914,0.4400627288169239,0.5413781960609959,0.33450809437416,0.2639273247128858,0.6406443652424562,0.05235126532205823,0.519769496504755,0.0033388180583031266,0.513247588607568,0.16313838506199602,0.02926239000276987,0.3932994708508509,0.39112922824048446,0.19243689409564946,0.5760709141166128,0.23173536320772067,0.38189944626873085,0.6190528970187078,0.6135756400714947,0.5078244581342384},
{0.10586122802740269,0.23043799313516874,0.30379213729077637,0.24161390695111407,0.28572919453934226,0.3253514705830314,0.049320947923149026,0.05601313228728336,0.26990095292485244,0.30991588438019024,0.06364596072969929,0.26442586378892463,0.3188663759615086,0.1590844747368445,0.2569443611008346,0.29888880284123065,0.06382251974865433,0.10644693409989414,0.31470683984547343,0.0026124558596880045,0.24061124381502}};
static param_t rshash_min_X[21] = {-2.746330647550977,-0.9199884374438398,-0.20364048566636067,-1.635871141309735,-0.6835984744007735,-0.06140064449540183,-0.27829494600614724,-1.9495717445965985,-1.441358488528391,-0.42048734791506204,-1.398087924648133,-1.8765244994087826,-1.4398413651943174,-2.325378561577513,-1.441407750185039,-0.48827888518542284,-4.567897329062897,-3.8293160555105947,-4.113439081421025,-0.6905897475230182,-2.1266054668088588};
static param_t rshash_delta_X[21] = {0.1750050751949002,0.20507768944038135,0.09868759942952245,0.19157113079326857,0.19997965696857142,0.05009571399865908,0.11279531203908376,0.22287053286338301,0.126980473929281,0.17655784941397185,0.11587612044978589,0.21338726397232247,0.257438263588967,0.15673583076011613,0.16149567346856478,0.06890082523104071,0.130981290338828,0.14368969105603885,0.1330241720960372,0.1113004489272115,0.30612654157244695};

const static score_t log_LUT_rshash[128] = {-0.0,-1.0,-1.584962500721156,-2.0,-2.321928094887362,-2.584962500721156,-2.807354922057604,-3.0,-3.169925001442312,-3.321928094887362,-3.4594316186372973,-3.584962500721156,-3.700439718141092,-3.807354922057604,-3.9068905956085187,-4.0,-4.087462841250339,-4.169925001442312,-4.247927513443585,-4.321928094887363,-4.392317422778761,-4.459431618637297,-4.523561956057013,-4.584962500721156,-4.643856189774724,-4.700439718141092,-4.754887502163468,-4.807354922057604,-4.857980995127572,-4.906890595608519,-4.954196310386875,-5.0,-5.044394119358453,-5.087462841250339,-5.129283016944966,-5.169925001442312,-5.20945336562895,-5.247927513443585,-5.285402218862249,-5.321928094887363,-5.357552004618084,-5.392317422778761,-5.426264754702098,-5.459431618637297,-5.491853096329675,-5.523561956057013,-5.554588851677638,-5.584962500721156,-5.614709844115208,-5.643856189774724,-5.672425341971495,-5.700439718141092,-5.727920454563199,-5.754887502163468,-5.78135971352466,-5.807354922057604,-5.832890014164741,-5.857980995127572,-5.882643049361842,-5.906890595608519,-5.930737337562887,-5.954196310386875,-5.977279923499917,-6.0,-6.022367813028454,-6.044394119358453,-6.066089190457772,-6.087462841250339,-6.108524456778169,-6.129283016944966,-6.149747119504682,-6.169925001442312,-6.189824558880018,-6.20945336562895,-6.22881869049588,-6.247927513443585,-6.266786540694901,-6.285402218862249,-6.303780748177103,-6.321928094887363,-6.339850002884624,-6.357552004618084,-6.3750394313469245,-6.392317422778761,-6.409390936137702,-6.426264754702098,-6.442943495848728,-6.459431618637297,-6.475733430966398,-6.491853096329675,-6.507794640198696,-6.523561956057013,-6.539158811108031,-6.554588851677638,-6.569855608330948,-6.584962500721156,-6.599912842187128,-6.614709844115208,-6.6293566200796095,-6.643856189774724,-6.658211482751795,-6.672425341971495,-6.6865005271832185,-6.700439718141092,-6.714245517666122,-6.727920454563199,-6.7414669864011465,-6.754887502163468,-6.768184324776926,-6.78135971352466,-6.794415866350106,-6.807354922057604,-6.820178962415188,-6.832890014164741,-6.845490050944375,-6.857980995127572,-6.870364719583405,-6.882643049361842,-6.894817763307944,-6.906890595608519,-6.918863237274595,-6.930737337562887,-6.94251450533924,-6.954196310386875,-6.965784284662087,-6.977279923499917,-6.9886846867721655,-7.0};