#ifndef XSTREAM_GENERATOR_1_H_
#define XSTREAM_GENERATOR_1_H_

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
    
void xstream_smtp1_c7(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score_xstream
);
    
#define ENSEMBLE 140
#define DIM_MAX 3
#define BATCH_SIZE 128
#define K_NUM 20
#define HASH_NUM 2
#define MATRIX_COL 128
const static param_t bottom_xstream = -7.908198388578782;
const static param_t delta_xstream = 0.1447555417130586;

static param_t xstream_fs[20][2] = {{6,17},
{18,5},
{5,13},
{11,17},
{7,18},
{11,3},
{5,12},
{10,10},
{15,2},
{19,15},
{9,15},
{6,9},
{8,17},
{9,2},
{15,1},
{6,1},
{7,16},
{10,0},
{16,0},
{15,16}};

static param_t xstream_R_T[3][20] = {{0.0,0.0,0.38729833462074165,-0.38729833462074165,0.0,0.0,0.38729833462074165,0.0,0.0,0.0,0.0,0.0,0.0,0.38729833462074165,0.38729833462074165,0.0,-0.38729833462074165,0.0,0.0,0.0},
{0.0,0.0,0.38729833462074165,0.0,0.0,0.0,0.38729833462074165,0.0,0.0,0.0,0.0,0.38729833462074165,0.0,-0.38729833462074165,0.0,-0.38729833462074165,-0.38729833462074165,0.38729833462074165,0.0,0.38729833462074165},
{-0.38729833462074165,0.0,0.0,0.0,0.0,0.0,0.0,0.38729833462074165,0.0,0.0,0.38729833462074165,-0.38729833462074165,0.0,0.0,0.0,0.38729833462074165,0.0,0.0,0.0,-0.38729833462074165}};

static param_t xstream_deltamax[20] = {0.39105317842609216,1.0,0.24811202011695074,0.5663290447231158,1.0,1.0,0.24811202011695074,0.39105317842609216,1.0,1.0,0.39105317842609216,0.28774244127026105,1.0,0.27401342464691647,0.5663290447231158,0.28774244127026105,0.24811202011695074,0.35045884862783616,1.0,0.28774244127026105};

