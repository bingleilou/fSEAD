
#include <iostream>
#include <cstring>
#include <string>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "loda_smtp1E245.h"

#define SMAPLE_NUM 95156
using namespace std;

float bottom_loda = 0.9718000593034282;
float delta_loda = 0.07128498340681227;
float loda_min_X[245] = {-7.300350249847751,-8.684076790658226,-5.505715456311795,-1.8599031404916893,-7.723582008531954,-13.181684869965514,-7.67491480915203,-3.6709536733872787,-7.763232601568697,-13.457377023433587,-2.116659732506305,-5.531817927701745,-6.514013525158761,-8.115472951773489,-2.593603113141379,-9.155924444013625,0.3778900689725142,-7.723973895177794,1.8271411336131955,-6.636202581131882,-7.714425701750791,-4.939520037575342,-0.31242273859845765,-3.709628249860376,-5.970234505493184,-8.019561183560109,-1.6929964535987174,-12.614300817222528,-5.490784388966301,-14.155453105842303,-9.010593988281586,-6.711042909707342,-6.56900803641904,-4.8697525445135135,-5.429345722510278,-12.663208885263751,-4.891827216634457,-5.988154443166994,-14.044646560858414,-5.884803981853385,-1.89275745458383,-6.32664514685342,-16.23742869860756,-4.742642345598461,-6.9356532247534,-12.379704443516712,-2.0594796614973605,-5.938862577756146,-1.611925828109814,-3.6191633643759022,-0.7588686433598197,-11.130050504827755,-11.117662182088043,-15.232731020302705,-8.72528922788408,-7.359650530153316,-5.569982427052368,-13.802765337148536,-0.16154637319755652,-15.60934036918657,-5.276248679755223,-12.685307070846669,-16.010325695281903,-2.8566004520365262,-1.9554441709069463,1.4543119660064865,-9.231442796441062,-6.879128463726185,-2.043773592220977,-4.295107183921156,-12.116027366566133,-9.848297756329966,-9.442255292386312,-8.323403058274987,-4.876104320282659,-14.6016719404503,-10.931512481105,-15.888851039756561,-10.268822354200706,-12.41947391646167,-6.741288114987589,-4.182080212984047,-12.395425998085472,-10.814651654199535,1.3426010325443207,-3.555172593529728,-1.3639780476933474,-2.555368605181737,-9.13717148148284,-8.594047507446449,-1.8624286185090366,0.20157995330359152,-8.928816654669408,-7.01710780409022,-14.2653556685248,-5.55735190954041,-15.091350184333026,-4.606940317271714,-4.149478336185256,-4.258667375272813,-4.699323252116303,-11.2247910670769,-6.279322802084303,-3.427576015676264,-3.4624646747559384,1.9370479416825606,-15.373053567157195,-8.968938527466449,-10.443483278145814,-13.439813398282752,-3.1002963786281317,1.5886248602400177,-1.8136324968340123,-5.34461296228983,-4.267411814965265,-15.456362981636214,-2.8538798837138573,-8.094584106346085,-2.253915305769914,-4.567713254221934,-3.528424099223827,-7.122646415161627,-6.341480609669967,-15.453723253606714,-2.9705587928080854,-4.956233448010726,-5.261770391505563,-13.778515338092932,-12.225863121885997,-14.875463056877662,0.707329848241604,-3.862503593446057,-0.41182275316992734,-14.427538173824063,-4.527010749587361,-5.499146453119732,-12.490833729552739,-15.958460795941193,-15.840285880731898,-0.03762864415582595,-6.861135780643239,-3.8162001285821807,-9.579304835132904,-2.1246245623511277,-0.8645578668367594,-4.206715074130362,-14.94635584731487,-14.140030764675165,-0.26898946658646017,-1.8122274428405682,-5.274913749650581,-3.9632726461996977,-15.52078269431993,-3.4422625443649553,-5.633167190369434,-13.98423711166664,-6.835642870013617,-9.268738470973807,-11.975465146965213,-6.670895947447109,0.9995501828871823,-6.152882605525733,-4.849466004951293,-10.034213985353029,-3.2584871481742224,-5.53144742243004,-1.974737496304324,0.2835808647526232,-5.660614979048202,-8.300955865210017,-2.128093223969623,-1.2587406417786915,-15.42569227821406,-13.810793844135851,-1.7264825748864072,-15.095425721697586,-11.025283900080666,-0.4595849956778091,-10.085490079490937,-0.7862829174004695,-9.336093816968182,-4.651090617893333,-10.357094831972766,-12.989524910166988,-9.062311334038995,-4.0816006685426105,-8.403034929480139,-7.798957229420558,-2.377238129100477,-10.060665402840865,-8.75641503018988,0.13413279555599636,-5.625381295866482,-5.432491317109535,-9.006755998605614,-3.195155510837875,-15.136913718111778,-4.834904971630323,-14.98766650424004,1.1858705165136252,-3.2545580567848376,-1.941247098485561,-8.413603019091445,-3.8560180333962086,-4.322819671194283,-6.067273547197061,-11.01999533886662,-11.086202979335122,-7.912252696782664,-6.441883581964532,-13.65431828684313,-3.9699150608734066,-8.349660253311445,-2.4117238070826645,-2.7680258238958206,-3.5681510598070374,-16.327544197752488,-5.1482301880537635,-3.029681361509823,-3.742750130166024,-1.2000416591919802,-6.895535359526394,-3.4143362592719746,-12.925784286554837,-11.725328754009672,-1.6151945493010125,0.28747672569488814,-4.657480111493084,-13.130748233824207,-14.714272021029789,-7.5863544397795595,-14.831524516594254,-5.694640115024957,0.5859381602185955,-13.648854221717672,-7.602106890170633,-7.921986779183514,-8.879149875484275,-12.719495110700638,-4.774841780039737,-12.200911945681261,-0.29546333489644117,-10.255357317637868,-5.833408906959019,-4.6170762994657455};

