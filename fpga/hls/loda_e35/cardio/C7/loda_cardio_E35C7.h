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
    
void loda_cardio_c7(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score_loda
);
    
#define ENSEMBLE 35
#define DIM_MAX 21
#define BATCH_SIZE 128
#define N_BINS 20
const static param_t bottom_loda = 2.580379516762855;
const static param_t delta_loda = 0.0805177582801107;
static param_t loda_min_X[35] = {-8.061602524849608,-6.64579330237201,-4.5832887585436985,-6.260735912286573,-2.274021676965349,-3.6694145973604053,-3.931268407422178,-2.4317253608645095,-3.145127548996,-4.706309984795455,-3.9620376038069454,-2.322371840438044,-5.269613812632588,-3.752875033323705,-6.1549600547879475,-3.6732040750472224,-2.9603880206191886,-8.826024440221218,-2.4706825695680017,-4.392084006147477,-3.7925755510679715,-4.15722314435728,-3.639700233482272,-5.99446893627907,-2.616082437483169,-4.519211955220546,-4.778908936530748,-2.880123622380621,-3.499183280388097,-5.4153787210588336,-4.873623613073963,-4.190565550266668,-3.7740872858732075,-6.740074832190197,-3.783637893270563};

static param_t loda_projections[35][21] = {{0.008293157108687959,0.18055329589965705,0.27511645873081864,0.0747352661439746,-0.09304243347103301,-0.42360739737021996,0.2172503763485419,0.4973298931279061,-0.28832234950857233,-0.1447029856231198,-0.06923552433037578,-0.05870413459147577,-0.4360001737116499,0.08661268898252392,-0.002622294736617818,0.11308263424111745,-0.07101289998748238,-0.07847212228150607,0.2160714507683452,-0.14377220959532783,0.04651318461162448},
{-0.16251025470567726,-0.29684544502980004,0.08680628215032378,-0.14921835513712683,-0.02908295606481619,0.1550338084286158,-0.012882382639690774,-0.028864668893825465,-0.2970578569952465,-0.06510308193855661,-0.2019778170241483,-0.08869226556881062,0.3056491051515592,0.16627173581666221,0.06335498502267299,-0.2992140646525757,0.1500679478442434,-0.19644085202734027,-0.6232558939172258,-0.15062513153651402,-0.042336443553735115},
{-0.1707264940496048,0.1665274949476631,0.2680569363253453,0.1845341269248839,0.013961819820347143,0.03365751696697214,0.01930863586940319,-0.1431660121328256,-0.5376296349943778,-0.09216770136244191,-0.02132477763680279,0.20558099885774106,-0.3491397108713162,0.03184150963197874,-0.21251952400092816,-0.2567214086561028,0.3417273973438089,-0.2694844244404176,-0.10881385637540328,0.10662914469976544,-0.16782505851485396},
{-0.018807214211800757,-0.36879752002676,-0.17263597939357211,-0.00512205107561882,-0.12537279909574278,0.2036728872193614,0.13989649450229055,0.01140130488648299,0.29473831120763466,0.23386015605621308,-0.19406461064620137,-0.1054264680689989,0.2865641427011484,0.22575674749676589,-0.46012004898336234,-0.27660064262124284,-0.13507492604421142,-0.3428473362513852,-0.06415923409241593,-0.06625526935046437,-0.031096767452761038},
{-0.5493803502698891,0.06341505661001302,0.07094000269922718,-0.18125437393797,-0.36780259735401366,0.0759675208420401,0.031525932957248495,0.07195386279515116,-0.03642515853393858,0.012849309485191085,-0.04991917578476871,0.05595110303898061,-0.29555160232841143,0.14222063758934878,0.213676659516281,0.050576877668452966,0.09495269624793001,0.08814614088300762,0.22889590265859086,0.11130396443459285,-0.5143713312791398},
{-0.341330987102313,-0.03793970285205655,0.10393004933844553,-0.4407041794376468,-0.14276345862350737,-0.060752402741182675,0.3573695809065591,-0.25704025021461957,-0.2192047399796271,-0.10142900732179794,-0.028533650108007774,-0.1945635692246688,-0.10133141270582463,0.07838777974983197,0.34772430989217423,-0.07479922545450358,-0.24711385505151784,-0.1455756171053696,-0.0573963246062978,-0.34636088991475233,0.11718313050511596},
{-0.13807597207982147,-0.30456031443006687,-0.08192381265038982,0.18199849124417167,0.06742771162173496,0.5090200797677801,0.08441386740954009,0.1049984469288283,0.17644447663136534,0.19555664648523727,-0.23652987573142145,-0.1419702051218096,-0.24297219699338157,-0.022216490844325126,-0.0029550550212097955,0.05366890729929035,-0.17101640321501316,-0.11054884182988574,-0.29515063489569765,0.13660299662235023,-0.45979094387341474},
{-0.15822942340731316,-0.08892715216622853,0.15519139933805343,0.5157309331234929,-0.042039553134852296,0.06773607044185961,0.015371346176280835,-0.10527558449579633,0.47313534640094873,0.4303665677132554,0.07305710138872386,-0.04954435468862408,-0.07147067081144494,-0.0928058966871512,0.1116604577922096,-0.10530853813000644,0.20051197121267075,-0.020316667401024918,-0.1551037159997035,-0.26061217717852464,-0.26940837569347625},
{-0.09981260324185738,0.0538569742869029,0.10541871161956066,0.0648693912495794,0.04010953176601192,0.357557255730232,0.23230652581724154,0.31983839194791713,0.23261334425509528,-0.12886693139873817,0.24185011006299018,0.1364181341435882,-0.24230401712166835,0.0018146204839881847,-0.43524316000490026,-0.2258372545755762,-0.06851056035947764,0.001332256883156504,0.29445131373583244,-0.38433100796241976,0.004339497368012254},
{-0.3027651734929139,-0.2654273719185299,0.5761496400225897,0.028547058280996285,0.1443048222851217,0.24744604474958531,0.1019916859306851,0.046087998628693776,-0.21576865674058585,0.00494152446158079,-0.14771226144075533,-0.07049994175700754,-0.009459327170678959,0.1381333713050759,0.09101590135104157,-0.25628905038847477,-0.20045518899797257,0.1274263514641395,0.2124438795368384,0.21153240276101162,-0.3126216586292886},
{-0.4523183492560105,-0.02469561348597622,-0.1334632772760675,-0.4826124453318673,-0.055450779628396354,0.0037609932793256856,-0.2798194843557283,0.3012951083172792,-0.22214742849340055,-0.1786544830806328,-0.1031443038642979,0.021326147460703816,0.11833598642218011,-0.016991064327197703,-0.22968989946099547,0.22323204825419946,-0.2748139383180751,-0.20138300957800404,0.07617286488288191,-0.019932751674907767,-0.20095871709206037},
{0.0020985585829497158,0.054158120628146005,0.17276457416884672,0.03879113053102316,0.15998210648388322,-0.005956336336308645,-0.055933480615842295,0.1310503753441924,-0.35748693888583016,-0.09967443852061403,-0.12907121080719897,0.22354823829310222,0.01877305204619912,0.4452879388175996,0.030414761121640144,0.5746605289529899,0.0006081306165254465,-0.28601570998734094,-0.2603093583893501,0.18061947533829706,0.05855995983920424},
{-0.22973819851951052,-0.0508791729678809,0.06498358825932131,0.2461245834584002,-0.2387852200788744,-0.1376378587977922,-0.5166033807548137,-0.2290245419267134,-0.10394055252622551,0.11597890064431501,0.15046364931571746,-0.14630972550928154,-0.025589021614010728,0.13018649018486045,-0.16552720177536562,0.12912849046840644,-0.02928359415993284,0.22671246285721453,-0.4122100096478842,-0.3637582917622236,-0.008188372690924192},
{-0.0671714432157322,-0.1768132546721921,0.051025795488012504,-0.08791184753798342,0.10377264775566616,-0.015891602517109964,-0.36144262283486084,-0.5455840077866053,-0.06928455142900591,-0.4456564961356457,0.04625793255417209,-0.2935832902929642,0.15883190339577716,-0.06218202552195018,-0.059298562564238134,0.2430787123024183,-0.2109785508605491,-0.16337901455203768,-0.15219080302044807,-0.1890215039714456,0.03216171672615098},
{0.12199783798538441,-0.10256046888804235,-0.1819042508713835,0.11659018438599572,-0.15589431022827596,-0.2588699193745333,-0.07505425630401973,-0.2573509072554629,0.17408755539267814,0.04262878420385264,0.20494738097063275,0.26422447720472547,-0.06651164837841968,0.3267967551726015,-0.4074459228576953,0.06651596878907379,0.22481577039141226,0.092685576466671,0.019142927564142116,0.4621284108196086,-0.25705274848989806},
{-0.020630756191947035,-0.42090382014045563,0.17822307305037022,0.06432837598644935,0.5003488447844702,0.02594133471365468,0.10880093347821497,0.08580058925576951,-0.23889297322948816,-0.0602302285836723,-0.07718705605386969,-0.4103317973369907,-0.29369317967552505,-0.11392386407905655,0.22178243215297844,0.006179495298679326,-0.1748720763222875,-0.2740666804109628,-0.0621135341309344,-0.10417182669917585,0.11136097709823602},
{-0.38356418381025414,-0.042483545601922995,0.17478712956417475,-0.09843072558014687,0.14053217131103218,-0.026106260072353074,0.2057481223342764,-0.3489878807927503,-0.08447363196198641,-0.45425354846454524,0.25871036042373946,-0.3960298003752952,0.16803545375134626,-0.1634132377299498,-0.044757435641242946,0.059707386248707355,0.0510674570111565,0.25171119575122847,0.05708637433242645,0.23873716220508562,0.04793147117120933},
{0.39276842154961833,-0.4140144622506856,0.261386339213978,-0.11343985942022686,-0.23155799266632862,-0.29888050824052614,-0.21961087779634866,-0.012973721296478781,-0.18229473903078638,0.10166987106973512,-0.01461021925237004,-0.042123482108820526,0.20721121860297306,-0.32927994110947517,0.15121103637356412,-0.004239858569994563,0.14125558936970162,-0.07393490462825249,0.36049930471277086,0.017994989339016464,0.16212362975784567},
{-0.0427634269253041,-0.171204189319445,0.27465312189827285,-0.03877771218702905,0.23837160428782245,0.21987004374391889,0.3732441542531837,0.0364277237879438,-0.282471550177497,0.24052270272744064,-0.03484679876887678,0.3720567379874086,0.022840581882679015,-0.08987393308722513,0.13247362694097445,-0.037423032524580374,0.25424546472869114,-0.0701712087379052,-0.021083954575560185,-0.0453493200252779,-0.5188678618067943},
{0.05523932658569484,-0.10870563682542798,-0.2000302514646484,-0.17694601605898108,-0.04147259049727785,-0.03479807037792205,-0.3361814197447988,-0.42075618657574415,0.027828704602181915,-0.0518676098192513,-0.14463475198965894,-0.24181809748933247,0.5294653483100071,0.25079232444943783,0.14618243935145653,-0.2585077662252188,-0.165932295407794,0.16382495773821604,-0.01093471144481147,0.22206447770524837,0.052296857272143595},
{0.32498317930138537,-0.1540111580077039,-0.013902284097058279,0.1646435923438646,-0.261495094074502,0.19849442087301558,-0.1671726310344213,0.5131050291159697,0.10662445962127486,0.10107526849431374,-0.08460297045977384,0.14184882364377205,0.07807348987942958,-0.039366549856515914,-0.23387325773903514,-0.19091696213107134,0.4509659548897749,-0.02382222047849704,-0.24172121252161793,-0.17312426531710312,0.06609588660372713},
{0.008106908451759178,-0.2782883513528279,0.06618217384938012,0.2678431322485107,-0.023144255648757897,-0.09241079978405818,0.22729066710357704,0.25635931234547,-0.1480588051482325,-0.3222935186339336,0.3653757520173103,-0.03551699410632858,0.23247376617109283,0.44800851435736233,-0.31205920220321853,-0.187833056376147,0.1472430980666373,-0.06609701408390893,0.06893651358806635,-0.15820020500728668,0.1269294901307859},
{0.30518497763318253,-0.07424185140189996,0.281880743949412,0.3819463714927719,0.3371267403466327,-0.23503886174554292,-0.01847551810409697,0.003739307679123992,-0.14344900223097565,-0.10115567687321267,-0.055296074374848736,-0.14089038620551025,0.030572523916852078,-0.0879080166556042,-0.27477205625969675,-0.00015884646579026357,-0.4711289874249329,-0.26633305373154587,-0.029879389502766904,-0.0654714539963487,0.2660870185108605},
{-0.0796474653785871,-0.24609675154940142,0.19945936673547923,0.33656253149033866,-0.28748824261990025,-0.001169076885745668,-0.08431590609659079,-0.17924146248160439,0.08488066289285195,-0.2666887168659795,-0.09616631292937776,0.09737588513758894,-0.37797341499737286,-0.09518358280276751,0.03719732153448939,-0.42648476103905264,-0.09002342544115328,0.3122209783654764,-0.11379789869655771,0.03007704042744817,-0.32626934626685333},
{-0.15226259626465186,-0.4142457699094294,0.17935326761503073,0.44799744145156595,0.17526248627337296,0.1818590329045475,0.040595694244351145,-0.2746173505049652,0.14028993251916813,0.21467612758309745,-0.19571696058262705,-0.2557422887449086,-0.09786709259493075,-0.18809108145519507,0.025414078283927683,0.19588245607500432,0.3578068441770906,-0.127357562660536,0.12587327273729898,-0.024115715534463227,0.13181492188938826},
{0.06356934004336541,0.15005252265377358,0.040905350135561,-0.1652214917876083,0.09921202411295217,0.20186435853264426,0.19385339825072329,-0.5232223553001801,-0.20947769115701664,0.12350545045335076,-0.11847803287431376,-0.03531201769111031,-0.1601742766054647,0.2948490257649869,0.005080403686000569,0.17082158288197744,0.4882744846346556,-0.16962891609280423,0.12589710418863742,-0.2320978333056449,0.1715147018760303},
{0.41458607891886085,-0.20519537116971698,0.2011763954174587,0.06106901991187688,-0.07131724538095696,0.26627540873873556,-0.07894887104048351,0.1538989115586036,-0.36572635334388787,-0.0404653046652221,0.17416197153550808,0.1348997585388893,0.03020492414709469,-0.240400890313185,-0.12289428817084078,-0.2592336750595773,0.15048032436751096,-0.29755045084649906,-0.3897431121113241,-0.07860139348722096,-0.20423831368751744},
{-0.16534444120789035,-0.44345604337483224,0.294168169156439,0.12363163126109597,0.11090047449861432,0.46550713705912306,-0.09066070408193647,-0.1517132619838621,0.29700431732422444,-0.09388902557080245,0.31576449207385654,0.04787574918859453,-0.19655777823347326,-0.13136257725564868,0.10694084817806815,-0.09566771890988397,-0.24143073754965264,0.03893916893925593,0.2540717941757029,0.11045693033962048,-0.04349878834631351},
{-0.28608094678966545,0.44027410330557865,0.3464912876941591,-0.08025024071860369,-0.02684072532786578,0.04910553154090361,0.021818177019214548,0.29645736601039147,0.02072232013843608,-0.03397848857671281,-0.10317062319033048,0.15270522543850226,0.2468809070465205,-0.3112399821831517,-0.19359695573034738,-0.050010570032732654,0.12156134838257975,-0.41741694593012446,0.04039547022594914,0.15715190704782733,-0.24007158297236372},
{0.38296866094262016,0.04546360127434656,-0.27738090804175,-0.369463311638944,0.3275861465925095,0.11470910830828047,-0.4758385107341773,-0.11916786385582245,-0.18430247954749485,0.28826686837854926,-0.06899489378989401,-0.09469417368159033,-0.0459028409178428,-0.226118425678041,0.11033057495149709,0.21020721932440234,-0.14486996377442926,0.0778205155055987,-0.0809851746144483,0.050314374711732404,0.01442763602144789},
{0.38228155704510497,0.09571399357602127,-0.09320026064323834,0.19783210911387422,0.16797314719781492,-0.13615225976907186,-0.18322334519712555,0.2947242127262661,0.23232055300332005,0.0431119382048238,-0.2578463126590771,-0.21678261873946497,-0.06584290921460619,-0.09755213341680113,-0.18980241020374636,-0.27714216761985233,-0.1359665855491813,0.20837153983016246,-0.3840053882127702,0.1903144739258135,0.2968325182691839},
{0.47500107743839004,-0.17385876267057718,0.032335282515926156,0.07193970075541131,-0.39283837667551963,0.035305538019164584,-0.053277580294150174,-0.10804875188292817,0.2356703507931843,-0.1344451726661127,-0.0634404707573912,-0.13678626848842615,-0.13471494580827076,-0.39787276715296727,0.22715526770966982,-0.3627980973959899,0.15629449773009846,0.16964849005644764,0.20611165325204464,0.043195511156137414,0.11943299223605923},
{0.09661700902707826,0.2341767630513098,-0.12563034080728006,-0.24622505385580967,0.2123227497250447,-0.1909087985136791,-0.12768588523258131,0.3140835995480197,-0.2429800146528148,-0.10350118107204408,-0.1264457465297542,-0.3734746422894198,0.3279978305794774,-0.05046602713215163,-0.11244281897569039,0.162480156470902,-0.14788478187835832,0.023905330639598214,-0.17899496756612976,0.3532274052648241,0.3305918189490969},
{-0.28030955309702094,-0.02758002981363122,0.1373233906336575,0.3022628528032933,0.04893161576336523,-0.294372141719536,0.08506548366722487,0.15961611114892826,0.14536034268408005,-0.26298571412991545,0.20407769610126386,0.06213611537408436,0.34976996946036776,0.2748417265118385,0.24220726228752967,0.3107588274924312,0.3291943597601755,0.08272536665979034,0.13125975145280097,0.2594689168832999,-0.0022057788913924913},
{-0.3887901738672208,0.2633238824406338,-0.17741795661915905,0.19246706844653308,0.14894189293070245,0.21995815708553143,0.13793532111338236,-0.310046002216805,0.2949763216068215,-0.13421445142322555,-0.026940413363863786,-0.037826024207265385,-0.23411945199486872,-0.14663603176352238,0.019279175875257036,-0.16173773905986435,0.012452617431482576,-0.39661876000081064,0.24268435450055806,0.16659160901345943,-0.2666948385775354}};

