#ifndef LODA_GENERATOR_1_H_
#define LODA_GENERATOR_1_H_

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "ap_int.h"
#include "ap_fixed.h"
#include "hls_stream.h"
#include "hls_math.h"
#define W_WIDTH 32
#define I_WIDTH 16
typedef ap_fixed<W_WIDTH,I_WIDTH> interface_t;
    
typedef ap_fixed<32,16> accum_t;
typedef ap_fixed<32,16> param_t;
typedef ap_fixed<32,16> score_t;
typedef ap_uint<16> const_t;
typedef ap_uint<8> char_t;

struct DataBus_IN {
    float data;
    ap_uint<1> last;
};

struct DataBus_OUT {
    float data;
    ap_uint<1> last;
};
    
void loda_cardio_c6(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score_loda
);
    
#define ENSEMBLE 35
#define DIM_MAX 21
#define BATCH_SIZE 128
#define N_BINS 20
const static param_t bottom_loda = 2.580379516762855;
const static param_t delta_loda = 0.0805177582801107;
static param_t loda_min_X[35] = {-2.517782644223163,-4.047335231571638,-6.521515332841384,-4.307885321550432,-5.9181293057197735,-3.320289853240742,-3.9866400380720406,-3.2989367288417397,-5.05753123850593,-4.201133294611026,-7.234708416403747,-6.167054339665664,-3.5335627466439163,-4.226381243174299,-5.826661508423845,-2.2150032048878243,-3.0624868253171034,-2.82307746010866,-3.9774203825238237,-6.9192985189064915,-3.2430781137853177,-3.393110872356007,-3.538301912968751,-6.077752281019733,-3.2020804675112684,-2.3823341470284034,-4.357861936661807,-3.9464979899413466,-3.321625451689475,-5.796735928449532,-3.889037646299108,-5.086855587248991,-2.319996988955097,-3.059566704386534,-5.944571237741871};

