#ifndef RSHASH_GENERATOR_1_H_
#define RSHASH_GENERATOR_1_H_

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
    
void rshash_shuttle_c4(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score_rshash
);
    
#define ENSEMBLE 25
#define DIM_MAX 9
#define BATCH_SIZE 128
#define HASH_NUM 2
#define MATRIX_COL 128
const static param_t bottom_rshash = -6.133982010631548;
const static param_t delta_rshash = 0.1630262361817786;
static param_t rshash_f[25] = {1.1134526855616582,3.0697412373620185,1.3274875821931422,2.832741734873553,1.1467451622197118,5.032823374471582,4.171970434372959,10.009017555150047,1.900247579967989,10.312625956679165,5.187070332545231,3.5338081496145164,9.06366227231042,7.923866978747165,1.5667495700009488,1.7446149504349155,2.819771570142362,5.33278401450351,1.5699233819919565,1.131255142088485,1.1260916763176896,2.0317497690636426,1.506983511103709,1.253507577216896,1.5380262823729935};

static param_t rshash_alpha[25][9] = {{0.32417772076696144,0.6905960471545471,0.36364505482813775,0.6623621611563391,0.4948507239394705,0.19531995554401466,0.791608348831365,0.664020177433367,0.12868216553991185},
{0.16026901026622167,0.18736673746614674,0.30637854333774356,0.0970061565577963,0.2145815397333286,0.24472274816855824,0.00011971837967479401,0.30538856465705644,0.22798104846646747},
{0.15392767108405123,0.2689206098333341,0.41304237704850943,0.6328212852730726,0.41774659710383993,0.6550722478044553,0.5461363977369771,0.45048507500134766,0.6656995951070984},
{0.1644255776439192,0.0194048371105785,0.3221756947044443,0.288239620715315,0.18446145515845552,0.1083515136995608,0.29312640485996,0.23152787418437223,0.19106172904655594},
{0.08536398743992488,0.5598596944902037,0.5594688231389063,0.805795586908616,0.1278107990798879,0.48675745615479366,0.16776954746763048,0.4605876558837692,0.24929241046309433},
{0.004173370543559118,0.04881552057711285,0.03704254527104358,0.054491833648629875,0.09603064667634369,0.005399083463494923,0.17749688180485637,0.08719698301521611,0.14093850837502397},
{0.07050340423658519,0.21510308472442444,0.005223768096131019,0.20149493307744998,0.18968880253631878,0.20944775311707006,0.08940554748729164,0.18713976933309887,0.22646196858295892},
{0.051711045052988645,0.08871961929072703,0.094816069450296,0.016263992118895218,0.0032915723057622246,0.0362103943029144,0.06276163412320389,0.05169136394044605,0.06502739636415492},
{0.24876922024710946,0.013048330220282416,0.39296617195852535,0.1966311241187249,0.398988383672503,0.1563190229609221,0.43472764694138205,0.09585120558838683,0.5176438857472102},
{0.054787537442651274,0.001644799573948784,0.08949552443152999,0.05202820742385775,0.08014649168955149,0.08644093035716019,0.06796759309194532,0.04716275707405495,0.04721230275377232},
{0.038986533704895444,0.1368065909541683,0.04004756350022291,0.013237589349826929,0.11100556612452303,0.00797287859174166,0.04351611888947241,0.06862139795353311,0.17808970693806017},
{0.09286589288518865,0.1765810520499272,0.23324578525676679,0.029482200694645255,0.06987362929532638,0.119113089434836,0.19310062598988773,0.21278136063811168,0.24413117824117933},
{0.029806108947009517,0.016242344006074286,0.011439612511886167,0.10761820571627771,0.010906929224589199,0.04882850143342096,0.09862113746638834,0.03505102865391561,0.01447272206449266},
{0.07009355887931339,0.11471261044933602,0.005056864028059185,0.032461099498580004,0.089622487889326,0.08900988440111149,0.08967617939561125,0.11214676295331079,0.012496260090895276},
{0.19142135101562394,0.3508520635393799,0.4705341668270331,0.4457788296865538,0.5433701899441146,0.35444802660205604,0.03779863035115794,0.2426210376583383,0.02604608521091497},
{0.14521055398745575,0.49267844526589466,0.09207023668036902,0.3886562949457942,0.5011758546293825,0.5243612140206119,0.3202679800600665,0.28024240185466337,0.1982431394234149},
{0.1607045322123442,0.33232533638604855,0.18018054259763935,0.2585991609638333,0.04710138939770339,0.011710568217771446,0.09713092954134617,0.3471965312585019,0.19233451832254841},
{0.1030476188234218,0.10158624025473273,0.07494303021901225,0.13309326152857637,0.04837416666829401,0.016379181631301504,0.023922709616739483,0.006911997001397969,0.18294231236428765},
{0.4844696143744314,0.35103875925347205,0.5989432728030457,0.4192077978368511,0.5256722955854893,0.005676377182865252,0.28637662854583235,0.1510524340360734,0.04294173445852505},
{0.7330654715465562,0.7073418172535714,0.26385041977393675,0.24338917300395563,0.07704912418887735,0.4298498543477159,0.024111209014639888,0.7803425254617147,0.3650869452709949},
{0.4221192591894183,0.7020147236694267,0.2841080632384268,0.0489770900922659,0.37175076532679335,0.2383409799781009,0.4560116629534805,0.15369438942787095,0.47348102221175964},
{0.06741990616605417,0.4749442731535046,0.3800822314427243,0.34458137406705514,0.47481798988012425,0.22387558499975452,0.23500473789460782,0.12508660549642603,0.15280558178018253},
{0.3490663439845606,0.12812668438481398,0.04700123507702594,0.1421585936219399,0.31027885486169143,0.3903453617734056,0.4019350922907617,0.5437928608122646,0.38512935510843094},
{0.3309881876077233,0.6398648912688739,0.565212752194151,0.34654329324383953,0.043582750901729916,0.7902473277145114,0.6778951472059034,0.3394808088334154,0.08438423657274918},
{0.3672422471271527,0.24306298854404834,0.21772559586099552,0.42540997610422565,0.07851461210131705,0.2443727369583884,0.4806549819309243,0.23511114646004985,0.042754394606138335}};
static param_t rshash_min_X[9] = {27,-4821,21,-3939,-188,-26739,-48,-353,-356};
static param_t rshash_delta_X[9] = {0.010101010101010102,0.00010105092966855295,0.0078125,0.00012871669455528383,0.0016025641025641025,-4.231371387466678e-05,0.006535947712418301,0.0016051364365971107,0.001607717041800643};

