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
    
void loda_http1_c2(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score_loda
);
    
#define ENSEMBLE 35
#define DIM_MAX 3
#define BATCH_SIZE 128
#define N_BINS 20
const static param_t bottom_loda = 0.8953576384868612;
const static param_t delta_loda = 0.07089864275670443;
static param_t loda_min_X[35] = {-8.428723139808813,-4.742585964165546,-2.7263214861443554,-2.5453951056744906,-8.774925122627703,-13.48753393599033,-17.36072280361097,-13.639364425329028,-3.5645492220120154,-10.038687661452867,-13.806726855778413,-13.836781741028918,-3.4971402362065387,-8.541744669556511,-12.151801691391693,-5.52274249442532,-13.331713444757675,-8.553329984174026,-8.448887221388443,-3.640470057010767,-16.462189257513376,-3.6173395422292476,-15.375261891080783,-8.239708123187,-7.909553255083688,-4.018203229611776,-6.163590759307581,-3.8990813515997917,-4.2861877552826115,-3.7203500140470087,-12.92324619491848,-3.3331899470103905,-11.429993417553765,-16.721761756181362,-7.543568454722647};

static param_t loda_projections[35][3] = {{-0.6118544639902339,0.5405434855915797,-0.5774485735368383},
{-0.9149151523497117,0.39876297620901124,0.06259674756595403},
{0.9925556831673886,0.1206425806878561,-0.016690821941791577},
{0.029771291328505044,0.07927134504711003,0.9964084122823609},
{0.7269964070428696,-0.5776970276385182,0.37113658995628446},
{0.33243962991168147,-0.8748093898885825,-0.35240945479222047},
{-0.21142591103784833,-0.299570585469079,-0.9303529160826708},
{-0.01573900486896766,-0.9171171220419515,-0.3983070024280554},
{0.8822109287834111,0.3363676807048553,0.3294854481040814},
{0.6865925227671578,0.17756191170586008,-0.7050265776490913},
{-0.37834239383961243,-0.8222256298504882,-0.42520823914957234},
{0.08426022387570982,-0.904003817860637,-0.4191387741140251},
{0.2776722676369853,0.34423132657342415,0.8968851128159252},
{-0.011803889529935664,0.7027206784386115,-0.7113679190733458},
{0.22203294230615314,-0.967564340073084,-0.12050153671140326},
{0.8081204651110339,0.5338057258995583,-0.24898345500368432},
{0.27241949993545234,-0.9126467228588533,-0.3047352544585436},
{-0.3808688398325158,-0.7600216009839387,0.5265986069887045},
{-0.3349985688753039,-0.7244373812256522,0.6024669613633741},
{-0.63914151961953,0.7260061259798152,-0.2537976023098299},
{-0.15648457664162913,-0.5906538382982394,-0.7916063545581525},
{-0.28064121539336345,0.7430745846377832,0.607520098340723},
{-0.3862966775838257,0.12798013970495856,-0.9134527687454875},
{0.3981915032662699,0.7086664779429992,-0.5824391382508672},
{-0.8879558971985098,-0.13511386845775766,0.4396345836951064},
{-0.4586539111681522,0.8273008641309016,-0.3243607096712245},
{0.7799401255047007,0.5376835208673655,-0.32029647518414095},
{0.23280758659110265,0.9655007033697595,-0.11665770192372968},
{0.9828835032042573,-0.17455013410832587,0.058925968907538324},
{0.8235227240365983,0.33279308320343326,0.4594116746092698},
{-0.7780074971983446,-0.0112582537758197,-0.6281541100916932},
{-0.1298419669213643,0.870037160296718,0.47558007036545863},
{-0.26033855933877237,0.5121152641448993,-0.8185119368410044},
{-0.02732002085947684,-0.5171986665594243,-0.8554292231209963},
{0.27393121454081626,-0.4593998797070609,0.8449339857203824}};

static param_t loda_delta[35] = {1.1756510661107604,1.7001846426254281,1.75525474868399,1.0378070886427389,1.3160456793451722,1.1824204861485874,0.9671389177467724,1.1972835453863988,1.3087041843049407,1.1497619070555376,1.1395871760455394,1.1739984950528228,0.9638811316615653,1.123272737827466,1.3281389256929028,1.3680032335540204,1.2028301032746405,1.2250565396411928,1.1922435477114592,1.4763940469899384,0.9997360683941788,1.120360481217138,1.0125640058297762,1.2250061443924087,1.3250062911870575,1.3544265859930542,1.3114184072249602,1.421346410456671,1.738054530638534,1.2057755660628338,1.2355612285851763,1.1485082542904674,1.0282029612375103,1.0027444641706933,1.0141099871273773};

const static score_t log_LUT_loda[128] = {15.0,7.0,6.0,5.415037499278844,5.0,4.678071905112637,4.415037499278844,4.192645077942396,4.0,3.830074998557688,3.678071905112638,3.5405683813627027,3.415037499278844,3.299560281858908,3.192645077942396,3.0931094043914813,3.0,2.9125371587496605,2.830074998557688,2.7520724865564143,2.678071905112638,2.6076825772212398,2.5405683813627027,2.476438043942987,2.415037499278844,2.356143810225275,2.299560281858908,2.2451124978365313,2.192645077942396,2.1420190048724277,2.0931094043914813,2.0458036896131246,2.0,1.9556058806415466,1.9125371587496607,1.8707169830550336,1.8300749985576876,1.7905466343710503,1.7520724865564146,1.7145977811377517,1.6780719051126376,1.6424479953819162,1.6076825772212398,1.573735245297902,1.5405683813627027,1.5081469036703252,1.4764380439429872,1.4454111483223626,1.415037499278844,1.3852901558847919,1.3561438102252752,1.3275746580285044,1.2995602818589078,1.2720795454368008,1.2451124978365316,1.2186402864753405,1.1926450779423958,1.1671099858352583,1.142019004872428,1.1173569506381587,1.0931094043914815,1.0692626624371138,1.0458036896131249,1.0227200765000835,1.0,0.9776321869715455,0.9556058806415466,0.9339108095422276,0.9125371587496606,0.891475543221831,0.8707169830550335,0.850252880495318,0.8300749985576876,0.8101754411199827,0.7905466343710502,0.7711813095041191,0.7520724865564145,0.7332134593050986,0.7145977811377517,0.6962192518228971,0.6780719051126376,0.6601499971153753,0.6424479953819163,0.6249605686530753,0.6076825772212398,0.5906090638622983,0.5737352452979021,0.5570565041512716,0.5405683813627027,0.5242665690336022,0.5081469036703252,0.49220535980130375,0.47643804394298717,0.4608411888919686,0.44541114832236267,0.4301443916690522,0.4150374992788438,0.40008715781287235,0.3852901558847918,0.37064337992039037,0.3561438102252753,0.34178851724820525,0.3275746580285044,0.31349947281678164,0.2995602818589079,0.28575448233387735,0.27207954543680085,0.25853301359885306,0.24511249783653147,0.23181567522307364,0.2186402864753404,0.20558413364989406,0.1926450779423959,0.1798210375848123,0.16710998583525832,0.1545099490556248,0.14201900487242788,0.12963528041659547,0.11735695063815874,0.1051822366920565,0.09310940439148148,0.0811367627254055,0.06926266243711372,0.05748549466076013,0.04580368961312479,0.03421571533791296,0.02272007650008353,0.011315313227834146};
#endif