static param_t xstream_shift_deltamax[20][20] = {{-0.8434402341806864,-0.1424775910649163,-0.3041031287195025,-0.1495996983486524,-0.21323357926829856,-0.22782484478082843,-0.7082274448641815,-0.4325060120596065,-0.8331798027095975,-0.9877314384259741,-0.30145026255980567,-0.2072723801200712,-0.44807536558490046,-0.74032825086512,-0.35831806167688474,-0.9681872135608977,-0.5854180134094445,-0.3929946741839402,-0.7241061542864974,-0.7943072800135679},
{-0.44080563849104193,-0.6635511457465036,-0.3230032137415758,-0.4119157731218415,-0.4546775081217007,-0.8869430509055193,-0.9015988009045197,-0.6354622236675349,-0.4854363698518025,-0.07312886752347159,-0.8997324503585298,-0.28971467333351675,-0.4914199968836883,-0.7571964796759763,-0.7619408032920708,-0.27057664100725454,-0.3922400366538916,-0.3844709939640435,-0.6803601287808135,-0.599448211732583},
{-0.8334997607743798,-0.9825114945489,-0.4744233277853037,-0.4846861337830619,-0.42808005522301784,-0.9081944073913163,-0.1991057362726586,-0.32379513293218665,-0.8921188264589229,-0.285135961939993,-0.8604498211734988,-0.14681296901633878,-0.7804008769537981,-0.5549762753840187,-0.13037941676952458,-0.7088169727338973,-0.9012463149475953,-0.7916624307623528,-0.2026450052537354,-0.4428802762636268},
{-0.21124202987733276,-0.3638292666534002,-0.9982558721136444,-0.3705034632527816,-0.7040145440928641,-0.531300377941086,-0.48036937705802596,-0.6399372185039471,-0.7902355052285592,-0.7457739850078473,-0.6319051515276437,-0.8978984706645241,-0.8843441820633646,-0.5160761079491034,-0.23927947681332318,-0.9374240130726031,-0.057071953071222925,-0.5833839446365502,-0.6685969322961629,-0.5417265928936769},
{-0.4933291021351348,-0.8814729944336277,-0.9790184215580684,-0.34588962018929337,-0.12626324334271877,-0.7366411381313416,-0.5592031885393798,-0.9831626941053928,-0.9097653796574711,-0.8683658252647748,-0.19497357997510545,-0.47615023933161715,-0.2417393397606762,-0.13001802609213486,-0.9410773434493931,-0.869492539926109,-0.42135141858671465,-0.26823064613788905,-0.7841074030214372,-0.6630615980871831},
{-0.028831294435755276,-0.9881826856374453,-0.9393031419687664,-0.7694771442752232,-0.85527398188265,-0.1456347590117002,-0.9611708790186916,-0.472605302435482,-0.4290246104623445,-0.020269761511153894,-0.17681091983116626,-0.3115278060222295,-0.05376157095837897,-0.691018173932938,-0.4173556323429789,-0.08000932372097891,-0.0930686872625297,-0.8363373544394096,-0.355989445000907,-0.8965705620307204},
{-0.32048282818303353,-0.48453900000772,-0.9246953512734892,-0.6184767047027212,-0.5008466216467146,-0.16584355976470855,-0.9918720411994694,-0.5868047302381872,-0.04166845127058516,-0.7351707892706627,-0.27096778420234846,-0.09011401790449403,-0.8839393491043696,-0.8416501994723732,-0.461060759958851,-0.4135376898173019,-0.6946895332806801,-0.6711649051390839,-0.9445652276577606,-0.3316161325688902},
{-0.5758728095222778,-0.5600272854390417,-0.38356332820720773,-0.07503533084636782,-0.8032095977301972,-0.503841512507364,-0.7896877465700636,-0.23112929076966005,-0.17136123091621724,-0.614521334909552,-0.8363603709413815,-0.07547519227939327,-0.6136946763255,-0.23642570385783823,-0.7921676361542179,-0.815689431409803,-0.5025762880657796,-0.7189940162589648,-0.11131511671291161,-0.9314438634399467},
{-0.5650242183762372,-0.21507112243175686,-0.7468523889059832,-0.9134215088662782,-0.4451236666280999,-0.26782571720388726,-0.8856285461916346,-0.694167509547927,-0.2840354454481403,-0.9259774665604454,-0.33727690464649984,-0.3379430674280519,-0.2775663175982319,-0.4198417463524,-0.9413717956626381,-0.5082963053843724,-0.3297794574639614,-0.010555478875756363,-0.1484981690346192,-0.5709258954058116},
{-0.5495224165388232,-0.7791069714650503,-0.14376713705389732,-0.24620480836399783,-0.18159056538782303,-0.6751643996120021,-0.9213384205369002,-0.055786135691374805,-0.22437371356425018,-0.9796517327129481,-0.08429983665127183,-0.4199499502459816,-0.05085545138775205,-0.7708273631867656,-0.43708911171888587,-0.8472079588140228,-0.995176388058341,-0.3937238775679942,-0.3182674277754215,-0.23879875566844766},
{-0.7878848794587874,-0.2301083164229496,-0.6221264782476507,-0.9097894418719458,-0.11374059105756329,-0.4180551620469467,-0.5239482950284831,-0.977193262135629,-0.8431941752126029,-0.38113722120229243,-0.7423901504128709,-0.033481143701085236,-0.4440776814468541,-0.6328669856492141,-0.5455364564490862,-0.8208110942621107,-0.9714017108693676,-0.9038093319993825,-0.9780058088601695,-0.012565852749197637},
{-0.711719029203377,-0.05302904145706766,-0.5998480278343733,-0.35392215470696575,-0.2890330420875926,-0.3125422044837387,-0.7252185866460233,-0.1266432001474863,-0.3478234458535221,-0.009573947524510573,-0.41022488619303427,-0.09461334357044215,-0.6735343582133357,-0.14902869249823103,-0.17363767895443105,-0.4974572434697151,-0.945808411973161,-0.4025301740745982,-0.09022528118147854,-0.21762687231055833},
{-0.34778710328362705,-0.789587894594691,-0.4703638730894485,-0.7493198160960161,-0.6951319564448234,-0.14713549478537935,-0.6283398999043627,-0.02068670493671443,-0.6178758176256505,-0.9040513063717249,-0.9670405728236063,-0.9264937361241857,-0.793205745433261,-0.9747187080867069,-0.6007581816626587,-0.8657465116447759,-0.07695999732534264,-0.9678897707191525,-0.5028811534637496,-0.8729313636839703},
{-0.8250512401955183,-0.15458445651265473,-0.86613707251359,-0.6047826423868043,-0.3329514530724197,-0.32441269315019605,-0.5092012698552237,-0.6989243452473306,-0.04143396728289672,-0.14194186970242995,-0.5333679925310246,-0.12945020489018244,-0.8311076323709884,-0.6442956295354345,-0.8716057084240858,-0.23434968369955886,-0.23442932152727702,-0.2313573510287388,-0.6756061328078901,-0.044938801451285815},
{-0.2900810921911926,-0.9356161269734138,-0.8521010999767342,-0.11398612401687447,-0.651137015192067,-0.3881155200291121,-0.6647166925265053,-0.38658042240212476,-0.06005735071730767,-0.4066893476556934,-0.7925623706444297,-0.3536126015668506,-0.48419800445006245,-0.654249147056186,-0.8014932656362274,-0.5457482176936305,-0.13116811387746208,-0.12293459781660832,-0.5396721887463509,-0.8383348619422799},
{-0.4966732464383902,-0.4405214391586231,-0.3057305875691251,-0.03662552948168485,-0.09137830499772293,-0.05178821730462657,-0.6784292234454273,-0.7084128504516015,-0.4562433253807906,-0.32993683300372134,-0.3861003041233848,-0.23012039224655745,-0.9065899016444112,-0.8108041092062913,-0.5050021926932451,-0.03129951587054336,-0.4978829516032217,-0.2305624294388501,-0.8512246533185407,-0.25856204698820806},
{-0.4203517375599915,-0.4510772064655877,-0.5676580717169981,-0.271085736964057,-0.614165664508694,-0.7588624711352231,-0.7411112768632605,-0.7475041232734277,-0.034032232952505126,-0.004325444745994389,-0.1774026049649613,-0.12537664581253172,-0.03480534622103659,-0.23945114608637064,-0.8281641914882639,-0.8303772548071044,-0.8240735859155142,-0.13529475702825355,-0.09272483388156172,-0.6371408986560423},
{-0.3762279477547341,-0.5159336226135525,-0.3227153648209994,-0.5924991595313361,-0.6652753369788165,-0.24664900609715068,-0.8182856745864255,-0.6789496166338395,-0.393508388457261,-0.9944536330275666,-0.004052031019867841,-0.5561644487177344,-0.20942406547864367,-0.2793449071745705,-0.9611576854014857,-0.346153221143077,-0.555026063827356,-0.794970874235701,-0.2872686860377699,-0.10419588208102903},
{-0.22541569391520946,-0.8012526666900132,-0.3249357232313558,-0.6334477951841756,-0.01887334579222688,-0.2429042237973198,-0.8749540801859025,-0.3380332899813441,-0.7558939198907957,-0.20293144211807812,-0.7159713257715403,-0.9562128124522211,-0.16512778018752594,-0.7943351745536752,-0.6269313798982276,-0.1239878369003331,-0.8593414750602137,-0.6828644561103477,-0.20878215307472026,-0.769201800409292},
{-0.4708301677066172,-0.881046385795487,-0.10118003943802167,-0.7846640218575108,-0.775916071457669,-0.9513609481773635,-0.8480336473564604,-0.4176081701467687,-0.393017876773752,-0.3248675079375315,-0.3839689763761305,-0.6274122669822956,-0.5520146781749458,-0.9987469280383692,-0.45258909584645,-0.5628349819528052,-0.957416089218632,-0.9148023213884405,-0.7147252423856342,-0.19781072004857048}};