float loda_projections[245][3] = {{-0.35534597090887576,-0.7611226760545963,0.5426062227382936},
{0.22180331100535713,-0.8377565703256792,0.4989661512599988},
{0.2848229555261605,0.3933570550990739,-0.8741545122054378},
{-0.009908971452286171,0.9947600218840728,0.10175613566737342},
{-0.563728453609407,-0.6950304163300541,0.4462543568047469},
{0.14779775260372569,-0.18801546053417903,-0.9709819828016422},
{0.2819668364737423,-0.6421460960013884,0.7128415634060388},
{0.4773676146978671,0.8695922303102228,-0.12621217620246156},
{0.03291386639988711,-0.7290976384149664,0.6836178106634797},
{0.20872234128844433,-0.9702194613203624,-0.12291940905445303},
{0.3209139451444953,0.11953445045628892,0.9395348609636095},
{0.9381477157557644,0.032253314894614624,-0.34472973051442823},
{-0.3155102356134887,-0.6824692479896526,0.6593094999858254},
{0.5906487652756708,-0.6914410851147821,0.4159846894942388},
{0.9585762712594529,0.04000915635630219,0.28201205574581506},
{0.8992670876417634,-0.3338015540695736,-0.28265743858076425},
{0.25648454106290336,0.44749564724132784,0.8567165960198372},
{-0.8067702548108535,0.194803241132597,-0.5578292330065409},
{-0.1479715925795654,0.5980976855435601,0.787644314609649},
{-0.0517680520093862,0.30205081871558426,-0.9518851672887852},
{0.6887093107904505,-0.634642368204288,0.3505831566270627},
{0.43785038529885917,0.7570178988102402,-0.48498550594277495},
{-0.7332801760770566,0.480580001285098,0.48098133616307426},
{-0.30403108184490474,-0.2754750570679555,0.9119641408551235},
{-0.06196856488918123,0.34251237343267826,-0.9374674239732754},
{-0.9577919163704035,-0.2575772491570049,0.12762682183702675},
{0.012361496927385912,0.09545360618024205,0.9953571230773914},
{-0.6191542787576572,-0.7683778275553573,-0.16199843584860557},
{0.5331904487775688,0.4594116626786416,-0.7103864226793899},
{0.13145668720685363,-0.9702707796130352,-0.20320864552895496},
{-0.47703834129093886,0.06513903038137375,-0.8764652461218095},
{-0.17153390003229838,-0.6423595626074924,0.7469607174854782},
{-0.9532985758422605,-0.18958513517120085,0.23511550739846052},
{0.1711969745950487,0.7899377415630371,-0.5888038385946466},
{-0.5063596341505865,0.5728782226471061,-0.6445234386114884},
{0.5588275523921358,-0.8164578057828609,-0.1452873637438945},
{-0.05586397002135817,0.8028068389317886,-0.593616371251503},
{0.8365836345430494,-0.3746686435423576,0.3996889164848973},
{0.47739652974909114,-0.3445594686241089,-0.8083138783696572},
{-0.9896148353944021,-0.01871944884327908,0.1425203838133849},
{0.18971679817250836,0.11988471705740071,0.9744922734979681},
{0.19897739272471102,-0.4626480954876006,0.8639240342334342},
{0.26587933410459763,-0.7146295750631707,-0.6470028980932989},
{-0.9521552794681741,-0.04763056988851611,0.3018801957614614},
{-0.2994703976476471,-0.7460951359599987,0.594692802234558},
{-0.8204792058316105,-0.46042434085294215,-0.3388558678082225},
{0.8250132634247718,0.5142334620313477,0.23434389623043875},
{0.4403731046293309,-0.36169520959797435,0.8217348137160806},
{0.33750330384405963,0.1955728342036562,0.9207837891795737},
{-0.6697338542591164,-0.37959137729079356,0.6382530460136537},
{-0.1734083383563737,0.9107689845834048,0.37473911579843844},
{0.5420501423836774,-0.06210968622549985,-0.8380477492475025},
{0.512983001793856,-0.8511181795278597,0.11156291654374541},
{-0.20139125911083477,-0.8155401033717482,-0.5425273270040423},
{0.11824602683013313,-0.883847069277473,0.45258395383454464},
{-0.5125603570737243,-0.7017952976547716,0.49473754713596063},
{-0.35786177098432603,0.6027090685185077,-0.7132157679086424},
{-0.4126855964390434,-0.6498294585106769,-0.6382885502211922},
{-0.757835984466668,0.1533434917302704,0.6341690580526652},
{0.08310098895463287,-0.5040148624866869,-0.8596878759336367},
{0.10394645889174184,0.43271200236826357,-0.8955196573444467},
{-0.3251535430665277,-0.30700630486613745,-0.8944396582239207},
{0.2730861843772744,-0.5961000592370465,-0.7550421546376407},
{0.25206082846568334,0.9676526551974772,-0.010661971790696593},
{0.5607077774619718,0.18191507991172207,0.8077831961574639},
{0.2038046051401364,0.571226981259796,0.7950870510859133},
{-0.7563887315770033,0.06940677499760309,-0.6504296936085899},
{0.12031054032482803,-0.5628132531506682,0.8177815209239627},
{-0.8789135809751889,0.14133386660208713,0.455560814083777},
{-0.630344773828509,0.7139206543511473,-0.30493075508697975},
{-0.843524733459567,-0.44407799604263887,-0.3020939547106504},
{-0.24537627859605832,0.012937143101443397,-0.9693415869706211},
{-0.5318491160725349,0.03545121692997049,-0.8460967609860277},
{0.8609653205912472,-0.07079619919534658,-0.5037128298134799},
{0.9475832369179146,-0.2781402393027591,0.1572387242150339},
{-0.2163165507305446,-0.8858565298423737,-0.410445317205188},
{0.4473488327665116,-0.012629122111422149,-0.8942703881361244},
{0.3516331431491719,-0.6182855127993011,-0.7029062222669104},
{-0.005150734319555224,0.050683154568028965,-0.9987015008394665},
{-0.2819366269714872,-0.9587244000139882,0.036868186689324685},
{0.44100018718936757,-0.4735066728257034,0.762437056869926},
{-0.7546126246613879,0.5853519910526592,-0.29651784646516416},
{0.3290002653205933,-0.9441710962877173,0.017313761977949715},
{-0.04903007529137503,-0.0031676176024433645,-0.9987922796636178},
{0.24906219972946397,0.5666874444677886,0.7853873954606655},
{-0.7686207229080729,0.6224186154002405,-0.14770664006576942},
{0.17455990714964498,0.1919669485086058,0.965752312705593},
{-0.922656028170028,0.3117643286567518,0.22695562795117785},
{-0.20024918581797177,0.08684325561606582,-0.9758885758800756},
{-0.8771435588277552,0.0870220639934153,-0.4722778182228191},
{-0.8645353208079659,0.12777109532208344,0.4860588712035434},
{-0.6644790247173361,0.05887477047904115,0.7449841522554276},
{-0.8755606124957899,-0.45044093880076935,0.17463268450745115},
{-0.8712178828124114,0.2234067216419625,-0.4371142155009948},
{-0.3232465388452081,-0.5541272291648035,-0.7671080034928138},
{0.45048308098552287,0.37993197822431407,-0.8079088349983246},
{-0.23468155630512674,-0.7955827948779063,-0.5585450596187053},
{-0.8422832071242891,-0.24920016843389428,0.4779730902979172},
{-0.7212667408042511,0.6336970138925245,-0.2796468901906666},
{-0.9245496702752694,0.36167941480191057,-0.11998294921545519},
{-0.44815943685707726,0.790551677919059,-0.4173501691569175},
{0.23052573829648204,-0.9525586334825598,0.19872074315657234},
{-0.033728526916960266,-0.5245341459026307,0.850721056665585},
{0.5964243962281887,-0.024677613088987183,0.8022898198257727},
{-0.28910016627688623,0.9448012024860964,-0.15418100284893363},
{-0.14574862099826005,0.5794054501188007,0.8019019041315063},
{-0.18234560393652882,-0.6322784510352153,-0.7529767865489159},
{-0.9803803332873847,-0.1780711038980652,-0.08452859906470137},
{-0.26309293473578643,-0.045207141560268164,-0.9637107564223101},
{-0.6502479716880087,-0.5730546976791312,-0.4987844111272023},
{0.8124601134980247,0.5824571855144036,0.02553803080537174},
{-0.12646127161566975,0.4979713447701296,0.8579231239272995},
{-0.769427618144431,0.6004353540644372,0.21784977857712368},
{-0.8587833798548616,0.35369266921636033,-0.3706650809392038},
{-0.26566418197060077,0.8998271900797712,-0.34602538983582537},
{0.4535658331845041,-0.6987664315823103,-0.5531758391880208},
{-0.2156665762046276,0.9754781079970671,-0.04393618925937813},
{0.7837741374999984,0.039007299579501296,-0.6198197576438238},
{0.28719356084994146,0.0917197440403906,0.9534712094025158},
{0.09401988302863254,0.8387508930793759,-0.5363368353505392},
{0.06878733302988357,0.9645816977341857,-0.25465751748352555},
{-0.34190903311769777,0.20033706959446243,-0.9181303129833066},
{-0.7905657256001141,-0.4350412697362174,0.43098135357885825},
{-0.16167462041939912,-0.8188520668822452,-0.550765476110221},
{0.9089662626189753,0.41645412698385725,0.018608963931534713},
{-0.47363240181421956,-0.5274782607403978,0.7052935788719322},
{0.0774053697033764,0.5350755710445756,-0.8412505821765621},
{-0.28419933635878,-0.9137027298809512,-0.2904790158020485},
{-0.36346147440361565,-0.2819942845357255,-0.8879048260447366},
{0.2369273550270903,-0.9251380337184394,-0.2966227351492919},
{-0.47568293408425566,0.23767275493367726,0.8468986998356001},
{-0.43746576797547027,0.8734188477422407,-0.21392339343383837},
{0.6683474298573354,0.3927942490499551,0.6316837744602722},
{-0.2296536245557787,-0.4745795496714002,-0.8497255226024957},
{-0.4519750267981798,0.8108755518465741,-0.3717518185137748},
{0.9157721350166356,-0.35044294436302115,0.19634444090233308},
{0.638488754202951,-0.7456780205569112,-0.19051614213680274},
{0.08094497050876404,-0.5748384123916181,-0.8142534687604465},
{0.35520439489207667,-0.6038448931711972,-0.713583339800208},
{0.41294194272073964,0.702846127684228,0.5792117684761829},
{0.790860493998653,-0.5069497732897575,0.3428434138111305},
{-0.3278765047684152,0.917793015904668,-0.22394860476783768},
{-0.9465322224744434,-0.0942542149293604,-0.30853345812997496},
{-0.30865598866977767,-0.07782096707156773,0.9479849037523371},
{-0.2548134788528414,0.115534313021957,0.9600634945197412},
{0.8166267928466552,0.5201358769920881,-0.2501586510010347},
{0.4885062527623683,-0.7554186175693742,-0.4366970955269161},
{-0.37748894122011645,-0.6818626526652213,-0.6265504146969049},
{-0.5450237699483933,0.06108123706012849,0.8361926648030616},
{0.9690730140003989,0.16547358703813175,0.18307371610615386},
{0.47187170403786827,-0.26894173125986387,0.8396472116998578},
{0.32055520106661467,0.9141042067225605,-0.24831001252720444},
{0.4330256350760672,-0.7289133527500622,-0.5302585440609441},
{0.3249945560039381,-0.06214198225243333,0.9436720365728454},
{-0.7398212513875208,-0.4499965339438725,0.5001676073416833},
{-0.11971624209068829,-0.34152574378078804,-0.9322168136837392},
{0.24368750728732638,-0.5242480194447682,0.8159536830607038},
{-0.11966645081335507,-0.9123694689533539,0.3914867720262205},
{0.5886307724721574,-0.8033376407636224,-0.09034627070980024},
{-0.8668206507077152,0.2518400511430974,-0.43034700899029776},
{-0.3883427950658423,0.5999453776209622,0.6994679530841212},
{0.6104829065484626,0.27827364474584093,-0.7415351640023597},
{0.023367001515491342,0.7809842575254982,-0.6241134293840516},
{-0.16923655810747365,-0.9303870184819208,0.3251753115478754},
{0.9690431831884692,0.21762407687137095,-0.11659789998899145},
{-0.09053612903794259,0.5633003627166598,-0.8212769999836257},
{0.737615873867269,0.18542141287402267,0.6492624448301522},
{0.5278419765259306,0.5604260108136437,0.6382049312099559},
{-0.193739260499181,0.5323085429754879,-0.8240829533587888},
{-0.3886059440981774,0.1065200555791478,-0.9152261458082256},
{-0.004363522933746319,0.9991523607900503,0.04093311123376481},
{0.5923746638032663,0.7026172183125267,0.3942350849616693},
{0.009369678453733512,-0.9124274946001983,-0.4091311235084403},
{0.597538950475271,-0.4108141222609923,-0.6886065346886001},
{-0.8606616031029227,0.4661336388741896,0.2048927418290205},
{0.4910461363250947,-0.5508942848501408,-0.6748252951095183},
{0.27747971060448073,0.007330573827821346,-0.9607035301747405},
{0.5957146642973241,0.385617119430903,0.7045732580384662},
{-0.9445309567152194,-0.3140713368619079,-0.096023263683371},
{0.7429617490123553,0.48134735369022474,0.4650941459531817},
{-0.5129774627942905,-0.7889414772936573,0.3382683373755724},
{-0.8603733824973097,0.4064196614259752,-0.3075397559609715},
{0.5358339078977647,-0.8224996978046684,0.19072564132344388},
{-0.7423755351195838,-0.49402468069241745,-0.45256842545925224},
{0.4189582958111744,-0.8263040130717613,0.3764247924253913},
{0.233824012878771,0.9194754152745149,-0.3160558363755153},
{0.8256476682144418,-0.029967976432974237,-0.5633896061879095},
{0.5431087194559194,-0.6278904651344681,0.557482271147857},
{0.24862120367492274,0.06400151294482037,0.9664839902574727},
{-0.16406747172968186,-0.9324100713888133,0.32201447714805986},
{-0.9349815538261238,0.020257396449982593,-0.35411739846265017},
{0.34057462127083643,0.432248250285563,0.8349672912583435},
{0.05817898148404382,0.3809606731386266,-0.9227589997584655},
{0.38994328552573543,0.5991553787878449,-0.69925465042643},
{-0.9560918640300794,-0.040503346810720195,-0.2902547612574489},
{-0.3431764439603171,-0.2248695645448547,0.9119559239635207},
{0.004356690294354286,-0.44897720474033614,-0.8935325897096499},
{-0.6427993714199597,0.6166485223764534,-0.4544816475426056},
{0.3691102517469411,-0.42958195631127194,-0.824146203575003},
{-0.06147581139124924,0.733184376212368,0.6772454467118021},
{0.8889777658574929,-0.01836528207505749,0.45758195793248235},
{0.08799824685437461,0.9885007523404329,0.1229738637798878},
{-0.789642842297754,0.13962664172298844,-0.5974684782723558},
{0.9039761519351291,0.37761212117781556,-0.20058963749941608},
{0.7631011259186823,-0.13227514237144153,0.6325977855891167},
{0.03220682833083018,0.3510039122842173,-0.935819947302921},
{-0.9153985070748422,-0.3183697549362999,-0.24634583898850562},
{0.37877890886974164,-0.010366574904004828,-0.9254291287398553},
{0.8024445484151543,0.035823174886700594,-0.5956504401575103},
{-0.16377234564907703,-0.5977408477880217,0.7847830895771495},
{-0.25325814792494766,-0.9388172671205988,-0.2334147584576342},
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

float loda_delta[245] = {1.6234648209403464,1.4828755787343635,1.9683233192132847,1.3402047628034717,1.5828467222344098,1.444938496257981,1.5155407756339,1.3235406664262919,1.5515984902390347,1.2880789115636058,1.5319930963136512,2.0569593436098805,1.6968244907977192,1.5579382302055713,1.7311918593849422,1.8020420151144465,1.4556834897444366,1.6000676153547622,1.401098977209209,1.7421840543269127,1.644898441517122,1.5636691447704891,1.5374148731128017,1.8101865329891793,1.7947798703315996,1.7553253809644649,1.4639693810529462,1.3244013137617507,2.051096835309755,1.2713293566865826,1.5781171133000902,1.6728902221838586,1.9490467945142302,1.6058041396157987,1.552453126928543,1.3410869300594208,1.5245404559480866,1.7816648291592718,1.5946392632387487,2.106855653850056,1.4794637717149361,1.661984492451985,1.2893441723637666,2.071442923810932,1.663010031012685,1.444246438496836,1.40688776377749,1.7180695283782772,1.5129155693750274,2.2433861244413817,1.237056101161194,1.7538630230547287,1.3738131334437313,1.3155236995476427,1.5131464024611068,1.6144600476529962,1.5279024663224383,1.4859370163518344,1.8761956002713827,1.4199604647730883,1.8644318406283868,1.4841475510708821,1.3747087236375877,1.2952297479012476,1.4972936561768295,1.4709984095962745,1.5322470132734627,1.6069459198543126,1.8640144185498453,1.555198297026234,1.4534380637035478,1.5681644168700042,1.5489053013851672,1.9183280847556696,1.9935590885458994,1.3033068284535885,1.683844197358594,1.3468019589896723,1.5378408397661365,1.2951229576209518,1.6118534227422636,1.7375481103665977,1.3114578686608924,1.5144020160293992,1.4877066774539243,1.6380770816457015,1.449928597915069,1.835951063984054,1.590647701715011,1.6088978497304616,1.8717966625810836,1.9690993392370535,1.5661727529597533,1.6802655507601403,1.5227616811312152,2.090733884736037,1.3313468362224747,2.1559232507526747,1.6566475554266369,1.9625824152830758,1.5014032462043674,1.3495312156642025,1.7178084421747264,1.5275669822807094,1.3348428567687698,1.4193719489604002,1.4328957608854542,1.7751078102758389,1.5418794416062327,1.4208048584609525,1.3991890803981537,1.4256355466224102,1.5195301283565332,1.7951428818777933,1.4218243210768855,1.29473760729512,1.3137384779963721,2.0541585358403203,1.5281023186105192,1.5849158272823882,1.416385390014865,1.7088487628805729,1.8004855513611626,1.3068281037544278,1.5137155896696428,1.9150428022817474,1.7380566184410748,1.309999070565478,1.5089949346198896,1.2401862090936864,1.6035827117192387,1.3800634430301217,1.5096612840192698,1.449930641849351,1.481422234516225,1.9576015288937731,1.377162965678679,1.4420769781636906,1.3579971768828736,1.4459666830041855,1.7924601867220065,1.3617319215442742,1.687803330285319,1.6343101800990674,1.5032745313830376,1.5576999954581636,1.2784292185591652,1.4450025537679232,1.7585004681595113,1.769582089181171,1.657204900451044,1.3575218525312303,1.2783754353366987,1.6343592846256674,1.8815455986235214,1.412254737824492,1.5964589670334617,1.4912618625829308,1.3801296584991956,1.6993262901724682,1.359030469152848,2.2758519389104133,1.564803986339465,1.4251746139112949,1.8083744645341648,1.6188891024801657,1.485538192204988,1.513227940914557,1.6041641288763817,1.6398426105192545,1.3508864786236863,1.3549208983294896,1.2706357054077861,1.5622661031460543,1.734179365337549,1.400827849751229,1.5797875067744453,1.5079380387913757,1.5918701480177104,1.4543566486735944,1.4429883847416607,1.8607994572002864,1.411905859153279,1.443168566065604,1.47185387976508,1.4041471763828635,1.9614807357054471,1.5396454035695357,1.5255884397926973,1.4246725088280305,1.6814451935898138,1.4959554348936472,1.850063520062809,1.7907473806216165,1.7225979796547435,1.7807677952790177,1.4051408005937562,1.5959171375602366,1.5137717541264237,1.3216001303759626,1.6041995795563204,1.3285680906834212,1.5651546391650035,1.6520997701740419,1.5528044218687493,1.8032595718844324,1.564437847520087,1.6290919171410219,2.0423891609554423,1.7041231958186496,1.3004759858833619,1.5101181845576677,1.4816457459233074,1.3687462291078758,1.556423159125802,1.9385369216095327,1.2860740618634325,1.5851039952070702,1.5872349692292205,1.9922481630171114,1.716022770587084,1.6316106312947503,1.3370647586900435,1.3241145098172709,1.4841317430960226,1.2628555488092743,1.4194003171248926,1.5739857489513176,1.5701731530771919,1.254530158609668,2.0461959987680785,1.4087855933307218,1.6750661715137154,1.720827506576009,1.4641357866403921,1.6421705676188583,1.5270348703737298,1.57986999789672,1.502022086476175,1.657176963492217,1.4586490833519663,1.6714754905852038,1.6174297697914026,2.2298237833869354,2.0611283954833133};

float log_LUT_loda[128] = {15.0,7.0,6.0,5.415037499278844,5.0,4.678071905112637,4.415037499278844,4.192645077942396,4.0,3.830074998557688,3.678071905112638,3.5405683813627027,3.415037499278844,3.299560281858908,3.192645077942396,3.0931094043914813,3.0,2.9125371587496605,2.830074998557688,2.7520724865564143,2.678071905112638,2.6076825772212398,2.5405683813627027,2.476438043942987,2.415037499278844,2.356143810225275,2.299560281858908,2.2451124978365313,2.192645077942396,2.1420190048724277,2.0931094043914813,2.0458036896131246,2.0,1.9556058806415466,1.9125371587496607,1.8707169830550336,1.8300749985576876,1.7905466343710503,1.7520724865564146,1.7145977811377517,1.6780719051126376,1.6424479953819162,1.6076825772212398,1.573735245297902,1.5405683813627027,1.5081469036703252,1.4764380439429872,1.4454111483223626,1.415037499278844,1.3852901558847919,1.3561438102252752,1.3275746580285044,1.2995602818589078,1.2720795454368008,1.2451124978365316,1.2186402864753405,1.1926450779423958,1.1671099858352583,1.142019004872428,1.1173569506381587,1.0931094043914815,1.0692626624371138,1.0458036896131249,1.0227200765000835,1.0,0.9776321869715455,0.9556058806415466,0.9339108095422276,0.9125371587496606,0.891475543221831,0.8707169830550335,0.850252880495318,0.8300749985576876,0.8101754411199827,0.7905466343710502,0.7711813095041191,0.7520724865564145,0.7332134593050986,0.7145977811377517,0.6962192518228971,0.6780719051126376,0.6601499971153753,0.6424479953819163,0.6249605686530753,0.6076825772212398,0.5906090638622983,0.5737352452979021,0.5570565041512716,0.5405683813627027,0.5242665690336022,0.5081469036703252,0.49220535980130375,0.47643804394298717,0.4608411888919686,0.44541114832236267,0.4301443916690522,0.4150374992788438,0.40008715781287235,0.3852901558847918,0.37064337992039037,0.3561438102252753,0.34178851724820525,0.3275746580285044,0.31349947281678164,0.2995602818589079,0.28575448233387735,0.27207954543680085,0.25853301359885306,0.24511249783653147,0.23181567522307364,0.2186402864753404,0.20558413364989406,0.1926450779423959,0.1798210375848123,0.16710998583525832,0.1545099490556248,0.14201900487242788,0.12963528041659547,0.11735695063815874,0.1051822366920565,0.09310940439148148,0.0811367627254055,0.06926266243711372,0.05748549466076013,0.04580368961312479,0.03421571533791296,0.02272007650008353,0.011315313227834146};

int    windows_value[ENSEMBLE][BATCH_SIZE] = {0};
int    windows_num[ENSEMBLE][BATCH_SIZE] = {0};
int    V_c[ENSEMBLE][BATCH_SIZE] = {0};
int    N_c[ENSEMBLE] = {0};
int    win_idx = 0;


float loda_ensemble(float X[DIM_MAX]) {

    win_idx += 1;
    if (win_idx >= BATCH_SIZE){
        win_idx = 0;
    }
    float score = 0;

    for(int r = 0; r < ENSEMBLE; r++) {
        // ****************************************
        // Random Projection
        // ****************************************
        float projected_X_temp = 0;
        for(int dim = 0; dim < DIM_MAX; dim++) {
            projected_X_temp += X[dim] * loda_projections[r][dim];
        }

        int idx_temp = 0;
        int VC_table = 0;
        int value = 0;

        idx_temp = (int)((projected_X_temp - loda_min_X[r])*(loda_delta[r]));
        if (idx_temp >= N_BINS){
            idx_temp = N_BINS - 1;
        }
        if (idx_temp <= 0){
            idx_temp = 0;
        }
        value = idx_temp;

        int VC_value = 0;
        // ****************************************
        // Slide Windows
        // ****************************************
        int valueFromWin;
        int nFromWin;

        VC_value = V_c[r][value];

        V_c[r][value] += 1;
        N_c[r] += 1;

        valueFromWin = windows_value[r][win_idx];
        nFromWin = windows_num[r][win_idx];

        V_c[r][valueFromWin] -= nFromWin;
        N_c[r] -= nFromWin;

        windows_value[r][win_idx] = value;
        windows_num[r][win_idx] = 1;

        VC_table = VC_value;
        if(VC_table > BATCH_SIZE-1){
            VC_table = BATCH_SIZE - 1;
        }
        float c;
        if(VC_table > 0){
            c= (float)log_LUT_loda[VC_table];
        }
        else{
            c = 15.0;
        }
        score += c;

    }
    return score;
}

float data_window [DIM_MAX] = {0};
int count = 0;

void loda_cardio(float data){
    float anomalyscore;
    bool flag;

    flag = 0;
    count += 1;
    if (count == DIM_MAX){
        count = 0;
        flag = 1;
    }

    for (int i = 0; i < DIM_MAX-1; i++) {
        data_window[i] = data_window[i+1];
    }
    data_window[DIM_MAX-1] = (float)data;


    float score_out_fixed;
    if(flag == 1){
        score_out_fixed = loda_ensemble(data_window);
        anomalyscore = (float)(((double)score_out_fixed/(double)ENSEMBLE - (double)bottom_loda)*(double)delta_loda);
        cout << setprecision(26) << anomalyscore << endl;;
    }
}


int main(int argc, char **argv)
{
    // Load data from file

    stringstream ss;
    string line;
    while (getline(cin, line)) {
        ss.clear();
        ss.str(line);
        string field;
        while (ss >> field) {
            loda_cardio(std::stof(field));
        }
    }
}
    