#define ENSEMBLE 140
#define DIM_MAX 3
#define BATCH_SIZE 128
#define K_NUM 20
#define HASH_NUM 2
#define MATRIX_COL 128
const static param_t bottom_xstream = -7.964051379979506;
const static param_t delta_xstream = 0.1435945752604345;

static param_t xstream_fs[20][2] = {{12,6},
{1,11},
{19,13},
{15,1},
{10,0},
{7,10},
{0,13},
{3,2},
{13,9},
{4,19},
{14,10},
{14,7},
{17,19},
{5,11},
{13,9},
{10,4},
{16,16},
{15,15},
{6,13},
{11,17}};

static param_t xstream_R_T[3][20] = {{0.0,0.0,0.38729833462074165,-0.38729833462074165,0.0,0.0,0.38729833462074165,0.0,0.0,0.0,0.0,0.0,0.0,0.38729833462074165,0.38729833462074165,0.0,-0.38729833462074165,0.0,0.0,0.0},
{0.0,0.0,0.38729833462074165,0.0,0.0,0.0,0.38729833462074165,0.0,0.0,0.0,0.0,0.38729833462074165,0.0,-0.38729833462074165,0.0,-0.38729833462074165,-0.38729833462074165,0.38729833462074165,0.0,0.38729833462074165},
{-0.38729833462074165,0.0,0.0,0.0,0.0,0.0,0.0,0.38729833462074165,0.0,0.0,0.38729833462074165,-0.38729833462074165,0.0,0.0,0.0,0.38729833462074165,0.0,0.0,0.0,-0.38729833462074165}};

static param_t xstream_deltamax[20] = {0.2779276393653878,1.0,0.2774557911045441,0.4964907665775345,1.0,1.0,0.2774557911045441,0.2779276393653878,1.0,1.0,0.2779276393653878,0.20501063765127978,1.0,0.2981485530810293,0.4964907665775345,0.20501063765127978,0.2774557911045441,0.39093570056855725,1.0,0.20501063765127978};