static param_t xstream_shift[20][20] = {{2.1568428047953945,0.1424775910649163,1.225668666016905,0.26415685323325283,0.21323357926829856,0.22782484478082843,2.8544664806257654,1.1060030602496402,0.8331798027095975,0.9877314384259741,0.7708676957263981,0.7203399651613832,0.44807536558490046,2.70179554822571,0.6327029577867936,3.3647702761079,2.3594907378268104,1.12137181219035,0.7241061542864974,2.760480089440534},
{1.1272268397489904,0.6635511457465036,1.301844278198711,0.7273435416388213,0.4546775081217007,0.8869430509055193,3.63383765316787,1.625002068069459,0.4854363698518025,0.07312886752347159,2.3007930890109782,1.0068541576784749,0.4914199968836883,2.7633554109681726,1.3454030133040265,0.940343175698285,1.580898968413559,1.0970503255071924,0.6803601287808135,2.0832804819694757},
{2.1314230563961742,0.9825114945489,1.9121335901488299,0.8558383828257122,0.42808005522301784,0.9081944073913163,0.8024832338989767,0.8280079303674115,0.8921188264589229,0.285135961939993,2.200339668984742,0.5102235470312327,0.7804008769537981,2.025361626347835,0.2302184886760813,2.463373041546358,3.632416980534766,2.2589312093616027,0.2026450052537354,1.5391552052887918},
{0.5401874771291671,0.3638292666534002,4.02340794147379,0.6542194272128928,0.7040145440928641,0.531300377941086,1.9360987703521892,1.6364455112717957,0.7902355052285592,0.7457739850078473,1.615905933998365,3.1204936842152393,0.8843441820633646,1.8833971679091996,0.42250963294723726,3.2578579959712335,0.23002494213831856,1.6646289483649617,0.6685969322961629,1.882678796016963},
{1.261539681433308,0.8814729944336277,3.945872598581059,0.6107573387100469,0.12626324334271877,0.7366411381313416,2.253833523566461,2.5141406548910266,0.9097653796574711,0.8683658252647748,0.4985858464565705,1.654779313158029,0.2417393397606762,0.4744950954854539,1.6617147790989524,3.021773694862904,1.6982305749963478,0.765369877770534,0.7841074030214372,2.3043580055832114},
{0.07372729855257858,0.9881826856374453,3.7858026448134754,1.3587103671354672,0.85527398188265,0.1456347590117002,3.873939193133938,1.2085448437923973,0.4290246104623445,0.020269761511153894,0.4521403471077604,1.0826619967738027,0.05376157095837897,2.521840580706432,0.7369490161802109,0.2780588201301539,0.3751075309396965,2.386406728533038,0.355989445000907,3.1158787632187344},
{0.8195377147244024,0.48453900000772,3.726926856819038,1.0920801439825516,0.5008466216467146,0.16584355976470855,3.9976783097084048,1.5005752736749371,0.04166845127058516,0.7351707892706627,0.6929179946649137,0.31317596912947143,0.8839393491043696,3.0715655649240263,0.8141216917176981,1.4371800280546312,2.799902773566671,1.915103321736402,0.9445652276577606,1.1524755649703442},
{1.4726201992272414,0.5600272854390417,1.5459280369665698,0.1324942302456929,0.8032095977301972,0.503841512507364,3.1827871386393705,0.5910431202730725,0.17136123091621724,0.614521334909552,2.1387382000257826,0.2623012161369113,0.6136946763255,0.8628252581510837,1.3987762830379236,2.8347901262284405,2.0256023381248673,2.0515790058492382,0.11131511671291161,3.2370750012685523},
{1.4448782149024906,0.21507112243175686,3.010141905071527,1.6128812699565134,0.4451236666280999,0.26782571720388726,3.5694705390499917,1.7751230467984103,0.2840354454481403,0.9259774665604454,0.8624834760427453,1.174463752848472,0.2775663175982319,1.5321940773281182,1.662234710428607,1.7664975077727825,1.329155505277478,0.03011902514969903,0.1484981690346192,1.9841560142654502},
{1.4052370543324486,0.7791069714650503,0.5794444661976911,0.4347380920298197,0.18159056538782303,0.6751643996120021,3.713396957159172,0.14265613673286692,0.22437371356425018,0.9796517327129481,0.21557128621370927,1.4594647504625329,0.05085545138775205,2.8131007237328793,0.771793563815155,2.9443274168174782,4.010996273333521,1.123452522627279,0.3182674277754215,0.8299045306429328},
{2.014776820456646,0.2301083164229496,2.507441912545807,1.6064679188699413,0.11374059105756329,0.4180551620469467,2.1117408772920934,2.4988756415908164,0.8431941752126029,0.38113722120229243,1.898437837536156,0.11635803030404608,0.4440776814468541,2.3096203642748634,0.9632853224326587,2.8525895958850462,3.915173921890141,2.578931408175593,0.9780058088601695,0.04367048772410742},
{1.8200057395464688,0.05302904145706766,2.4176500096675175,0.6249408502083836,0.2890330420875926,0.3125422044837387,2.9229482163104485,0.3238516067231544,0.3478234458535221,0.009573947524510573,1.0490258328652493,0.32881261155901886,0.6735343582133357,0.5438736904597425,0.3066021080365467,1.7288281884092314,3.812021729246903,1.1485804272046167,0.09022528118147854,0.7563252447217303},
{0.8893601240716108,0.789587894594691,1.8957722115508007,1.3231174051162542,0.6951319564448234,0.14713549478537935,2.5324847204427527,0.05289997902580442,0.6178758176256505,0.9040513063717249,2.4729132153221305,3.219871674244884,0.793205745433261,3.557193262858173,1.0607935214701476,3.0087550095942452,0.31018246229693575,2.7617786639109423,0.5028811534637496,3.03372474296926},
{2.10981852523531,0.15458445651265473,3.4909113718284397,1.0678997448956355,0.3329514530724197,0.32441269315019605,2.052303913430737,1.7872872125994628,0.04143396728289672,0.14194186970242995,1.363927010330718,0.4498822082648447,0.8311076323709884,2.3513286999191734,1.5390446888526137,0.8144425364051414,0.9448527379559273,0.6601555416123187,0.6756061328078901,0.15617717446512244},
{0.7417944877950072,0.9356161269734138,3.434340261205747,0.20127190204875237,0.651137015192067,0.3881155200291121,2.679099111011158,0.9885622818820465,0.06005735071730767,0.4066893476556934,2.026738086708127,1.2289205582805256,0.48419800445006245,2.38765362645727,1.415243087219879,1.8966552701936603,0.5286648902202897,0.3507818344377335,0.5396721887463509,2.9134904751672583},
{1.270091317087351,0.4405214391586231,1.232228037259199,0.06467181901219891,0.09137830499772293,0.05178821730462657,2.7343666103949382,1.8115511892853453,0.4562433253807906,0.32993683300372134,0.9873345248780699,0.7997443520346645,0.9065899016444112,2.958994108595458,0.891711624891402,0.10877615318883528,2.0066861386584103,0.6578873107115979,0.8512246533185407,0.8985884940948095},
{1.0749221864192997,0.4510772064655877,2.287910402121692,0.47867178893604806,0.614165664508694,0.7588624711352231,2.987002711573298,1.9115152734008625,0.034032232952505126,0.004325444745994389,0.4536534025345861,0.43572524532372386,0.03480534622103659,0.8738664771440249,1.4623374859630625,2.885835162659149,3.321377116381047,0.38605033817230716,0.09272483388156172,2.214275015681854},
{0.9620889651606298,0.5159336226135525,1.3006841211033766,1.0462100876726448,0.6652753369788165,0.24664900609715068,3.298049301282204,1.736207897264691,0.393508388457261,0.9944536330275666,0.010361841415473017,1.932855112587854,0.20942406547864367,1.0194570121318836,1.6971718020773696,1.2029967481159785,2.236997883317936,2.268371528777996,0.2872686860377699,0.3621150971717913},
{0.5764323277526111,0.8012526666900132,1.3096331369926906,1.1185154656757448,0.01887334579222688,0.2429042237973198,3.5264477705412327,0.8644177023233973,0.7558939198907957,0.20293144211807812,1.8308796994137122,3.3231552781402227,0.16512778018752594,2.898891452406852,1.107009053729075,0.43089867574967144,3.4635221407457495,1.9484868445581869,0.20878215307472026,2.6732302576345415},
{1.20400547465593,0.881046385795487,0.40779982924780983,1.3855267166124974,0.775916071457669,0.9513609481773635,3.4179466474728994,1.0679063441641234,0.393017876773752,0.3248675079375315,0.9818843000369564,2.1804648080850915,0.5520146781749458,3.6448831998845215,0.799162783656497,1.956037418283264,3.858805747369038,2.6102988267244447,0.7147252423856342,0.6874575720401894}};