static param_t loda_projections[35][21] = {{0.1746601861269388,0.0457118422060759,0.07346676944944538,-0.04183871132753552,-0.3738756827763572,0.1130563156350038,-0.01189654323492015,-0.3872864697165328,0.15027968364486563,0.012837952972097041,0.19904218779276772,-0.11844921385982553,-0.3711060962691362,0.06193325307700165,-0.3498446612791611,0.1005635113011559,-0.23869226461188706,-0.44591246350510844,-0.13011352817569885,0.17240529746279035,0.06810062588793767},
{0.07480626203467511,0.3352679331407399,0.33186198147656537,-0.0012054674051747616,-0.0999230248915221,0.10836946848515294,-0.005443175652856637,-0.27938616889354184,0.045242810510502135,-0.0872619125735904,0.15936077906835314,-0.012152775628586469,0.3583069584027081,0.03322075320390801,-0.4214503509518362,-0.17881418283404854,0.26019078222504255,-0.13730417234496278,-0.2506667811677443,-0.004251752654306186,-0.3851748931596363},
{-0.2689649700468198,-0.21225889481777083,-0.06839059294618854,-0.03621878292892038,0.17840044467954358,-0.0979296637254775,-0.10157386512020875,-0.5947673026960769,0.10125293318028473,-0.15113515533892083,-0.12847455577111605,0.03391427076338117,-0.0812484414312988,-0.12051313971683256,-0.01864479558566574,-0.4065751276319249,0.12361134491342274,0.18208184935960944,0.041117612159231716,-0.2684291984139642,-0.3338091880834593},
{-0.06867963383787186,-0.6205652532381264,-0.39425825156938615,0.17340187576132296,-0.25768016494992757,-0.01347929486456869,-0.14360887403162417,-0.023721564383650452,0.013019272107465996,-0.06659655533859302,0.001005700127668647,0.11663176996610414,-0.2570198363536539,-0.059475213860949644,-0.30840953855273734,0.07079403706590041,0.23513521598667889,0.13946649353412777,-0.09432041039604919,0.20400032179062866,0.1540189947916031},
{0.15536836559740633,-0.23537522054325208,0.1974640340619811,-0.14332363966874598,-0.2651005492863095,-0.17617640727467918,0.2921616683933295,-0.0006838559809661609,-0.16665287411432853,0.18629801134531682,0.25332734972553933,-0.10780180988610491,-0.28344390968088734,-0.022780704673460366,0.08182340151074893,-0.4372454485574718,-0.219337910610128,-0.4108441991670085,-0.13215071320116314,0.011004281329850004,-0.1508276580675228},
{-0.210136886458717,-0.11435970623232314,0.1401245546271328,-0.23220470025159082,-0.19059729180625412,0.18958961790183043,0.12480968662670006,0.32268475360713655,-0.4367810359986381,-0.06848382854457671,0.31360504743987483,-0.2497332141184113,0.19084412991605743,-0.12635649430350865,0.39826037065253833,0.02784631087203262,-0.21137427849830365,-0.0048874230131453825,-0.21968058924696102,0.12047194096912768,0.04246473791928125},
{-0.140538692406143,0.08365133461327426,0.3799357843948675,0.22796263277500028,0.17082888588654205,0.19101606567285198,0.21766147974170624,-0.24210145622043078,-0.2611843353076672,0.3190088850819331,-0.09492444904204876,-0.3736078395306205,0.10913786210061537,0.15614784560314415,-0.1744149505343966,-0.08453343936306203,-0.13970654299283772,0.10772092173324252,-0.1940780853066574,0.32957487241710987,-0.18822640116885664},
{0.10970396190952957,0.04091930579358343,0.16430578685033592,0.19937419538109494,0.3442788205876081,-0.08650285423816924,-0.18454899994653678,0.025516518293154142,-0.24815816071901317,0.2674655183256542,0.22250429904780583,0.21950712118609417,-0.42228763211245757,-0.08252235878166359,-0.08076111743136705,-0.28863423230456897,-0.29784347819718204,0.05711172629644092,0.1776338545341759,0.04202386582187648,-0.35742293936265274},
{0.2212336851331681,0.11030723203739609,-0.06959088333797715,-0.07440948944336688,-0.1480025382878048,-0.1754855898361224,0.008592762764396328,-0.17006634926417846,-0.06309976314806096,0.5375729192840081,-0.10012047029358694,0.36110497693259735,-0.09942399253986185,0.16703015262737814,0.3327884366812436,-0.07512079920978852,0.0035338726714374347,0.10038482103256491,0.3520689483713006,0.25719456660434586,-0.2430188444790476},
{-0.22630963438818727,-0.04682747374307687,-0.20449863138529217,0.00813497004993063,0.16148089176948732,-0.0022415391621452927,0.007018890059915411,0.3589841186706314,-0.14308295752746716,0.2616683864626784,0.07010424117223987,0.03379857952048202,0.6534146451900736,-0.24336241756957866,-0.19876250035789025,-0.08773669116736689,0.09431004787288116,0.2107862575339845,-0.2323440170017186,-0.04098974633446788,0.11106719460495981},
{0.24794865928617543,0.5800729228971916,-0.05633048364248139,-0.1925276695961948,0.09763105612054206,-0.24725930825678138,-0.1262822710900719,0.013405499282189308,-0.009919162182906716,0.1815248639900372,-0.20758084810696545,0.024983514170908442,-0.03853394640760043,-0.20690141688676156,-0.37794057228034783,-0.20483676447493787,0.18424458428694443,0.254760113434683,0.005720485849781654,0.25501112421178657,0.07235235812616597},
{-0.09002867118200311,0.05298459172975123,0.03440302013149625,0.1664539976938092,-0.5402226444746822,-0.26220305252161613,0.08594535851679941,0.11503025830108744,-0.23709301836277838,0.36245999072682633,-0.05586781106599271,0.36567338758051077,-0.10660188028782855,-0.1734719161163392,0.16305861716951398,0.06600266928592874,0.08315828757743675,-0.01589085840031417,0.2205242985331544,0.32873683595672376,-0.13524515044838648},
{-0.030530623042364216,0.007268942275766238,-0.27067260000299653,-0.29105718957698934,0.24338742101854552,0.21910280079548586,-0.00892997219342548,-0.33835537058224957,-0.5190329480232172,0.34592032185721217,0.2382409543636271,-0.14341898785131338,0.18359112089254204,-0.12404950682376006,-0.059913454254833326,0.267826395303103,-0.04540114962522215,-0.13388141715628618,-0.028812190578733767,-0.0806569604269383,-0.03331561214366931},
{0.33129243176457845,0.036757717674045,-0.283361522753551,0.19499543838656058,-0.16067445132800529,0.26262391887517245,0.02662540378535265,-0.15193020554367553,0.07176612239467269,-0.09860645042877766,-0.09847240761592685,0.06608208437521057,0.3547276673618847,-0.2894417714389086,-0.041339749283708774,-0.22638971460667248,-0.31721844989385106,-0.05419197567235166,-0.31897749176353396,0.0764369574658271,0.3864421763966994},
{0.24174117295604636,0.060615214774528706,-0.18577634127636802,0.2035148272319282,0.5105802439908314,-0.1425808462422639,-0.03760067795724614,-0.16241236898670722,-0.08180750393015425,0.09270251959912372,0.17849788473774245,-0.09641681680626053,0.020210738124028984,0.16565475337593882,0.07400895217408084,0.2203643789904723,0.5083542021137121,0.13211220534237286,0.07305179588164694,-0.3359395079017155,0.14401933830348956},
{0.009338985224943785,-0.2677064267339898,-0.1371407761607165,-0.1394250331252289,-0.3019232859854228,0.10066913704625889,-0.22039384140952467,0.12207059285173612,-0.15843427395889773,0.102002425702603,-0.16029052926764079,0.0837704985245673,-0.2591782902341231,0.3759741155223053,-0.016912483413540434,0.4346670893133571,0.17048727677524497,-0.33059838791337337,-0.20347445234191824,0.12534637042384572,-0.252566490001636},
{0.1584954845804585,0.07471001723001679,0.36842620035664025,0.2826225158293255,0.014141445445546044,0.0832290993229716,0.09265534909333313,-0.06105899091087288,-0.2837772683275822,0.2517634549850033,0.0006298414531043205,-0.18135084283381567,0.16563302967080076,-0.36695377848900357,0.14515102523452514,0.2085498305643132,0.41941324016041726,-0.04977852878857337,-0.20660989792745035,-0.005609440406031411,-0.3311877921875506},
{0.04152230738321461,0.27642497139807004,0.3065011756554619,-0.06389377983128319,0.0222517677967848,0.24350244929333634,-0.2478310613150781,0.13142372581235864,0.0009930106001574328,0.27895187997309273,0.06806848856579055,-0.051041109312446535,0.21354495091472223,0.3219703928592874,-0.30082685031707934,-0.1761058575952165,-0.21339639276610123,-0.13516878989555903,-0.12332361894637305,-0.005225715062134248,0.5004837551663023},
{0.07517953679968756,-0.34063004178101397,0.35788549290874055,-0.03930660907204918,0.007963667587818687,0.35896585091976835,-0.06074125373578963,-0.23386468276886863,0.07122848357168353,0.354468614134078,-0.022802982146018693,-0.19699928238079875,-0.07127435786217348,-0.031171995253450508,-0.30653454672909974,-0.17259432820601817,0.026781317879412802,-0.4569682990420993,-0.1149152713045483,0.01029868879718075,0.19669034086467246},
{-0.19163739203140456,0.16276871078006763,-0.3015784937796551,0.2835478294449215,-0.268775699949731,-0.16531026669614157,-0.17244017726916677,-0.1378610784697384,-0.010902582153961522,-0.22240069146268132,-0.2131305461865694,-0.2587634547015586,0.10667273119970101,0.4369930949246021,-0.19128580464050887,-0.42016950377274315,0.17568556506840544,0.05189143331190782,0.018771789332269768,0.06683853796992441,0.03614746111645217},
{-0.168790384581447,-0.08486827573520102,-0.24858610940541953,-0.21408224253185318,0.07370917567867236,0.10672858854721629,-0.14404408937692512,-0.14903322724226753,-0.1465845147751008,0.25501797369576434,0.061014847313521386,-0.2341490888125259,0.11706334180643638,-0.16253785211476368,-0.045642908656367775,0.05480860998095011,-0.0769381535048351,0.1496618595297305,-0.05970343666700062,0.7380925224873114,0.17307405512855378},
{0.14447981577188582,-0.08166693604435482,0.09169775827308939,0.07255591208052078,-0.11116030447273217,0.2266309561312395,0.15872847578504218,0.1885190524155463,0.006427953719362771,-0.33969936966148184,-0.38747818384151633,-0.21503144258924423,-0.04461571191970498,-0.25205860435959193,-0.027558264884297128,0.18887580827758907,-0.28630129851329084,0.25610090543432473,-0.08689004470756649,-0.3205005643636685,0.4034003163281771},
{-0.23621137589212404,0.2282673204333797,-0.14677283133038485,-0.25901821502256517,-0.5543632583174051,-0.0897892996329083,-0.1372317894012759,0.0982528311096232,0.06144758185565789,-0.07785251195055855,-0.11257063807674605,-0.26835383313354183,0.07072458859775045,0.31549563574617306,-0.08639789638515892,0.2844741383319575,0.2852993025904791,0.07976434632152889,-0.1875060074349565,0.0369765092536766,-0.21877486704218913},
{-0.04783094315989807,-0.0039140111140170235,0.14882055536683803,-0.06788944967114181,-0.21558966929344195,0.1003343228585931,0.06914240215040501,-0.310932656890019,-0.3274055659608376,0.10852664998374327,0.4810253256901143,-0.34365194054925285,-0.2393177252457217,-0.08630782447301993,-0.2510922831244525,-0.27708533986393474,0.2467162235084982,-0.09075970079554381,0.2589667878803213,-0.047849083868805986,0.03840614947122673},
{0.24639999281568378,0.5675516344886893,0.3846196837013722,-0.10400520234942255,-0.10807266304657173,-0.09061158579316539,-0.09261906939329771,-0.1326095463056452,0.41024807164993454,-0.13819529487087612,0.06216345815788239,-0.2812341952018956,-0.06851637522899247,0.01693545099622891,-0.08221453738253356,0.00412824132724222,-0.0160529660730507,-0.055125503090079235,0.221753019355756,0.277530457295878,-0.027550317991658854},
{-0.26517912115600795,0.031675462486234804,0.02393705256536991,-0.20957175943600861,-0.08453202098014975,-0.050309827609869615,-0.1638525840321276,-0.017949590322503938,-0.15715738124873962,0.22782084346026024,-0.32801014986634225,0.21067396444772762,-0.46627941520931515,0.09141979284978739,0.10400816774925772,0.15403686323633514,0.010439426485285784,0.31638754060322166,0.007351132283600553,0.28207064778181584,0.4226284016654091},
{-0.19587345095581354,0.0037033718481324605,-0.2778683581693349,-0.12080925774955568,0.08890536389220001,0.1592896992670218,-0.0038479585989861526,0.3287031495666945,0.07040511878533277,-0.21670244703561323,0.2871025758818532,-0.3200797021320521,-0.3368373808895844,-0.11918191799731417,-0.3568216410598396,0.10723079238030378,0.2542660652767885,0.3837332259039493,-0.06328998811206879,0.04451227182215527,-0.08548237784201149},
{0.3401021277308401,-0.25233119980161767,0.3048076806340962,-0.026117176967610952,-0.04046254901203739,-0.08872671762455034,-0.4741715542210285,0.2730279823759306,0.028113239859462756,-0.13776216299848393,0.11222118499414566,-0.061565018060743715,-0.13252984932762696,-0.11499634501029408,0.0034205129911912854,0.376681916591381,0.18199134732442582,0.12406760758729726,-0.32651562987395305,-0.16459893148112753,0.16467028339459747},
{0.41098511902372803,0.5226499565794195,0.11068587411166741,-0.09410756639772817,0.2781699983202819,-0.005246444160109886,0.07804356841746957,-0.4148951067976117,-0.020021526705956225,-0.04391382895816905,0.17558560280375904,0.14589379359597113,-0.08684659718728631,0.008525525793476502,0.01834153171946171,0.3067066434065247,0.024758618313987363,0.04886210365351175,0.06918271340460398,0.23442729263053197,0.2489537250484825},
{0.32172294972280047,-0.006878150285832148,0.32509489882105447,0.1282490273892218,-0.34155453560562943,-0.1744663260195749,0.09791002296893023,0.15635621601663116,0.2663711680160439,-0.08270261641594538,0.40349192381513543,-0.49649872699811487,0.09263894996177785,-0.020899789038092798,-0.05938789639843779,0.11904343750056795,0.027786907262474743,0.18114828626726015,0.05199809958243511,-0.05393919525944715,-0.20038402617097045},
{0.01979700965736594,-0.4115713207528843,0.011454163323408048,-0.03077340703245211,0.3887566286399285,0.10670950049308008,-0.2631322614524768,-0.0015673942514303017,-0.011147937288960139,-0.24010517262021197,-0.31918194280485435,0.1156646258181877,0.25603656638519134,-0.04443651735059822,-0.04657639644292657,-0.06742705828970152,0.35255972873732466,-0.03517052915436495,0.15121769155535167,-0.3331382050697722,-0.3011989060273163},
{0.16660947761880004,-0.22632220724457505,0.19505914982257413,0.09858518023095506,0.22646827349895846,-0.09405146553956738,-0.18828761407141423,-0.024395636316609643,-0.3914760021547863,-0.14070477816472637,-0.2738715598647187,0.038475125570997006,-0.22163102637771262,-0.4523145016328198,-0.09714490388930598,0.26605576242113826,0.09694618474073244,0.19588718436674216,0.08905287790191067,-0.3604299181474278,0.08939924817455408},
{0.3671736785448687,-0.07855292383357923,-0.1956933800944546,0.15807188465011018,-0.3293878661331166,-0.1357038473332243,-0.06155504868068807,0.2495101177092958,0.0862255492493965,-0.47081747794737555,-0.2468515008760964,0.20166932921951353,-0.007192362913779977,0.05614903188190969,-0.024434722336121092,-0.008993992075020225,-0.26108259071491774,-0.40574092198977,0.1488750356550222,-0.10722000042942409,0.04161548991640329},
{-0.2760187457313766,-0.6083665461832992,-0.028373032185123787,0.08410957379618374,0.16526541746458512,0.09522639292113973,0.12470736524856994,-0.19921534386570658,0.024426402079608805,-0.32571947309506116,0.19121534100990295,0.059976558207213114,-0.03035176514574623,0.2581517127916834,-0.035257284499389425,-0.19642849551224012,0.0888040922634886,-0.031651764827615156,0.10621553047502548,-0.06302962898320012,-0.4193106067126538},
{-0.07372048671361589,-0.19411130131889828,0.15471101428771827,-0.18337989797585771,-0.11349567429056967,0.3538365659808378,-0.114475705715093,0.268741366800202,0.31878370339258977,0.26134368929793594,-0.34199171479192236,0.02335315018943581,-0.32660244165622937,0.11985981015998798,-0.16799204326439943,-0.34715356495875244,-0.06081958916024409,-0.08856440778544811,-0.2686385418147063,0.18545783173001487,0.024709008133312803}};