static param_t xstream_shift_deltamax[20][20] = {{-0.5279375848826491,-0.1489456618011512,-0.5724529704206421,-0.9862751967551241,-0.898690106949218,-0.18508082283847926,-0.9449013303208009,-0.26228778146657306,-0.7696257109026103,-0.718561110473736,-0.3879951455264923,-0.44371292918741767,-0.8137807591913,-0.8641498072116968,-0.011903022989183554,-0.766331710238022,-0.42187842222407446,-0.23315042563832455,-0.18595333001747505,-0.4768835869523179},
{-0.531671883533918,-0.6053371686605701,-0.782911294092812,-0.33774606652236805,-0.9927174708333336,-0.3283002687768384,-0.9644153514327894,-0.5997950277388504,-0.03373804761057353,-0.2285851751957585,-0.6403288147711113,-0.6974191077317214,-0.2841295757729003,-0.2700964089088047,-0.3696104989568413,-0.65081277318033,-0.11418098264959897,-0.42014970476578106,-0.6914946215314085,-0.4458477101510749},
{-0.9866648581230558,-0.8090185399103822,-0.47304762705202497,-0.3673642653290057,-0.12868248024181517,-0.782046802808632,-0.1845442728164841,-0.9591064484282382,-0.899758460903065,-0.2512238536000784,-0.6862900865865151,-0.23694057508568223,-0.4070090486000758,-0.07689479246788022,-0.7847184995629184,-0.38148455810965587,-0.4988145218043719,-0.21679331127014465,-0.5844991788536676,-0.962966755935413},
{-0.28728289609252855,-0.6098107765332231,-0.8014192761854161,-0.9593130937340884,-0.8162762122372036,-0.14728229569183582,-0.18169768337894077,-0.6991220766025258,-0.23389895517633008,-0.2508434792036911,-0.22107921306624678,-0.2952028905702081,-0.13619650088450852,-0.6842932283302962,-0.26268525688365874,-0.02608417728802881,-0.48148579689205073,-0.7237363802842905,-0.22543277041762722,-0.6242647268753762},
{-0.5608456027486445,-0.47564077162099483,-0.26933827475546124,-0.6127041798816932,-0.4872234254980846,-0.9762018462124811,-0.4848384507755785,-0.2798007763495868,-0.5305758332284111,-0.5389527201447687,-0.7900148081543255,-0.4066938619735381,-0.6035100330905081,-0.6783537486873822,-0.09502680830494803,-0.10878900979666473,-0.6992825241374708,-0.9506236183498983,-0.7289783560958945,-0.8305284823917699},
{-0.05154584525839434,-0.5981985601002776,-0.5418137973427442,-0.8548994207500217,-0.7587718997957152,-0.1736049228510136,-0.9293497776132822,-0.9075633976210762,-0.9720081674645016,-0.8788121343920815,-0.8169688958127284,-0.866706669007424,-0.8204257550346569,-0.0062122851968656745,-0.022705884499817697,-0.2528904255156076,-0.13362483703997752,-0.0008955687954242952,-0.8643267368755526,-0.6182638400026678},
{-0.43146432196306284,-0.47737490841782093,-0.4518570644951244,-0.14222487677268458,-0.6375084965657599,-0.01737728538277772,-0.647375450574431,-0.6874754095265764,-0.31937927972921143,-0.7835957756304207,-0.32002485569937444,-0.882720991588393,-0.19603653750467553,-0.031490542726326565,-0.9667156734968495,-0.6153039950633361,-0.4482414013250797,-0.9162271853050765,-0.23833992066465925,-0.7200768793806671},
{-0.860545126302405,-0.6778684924215387,-0.29590726456971383,-0.3656644818301833,-0.6261340820638096,-0.9524580084708393,-0.21944442948347176,-0.18091210746386066,-0.26707085890240945,-0.6565339145752054,-0.1716520359078385,-0.013057673328897736,-0.6408204322687672,-0.0847968636224039,-0.05516555956512681,-0.05228893694698678,-0.1810750011374742,-0.14491232880580696,-0.34419208644835786,-0.05598666899222182},
{-0.8439881781132058,-0.49767414115996245,-0.6781146377961234,-0.5379655269127558,-0.3476546815691618,-0.7297378443571529,-0.7545294116379029,-0.006052605640870956,-0.627522600423391,-0.5861646922951111,-0.8897799831419578,-0.5638872218415644,-0.5610447940230141,-0.7609074490182657,-0.5149024099225643,-0.39455273658113965,-0.35949236626967473,-0.7763858878810095,-0.6828784200224979,-0.48668076676930844},
{-0.44135330348407237,-0.8773494927553476,-0.8483681689991858,-0.5023544107046862,-0.41636276658437543,-0.1267712132858284,-0.5619837125828501,-0.41872175924589383,-0.9872446159455396,-0.2886430495030581,-0.4266912827197027,-0.44977862811495817,-0.12780829601311727,-0.9577125173775605,-0.09102493775032339,-0.3968776337187949,-0.9745021132760062,-0.344342708322657,-0.05495736173965182,-0.9670949458133214},
{-0.5796079217871163,-0.8124676885480855,-0.34087631721681666,-0.4761191483897801,-0.2628165439640585,-0.9506696932353634,-0.7127833629627458,-0.2554356266891037,-0.5222178678044099,-0.11226985518263766,-0.5171587091060101,-0.9680599921625144,-0.3114574872542618,-0.12950397273077063,-0.7103699247705079,-0.20224491197679884,-0.9252651994334576,-0.4495073976012009,-0.43659905132182575,-0.8100450166618779},
{-0.5206776731305984,-0.8693300881669519,-0.4086003942964187,-0.06849092742734852,-0.13272525258987566,-0.5070548525364181,-0.27065717549535084,-0.2878052125070648,-0.3579267919521606,-0.09898893583371715,-0.2826879063956824,-0.46952881517508305,-0.06737472821572044,-0.1877511716833118,-0.5496837352285737,-0.5914246225468374,-0.8803743820708518,-0.5155671416133415,-0.828141965182952,-0.31510913575986976},
{-0.855860807161107,-0.10978568784244858,-0.6774089276608378,-0.6816029646584628,-0.8941800850117887,-0.5301633122487212,-0.09636892907975492,-0.4993949988771966,-0.7034731019914789,-0.2519950844869675,-0.822509867585791,-0.9927707703041814,-0.23001621293736918,-0.479290564739023,-0.11741693826101529,-0.3207526183277333,-0.9181573134128678,-0.3724940140221078,-0.6333300643477209,-0.9748217075821406},
{-0.8462971660951443,-0.6801538188779586,-0.6503013167440722,-0.008864909757133388,-0.6879263969496324,-0.4969207803005006,-0.19357729537239035,-0.5098524447722317,-0.7368768162395753,-0.5111834744509509,-0.5203203573171195,-0.15244020217286913,-0.37622446513378094,-0.5507471417951195,-0.061760940361428096,-0.2092882238280089,-0.4059002998312531,-0.804992171384337,-0.06438480903338484,-0.758867201522417},
{-0.9079484271785478,-0.24019486774777865,-0.03478097550891157,-0.38925908552787414,-0.6312354288671775,-0.14500642081488446,-0.08542087919849684,-0.36915160503796124,-0.39180810226045937,-0.9703332528538274,-0.3853999968800108,-0.8584051603362397,-0.02617687795619761,-0.7190600175014994,-0.766771137494749,-0.5059304191565658,-0.9818776326339913,-0.6158036238552547,-0.9591310054070007,-0.4969256087430479},
{-0.5879039078340693,-0.713016609527101,-0.5459088847940088,-0.31015893432640573,-0.28632597994170594,-0.3357874815430707,-0.9004984271322378,-0.2413113284962626,-0.9949083730106694,-0.305791084289214,-0.01531695461974192,-0.3231039084249394,-0.31868911510073106,-0.7376458511898205,-0.7739763498308398,-0.6021879829291279,-0.8986789302879158,-0.6308170582793905,-0.26789282993563845,-0.7498489255694493},
{-0.9073568273645736,-0.15717280827401292,-0.3921716050998958,-0.9875434421068181,-0.1869910575264201,-0.6366887643076773,-0.9456699627124422,-0.15660557167801836,-0.09331540493690382,-0.20331873683031854,-0.8774509446764818,-0.06195025839088831,-0.3416617690029754,-0.1109071789658218,-0.7023497671187318,-0.4974255148122923,-0.6539170245862774,-0.41903866460417005,-0.8153152087463151,-0.24233466071420073},
{-0.1580921403448331,-0.8067966469892099,-0.5438226106332437,-0.5267057899518252,-0.4285466861873167,-0.9479620662297007,-0.9407837326601883,-0.25748838352187964,-0.07544778038457978,-0.41548405380942877,-0.653964249486174,-0.33184299570259657,-0.11102290032757867,-0.3616069045277114,-0.02758064275203398,-0.20125799803310396,-0.15644554456840487,-0.659688967994373,-0.9433036269092169,-0.654899105248373},
{-0.30285698091150515,-0.347995970269674,-0.2549292420742697,-0.2970395087479366,-0.7267873574713145,-0.3872170590744305,-0.3713831993441452,-0.8287046928965537,-0.5683063935498778,-0.24281133849003889,-0.12607905572221012,-0.27750105238883727,-0.5226457379754637,-0.5422953796303734,-0.9348834243374078,-0.605352500426794,-0.9124222419669078,-0.32427082991727196,-0.6790385870875609,-0.7106777419451752},
{-0.6143953367069955,-0.4322718244282089,-0.5044615879836334,-0.9680939594620258,-0.7145255411982894,-0.30743461564237307,-0.7197640232403184,-0.17644290391573358,-0.7234111026902788,-0.5185530100382179,-0.005690194388246916,-0.5560616504547259,-0.7413043127789419,-0.01888355144983489,-0.2433604390564339,-0.5169805048570072,-0.5772700885453376,-0.037012280745022275,-0.6463656221500422,-0.39058386001805756}};

