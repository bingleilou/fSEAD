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
    
void loda_smtp1_c7(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score_loda
);
    
#define ENSEMBLE 35
#define DIM_MAX 3
#define BATCH_SIZE 128
#define N_BINS 20
const static param_t bottom_loda = 0.9718000593034282;
const static param_t delta_loda = 0.07128498340681227;
static param_t loda_min_X[35] = {-13.65431828684313,-3.9699150608734066,-8.349660253311445,-2.4117238070826645,-2.7680258238958206,-3.5681510598070374,-16.327544197752488,-5.1482301880537635,-3.029681361509823,-3.742750130166024,-1.2000416591919802,-6.895535359526394,-3.4143362592719746,-12.925784286554837,-11.725328754009672,-1.6151945493010125,0.28747672569488814,-4.657480111493084,-13.130748233824207,-14.714272021029789,-7.5863544397795595,-14.831524516594254,-5.694640115024957,0.5859381602185955,-13.648854221717672,-7.602106890170633,-7.921986779183514,-8.879149875484275,-12.719495110700638,-4.774841780039737,-12.200911945681261,-0.29546333489644117,-10.255357317637868,-5.833408906959019,-4.6170762994657455};

static param_t loda_projections[35][3] = {{-0.25325814792494766,-0.9388172671205988,-0.2334147584576342},
{0.04739427843876863,0.9215349627713817,-0.3853921311615178},
{0.2354366120368652,-0.767366798477039,0.5964208231674193},
{0.7854841914997472,0.593687379987707,0.17478523892857842},
{0.4662427271364027,0.05158961839284105,0.8831513067795863},
{-0.9210978921482269,0.38787904666471035,-0.03359342552597208},
{0.10055708813025775,-0.7759600013085614,-0.6227153028439089},
{-0.6066116988653515,0.5728398586095924,-0.5512501638891679},
{-0.10754693086955883,-0.11983275758279571,0.986951755594285},
{0.9508986783482253,0.1768768120832642,-0.2539808986181049},
{-0.45677983042504583,-0.02435960309420049,0.8892461955240288},
{0.008959585182056511,-0.6003089197235346,0.7997180295164842},
{-0.2274009380827499,0.960628849432224,-0.15962777639748915},
{0.08658434005180117,-0.9943931586468453,-0.06070747972156242},
{-0.8733368884340155,-0.40387311287037586,-0.27234020636105954},
{-0.42342495102258565,0.8676642527275688,0.2605188196469322},
{-0.14862490925204136,0.3195352221424653,0.935846076104499},
{0.5751308698313373,-0.17827544195691467,0.7983998680874868},
{-0.4774575099213001,-0.4840243315097723,-0.7333176479031919},
{0.4259343530550685,-0.8403887824064258,-0.33515163925155617},
{0.5729251915238525,0.1999945333450674,-0.7948326311554185},
{0.10445919427220375,-0.38173887408444523,-0.9183483591452332},
{-0.17899589034918273,0.4563026404578112,-0.871635457946344},
{-0.5622740961987294,0.17529418028609284,0.8081582710717802},
{-0.44072516773185977,-0.6788627371058775,-0.5872875877258434},
{-0.42729866278018036,0.18551476344576248,-0.884872943043199},
{0.5233622952728137,-0.6496574598157845,0.5513955864825857},
{0.7183814305663225,-0.6693018638279852,0.18963948769670547},
{-0.6678891262333106,-0.36963712722395525,-0.6459818180389649},
{-0.7001154807653291,0.5538852352868793,-0.45061009722811396},
{0.027486279397884266,-0.108692573999651,-0.9936953400324426},
{-0.4859348972459436,0.08939231983935826,0.8694114611576684},
{0.8125033734462813,-0.5635805683290116,-0.1490476807614299},
{0.7864472553375201,0.1968157589584205,-0.5854607344627837},
{0.9834720491897403,-0.03458934500541047,-0.17772536587282492}};

static param_t loda_delta[35] = {1.3004759858833619,1.5101181845576677,1.4816457459233074,1.3687462291078758,1.556423159125802,1.9385369216095327,1.2860740618634325,1.5851039952070702,1.5872349692292205,1.9922481630171114,1.716022770587084,1.6316106312947503,1.3370647586900435,1.3241145098172709,1.4841317430960226,1.2628555488092743,1.4194003171248926,1.5739857489513176,1.5701731530771919,1.254530158609668,2.0461959987680785,1.4087855933307218,1.6750661715137154,1.720827506576009,1.4641357866403921,1.6421705676188583,1.5270348703737298,1.57986999789672,1.502022086476175,1.657176963492217,1.4586490833519663,1.6714754905852038,1.6174297697914026,2.2298237833869354,2.0611283954833133};

const static score_t log_LUT_loda[128] = {15.0,7.0,6.0,5.415037499278844,5.0,4.678071905112637,4.415037499278844,4.192645077942396,4.0,3.830074998557688,3.678071905112638,3.5405683813627027,3.415037499278844,3.299560281858908,3.192645077942396,3.0931094043914813,3.0,2.9125371587496605,2.830074998557688,2.7520724865564143,2.678071905112638,2.6076825772212398,2.5405683813627027,2.476438043942987,2.415037499278844,2.356143810225275,2.299560281858908,2.2451124978365313,2.192645077942396,2.1420190048724277,2.0931094043914813,2.0458036896131246,2.0,1.9556058806415466,1.9125371587496607,1.8707169830550336,1.8300749985576876,1.7905466343710503,1.7520724865564146,1.7145977811377517,1.6780719051126376,1.6424479953819162,1.6076825772212398,1.573735245297902,1.5405683813627027,1.5081469036703252,1.4764380439429872,1.4454111483223626,1.415037499278844,1.3852901558847919,1.3561438102252752,1.3275746580285044,1.2995602818589078,1.2720795454368008,1.2451124978365316,1.2186402864753405,1.1926450779423958,1.1671099858352583,1.142019004872428,1.1173569506381587,1.0931094043914815,1.0692626624371138,1.0458036896131249,1.0227200765000835,1.0,0.9776321869715455,0.9556058806415466,0.9339108095422276,0.9125371587496606,0.891475543221831,0.8707169830550335,0.850252880495318,0.8300749985576876,0.8101754411199827,0.7905466343710502,0.7711813095041191,0.7520724865564145,0.7332134593050986,0.7145977811377517,0.6962192518228971,0.6780719051126376,0.6601499971153753,0.6424479953819163,0.6249605686530753,0.6076825772212398,0.5906090638622983,0.5737352452979021,0.5570565041512716,0.5405683813627027,0.5242665690336022,0.5081469036703252,0.49220535980130375,0.47643804394298717,0.4608411888919686,0.44541114832236267,0.4301443916690522,0.4150374992788438,0.40008715781287235,0.3852901558847918,0.37064337992039037,0.3561438102252753,0.34178851724820525,0.3275746580285044,0.31349947281678164,0.2995602818589079,0.28575448233387735,0.27207954543680085,0.25853301359885306,0.24511249783653147,0.23181567522307364,0.2186402864753404,0.20558413364989406,0.1926450779423959,0.1798210375848123,0.16710998583525832,0.1545099490556248,0.14201900487242788,0.12963528041659547,0.11735695063815874,0.1051822366920565,0.09310940439148148,0.0811367627254055,0.06926266243711372,0.05748549466076013,0.04580368961312479,0.03421571533791296,0.02272007650008353,0.011315313227834146};
#endif