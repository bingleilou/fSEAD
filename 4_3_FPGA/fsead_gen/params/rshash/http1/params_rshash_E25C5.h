#define ENSEMBLE 25
#define DIM_MAX 3
#define BATCH_SIZE 128
#define HASH_NUM 2
#define MATRIX_COL 128
const static param_t bottom_rshash = -6.727058836573144;
const static param_t delta_rshash = 0.14865337501781295;
static param_t rshash_f[25] = {1.4949216107529237,1.582932424804031,2.221165027784842,2.6964613553529495,1.7784454300703254,1.224558488611233,1.231397014720668,1.951592873020231,1.5621488151491827,5.098270240900417,4.493761873811084,1.8724621165607274,2.632469347069577,1.4862010883900174,1.3736425926576565,4.772122435980168,3.0327532222187923,4.844974174734098,2.3425436087135756,1.227213078686462,1.5657269104531932,11.273959022612745,6.182177555036094,4.191042524324303,6.124984080581049};

static param_t rshash_alpha[25][3] = {{0.33393550374161196,0.23876585258503327,0.5026606498068136},
{0.368189687537745,0.09136027152482278,0.07502259527681224},
{0.4420375282238868,0.41411004155853304,0.07442641713224396},
{0.1348666799844901,0.14185872595281723,0.1706114352655067},
{0.33435539748627907,0.2907188183279104,0.03896795719241834},
{0.06817024262484564,0.6371354376810499,0.3873945450311339},
{0.21730848033132558,0.3406585765028297,0.2081975208224589},
{0.502153444446127,0.09877440220161453,0.29132998027149637},
{0.4068888580426937,0.6372356725988579,0.41726519770504833},
{0.01790967880273573,0.12159423419494185,0.009542637428686974},
{0.10844928777211933,0.2089602290674386,0.06466274013918094},
{0.3696897171517757,0.29554814841521604,0.3017263098604021},
{0.18896562179885718,0.009685664317632918,0.2652748622167515},
{0.0964542391046569,0.4121516523341443,0.6027776682268107},
{0.2303518853052741,0.17321188584004782,0.5156062825115547},
{0.17581719569790616,0.16740465131867063,0.020322523768697566},
{0.0503580651560724,0.19208485405230333,0.05995905907587387},
{0.13816696968172396,0.16645610016062193,0.005872633591065648},
{0.21032430906778862,0.00971779677418326,0.4196334945261831},
{0.7588109348483985,0.2803070599102663,0.1929589241319954},
{0.23522805899959245,0.4391957345637146,0.29820349605746976},
{0.019871541845312656,0.08600667469128731,0.0026189793808659425},
{0.08552983949248444,0.05259884572633259,0.04988889231112641},
{0.14733355260291575,0.01408175419391995,0.0018412359373875021},
{0.07248676639970711,0.061012804488898544,0.09870304608666171}};
static param_t rshash_min_X[3] = {-2.3025850929940455,-2.3025850929940455,-2.3025850929940455};
static param_t rshash_delta_X[3] = {0.09614502352502724,0.07570437288699758,0.053820455935644385};

const static score_t log_LUT_rshash[128] = {-0.0,-1.0,-1.584962500721156,-2.0,-2.321928094887362,-2.584962500721156,-2.807354922057604,-3.0,-3.169925001442312,-3.321928094887362,-3.4594316186372973,-3.584962500721156,-3.700439718141092,-3.807354922057604,-3.9068905956085187,-4.0,-4.087462841250339,-4.169925001442312,-4.247927513443585,-4.321928094887363,-4.392317422778761,-4.459431618637297,-4.523561956057013,-4.584962500721156,-4.643856189774724,-4.700439718141092,-4.754887502163468,-4.807354922057604,-4.857980995127572,-4.906890595608519,-4.954196310386875,-5.0,-5.044394119358453,-5.087462841250339,-5.129283016944966,-5.169925001442312,-5.20945336562895,-5.247927513443585,-5.285402218862249,-5.321928094887363,-5.357552004618084,-5.392317422778761,-5.426264754702098,-5.459431618637297,-5.491853096329675,-5.523561956057013,-5.554588851677638,-5.584962500721156,-5.614709844115208,-5.643856189774724,-5.672425341971495,-5.700439718141092,-5.727920454563199,-5.754887502163468,-5.78135971352466,-5.807354922057604,-5.832890014164741,-5.857980995127572,-5.882643049361842,-5.906890595608519,-5.930737337562887,-5.954196310386875,-5.977279923499917,-6.0,-6.022367813028454,-6.044394119358453,-6.066089190457772,-6.087462841250339,-6.108524456778169,-6.129283016944966,-6.149747119504682,-6.169925001442312,-6.189824558880018,-6.20945336562895,-6.22881869049588,-6.247927513443585,-6.266786540694901,-6.285402218862249,-6.303780748177103,-6.321928094887363,-6.339850002884624,-6.357552004618084,-6.3750394313469245,-6.392317422778761,-6.409390936137702,-6.426264754702098,-6.442943495848728,-6.459431618637297,-6.475733430966398,-6.491853096329675,-6.507794640198696,-6.523561956057013,-6.539158811108031,-6.554588851677638,-6.569855608330948,-6.584962500721156,-6.599912842187128,-6.614709844115208,-6.6293566200796095,-6.643856189774724,-6.658211482751795,-6.672425341971495,-6.6865005271832185,-6.700439718141092,-6.714245517666122,-6.727920454563199,-6.7414669864011465,-6.754887502163468,-6.768184324776926,-6.78135971352466,-6.794415866350106,-6.807354922057604,-6.820178962415188,-6.832890014164741,-6.845490050944375,-6.857980995127572,-6.870364719583405,-6.882643049361842,-6.894817763307944,-6.906890595608519,-6.918863237274595,-6.930737337562887,-6.94251450533924,-6.954196310386875,-6.965784284662087,-6.977279923499917,-6.9886846867721655,-7.0};