static param_t xstream_shift[20][20] = {{1.8995504948270963,0.1489456618011512,2.063222281797479,1.9864925254377361,0.898690106949218,0.18508082283847926,3.405592388463668,0.9437268710138857,0.7696257109026103,0.718561110473736,1.3960293636589352,2.164341003329628,0.8137807591913,2.8983867212558385,0.023974308870303468,3.7380094955928165,1.5205248394513147,0.596390724355034,0.18595333001747505,2.3261406940428633},
{1.9129867211045393,0.6053371686605701,2.8217514976928864,0.6802665613512954,0.9927174708333336,0.3283002687768384,3.4759243899486747,2.158097802393478,0.03373804761057353,0.2285851751957585,2.303940753187485,3.401867901694065,0.2841295757729003,0.9059121908111334,0.7444458665458807,3.1745317249700644,0.4115285617036412,1.074728412254845,0.6914946215314085,2.1747540286638958},
{3.550078215955703,0.8090185399103822,1.7049477510230908,0.7399216461997108,0.12868248024181517,0.782046802808632,0.6651303693529635,3.4509214363070733,0.899758460903065,0.2512238536000784,2.4693121135903247,1.1557477104613216,0.4070090486000758,0.25790764930186383,1.5805298957969096,1.860803724529435,1.7978162208062214,0.5545497915765978,0.5844991788536676,4.697155069452571},
{1.0336607641776914,0.6098107765332231,2.8884575556883756,1.9321871791230525,0.8162762122372036,0.14728229569183582,0.6548707549249815,2.515482368716122,0.23389895517633008,0.2508434792036911,0.7954560171527125,1.4399393804742175,0.13619650088450852,2.2951418722609813,0.529083871376763,0.12723328694971248,1.7353604153485807,1.8512926274876527,0.22543277041762722,3.045035779739594},
{2.017955479452363,0.47564077162099483,0.9707430278648456,1.2340696365921444,0.4872234254980846,0.9762018462124811,1.7474439760130778,1.006739657086557,0.5305758332284111,0.5389527201447687,2.8425197650662715,1.9837695576817755,0.6035100330905081,2.275220663247769,0.19139692961461785,0.5306505605904865,2.520338542416598,2.4316623346687423,0.7289783560958945,4.051148232632139},
{0.1854649842530692,0.5981985601002776,1.952793254686802,1.7218838260439557,0.7587718997957152,0.1736049228510136,3.349541827595544,3.2654665066539663,0.9720081674645016,0.8788121343920815,2.939502158468918,4.227618034541602,0.8204257550346569,0.02083620776511812,0.045732742738271714,1.2335478217758176,0.4816076698490257,0.002290834001913422,0.8643267368755526,3.0157646797544517},
{1.5524340182511407,0.47737490841782093,1.6285731960983532,0.28646026542061387,0.6375084965657599,0.01737728538277772,2.3332562207378933,2.4735769752743506,0.31937927972921143,0.7835957756304207,1.1514682614154903,4.305732627835093,0.19603653750467553,0.10562031041541975,1.9470969826100126,3.001327160934739,1.6155417032048336,2.3436774486765004,0.23833992066465925,3.51238788206448},
{3.0962919998433756,0.6778684924215387,1.0665023908555482,0.7364980508113423,0.6261340820638096,0.9524580084708393,0.7909167388789015,0.6509324077193269,0.26707085890240945,0.6565339145752054,0.617614125388119,0.06369266238324986,0.6408204322687672,0.2844114544448527,0.11111094763231992,0.2550547500658455,0.6526264974200735,0.3706807247203408,0.34419208644835786,0.2730915314133814},
{3.036719126029872,0.49767414115996245,2.4440457166043177,1.0835358140114462,0.3476546815691618,0.7297378443571529,2.7194581473111135,0.02177763123772543,0.627522600423391,0.5861646922951111,3.2014807349627286,2.7505266473085586,0.5610447940230141,2.552108474635026,1.0370835564011531,1.9245476288516712,1.2956744021760915,1.9859682468290127,0.6828784200224979,2.3739293353018374},
{1.5880151556421167,0.8773494927553476,3.0576697124318604,1.011810177594181,0.41636276658437543,0.1267712132858284,2.025489215220947,1.5065855278085742,0.9872446159455396,0.2886430495030581,1.535260342202732,2.193928243274992,0.12780829601311727,3.2121991117537916,0.18333661747183463,1.935888002035671,3.5122788729568026,0.8808167374375435,0.05495736173965182,4.717291536151096},
{2.0854634073479588,0.8124676885480855,1.2285788516426244,0.9589687874193868,0.2628165439640585,0.9506696932353634,2.5689979658567377,0.919072414936342,0.5222178678044099,0.11226985518263766,1.8607674655420237,4.721998835051529,0.3114574872542618,0.4343605608428853,1.430781743772012,0.9865093552892342,3.3348202816383883,1.1498243750761568,0.43659905132182575,3.9512340722521584},
{1.8734289051621469,0.8693300881669519,1.4726684660997393,0.13795005272601105,0.13272525258987566,0.5070548525364181,0.9754965806187423,1.0355400893708564,0.3579267919521606,0.09898893583371715,1.0171277208742682,2.2902656201369656,0.06737472821572044,0.6297235714985534,1.1071378809674848,2.8848484611459155,3.173025794726089,1.318802915322204,0.828141965182952,1.5370379770042273},
{3.0794375439425736,0.10978568784244858,2.4415022118085585,1.37284116954876,0.8941800850117887,0.5301633122487212,0.34733075383329637,1.7968525909028021,0.7034731019914789,0.2519950844869675,2.959438900945178,4.84253296159622,0.23001621293736918,1.6075562325763286,0.2364936997124978,1.5645657318198725,3.3092021967092773,0.9528268036927076,0.6333300643477209,4.754981101226067},
{3.0450270006522406,0.6801538188779586,2.3438015626029647,0.017855135188599724,0.6879263969496324,0.4969207803005006,0.6976869886253384,1.8344790965605815,0.7368768162395753,0.5111834744509509,1.8721432618404001,0.7435721576173416,0.37622446513378094,1.8472239294934305,0.12439494250248699,1.020865191317561,1.4629368455975447,2.05914213056929,0.06438480903338484,3.7015991473244405},
{3.266851865657306,0.24019486774777865,0.12535681944301624,0.7840207950112713,0.6312354288671775,0.14500642081488446,0.3078720356076858,1.3282291962068677,0.39180810226045937,0.9703332528538274,1.3866918661275374,4.187124971516721,0.02617687795619761,2.4117508204243303,1.5443814650982157,2.467825206305374,3.538861556016411,1.5752043698226097,0.9591310054070007,2.423901581089228},
{2.1153128532897005,0.713016609527101,1.967552677926671,0.6247023211819787,0.28632597994170594,0.3357874815430707,3.2455564309808693,0.8682523589494955,0.9949083730106694,0.305791084289214,0.05511130398803166,1.5760348444676058,0.31868911510073106,2.4740883145904347,1.5588937437167258,2.937349933779735,3.2389986408656273,1.6136082157806562,0.26789282993563845,3.6576098399583135},
{3.264723254716252,0.15717280827401292,1.4134561889613877,1.9890469442448298,0.1869910575264201,0.6366887643076773,3.40836267625828,0.5634760617389734,0.09331540493690382,0.20331873683031854,3.1571201291099684,0.30218070194125646,0.3416617690029754,0.3719863062212481,1.414628054334721,2.426340020747636,2.356833216502893,1.0718864099511538,0.8153152087463151,1.1820589579668963},
{0.5688248232734833,0.8067966469892099,1.9600333749326346,1.060857170784005,0.4285466861873167,0.9479620662297007,3.390751834427219,0.9264583548071054,0.07544778038457978,0.41548405380942877,2.353001849616029,1.61866232652306,0.11102290032757867,1.2128413865870271,0.05555116954572174,0.9816953907310946,0.563857557074586,1.6874615621826161,0.9433036269092169,3.1944640178250028},
{1.0896972377523888,0.347995970269674,0.9188103123002161,0.5982780118863488,0.7267873574713145,0.3872170590744305,1.3385310786474436,2.9817282469235336,0.5683063935498778,0.24281133849003889,0.45363986111671195,1.3535934308972917,0.5226457379754637,1.8188764427207909,1.882982498913022,2.952785803517621,3.288531979579807,0.8294735667417142,0.6790385870875609,3.466540810209215},
{2.210630573158858,0.4322718244282089,1.818169251308056,1.9498730381944442,0.7145255411982894,0.30743461564237307,2.5941575065885525,0.6348519503803882,0.7234111026902788,0.5185530100382179,0.020473654226113486,2.712355109106967,0.7413043127789419,0.06333604927709582,0.49016105724179565,2.5217252664536547,2.0805840319542104,0.09467613392993648,0.6463656221500422,1.9051882599498824}};

