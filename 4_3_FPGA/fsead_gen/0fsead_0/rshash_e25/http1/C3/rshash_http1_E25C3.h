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
    
void rshash_http1_c3(
    hls::stream<DataBus_IN> &data,
    hls::stream<DataBus_OUT> &score_rshash
);
    
#define ENSEMBLE 25
#define DIM_MAX 3
#define BATCH_SIZE 128
#define HASH_NUM 2
#define MATRIX_COL 128
const static param_t bottom_rshash = -6.727058836573144;
const static param_t delta_rshash = 0.14865337501781295;
static param_t rshash_f[25] = {2.6961727241263977,4.651396809193729,1.6674250139561826,1.1744597764198386,1.1869479773199878,10.689097344516421,10.396407383372548,2.9099899185261946,2.935587171788674,1.1652532911508906,1.448108072033092,1.2335806246320622,5.07680066707248,1.2026815616020732,1.45564390061475,1.3131592565946322,1.2449849635161905,5.724706771790508,2.9156361554871917,2.108794206767265,1.2176597536287197,1.953214588165017,1.4760257627243532,1.4028433563517837,1.5040449446860447};

static param_t rshash_alpha[25][3] = {{0.03857414005040189,0.2699932560561577,0.11561502637626636},
{0.09652025548118533,0.05892273058269715,0.19308766706850106},
{0.34524913925863576,0.3216173374461054,0.08233939963051147},
{0.7127490103954585,0.4893313836422366,0.0596649358051145},
{0.08692423933413478,0.5146202086692655,0.49546058082418193},
{0.011439193378547737,0.08381303768933084,0.05065350234711008},
{0.027312064055396105,0.02698774656616672,0.0016272086723519773},
{0.13703724190791464,0.33441972096990735,0.08608076685771789},
{0.07011455513205644,0.16898585949711417,0.09361492157508097},
{0.6713856052090657,0.6872385967303475,0.38138420917397275},
{0.502222669418706,0.23579926076529498,0.316936452869987},
{0.6770211951054685,0.2021727377338079,0.5629013640877659},
{0.05732425273595372,0.06615384097016948,0.12747080843573108},
{0.27510085998115213,0.4236370782505893,0.7202168460126112},
{0.6525145186169141,0.4627865936704283,0.5914114736495609},
{0.6291645035427931,0.3356429055832087,0.24518948598922705},
{0.01785382568669373,0.34483763141011253,0.24828038619584908},
{0.0695408637045092,0.11528903809909569,0.019066480042220054},
{0.09098453857772994,0.07147897966819906,0.12986956638981784},
{0.027641884439810544,0.09708667448122792,0.14544260975073894},
{0.647346288931672,0.6294014397645047,0.0660076960474783},
{0.4944457820627282,0.17472655497860576,0.1494787292139495},
{0.24720134158935828,0.12843698257812391,0.03853259870155684},
{0.23118238922139386,0.09951912087499017,0.36836666923151357},
{0.5257410631966797,0.16162654734836623,0.12291321131389638}};
static param_t rshash_min_X[3] = {-2.3025850929940455,-2.3025850929940455,-2.3025850929940455};
static param_t rshash_delta_X[3] = {0.09614502352502724,0.07570437288699758,0.053820455935644385};

const static score_t log_LUT_rshash[128] = {-0.0,-1.0,-1.584962500721156,-2.0,-2.321928094887362,-2.584962500721156,-2.807354922057604,-3.0,-3.169925001442312,-3.321928094887362,-3.4594316186372973,-3.584962500721156,-3.700439718141092,-3.807354922057604,-3.9068905956085187,-4.0,-4.087462841250339,-4.169925001442312,-4.247927513443585,-4.321928094887363,-4.392317422778761,-4.459431618637297,-4.523561956057013,-4.584962500721156,-4.643856189774724,-4.700439718141092,-4.754887502163468,-4.807354922057604,-4.857980995127572,-4.906890595608519,-4.954196310386875,-5.0,-5.044394119358453,-5.087462841250339,-5.129283016944966,-5.169925001442312,-5.20945336562895,-5.247927513443585,-5.285402218862249,-5.321928094887363,-5.357552004618084,-5.392317422778761,-5.426264754702098,-5.459431618637297,-5.491853096329675,-5.523561956057013,-5.554588851677638,-5.584962500721156,-5.614709844115208,-5.643856189774724,-5.672425341971495,-5.700439718141092,-5.727920454563199,-5.754887502163468,-5.78135971352466,-5.807354922057604,-5.832890014164741,-5.857980995127572,-5.882643049361842,-5.906890595608519,-5.930737337562887,-5.954196310386875,-5.977279923499917,-6.0,-6.022367813028454,-6.044394119358453,-6.066089190457772,-6.087462841250339,-6.108524456778169,-6.129283016944966,-6.149747119504682,-6.169925001442312,-6.189824558880018,-6.20945336562895,-6.22881869049588,-6.247927513443585,-6.266786540694901,-6.285402218862249,-6.303780748177103,-6.321928094887363,-6.339850002884624,-6.357552004618084,-6.3750394313469245,-6.392317422778761,-6.409390936137702,-6.426264754702098,-6.442943495848728,-6.459431618637297,-6.475733430966398,-6.491853096329675,-6.507794640198696,-6.523561956057013,-6.539158811108031,-6.554588851677638,-6.569855608330948,-6.584962500721156,-6.599912842187128,-6.614709844115208,-6.6293566200796095,-6.643856189774724,-6.658211482751795,-6.672425341971495,-6.6865005271832185,-6.700439718141092,-6.714245517666122,-6.727920454563199,-6.7414669864011465,-6.754887502163468,-6.768184324776926,-6.78135971352466,-6.794415866350106,-6.807354922057604,-6.820178962415188,-6.832890014164741,-6.845490050944375,-6.857980995127572,-6.870364719583405,-6.882643049361842,-6.894817763307944,-6.906890595608519,-6.918863237274595,-6.930737337562887,-6.94251450533924,-6.954196310386875,-6.965784284662087,-6.977279923499917,-6.9886846867721655,-7.0};
#endif