static param_t loda_delta[35] = {1.5670932774677466,1.7435399933521942,2.5021422090418497,1.7508074710952992,3.670453249090006,2.416310708385938,1.0563207963908585,3.568080227690208,2.2357321285882223,1.8109617441629422,2.682671379779756,1.9769259818621308,2.7093007356017877,2.994691402108068,1.911930971725844,2.601628515606091,3.46036556091037,1.642955203018322,2.3655338093223093,2.9856827102517083,3.105885510392705,2.911865003470953,2.7171121968996568,2.3689516993490822,3.560193151900088,2.5498384567750474,1.7902283113615158,1.5673716704372351,2.4822405135023384,2.1493088332346644,2.3310012246950906,2.9742670856105438,2.9782770273621897,1.6321767568543666,2.042610729608852};

const static score_t log_LUT_loda[128] = {15.0,7.0,6.0,5.415037499278844,5.0,4.678071905112637,4.415037499278844,4.192645077942396,4.0,3.830074998557688,3.678071905112638,3.5405683813627027,3.415037499278844,3.299560281858908,3.192645077942396,3.0931094043914813,3.0,2.9125371587496605,2.830074998557688,2.7520724865564143,2.678071905112638,2.6076825772212398,2.5405683813627027,2.476438043942987,2.415037499278844,2.356143810225275,2.299560281858908,2.2451124978365313,2.192645077942396,2.1420190048724277,2.0931094043914813,2.0458036896131246,2.0,1.9556058806415466,1.9125371587496607,1.8707169830550336,1.8300749985576876,1.7905466343710503,1.7520724865564146,1.7145977811377517,1.6780719051126376,1.6424479953819162,1.6076825772212398,1.573735245297902,1.5405683813627027,1.5081469036703252,1.4764380439429872,1.4454111483223626,1.415037499278844,1.3852901558847919,1.3561438102252752,1.3275746580285044,1.2995602818589078,1.2720795454368008,1.2451124978365316,1.2186402864753405,1.1926450779423958,1.1671099858352583,1.142019004872428,1.1173569506381587,1.0931094043914815,1.0692626624371138,1.0458036896131249,1.0227200765000835,1.0,0.9776321869715455,0.9556058806415466,0.9339108095422276,0.9125371587496606,0.891475543221831,0.8707169830550335,0.850252880495318,0.8300749985576876,0.8101754411199827,0.7905466343710502,0.7711813095041191,0.7520724865564145,0.7332134593050986,0.7145977811377517,0.6962192518228971,0.6780719051126376,0.6601499971153753,0.6424479953819163,0.6249605686530753,0.6076825772212398,0.5906090638622983,0.5737352452979021,0.5570565041512716,0.5405683813627027,0.5242665690336022,0.5081469036703252,0.49220535980130375,0.47643804394298717,0.4608411888919686,0.44541114832236267,0.4301443916690522,0.4150374992788438,0.40008715781287235,0.3852901558847918,0.37064337992039037,0.3561438102252753,0.34178851724820525,0.3275746580285044,0.31349947281678164,0.2995602818589079,0.28575448233387735,0.27207954543680085,0.25853301359885306,0.24511249783653147,0.23181567522307364,0.2186402864753404,0.20558413364989406,0.1926450779423959,0.1798210375848123,0.16710998583525832,0.1545099490556248,0.14201900487242788,0.12963528041659547,0.11735695063815874,0.1051822366920565,0.09310940439148148,0.0811367627254055,0.06926266243711372,0.05748549466076013,0.04580368961312479,0.03421571533791296,0.02272007650008353,0.011315313227834146};
#endif