const static score_t log_LUT_rshash[128] = {-0.0,-1.0,-1.584962500721156,-2.0,-2.321928094887362,-2.584962500721156,-2.807354922057604,-3.0,-3.169925001442312,-3.321928094887362,-3.4594316186372973,-3.584962500721156,-3.700439718141092,-3.807354922057604,-3.9068905956085187,-4.0,-4.087462841250339,-4.169925001442312,-4.247927513443585,-4.321928094887363,-4.392317422778761,-4.459431618637297,-4.523561956057013,-4.584962500721156,-4.643856189774724,-4.700439718141092,-4.754887502163468,-4.807354922057604,-4.857980995127572,-4.906890595608519,-4.954196310386875,-5.0,-5.044394119358453,-5.087462841250339,-5.129283016944966,-5.169925001442312,-5.20945336562895,-5.247927513443585,-5.285402218862249,-5.321928094887363,-5.357552004618084,-5.392317422778761,-5.426264754702098,-5.459431618637297,-5.491853096329675,-5.523561956057013,-5.554588851677638,-5.584962500721156,-5.614709844115208,-5.643856189774724,-5.672425341971495,-5.700439718141092,-5.727920454563199,-5.754887502163468,-5.78135971352466,-5.807354922057604,-5.832890014164741,-5.857980995127572,-5.882643049361842,-5.906890595608519,-5.930737337562887,-5.954196310386875,-5.977279923499917,-6.0,-6.022367813028454,-6.044394119358453,-6.066089190457772,-6.087462841250339,-6.108524456778169,-6.129283016944966,-6.149747119504682,-6.169925001442312,-6.189824558880018,-6.20945336562895,-6.22881869049588,-6.247927513443585,-6.266786540694901,-6.285402218862249,-6.303780748177103,-6.321928094887363,-6.339850002884624,-6.357552004618084,-6.3750394313469245,-6.392317422778761,-6.409390936137702,-6.426264754702098,-6.442943495848728,-6.459431618637297,-6.475733430966398,-6.491853096329675,-6.507794640198696,-6.523561956057013,-6.539158811108031,-6.554588851677638,-6.569855608330948,-6.584962500721156,-6.599912842187128,-6.614709844115208,-6.6293566200796095,-6.643856189774724,-6.658211482751795,-6.672425341971495,-6.6865005271832185,-6.700439718141092,-6.714245517666122,-6.727920454563199,-6.7414669864011465,-6.754887502163468,-6.768184324776926,-6.78135971352466,-6.794415866350106,-6.807354922057604,-6.820178962415188,-6.832890014164741,-6.845490050944375,-6.857980995127572,-6.870364719583405,-6.882643049361842,-6.894817763307944,-6.906890595608519,-6.918863237274595,-6.930737337562887,-6.94251450533924,-6.954196310386875,-6.965784284662087,-6.977279923499917,-6.9886846867721655,-7.0};
#endif