const static score_t log_LUT_xstream_d0[128] = {1.0,2.0,2.584962500721156,3.0,3.321928094887362,3.584962500721156,3.807354922057604,4.0,4.169925001442312,4.321928094887362,4.459431618637297,4.584962500721156,4.700439718141093,4.807354922057604,4.906890595608519,5.0,5.087462841250339,5.169925001442312,5.247927513443585,5.321928094887363,5.392317422778761,5.459431618637297,5.523561956057013,5.584962500721156,5.643856189774724,5.700439718141092,5.754887502163468,5.807354922057604,5.857980995127572,5.906890595608519,5.954196310386875,6.0,6.044394119358453,6.087462841250339,6.129283016944966,6.169925001442312,6.20945336562895,6.247927513443585,6.285402218862249,6.321928094887363,6.357552004618084,6.392317422778761,6.426264754702098,6.459431618637297,6.491853096329675,6.523561956057013,6.554588851677638,6.584962500721156,6.614709844115208,6.643856189774724,6.672425341971495,6.700439718141092,6.727920454563199,6.754887502163468,6.78135971352466,6.807354922057604,6.832890014164741,6.857980995127572,6.882643049361842,6.906890595608519,6.930737337562887,6.954196310386875,6.977279923499917,7.0,7.022367813028454,7.044394119358453,7.066089190457772,7.087462841250339,7.108524456778169,7.129283016944966,7.149747119504682,7.169925001442312,7.189824558880018,7.20945336562895,7.22881869049588,7.247927513443585,7.266786540694901,7.285402218862249,7.303780748177103,7.321928094887363,7.339850002884624,7.357552004618084,7.3750394313469245,7.392317422778761,7.409390936137702,7.426264754702098,7.442943495848728,7.459431618637297,7.475733430966398,7.491853096329675,7.507794640198696,7.523561956057013,7.539158811108031,7.554588851677638,7.569855608330948,7.584962500721156,7.599912842187128,7.614709844115208,7.6293566200796095,7.643856189774724,7.658211482751795,7.672425341971495,7.6865005271832185,7.700439718141092,7.714245517666122,7.727920454563199,7.7414669864011465,7.754887502163468,7.768184324776926,7.78135971352466,7.794415866350106,7.807354922057604,7.820178962415188,7.832890014164741,7.845490050944375,7.857980995127572,7.870364719583405,7.882643049361842,7.894817763307944,7.906890595608519,7.918863237274595,7.930737337562887,7.94251450533924,7.954196310386875,7.965784284662087,7.977279923499917,7.9886846867721655,8.0};