static param_t loda_delta[35] = {2.7838421319963595,2.679117897334962,2.132069197342657,3.2030058727513753,1.7306695442336588,2.317555944290729,2.1784823081703726,2.936712476687313,2.286588734199255,2.4598736575664506,1.8795346514259887,2.1245839191173665,2.377258800168923,1.996571327907932,1.8618402163573342,2.4012639949404946,2.8629822661345554,2.788037201895179,1.6894859259235422,2.063405434132413,2.4537046004153713,2.465116971540259,2.913752835732788,2.2334236140896104,2.506604018148764,3.205776625819644,2.787483753230864,1.91117763551151,2.0100064078631803,2.159114335324972,3.296879517555937,2.4883396533023827,4.0057437393151405,3.450774731044451,1.3084871423098567};

const static score_t log_LUT_loda[128] = {15.0,7.0,6.0,5.415037499278844,5.0,4.678071905112637,4.415037499278844,4.192645077942396,4.0,3.830074998557688,3.678071905112638,3.5405683813627027,3.415037499278844,3.299560281858908,3.192645077942396,3.0931094043914813,3.0,2.9125371587496605,2.830074998557688,2.7520724865564143,2.678071905112638,2.6076825772212398,2.5405683813627027,2.476438043942987,2.415037499278844,2.356143810225275,2.299560281858908,2.2451124978365313,2.192645077942396,2.1420190048724277,2.0931094043914813,2.0458036896131246,2.0,1.9556058806415466,1.9125371587496607,1.8707169830550336,1.8300749985576876,1.7905466343710503,1.7520724865564146,1.7145977811377517,1.6780719051126376,1.6424479953819162,1.6076825772212398,1.573735245297902,1.5405683813627027,1.5081469036703252,1.4764380439429872,1.4454111483223626,1.415037499278844,1.3852901558847919,1.3561438102252752,1.3275746580285044,1.2995602818589078,1.2720795454368008,1.2451124978365316,1.2186402864753405,1.1926450779423958,1.1671099858352583,1.142019004872428,1.1173569506381587,1.0931094043914815,1.0692626624371138,1.0458036896131249,1.0227200765000835,1.0,0.9776321869715455,0.9556058806415466,0.9339108095422276,0.9125371587496606,0.891475543221831,0.8707169830550335,0.850252880495318,0.8300749985576876,0.8101754411199827,0.7905466343710502,0.7711813095041191,0.7520724865564145,0.7332134593050986,0.7145977811377517,0.6962192518228971,0.6780719051126376,0.6601499971153753,0.6424479953819163,0.6249605686530753,0.6076825772212398,0.5906090638622983,0.5737352452979021,0.5570565041512716,0.5405683813627027,0.5242665690336022,0.5081469036703252,0.49220535980130375,0.47643804394298717,0.4608411888919686,0.44541114832236267,0.4301443916690522,0.4150374992788438,0.40008715781287235,0.3852901558847918,0.37064337992039037,0.3561438102252753,0.34178851724820525,0.3275746580285044,0.31349947281678164,0.2995602818589079,0.28575448233387735,0.27207954543680085,0.25853301359885306,0.24511249783653147,0.23181567522307364,0.2186402864753404,0.20558413364989406,0.1926450779423959,0.1798210375848123,0.16710998583525832,0.1545099490556248,0.14201900487242788,0.12963528041659547,0.11735695063815874,0.1051822366920565,0.09310940439148148,0.0811367627254055,0.06926266243711372,0.05748549466076013,0.04580368961312479,0.03421571533791296,0.02272007650008353,0.011315313227834146};
#endif