const static score_t log_LUT_xstream_d0[128] = {1.0,2.0,2.584962500721156,3.0,3.321928094887362,3.584962500721156,3.807354922057604,4.0,4.169925001442312,4.321928094887362,4.459431618637297,4.584962500721156,4.700439718141093,4.807354922057604,4.906890595608519,5.0,5.087462841250339,5.169925001442312,5.247927513443585,5.321928094887363,5.392317422778761,5.459431618637297,5.523561956057013,5.584962500721156,5.643856189774724,5.700439718141092,5.754887502163468,5.807354922057604,5.857980995127572,5.906890595608519,5.954196310386875,6.0,6.044394119358453,6.087462841250339,6.129283016944966,6.169925001442312,6.20945336562895,6.247927513443585,6.285402218862249,6.321928094887363,6.357552004618084,6.392317422778761,6.426264754702098,6.459431618637297,6.491853096329675,6.523561956057013,6.554588851677638,6.584962500721156,6.614709844115208,6.643856189774724,6.672425341971495,6.700439718141092,6.727920454563199,6.754887502163468,6.78135971352466,6.807354922057604,6.832890014164741,6.857980995127572,6.882643049361842,6.906890595608519,6.930737337562887,6.954196310386875,6.977279923499917,7.0,7.022367813028454,7.044394119358453,7.066089190457772,7.087462841250339,7.108524456778169,7.129283016944966,7.149747119504682,7.169925001442312,7.189824558880018,7.20945336562895,7.22881869049588,7.247927513443585,7.266786540694901,7.285402218862249,7.303780748177103,7.321928094887363,7.339850002884624,7.357552004618084,7.3750394313469245,7.392317422778761,7.409390936137702,7.426264754702098,7.442943495848728,7.459431618637297,7.475733430966398,7.491853096329675,7.507794640198696,7.523561956057013,7.539158811108031,7.554588851677638,7.569855608330948,7.584962500721156,7.599912842187128,7.614709844115208,7.6293566200796095,7.643856189774724,7.658211482751795,7.672425341971495,7.6865005271832185,7.700439718141092,7.714245517666122,7.727920454563199,7.7414669864011465,7.754887502163468,7.768184324776926,7.78135971352466,7.794415866350106,7.807354922057604,7.820178962415188,7.832890014164741,7.845490050944375,7.857980995127572,7.870364719583405,7.882643049361842,7.894817763307944,7.906890595608519,7.918863237274595,7.930737337562887,7.94251450533924,7.954196310386875,7.965784284662087,7.977279923499917,7.9886846867721655,8.0};
#endif