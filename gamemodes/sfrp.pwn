/*                                                            		 			 *\
		ATENÇÃO: LEIA TODO ESSE TEXTO ABAIXO ANTES DE FAZER QUALQUER COISA!
		ELE CONTÉM INSTRUÇÕES SOBRE COMO MODIFICAR O GAMEMODE, DENTRE OUTRAS
		INFORMAÇÕES DE IMPORTÂNCIA PARA OS PROGRAMADORES! SEJA CONSCIENTE!
			
			
			FEITO SOB MEDIDA, DISCRIÇÃO E GUIA PARA O SANTA FARIA ROLEPLAY, 2015								 
	CRÉDITOS TODOS AO LELETE, SALVO ONDE (OBVIAMENTE) AS FUNÇÕES FORAM RETIRADAS
	HÁ MUITO TEMPO ATRÁS DE PÁGINAS DO FÓRUM SAMP, E INFELIZMENTE NÃO HÁ OS DEVIDOS
	CRÉDITOS DOCUMENTADOS, OU NO CASO DE INCLUDES, QUE ESTÃO COM OS CRÉDITOS NELAS. 
								  GM DO ZERO!
								PASSE UMA VISÃO


			   #             #            #                      #######                            
               #####         ####         #####                  #######                            
               ########      #######      #######                #######                            
               ##########    ##########   ##########             #######                            
               ############# ##########################          #######                            
               ###############################################################                      
               ###############################################################                      
               ###################                         ###################                      
               ####################                        ###################                      
               ######################                   ######################                      
               ##########################            #########################                      
               #####        #################    ################         ####                      
               #####            ##############################            ####                      
               #####                ######################                ####                      
               #####                  ##################                  ####                      
               #####              #########################               ####                      
               #####           ################################           ####                      
               #####  #####################       ######################  ####                      
               ########################               ########################                      
               #####################                      ####################                      
               ####################                        ###################                      
               ###############################################################                      
               ###############################################################                      
               ###############################################################      
		

												
							DOCUMENTAÇÃO DAS FUNÇÕES ABAIXO!
				ATENÇÃO: AS DOCUMENTAÇÕES SÃO IMPORTANTES! ELAS CONTÉM INSTRUÇÕES
			   SOBRE COMO MODIFICAR O GAMEMODE E UTILIZAR ELE DE MANEIRA ORGANIZADA
			   E COMPACTA, SALVANDO TEMPO E DEIXANDO O GAMEMODE MELHOR! UTILIZE-AS!
					LEIA TODAS AS DOCUMENTAÇÕES ANTES DE MODIFICAR O GAMEMODE!
				OS COMANDOS TEM SUA PRÓPRIA DOCUMENTAÇÃO IN-GAME NO HELP/AJUDA!
				AO EDITAR O GM, ADICIONANDO UMA FUNÇÃO, POR FAVOR DOCUMENTE-A!
				                  SIGA O MODELO ABAIXO:
				
				***
				   * NomeDaFunção(parâmetros, parâmetros, parâmetros);
				   * Função pra fazer tal coisa (se ela retorna algo, descreva o que ela retorna);
				   * Por: Autor;
				   * Versão: versão;
				***
							
							
												
\*																	 			 */						
#include <a_samp>
#include <a_mysql>
#include <YSI\y_master>
#include <YSI\y_iterate>
#include <streamer>
#include <sscanf2>
#include <YSI\y_hooks>
#include <..\..\gamemodes\ItemModule.pwn>
//##############################################################################################
#define 		SERVER_NAME					"Santa Faria Roleplay"
#define 		SERVER_VERSION				"SF-RP 0.2.1"
#define 		SERVER_MAP					"SF-RP 0.2.1"
#define 		SERVER_TEXT					"hostname [BR] Santa Faria Roleplay"
#define			LAST_UPDATE 				"13 de outubro de 2015, 13:54"
#define			INTERNAL_SERVER_PASSWORD 	"s3x0n4l4j3"
#define			MYSQL_HOST					"localhost"
#define			MYSQL_USER					"adrp"
#define			MYSQL_DB					"adrp"
#define			MYSQL_PASS					"gml3nd4"
#undef 			MAX_PLAYERS
#define 		MAX_PLAYERS					(50)
#define			MAX_JOBS					(20)
#define			MAX_BUSINESS				(1000)
#define			MAX_HOUSES					(1000)
#define			MAX_PAYPHONES				(1000)
#define			MAX_STORAGES				(1000)
#define			MAX_WEAPONS					(50)
#define			DEFAULT_MESSAGE_RADIUS		(30)
#define 		PRISON_WORLD 				(10000)
#define 		DIALOG_NULL					(1)
#define 		DIALOG_LOGIN				(2)
#define 		DIALOG_ADMINLOGIN			(3)
#define 		DIALOG_RCONLOGIN			(4)
#define 		DIALOG_ADMINREGISTER		(5)
#define 		DIALOG_TERMS				(6)
#define 		DIALOG_REGISTEREX			(7)
#define			DIALOG_PM					(8)
#define			DIALOG_REPORT				(9)
#define			DIALOG_SUGGESTION			(10)
#define			DIALOG_BUGTRACKER			(11)
#define			DIALOG_TUTORIAL				(12)
#define 		DIALOG_NAMEREGISTER			(13)
#define			PANEL_PLAYER_REPORT			(0)
#define			PANEL_PLAYER_SUGGESTION		(1)
#define			PANEL_PLAYER_BUGTRACKER		(2)
#define			PANEL_PLAYER_HELP			(3)
#define			PANEL_PLAYER_MYREPORTS		(4)
#define			PANEL_PLAYER_REPORTEDBY 	(5)
#define			PANEL_PLAYER_MYSUGGESTIONS	(6)
#define			PANEL_PLAYER_MYBUGS			(7)
#define			PANEL_PLAYER_ADMIN			(8)
#define			PANEL_PLAYER_INVENTORY		(9)
#define			ITEM_INVALID_ID				(-1)
#define			QUERY_INSERT_ITEM			(0)
#define 		COLOR_SYSTEM 				0xA9C4E4FF
#define 		COLOR_ERROR 				0xAFAFAFFF
#define 		COLOR_WARNING 				0xFFAA00FF
#define 		COLOR_SYSBLUE 				0x0F59EFFF
#define 		COLOR_YELLOW 				0xFFAA00FF
#define			COLOR_GROUP	 				0x7BDDA5FF
#define 		COLOR_SYSTEM 				0xA9C4E4FF
#define 		COLOR_ERROR	 				0xAFAFAFFF
#define 		COLOR_WARNING 				0xFFAA00FF
#define 		COLOR_SUCESSS 				0x005E23FF
#define 		COLOR_RED 	 				0xE60000FF
#define 		COLOR_WHITE	 				0xFFFFFFFF
#define 		COLOR_LIGHT	 				0xAFD9FAFF
#define 		COLOR_GREY 	 				0xCECECEFF
#define 		COLOR_PURPLE 				0xC2A2DAFF
#define     	COLOR_LIGHTRED 				0xFF8080FF
#define 		COLOR_NICESKY 				0x00C2ECFF
#define 		COLOR_GREEN	 				0x00FF00FF
#define     	COLOR_TEAL 					0x67AAB1FF
#define 		COLOR_DCHAT	 				0xFFD700FF
#define     	COLOR_CHATBUBBLE 			0xFFFFFFFF
#define 		COLOR_NEWBIE 				0x0077BFFF
#define 		COLOR_RADIOCHAT 			0x8D8DFFFF
#define 		COLOR_GENANNOUNCE			0xA9C4E4FF
#define 		COLOR_COOLBLUE 				0x0064FFFF
#define 		COLOR_HOTORANGE 			0xF97804FF
#define 		COLOR_SMS	 				0xD5EAFFFF
#define 		COLOR_CYAN	 				0x011EEFFF
#define			COLOR_HOUSEGREEN			0x006F0AFF
#define 		EMBED_GROUP					"{7BDDA5}"
#define 		EMBED_CYAN					"{011EEF}"
#define 		EMBED_YELLOW				"{FFFF00}"
#define 		EMBED_SYSTEM				"{A9C4E4}"
#define 		EMBED_ERROR					"{AFAFAF}"
#define 		EMBED_WARNING				"{FFAA00}"
#define 		EMBED_SUCESSS				"{005E23}"
#define 		EMBED_RED 					"{E60000}"
#define 		EMBED_WHITE					"{FFFFFF}"
#define 		EMBED_LIGHT					"{AFD9FA}"
#define 		EMBED_GREY 					"{CECECE}"
#define 		EMBED_PURPLE				"{C2A2DA}"
#define 		EMBED_LIGHTRED      		"{FF8080}"
#define 		EMBED_NICESKY				"{00C2EC}"
#define 		EMBED_GREEN					"{00FF00}"
#define 		EMBED_TEAL          		"{67AAB1}"
#define 		EMBED_DCHAT					"{FFD700}"
#define 		EMBED_CHATBUBBLE			"{FFFFFF}"
#define 		EMBED_NEWBIE				"{0077BF}"
#define 		EMBED_RADIOCHAT				"{8D8DFF}"
#define 		EMBED_GENANNOUNCE   		"{A9C4E4}"
#define 		EMBED_COOLBLUE				"{0064FF}"
#define 		EMBED_HOTORANGE 			"{F97804}"
#define 		EMBED_SMS					"{D5EAFF}"
#define 		EMBED_GREY         	 		"{CECECE}"
#define 		EMBED_LIGHTRED 				"{FF8080}"
#define 		EMBED_OOC      				"{AFD9FA}"
#define 		EMBED_WHITE    				"{FFFFFF}"
#define 		TYPE_CAR					(0)
#define 		TYPE_BIKE 					(1)
#define 		TYPE_MOTORBIKE 				(2)
#define 		TYPE_BOAT 					(3)
#define 		TYPE_PLANE 					(4)
#define 		TYPE_RC 					(5)
#define 		TYPE_TRAIN 					(6)
#define 		TYPE_TRAILER 				(7)
#define 		TYPE_HELICOPTER 			(8)
#define 		PRESSED(%0,%1,%2) \
				((((%0) & (%2)) == (%2)) && (((%1) & (%2)) != (%2)))
//##############################################################################################
forward SendErrorMessage(playerid, msg[]);
forward SendSystemMessage(playerid, msg[]);
forward SendActionMessage(playerid, msg[]);
forward SendWarningMessage(playerid, msg[]);
forward SendFactionMessage(faction, msg[]);
forward SendFactionChat(faction, msg[]);
forward SendRPMessage(playerid, msg[]);
forward SendChatMessage(playerid, msg[]);
forward SendColoredMessage(playerid, color, msg[]);
forward SendAdminBroadcast(msg[]);
forward SendAdminColoredBroadcast(msg[], color);
forward SendAdminMessage(msg[]);
forward SendNewbieMessage(msg[]);
forward SendPrivateMessage(playerid, forplayerid, msg[]);
forward SendServerBroadcast(msg[]);
forward SendColoredServerBroadcast(color, msg[]);
forward SendServerChat(msg[]);
forward SendColoredServerChat(color, msg[]);
forward BroadcastRPMessage(message[], playerid, Float:radius);
forward BroadcastChat(message[], playerid, Float:radius);
forward BroadcastMessage(message[], color, playerid, Float:radius);
forward OnPlayerLogin(playerid);
forward OnPlayerRegister(playerid);
forward CheckAccount(playerid);
forward CheckExist(playerid, name[]);
forward GetReportedReports(playerid);
forward GetReporteeReports(playerid);
forward ShowReportInfoBox(playerid);
forward ShowSuggestionInfoBox(playerid);
forward ShowBugTrackerInfoBox(playerid);
forward GetReporteeName(playerid);
forward GetReportedName(playerid);
forward GetSuggestion(playerid);
forward GetBugTracker(playerid);
forward SavePlayerData(playerid);
forward UnfreezePlayer(playerid);
forward RemoveOfflinePlayer(playerid);
forward GlobalTimer();
forward Float:GetDistanceBetweenPlayerToPoint(playerid, Float:pX, Float:pY, Float:pZ);
forward ShutServerDown();
forward GetItemID(itemid);
forward GetItemName(itemnamex[]);
forward GetItemWeight(itemweight);
forward GetItemModel(itemmodel);
forward GetItemVolume(itemvolume);
forward InsertionQuery(queryid, playerid, extraint, Float:extrafloat, extrastr[]);
//##############################################################################################
new db;
new hourcounter;
new HelpStackMessage[20][128];
new HelpStackPlayer[20];
new HelpStackElements = 0;
new bool:OOCChat = true;
//##############################################################################################

//##############################################################################################
new Text:RegisterText[MAX_PLAYERS][54];
new Text:ChatIndicator[MAX_PLAYERS];
new Text:MenuDisc[9];
new Text:BlankScreen;
new Text:MenuInventory[MAX_PLAYERS];
new Text:MenuStats[MAX_PLAYERS];
new Text:MenuPanel[MAX_PLAYERS];
new Text:MenuCharacters[MAX_PLAYERS];
new Text:MenuAdmin[MAX_PLAYERS];
new Text:Cards[5][MAX_PLAYERS];
new Text:MessageBox[MAX_PLAYERS][3];
new Text:Panel[MAX_PLAYERS][31];
new Text:InfoBox[MAX_PLAYERS][14];
new Text:ItemBox[MAX_PLAYERS][8];
//##############################################################################################
new Text3D:NameText[MAX_PLAYERS];
new Text3D:ActorText[MAX_PLAYERS];
new Text3D:TutorialActorText[MAX_PLAYERS];
//##############################################################################################

//##############################################################################################
main()
{
	
	print("#             #            #                      #######      ");                      
	print("#####         ####         #####                  #######      ");                      
	print("########      #######      #######                #######      ");                      
	print("##########    ##########   ##########             #######      ");                      
	print("############# ##########################          #######      ");                      
	print("###############################################################");                      
	print("###############################################################");                      
	print("###################                         ###################");                      
	print("####################                        ###################");                      
	print("######################                   ######################");                      
	print("##########################            #########################");                      
	print("#####        #################    ################         ####");                      
	print("#####            ##############################            ####");                      
	print("#####                ######################                ####");                      
	print("#####                  ##################                  ####");                      
	print("#####              #########################               ####");                      
	print("#####           ################################           ####");                      
	print("#####  #####################       ######################  ####");                      
	print("########################               ########################");                      
	print("#####################                      ####################");                      
	print("####################                        ###################");                      
	print("###############################################################");                      
	print("###############################################################");                     
	print("###############################################################");  
	print("[X] LeLeTe apresenta, do zero... [X]");
	print(SERVER_NAME);
	print(SERVER_VERSION);
	printf("Atualizado em: %s", LAST_UPDATE);
	print("[X] A LENDA! [X]");
}
//##############################################################################################

//##############################################################################################
static const NationaltyStatus[4][24] = {{"Imigrante Ilegal"}, {"Imigrante Legal"}, {"Naturalizado"}, {"Nacional"}}; 
static const SkinToneStatus[5][24] = {{"Americano"}, {"Africano"}, {"Arábico"}, {"Asiático"}, {"Europeu"}};
static const EyeColorStatus[8][24] = {{"Castanho"}, {"Castanho Claro"}, {"Castanho Escuro"}, {"Preto"}, {"Cinza"}, {"Verde"}, {"Azul"}, {"Azul Claro"}}; 
static const EyeShapeStatus[5][24] = {{"Afastados"}, {"Juntos"}, {"Amendoados"}, {"Fundos"}, {"Saltados"}};
static const HairColorStatus[9][24] = {{"Preto"}, {"Castanho Escuro"}, {"Castanho Claro"}, {"Castanho"}, {"Ruivo Claro"}, {"Ruivo"}, {"Loiro Claro"}, {"Loiro"}, {"Cinza"}};
static const HairSizeStatus[6][24] = {{"Muito Longo"}, {"Longo"}, {"Médio"}, {"Curto"}, {"Muito Curto"}, {"Sem Cabelo"}};
static const BodyToneStatus[7][24] = {{"Muito Magro"}, {"Magro"}, {"Esbelto"}, {"Definido"}, {"Muito Definido"}, {"Gordo"}, {"Muito Gordo"}};


static const InteriorNames[][] = {
	"GYM LS", 
	"Putero", 
	"Putero 2",
	"Casa de Apostas",
	"Gravadora",
	"Putero 3",
	"Depósito 1", 
	"Depósito 2",
	"Apartamento do B-Dup",
	"Casa do B-Dup",
	"Wheel Arch Angels", 
	"Casa do OG Loc",
	"Barbearia 1",
	"Prefeitura",
	"Delegacia de LV",
	"Pro Laps", 
	"Sex Shop",
	"Tatuadora",
	"24/7 1",
	"Stacked",
	"Donuts",
	"Ammu-Nation 1", 
	"Victim", 
	"Loco Low Co",
	"Delegacia de SF", 
	"24/7 2", 
	"GYM LV", 
	"Transfenders", 
	"Restaurante (Aberto)",
	"Ammu-Nation 2",
	"SubUrban",
	"Quarto 1 (Denise)",
	"Celeiro",
	"Delegacia (Pequena)",
	"Estádio",
	"Estádio de Corrida ",
	"Pig Pen",
	"Cassino 4D",
	"Liberty City",
	"Casa do Ryder",
	"Casa do Sweet",
	"Campo de Batalha",
	"Casa do CJ",
	"Burguer Shot",
	"Cassino Caligula",
	"Quarto (Katie)",
	"Barbearia 2 (Reece)",
	"Trailer",
	"24/7 3",
	"Zip",
	"Pleasure Domes",
	"Mansão (Madd Dogg)",
	"Palácio de Crack",
	"Prédio (Burning Desire)",
	"Casa do Wu Zi Mu",
	"Casa (Aero Abandonado)",
	"Sala de Roupas",
	"Didier Sachs",
	"Cassino Redsands",
	"Estádio Kickstart",
	"Alhambra",
	"Prédio (Interior)",
	"Quarto de Hotel 1",
	"Casa de Dois Andares 1",
	"Casa Normal",
	"Represa",
	"24/7 4",
	"Motel Jefferson",
	"Jatinho",
	"Bar 1 (Welcome Pump)",
	"Casa de Dois Andares 2",
	"Casa 1", 
	"Casa 2", 
	"Casa 3", 
	"Casa de Dois Andares 3",
	"Binco",
	"Casa 4",
	"Casa 5",
	"Casa 6",
	"Casa 7",
	"Estádio 3",
	"Quarto de Hotel 2",
	"Banco",
	"Posto Dillimore",
	"Bar 2", 
	"Casa 8",
	"Casa de Dois Andares 4",
	"Casa 9",
	"Ammu-Nation 3",
	"Restaurante 2",
	"24/7 5",
	"Casa 10",
	"Casa de Dois Andares 5",
	"Fábrica/Abatedouro", 
	"Casa 11",
	"Casa de Dois Andares 6",
	"Quartinho (Putaria)",
	"Barbearia 3",
	"Estádio de Motocross", 
	"Delegacia LS",
	"Casa de Dois Andares 7",
	"Casa 12", 
	"Casa de Dois Andares 8", 
	"Escola de Direção", 
	"Casa de Dois Andares 9",
	"Casa 13",
	"Loja do Zero", 
	"Ammu-Nation 4", 
	"Ammu-Nation 5",
	"Casa de Dois Andares 10", 
	"24/7 6",
	"Inferninho (Putero)",
	"Casa de Dois Andares 11", 
	"Cluckin' Bell",
	"Quarto de Hotel 3",
	"Corredor de Apartamentos",
	"Casa 14",
	"Escola de Direção 2",
	"Casa 15",
	"Andromada",
	"Bar 3 (Ten Green Bottles)",
	"Casa 16",
	"Casa de Dois Andares 12",
	"Casa 17"
};

static const Float:InteriorPos[][] = {
	{ 772.28, -5.51, 1000.72 },
	{ 975.20, -8.60, 1001.14 },
	{ 967.35, -53.11, 1001.12 },
	{ 834.66, 7.34, 1004.18 },
	{ 1038.07, -3.91, 1001.28 },
	{ 1212.04, -25.87, 1000.95 },
	{ 1309.42, 3.68, 1001.02 },
	{ 1419.16, 3.90, 1001.90 },
	{ 1531.25, -7.05, 1002.09 },
	{ 1521.08, -48.30, 1002.13 },
	{ 609.46, -125.70, 997.99 },
	{ 513.95, -7.32, 1001.56 },
	{ 418.77, -84.20, 1001.80 },
	{ 390.74, 173.76, 1008.38 },
	{ 288.66, 167.17, 1007.17 },
	{ 206.94, -140.37, 1003.50 },
	{ -100.28, -25.03, 1000.71 },
	{ -204.45, -44.28, 1002.27 },
	{ -25.72, -187.82, 1003.54 },
	{ 372.29, -133.50, 1001.49 },
	{ 377.13, -193.24, 1000.63 },
	{ 315.69, -143.66, 999.60 },
	{ 227.55, -8.09, 1002.21 },
	{ 620.19, -70.90, 997.99 },
	{ 246.47, 107.29, 1003.21 },
	{ 6.08, -31.60, 1003.54 },
	{ 773.89, -78.70, 1000.66 },
	{ 627.30, -12.00, 1000.92 },
	{ 455.36, -22.00, 1000.13 },
	{ 285.42, -41.76, 1001.51 },
	{ 203.84, -50.15, 1001.80 },
	{ 243.81, 305.06, 999.14 },
	{ 292.79, 309.82, 999.14 },
	{ 322.21, 302.39, 999.14 },
	{ -1402.66, 106.38, 1032.27 },
	{ -1403.01, -250.45, 1043.53 },
	{ 1204.69, -13.83, 1000.92 },
	{ 2019.08, 1017.75, 996.87 },
	{ -741.84, 493.00, 1371.97 },
	{ 2468.84, -1698.32, 1013.50 },
	{ 2524.29, -1679.20, 1015.49 },
	{ -1128.68, 1066.10, 1345.74 },
	{ 2495.81, -1692.08, 1014.74 },
	{ 363.00, -75.02, 1001.50 },
	{ 2234.00, 1714.68, 1012.38 },
	{ 266.57, 305.19, 999.14 },
	{ 411.90, -23.00, 1001.80 },
	{ 2.06, -2.85, 999.42 },
	{ -30.96, -92.01, 1003.54 },
	{ 161.38, -96.97, 1001.80 },
	{ -2636.54, 1402.46, 906.46 },
	{ 1260.65, -785.16, 1091.90 },
	{ 2531.47, -1281.86, 1048.28 },
	{ 2352.76, -1180.93, 1027.97 },
	{ -2158.66, 643.13, 1052.37 },
	{ 422.56, 2536.32, 10.00 },
	{ 254.16, -41.63, 1002.03 },
	{ 204.25, -168.86, 1000.52 },
	{ 1133.17, -15.13, 1000.67 },
	{ -1464.57, 1555.91, 1052.53 },
	{ 493.37, -24.64, 1000.67 },
	{ 1726.95, -1637.92, 20.22 },
	{ 2233.69, -1115.26, 1050.88 },
	{ 2317.71, -1026.76, 1050.21 },
	{ 2270.41, -1210.26, 1047.56 },
	{ -959.53, 1955.84, 9.00 },
	{ -25.84, -141.55, 1003.54 },
	{ 2214.39, -1150.44, 1025.79 },
	{ 3.02, 32.93, 1199.59 },
	{ 681.67, -451.49, -25.61 },
	{ 235.25, 1186.71, 1080.25 },
	{ 226.78, 1239.77, 1082.14 },
	{ 223.17, 1287.07, 1082.14 },
	{ 318.92, 1114.47, 1083.88 },
	{ 226.35, 1114.12, 1080.99 },
	{ 207.77, -111.26, 1005.13 },
	{ 295.15, 1472.49, 1080.25 },
	{ 328.05, 1477.72, 1084.43 },
	{ 387.22, 1471.73, 1080.19 },
	{ 377.15, 1417.31, 1081.32 },
	{ -1417.69, 932.64, 1041.53 },
	{ 446.47, 506.72, 1001.41 },
	{ 2304.68, -16.18, 26.74 },
	{ 662.63, -573.39, 16.33 },
	{ -229.29, 1401.19, 27.76 },
	{ 446.91, 1397.06, 1084.30 },
	{ 491.24, 1398.50, 1080.25 },
	{ 261.02, 1284.30, 1080.25 },
	{ 285.78, -86.72, 1001.52 },
	{ 460.55, -88.67, 999.55 },
	{ -27.44, -31.47, 1003.55 },
	{ 300.04, 309.92, 1003.30 },
	{ 24.29, 1340.23, 1084.37 },
	{ 965.08, 2159.78, 1011.03 },
	{ 221.95, 1140.19, 1082.60 },
	{ 2324.39, -1149.54, 1050.71 },
	{ 343.71, 305.30, 999.14 },
	{ 411.91, -54.44, 1001.89 },
	{ -1421.56, -663.82, 1059.55 },
	{ 246.68, 62.33, 1003.64 },
	{ -260.57, 1456.51, 1084.36 },
	{ 22.88, 1403.32, 1084.43 },
	{ 140.33, 1365.91, 1083.85 },
	{ 1494.60, 1303.57, 1093.28 },
	{ 234.10, 1063.72, 1084.21 },
	{ -68.85, 1351.19, 1080.21 },
	{ -2240.78, 136.94, 1035.41 },
	{ 296.88, -112.06, 1001.51 },
	{ 316.39, -170.29, 999.59 },
	{ -283.44, 1471.24, 1084.37 },
	{ -27.39, -58.12, 1003.54 },
	{ 744.47, 1436.34, 1102.70 },
	{ 2807.63, -1174.75, 1025.57 },
	{ 364.82, -11.70, 1001.85 },
	{ 2218.40, -1076.26, 1050.48 },
	{ 2265.89, 1647.48, 1084.23 },
	{ 2237.55, -1081.64, 1049.02 },
	{ -2029.66, -119.62, 1035.17 },
	{ 2365.32, -1135.59, 1050.88 },
	{ 316.30, 972.78, 1961.70 },
	{ 501.85, -67.56, 998.75 },
	{ -42.68, 1412.76, 1084.42 },
	{ 83.00, 1322.28, 1083.86 },
	{ 260.86, 1237.23, 1084.25 }
};

static const InteriorInts[] = 
{
5 ,
3 ,
3 ,
3 ,
3 ,
3 ,
18 ,
1 ,
3 ,
2 ,
3 ,
3 ,
3 ,
3 ,
3 ,
3 ,
3 ,
3 ,
17 ,
5 ,
17 ,
7 ,
5 ,
2 ,
10 ,
10 ,
7 ,
1 ,
1 ,
1 ,
1 ,
1 ,
3 ,
5 ,
1 ,
7 ,
2 ,
10 ,
1 ,
2 ,
1 ,
10 ,
3 ,
10 ,
1 ,
2 ,
2 ,
2 ,
18 ,
18 ,
3 ,
5 ,
2 ,
5 ,
-1 ,
10 ,
14 ,
14 ,
12 ,
14 ,
17 ,
18 ,
5 ,
9 ,
10 ,
17 ,
16 ,
15 ,
1 ,
1 ,
3 ,
2 ,
1 ,
5 ,
5 ,
5 ,
15 ,
15 ,
15 ,
15 ,
15 ,
12 ,
0 ,
0 ,
18 ,
2 ,
2 ,
4 ,
4 ,
4 ,
4 ,
4 ,
10 ,
1 ,
4 ,
12 ,
6 ,
12 ,
4 ,
6 ,
4 ,
5 ,
5 ,
3 ,
6 ,
6 ,
6 ,
6 ,
6 ,
15 ,
6 ,
6 ,
8 ,
9 ,
1 ,
1 ,
2 ,
3 ,
8 ,
9 ,
11 ,
8 ,
9,
9 

};

static const VehicleNames[][] =
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perreniel", "Sentinel",
    "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
    "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection",
    "Hunter", "Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus",
    "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie",
    "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral",
    "Squalo", "Seasparrow", "Pizza Faggio", "Tram", "Trailer", "Turismo", "Speeder",
    "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair", "Berkley's RC Van",
    "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale",
    "Oceanic","Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy",
    "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX",
    "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Heli",
    "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking",
    "Blista Compact", "Police Maverick", "Boxville", "Benson", "Mesa", "RC Goblin",
    "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher", "Super GT",
    "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt",
    "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra",
    "FCR-900", "NRG-500", "HPV-1000", "Cement Truck", "Tow Truck", "Fortune",
    "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer",
    "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex", "Vincent",
    "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo",
    "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite",
    "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratium",
    "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper",
    "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
    "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car",
    "Police Car", "Police Car", "Police Ranger", "Picador", "S.W.A.T", "Alpha",
    "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs", "Boxville",
    "Tiller", "Utility Trailer"
};

//##############################################################################################
/***
   * ShowUpdateDialog(playerid);
   * Mostra os updates;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock ShowUpdateDialog(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	new str[1500];
	new straux[128];
	format(straux, 128, "A versão atual do gamemode é a %s, online desde %s;", SERVER_VERSION, LAST_UPDATE);
	strcat(str, straux);
	strcat(str, "\n{00B33C}adicionado\t Tutorial;");
	strcat(str, "\n{c2A2da}modificado\t Criação de Personagens;");
	strcat(str, "\n{afafaf}removido\t Sistemas de Veículo, Propriedades, Empresas, Administrativos, Itens, Casas, e todos os outros;");
	return ShowPlayerDialog(playerid, DIALOG_NULL, DIALOG_STYLE_MSGBOX, "Atualizações", str, "Sair", "");
}

/***
   * HelpStackEmpty();
   * Verifica se a fila de ajuda está vazia;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock HelpStackEmpty()
{
	if(HelpStackElements == 0) return true;
	return false;
}

/***
   * HelpStackFull();
   * Verifica se a fila de ajuda está cheia;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock HelpStackFull()
{
	if(HelpStackElements == 20) return true;
	return false;
}

/***
   * HelpStackTopMessage();
   * Mostra a última mensagem da fila de ajuda;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock HelpStackTopMessage()
{
	new stack[128];
	format(stack, 128, "Vazio");
	if(!HelpStackEmpty()) format(stack, 128, "%s", HelpStackMessage[(HelpStackElements-1)]);
	return stack;
}

/***
   * HelpStackTopPlayer();
   * Mostra o último jogador da fila de ajuda;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock HelpStackTopPlayer()
{
	if(HelpStackEmpty()) return INVALID_PLAYER_ID;
	return HelpStackPlayer[(HelpStackElements-1)];
}

/***
   * HelpStackPop();
   * Remove o último jogador e mensagem da fila de ajuda;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock HelpStackPop()
{
	if(HelpStackEmpty()) return false;
	HelpStackPlayer[HelpStackElements] = INVALID_PLAYER_ID;
	format(HelpStackMessage[HelpStackElements], 128, "Vazio");
	HelpStackElements--;
	return true;
}

/***
   * HelpStackPush(playerid, message[]);
   * Adiciona uma mensagem e jogador a fila de ajuda;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock HelpStackPush(playerid, message[])
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(HelpStackFull()) return false;
	HelpStackPlayer[HelpStackElements] = playerid;
	format(HelpStackMessage[HelpStackElements], 128, "%s", message);
	HelpStackElements++;
	return true;
}

/***
   * convert_encoding(string);
   * Modifica uma string;
   * Por: LeLeTe;
   * Versão: 1.2;
***/


stock convert_encoding(string[])
{
	new original[52] = {192,193,194,196,198,199,200,201,202,203,204,205,206,207,210,211,212,214,217,218,219,220,223,224,225,226,227,228,230,231,232,233,234,235,236,237,238,239,242,243,244,245,246,249,250,251,252,209,241,191,161,176};
	new fixed[52] = {128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,151,155,156,157,158,159,160,161,162,163,164,165,166,167,168,168,169,170,171,172,173,174,175,94,124};
	new len = strlen(string);
	for (new i; i < len; i++) {
		for(new j;j < 52;j++) {
			if(string[i] == original[j]) {
				string[i] = fixed[j];
				break;
			}
		}
	}
}

/***
   * OpenInfoBox(playerid);
   * Abre a Caixa de Informações;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock OpenInfoBox(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	for(new i = 0; i < 2; i++) TextDrawShowForPlayer(playerid, InfoBox[playerid][i]);
	TextDrawShowForPlayer(playerid, InfoBox[playerid][13]);
	SetPVarInt(playerid, "InfoBox", 1337);
	SelectTextDraw(playerid, COLOR_PURPLE);
	return 1;
}

/***
   * CloseInfoBox(playerid);
   * Fecha a Caixa de Informações;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock CloseInfoBox(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	for(new i = 0; i < 14; i++) TextDrawHideForPlayer(playerid, InfoBox[playerid][i]);
	SetPVarInt(playerid, "InfoBox", 0);
	CancelSelectTextDraw(playerid);
	return 1;
}

/***
   * CloseItemBox(playerid);
   * Fecha a Caixa de Itens;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock CloseItemBox(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	for(new i = 0; i < 8; i++) TextDrawHideForPlayer(playerid, ItemBox[playerid][i]);
	SetPVarInt(playerid, "ItemBox", 0);
	CancelSelectTextDraw(playerid);
	return 1;
}

/***
   * ItemBoxPickup(playerid);
   * Pega o item mostrado na caixa de item;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock ItemBoxPickup(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	if(GetPVarInt(playerid, "ItemContainer") != -1)
	{
		if(GetPVarInt(playerid, "RightHandItem") != -1)
		{
			new item = GetPVarInt(playerid, "ItemID");
			mysql_format(db, string, 128, "SELECT `containerID` FROM `containers` WHERE `itemID` = '%i';", PlacedItems[item][pID]);
			mysql_function_query(db, string, true, "IsItemContainer", "i", item);
			if(item == -1)
			{
				if(GetPVarInt(playerid, "LeftHandItem") != -1)
				{
					mysql_format(db, string, 128, "SELECT `containerID` FROM `containers` WHERE `itemID` = '%i';", PlacedItems[item][pID]);
					mysql_function_query(db, string, true, "IsItemContainer", "i", item);
					if(item == -1)
					{
						if(GetPVarInt(playerid, "BackItem") != -1)
						{
							mysql_format(db, string, 128, "SELECT `containerID` FROM `containers` WHERE `itemID` = '%i';", PlacedItems[item][pID]);
							mysql_function_query(db, string, true, "IsItemContainer", "i", item);
							if(item == -1)
							{
								return SendActionMessage(playerid, "Você não possui mais espaço para este item.");
							}
							else 
							{
								if(!AddItemToContainer(GetPVarInt(playerid, "ItemContainer"), PlacedItems[GetPVarInt(playerid, "ItemID")][pID])) return SendActionMessage(playerid, "Você não possui mais espaço para este item.");
							}
						}
						else
						{
							SetPVarInt(playerid, "BackItem", PlacedItems[item][pID]);
						}
					}
					else 
					{
						if(!AddItemToContainer(GetPVarInt(playerid, "ItemContainer"), PlacedItems[GetPVarInt(playerid, "ItemID")][pID]))
						{
							if(GetPVarInt(playerid, "BackItem") != -1)
							{
								mysql_format(db, string, 128, "SELECT `containerID` FROM `containers` WHERE `itemID` = '%i';", PlacedItems[item][pID]);
								mysql_function_query(db, string, true, "IsItemContainer", "i", item);
								if(item == -1)
								{
									return SendActionMessage(playerid, "Você não possui mais espaço para este item.");
								}
								else 
								{
									if(!AddItemToContainer(GetPVarInt(playerid, "ItemContainer"), PlacedItems[GetPVarInt(playerid, "ItemID")][pID])) return SendActionMessage(playerid, "Você não possui mais espaço para este item.");
								}
							}
							else
							{
								SetPVarInt(playerid, "BackItem", PlacedItems[item][pID]);
							}
						}
						else
						{
							SetPVarInt(playerid, "BackItem", PlacedItems[item][pID]);
						}
					}
				}
				else
				{
					SetPVarInt(playerid, "LeftHandItem", PlacedItems[item][pID]);
				}
			}
			else
			{
				if(!AddItemToContainer(GetPVarInt(playerid, "ItemContainer"), PlacedItems[GetPVarInt(playerid, "ItemID")][pID]))
				{
					if(GetPVarInt(playerid, "LeftHandItem") != -1)
					{
						mysql_format(db, string, 128, "SELECT `containerID` FROM `containers` WHERE `itemID` = '%i';", PlacedItems[item][pID]);
						mysql_function_query(db, string, true, "IsItemContainer", "i", item);
						if(item == -1)
						{
							if(GetPVarInt(playerid, "BackItem") != -1)
							{
								mysql_format(db, string, 128, "SELECT `containerID` FROM `containers` WHERE `itemID` = '%i';", PlacedItems[item][pID]);
								mysql_function_query(db, string, true, "IsItemContainer", "i", item);
								if(item == -1)
								{
									return SendActionMessage(playerid, "Você não possui mais espaço para este item.");
								}
								else 
								{
									if(!AddItemToContainer(GetPVarInt(playerid, "ItemContainer"), PlacedItems[GetPVarInt(playerid, "ItemID")][pID])) return SendActionMessage(playerid, "Você não possui mais espaço para este item.");
								}
							}
							else
							{
								SetPVarInt(playerid, "BackItem", PlacedItems[item][pID]);
							}
							
						}
						else 
						{
							if(!AddItemToContainer(GetPVarInt(playerid, "ItemContainer"), PlacedItems[GetPVarInt(playerid, "ItemID")][pID]))
							{
								if(GetPVarInt(playerid, "BackItem") != -1)
								{
									mysql_format(db, string, 128, "SELECT `containerID` FROM `containers` WHERE `itemID` = '%i';", PlacedItems[item][pID]);
									mysql_function_query(db, string, true, "IsItemContainer", "i", item);
									if(item == -1)
									{
										return SendActionMessage(playerid, "Você não possui mais espaço para este item.");
									}
									else 
									{
										if(!AddItemToContainer(GetPVarInt(playerid, "ItemContainer"), PlacedItems[GetPVarInt(playerid, "ItemID")][pID])) return SendActionMessage(playerid, "Você não possui mais espaço para este item.");
									}
								}
								else
								{
									SetPVarInt(playerid, "BackItem", PlacedItems[item][pID]);
								}
							}
						}
					}
					else
					{
						SetPVarInt(playerid, "LeftHandItem", PlacedItems[item][pID]);
					}
				}
			}
		}
		else
		{
			SetPVarInt(playerid, "RightHandItem", PlacedItems[item][pID]);
		}
		RemovePlacedItem(GetPVarInt(playerid, "ItemID"));
	}
	new str[128];
	format(str, 128, "Você pegou \"%s\".", GetPVarStringEx(playerid, "ItemName"));
	SendActionMessage(playerid, str);
	return 1;
}

/***
   * AddInfoBoxTitle(playerid, titleid, title[]);
   * Adiciona um título a caixa;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock AddInfoBoxTitle(playerid, titleid, infotitle[])
{
    if(!IsPlayerConnected(playerid)) return 0;
	if(titleid < 1 || titleid > 5) return 0;
	if(strlen(infotitle) > 24) format(infotitle, 24, "%s", infotitle);
	convert_encoding(infotitle);
	TextDrawSetString(InfoBox[playerid][1+(titleid*2)], infotitle);
	TextDrawShowForPlayer(playerid, InfoBox[playerid][1+(titleid*2)]);
	return 1;
}

/***
   * AddInfoBoxMessage(playerid, messageid, message[]);
   * Adiciona uma mensagem a caixa;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock AddInfoBoxMessage(playerid, messageid, infomessage[])
{
    if(!IsPlayerConnected(playerid)) return 0;
	if(messageid < 1 || messageid > 5) return 0;
	if(strlen(infomessage) > 128) format(infomessage, 128, "%s", infomessage);
	convert_encoding(infomessage);
	TextDrawSetString(InfoBox[playerid][2+(messageid*2)], infomessage);
	TextDrawShowForPlayer(playerid, InfoBox[playerid][2+(messageid*2)]);
	return 1;
}

/***
   * SetPanelTabTitle(playerid, title[]);
   * Define o título da aba do painel de um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SetPanelTabTitle(playerid, title[])
{
    if(!IsPlayerConnected(playerid)) return 0;
    if(strlen(title) > 24) format(title, 24, "%s", title);
	convert_encoding(title);
	TextDrawSetString(Panel[playerid][4], title);
	return 1;
}

/***
   * ShowPanelItem(playerid, itemid);
   * Mostra ao jogador um item do painel;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock ShowPanelItem(playerid, itemid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	if(itemid < 1 || itemid > 21) return 0;
	TextDrawShowForPlayer(playerid, Panel[playerid][9+itemid]);
	return 1;
}

/***
   * AddPanelItem(playerid, itemid, itemtitle[]);
   * Adiciona um item ao painel do jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock AddPanelItem(playerid, itemid, itemtitle[], bool:showitem = false)
{
    if(!IsPlayerConnected(playerid)) return 0;
	if(itemid < 1 || itemid > 21) return 0;
	if(strlen(itemtitle) > 48) format(itemtitle, 48, "%s", itemtitle);
	convert_encoding(itemtitle);
	TextDrawSetString(Panel[playerid][9+itemid], itemtitle);
	if(showitem) TextDrawShowForPlayer(playerid, Panel[playerid][9+itemid]);
	return 1;
}

/***
   * PanelItemClicked(playerid, panelid);
   * "Callback" para ações ao clicar em um item do painel;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock PanelItemClicked(playerid, itemid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	if(itemid < 1 || itemid > 21) return 0;
	switch(GetPVarInt(playerid, "PanelOpen"))
	{
		case PANEL_PLAYER_REPORT:
		{
			switch(itemid)
			{
				case 1:
				{
					new str[256];
					format(str, 256, "SELECT * FROM playerreports WHERE reported = '%i'", GetPVarInt(playerid, "InternalID"));
					mysql_function_query(db, str, true, "GetReportedReports", "i", playerid);
				}
				case 2:
				{
					new str[256];
					format(str, 256, "SELECT * FROM playerreports WHERE reportee = '%i'", GetPVarInt(playerid, "InternalID"));
					mysql_function_query(db, str, true, "GetReporteeReports", "i", playerid);
				}
				case 3:
				{
					HidePlayerPanel(playerid);
					SetPVarInt(playerid, "Reporting", 1337);
					ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", "Digite abaixo o nome ou ID do jogador que deseja reportar;", "Reportar", "Cancelar");
				}
			}
		}
		case PANEL_PLAYER_SUGGESTION:
		{
			switch(itemid)
			{
				case 1:
				{
					new str[256];
					format(str, 256, "SELECT * FROM playersuggestions WHERE sugPlayer = '%i'", GetPVarInt(playerid, "InternalID"));
					mysql_function_query(db, str, true, "GetSuggestion", "i", playerid);
				}
				case 2:
				{
					HidePlayerPanel(playerid);
					SetPVarInt(playerid, "Suggesting", 1337);
					ShowPlayerDialog(playerid, DIALOG_SUGGESTION, DIALOG_STYLE_INPUT, "Faça uma Sugestão", "Digite abaixo a sua sugestão;\nComentários adicionais podem ser feitos a seguir;", "Sugerir", "Cancelar");
				}
			}
		}
		case PANEL_PLAYER_BUGTRACKER:
		{
			switch(itemid)
			{
				case 1:
				{
					new str[256];
					format(str, 256, "SELECT * FROM bugtracker WHERE bugReporter = '%i'", GetPVarInt(playerid, "InternalID"));
					mysql_function_query(db, str, true, "GetBugTracker", "i", playerid);
				}
				case 2:
				{
					HidePlayerPanel(playerid);
					SetPVarInt(playerid, "BugTracking", 1337);
					ShowPlayerDialog(playerid, DIALOG_BUGTRACKER, DIALOG_STYLE_INPUT, "Reporte um Bug", "Digite abaixo o título do seu bug;\nDetalhes e comentários adicionais sobre o bug serão feitos a seguir\nAtenção: Limite de 24 caracteres de título;", "Relatar", "Cancelar");
				}
			}
		}
		case PANEL_PLAYER_REPORTEDBY, PANEL_PLAYER_MYREPORTS:
		{
			for(new i = 0; i < 31; i++) TextDrawHideForPlayer(playerid, Panel[playerid][i]);
			new str[256];
			new x[24];
			format(x, 24, "PanelItem%iExtra", itemid);
			format(str, 256, "SELECT * FROM playerreports WHERE reportid = '%i'", strval(GetPVarStringEx(playerid, x)));
			mysql_function_query(db, str, true, "ShowReportInfoBox", "i", playerid);
		}
		case PANEL_PLAYER_MYSUGGESTIONS:
		{
			for(new i = 0; i < 31; i++) TextDrawHideForPlayer(playerid, Panel[playerid][i]);
			new str[256];
			new x[24];
			format(x, 24, "PanelItem%iExtra", itemid);
			format(str, 256, "SELECT * FROM playersuggestions WHERE suggestionID = '%i'", strval(GetPVarStringEx(playerid, x)));
			mysql_function_query(db, str, true, "ShowSuggestionInfoBox", "i", playerid);
		}
		case PANEL_PLAYER_MYBUGS:
		{
			for(new i = 0; i < 31; i++) TextDrawHideForPlayer(playerid, Panel[playerid][i]);
			new str[256];
			new x[24];
			format(x, 24, "PanelItem%iExtra", itemid);
			format(str, 256, "SELECT * FROM bugtracker WHERE bugID = '%i'", strval(GetPVarStringEx(playerid, x)));
			mysql_function_query(db, str, true, "ShowBugTrackerInfoBox", "i", playerid);
		}
		case PANEL_PLAYER_HELP:
		{
			HidePlayerPanel(playerid);
			switch(itemid)
			{
				case 1: ShowUpdateDialog(playerid);
				case 4: return ShowPlayerDialog(playerid, DIALOG_TUTORIAL, DIALOG_STYLE_MSGBOX, "Tutorial", "Você deseja ver o tutorial de novo?", "SIM", "NÃO"); 
			}
		}
		case PANEL_PLAYER_ADMIN:
		{
			for(new i = 0; i < 31; i++) TextDrawHideForPlayer(playerid, Panel[playerid][i]);
			
		}
		case PANEL_PLAYER_INVENTORY:
		{
		
		}
		default: return 0;
	}
	return 1;
}

/***
   * ShowPlayerPanel(playerid, panelid);
   * Abre o painel para um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock ShowPlayerPanel(playerid, panelid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	switch(panelid)
	{
		case PANEL_PLAYER_REPORT:
		{
			SetPanelTabTitle(playerid, "Denúncias");
			AddPanelItem(playerid, 1, "Denúncias Enviadas", true);
			AddPanelItem(playerid, 2, "Denúncias Recebidas", true);
			AddPanelItem(playerid, 3, "Denunciar", true);
		}
		case PANEL_PLAYER_SUGGESTION:
		{
			SetPanelTabTitle(playerid, "Sugestões");
			AddPanelItem(playerid, 1, "Minhas Sugestões", true);
			AddPanelItem(playerid, 2, "Fazer uma Sugestão", true);
		}
		case PANEL_PLAYER_BUGTRACKER:
		{
			SetPanelTabTitle(playerid, "Rastreador de Erros");
			AddPanelItem(playerid, 1, "Bugs/Erros Reportados", true);
			AddPanelItem(playerid, 2, "Reportar um Erro/Bug", true);
		}
		case PANEL_PLAYER_HELP:
		{
			SetPanelTabTitle(playerid, "Ajuda");
			AddPanelItem(playerid, 1, "Atualizações", true);
			AddPanelItem(playerid, 2, "Regras", true);
			AddPanelItem(playerid, 3, "Sistemas", true);
			AddPanelItem(playerid, 4, "Tutorial", true);
			AddPanelItem(playerid, 5, "Peça Ajuda Online", true);
		}
		case PANEL_PLAYER_REPORTEDBY:
		{
			SetPanelTabTitle(playerid, "Relatórios Enviados");
		}
		case PANEL_PLAYER_MYREPORTS:
		{
			SetPanelTabTitle(playerid, "Relatórios Recebidos");
		}
		case PANEL_PLAYER_MYSUGGESTIONS:
		{
			SetPanelTabTitle(playerid, "Sugestões Enviadas");
		}
		case PANEL_PLAYER_MYBUGS:
		{
			SetPanelTabTitle(playerid, "Relatóios de Erro");
		}
		case PANEL_PLAYER_ADMIN:
		{
			SetPanelTabTitle(playerid, "Relatóios de Erro");
		}
		case PANEL_PLAYER_LEFTHAND:
		{
			SetPanelTabTitle(playerid, "Mão Esquerda");
			if(GetPVarInt(playerid, "LeftHandItem") == -1) AddPanelItem(playerid, 1, "Nada", true);
			else 
			{
				new string[128], sName[24];
				mysql_format(db, string, 128, "SELECT itemName FROM items WHERE itemID = '%i';", GetPVarInt(playerid, "LeftHandItem"));
				mysql_function_query(db, string, true, "GetItemName", "s", sName);
				AddPanelItem(playerid, 1, sName, true);
			}
		}
		default: return 0;
	}
	for(new i = 0; i < 10; i++) TextDrawShowForPlayer(playerid, Panel[playerid][i]);
	SelectTextDraw(playerid, COLOR_PURPLE);
	SetPVarInt(playerid, "PanelOpen", panelid);
	return 1;
}

/***
   * HidePlayerPanel(playerid);
   * Fecha o painel para um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock HidePlayerPanel(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	SetPVarInt(playerid, "PanelOpen", -1);
	for(new i = 0; i < 31; i++) TextDrawHideForPlayer(playerid, Panel[playerid][i]);
	CancelSelectTextDraw(playerid);
	return 1;
}

/***
   * PanelTabBackward(playerid);
   * Volta uma aba do painel;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock PanelTabBackward(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;for(new i = 0; i < 31; i++) TextDrawHideForPlayer(playerid, Panel[playerid][i]);
	switch(GetPVarInt(playerid, "PanelOpen"))
	{
		case PANEL_PLAYER_REPORT: ShowPlayerPanel(playerid, PANEL_PLAYER_SUGGESTION);
		case PANEL_PLAYER_SUGGESTION: ShowPlayerPanel(playerid, PANEL_PLAYER_BUGTRACKER);
		case PANEL_PLAYER_BUGTRACKER: ShowPlayerPanel(playerid, PANEL_PLAYER_HELP);
		case PANEL_PLAYER_HELP: ShowPlayerPanel(playerid, PANEL_PLAYER_REPORT);
		case PANEL_PLAYER_MYREPORTS, PANEL_PLAYER_REPORTEDBY: return 1;
		default: return 0;
	}
	return 1;
}

/***
   * PanelTabForward(playerid);
   * Avança uma aba do painel;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock PanelTabForward(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;for(new i = 0; i < 31; i++) TextDrawHideForPlayer(playerid, Panel[playerid][i]);
	switch(GetPVarInt(playerid, "PanelOpen"))
	{
		case PANEL_PLAYER_REPORT: ShowPlayerPanel(playerid, PANEL_PLAYER_HELP);
		case PANEL_PLAYER_HELP: ShowPlayerPanel(playerid, PANEL_PLAYER_BUGTRACKER);
		case PANEL_PLAYER_BUGTRACKER: ShowPlayerPanel(playerid, PANEL_PLAYER_SUGGESTION);
		case PANEL_PLAYER_SUGGESTION: ShowPlayerPanel(playerid, PANEL_PLAYER_REPORT);
		default: return 0;
	}
	return 1;
}

/***
   * PanelListUp(playerid);
   * Sobe a lista do painel;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock PanelListUp(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	return 1;
}

/***
   * PanelListDown(playerid);
   * Desce a lista do painel;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock PanelListDown(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	return 1;
}

/***
   * GetVehicleName(vehicleid);
   * Pega a ID do veículo e retorna o nome dele, segundo a tabela VehicleNames;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetVehicleName(vehicleid)
{
    new string[128];
	format(string, sizeof(string), "%s", VehicleNames[GetVehicleModel(vehicleid) - 400]);
    return string;
}

/***
   * ReturnPlayerNameEx(playerid);
   * Retorna o nome do jogador completo;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock ReturnPlayerNameEx(playerid)
{
	new string[24];
	GetPlayerName(playerid, string, 24);
	return string;
}

/***
   * ReturnRPName(playerid);
   * Retorna o nome do jogador sem a sublinha;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock ReturnRPName(playerid)
{
	new str[24], idx;
	GetPlayerName(playerid, str, 24);
	idx = strfind( str, "_" );
	if(idx != -1) str[idx] = ' ';
	return str;
}


/***
   * FormatDate(date);
   * Formata a data em uma string com Dia, Mês, Ano, Hora, Minuto e Segundo;
   * Por: pen_TheGun;
   * Versão: ?;
***/

stock FormatDate(date)
{
	new year=1970, day=0, month=0, hour=0, mins=0, sec=0;
	
	new days_of_month[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };
	new names_of_month[12][10] = {"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"};
	new returnstring[48];
	
	while(timestamp>31622400){
		timestamp -= 31536000;
		if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) timestamp -= 86400;
		year++;
	}
	
	if ( ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0) ) 
		days_of_month[1] = 29;
	else 
		days_of_month[1] = 28;
	
	
	while(timestamp>86400){
		timestamp -= 86400, day++;
		if(day==days_of_month[month]) day=0, month++;
	}
	
	while(timestamp>60){
		timestamp -= 60, mins++;
		if( mins == 60) mins=0, hour++;
	}
	
	sec=timestamp;
	
	format(returnstring, 48, "%02d de %s de %d, %02d:%02d:%02d", names_of_month[month],day+1,year, hour, mins, sec);
	
	return returnstring;
}

/***
   * StartRegister(playerid);
   * Função para iniciar o registro usando as textdraws;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock StartRegister(playerid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	SetPlayerInterior(playerid, 14);
	SetPlayerPos(playerid, 258.3504,-41.5838,1002.0234);
	SetPlayerCameraPos(playerid, 254.1672,-41.8898,1003.2319);
	SetPlayerCameraLookAt(playerid, 258.3504,-41.5838,1002.0234);
	TogglePlayerControllable(playerid, false);
	AddRegisterSelection(playerid, 1, "Idade", "18");
	SetPVarInt(playerid, "Registration1", 18);
	AddRegisterSelection(playerid, 2, "Sexo", "Masculino");
	SetPVarInt(playerid, "Registration2", 0);
	AddRegisterSelection(playerid, 3, "Skin", "183");
	SetPVarInt(playerid, "Registration3", 183);
	AddRegisterSelection(playerid, 4, "Peso", "85kg");
	SetPVarInt(playerid, "Registration4", 85);
	AddRegisterSelection(playerid, 5, "Altura", "180cm");
	SetPVarInt(playerid, "Registration5", 180);
	AddRegisterSelection(playerid, 6, "Ingresso/Imigração", "Imigrante Legal");
	SetPVarInt(playerid, "Registration6", 1);
	AddRegisterSelection(playerid, 7, "Tom de Pele", "Americano");
	SetPVarInt(playerid, "Registration7", 0);
	AddRegisterSelection(playerid, 8, "Cor do Olho", "Castanho");
	SetPVarInt(playerid, "Registration8", 0);
	AddRegisterSelection(playerid, 9, "Formato do Olho", "Amendoados");
	SetPVarInt(playerid, "Registration9", 2);
	AddRegisterSelection(playerid, 10, "Cor do Cabelo", "Preto");
	SetPVarInt(playerid, "Registration10", 0);
	AddRegisterSelection(playerid, 11, "Tamanho do Cabelo", "Médio");
	SetPVarInt(playerid, "Registration11", 2);
	AddRegisterSelection(playerid, 12, "Definição Corporal", "Esbelta");
	SetPVarInt(playerid, "Registration12", 2);
	for(new i = 0; i < 54; i++) 
	{
		TextDrawShowForPlayer(playerid, RegisterText[playerid][i]);
	}	
	SelectTextDraw(playerid, COLOR_PURPLE);
	return 1;
}

/***
   * RegisterMenuBackward(playerid, titleid);
   * Função para atualizar o menu de registro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock RegisterMenuBackward(playerid, titleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	new string[24], aux[24];
	switch(titleid)
	{
		case 1:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 18) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 99);
			format(aux, 24, "%i", GetPVarInt(playerid, string));
		}
		case 2:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) == 1) 
			{
				SetPVarInt(playerid, string, 0);
				format(aux, 24, "Masculino");
			}	
			else 
			{
				SetPVarInt(playerid, string, 1);
				format(aux, 24, "Feminino");
			}
			
		}
		case 3:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 1) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 299);
			format(aux, 24, "%i", GetPVarInt(playerid, string));
			SetPlayerSkin(playerid, GetPVarInt(playerid, string));
		}
		case 4:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 45) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 200);
			format(aux, 24, "%ikg", GetPVarInt(playerid, string));
		}
		case 5:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 120) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 220);
			format(aux, 24, "%icm", GetPVarInt(playerid, string));
		}
		case 6:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 0) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 3);
			format(aux, 24, "%s", NationaltyStatus[GetPVarInt(playerid, string)]);
		}
		case 7:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 0) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 4);
			format(aux, 24, "%s", SkinToneStatus[GetPVarInt(playerid, string)]);
		}
		case 8:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 0) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 3);
			format(aux, 24, "%s", EyeColorStatus[GetPVarInt(playerid, string)]);
		}
		case 9:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 0) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 4);
			format(aux, 24, "%s", EyeShapeStatus[GetPVarInt(playerid, string)]);
		}
		case 10:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 0) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 8);
			format(aux, 24, "%s", HairColorStatus[GetPVarInt(playerid, string)]);
		}
		case 11:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 0) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 5);
			format(aux, 24, "%s", HairSizeStatus[GetPVarInt(playerid, string)]);
		}
		case 12:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) > 0) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)-1));
			else SetPVarInt(playerid, string, 6);
			format(aux, 24, "%s", BodyToneStatus[GetPVarInt(playerid, string)]);
		}
		default: return 0;
	}
	UpdateRegisterInfo(playerid, titleid, aux);
	return 1;
}

/***
   * RegisterMenuForward(playerid, titleid);
   * Função para atualizar o menu de registro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock RegisterMenuForward(playerid, titleid)
{
	if(!IsPlayerConnected(playerid)) return 0;
	new string[24], aux[24];
	switch(titleid)
	{
		case 1:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) <= 99) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 18);
			format(aux, 24, "%i", GetPVarInt(playerid, string));
		}
		case 2:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) == 1) 
			{
				SetPVarInt(playerid, string, 0);
				format(aux, 24, "Masculino");
			}	
			else 
			{
				SetPVarInt(playerid, string, 1);
				format(aux, 24, "Feminino");
			}
			
		}
		case 3:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 299) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 1);
			format(aux, 24, "%i", GetPVarInt(playerid, string));
			SetPlayerSkin(playerid, GetPVarInt(playerid, string));
		}
		case 4:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 200) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 45);
			format(aux, 24, "%ikg", GetPVarInt(playerid, string));
		}
		case 5:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 220) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 120);
			format(aux, 24, "%icm", GetPVarInt(playerid, string));
		}
		case 6:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 3) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 0);
			format(aux, 24, "%s", NationaltyStatus[GetPVarInt(playerid, string)]);
		}
		case 7:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 4) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 0);
			format(aux, 24, "%s", SkinToneStatus[GetPVarInt(playerid, string)]);
		}
		case 8:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 3) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 0);
			format(aux, 24, "%s", EyeColorStatus[GetPVarInt(playerid, string)]);
		}
		case 9:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 4) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 0);
			format(aux, 24, "%s", EyeShapeStatus[GetPVarInt(playerid, string)]);
		}
		case 10:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 8) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 0);
			format(aux, 24, "%s", HairColorStatus[GetPVarInt(playerid, string)]);
		}
		case 11:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 5) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 0);
			format(aux, 24, "%s", HairSizeStatus[GetPVarInt(playerid, string)]);
		}
		case 12:
		{
			format(string, 24, "Registration%i", titleid);
			if(GetPVarInt(playerid, string) < 6) SetPVarInt(playerid, string, (GetPVarInt(playerid, string)+1));
			else SetPVarInt(playerid, string, 0);
			format(aux, 24, "%s", BodyToneStatus[GetPVarInt(playerid, string)]);
		}
		default: return 0;
	}
	UpdateRegisterInfo(playerid, titleid, aux);
	return 1;
}

/***
   * ResetRegistrationValues(playerid);
   * Função para voltar ao padrão a seleção dos itens do personagem;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock ResetRegistrationValues(playerid)
{
	for(new i = 0; i < 54; i++) TextDrawHideForPlayer(playerid, RegisterText[playerid][i]);
	AddRegisterSelection(playerid, 1, "Idade", "18");
	AddRegisterSelection(playerid, 2, "Sexo", "Masculino");
	AddRegisterSelection(playerid, 3, "Skin", "183");
	AddRegisterSelection(playerid, 4, "Peso", "85kg");
	AddRegisterSelection(playerid, 5, "Altura", "180cm");
	AddRegisterSelection(playerid, 6, "Ingresso/Imigração", "Imigrante Legal");
	AddRegisterSelection(playerid, 7, "Tom de Pele", "Parda");
	AddRegisterSelection(playerid, 8, "Cor do Olho", "Castanho");
	AddRegisterSelection(playerid, 9, "Formato do Olho", "Médio");
	AddRegisterSelection(playerid, 10, "Cor do Cabelo", "Preto");
	AddRegisterSelection(playerid, 11, "Tamanho do Cabelo", "Médio");
	AddRegisterSelection(playerid, 12, "Definição Corporal", "Esbelta");
	for(new i = 0; i < 54; i++) TextDrawShowForPlayer(playerid, RegisterText[playerid][i]);
	return true;
}

/***
   * FinishCreation(playerid);
   * Função para terminar o registro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock FinishCreation(playerid)
{
	for(new i = 0; i < 54; i++) TextDrawHideForPlayer(playerid, RegisterText[playerid][i]);
	switch(GetPVarInt(playerid, "Registration6"))
	{
		case 0:
		{
			SetPVarFloat(playerid, "PosX", -420.8024);
			SetPVarFloat(playerid, "PosY", 1163.8466);
			SetPVarFloat(playerid, "PosZ", 1.8519);
			SetPVarInt(playerid, "Int", 0);
			SetPVarInt(playerid, "VW", 0);
		}
		case 1:
		{
			SetPVarFloat(playerid, "PosX", 206.9176);
			SetPVarFloat(playerid, "PosY", 2276.0947);
			SetPVarFloat(playerid, "PosZ", 23.5451);
			SetPVarInt(playerid, "Int", 0);
			SetPVarInt(playerid, "VW", 0);
		}
		case 2:
		{
			SetPVarFloat(playerid, "PosX", 691.6268);
			SetPVarFloat(playerid, "PosY", 1884.6194);
			SetPVarFloat(playerid, "PosZ", 5.7434);
			SetPVarInt(playerid, "Int", 0);
			SetPVarInt(playerid, "VW", 0);
		}
		case 3:
		{
			SetPVarFloat(playerid, "PosX", -146.8587);
			SetPVarFloat(playerid, "PosY", 1124.3914);
			SetPVarFloat(playerid, "PosZ", 19.7422);
			SetPVarInt(playerid, "Int", 0);
			SetPVarInt(playerid, "VW", 0);
		}
	}
	SetPlayerPos(playerid, GetPVarFloat(playerid, "PosX"), GetPVarFloat(playerid, "PosY"), GetPVarFloat(playerid, "PosZ"));
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	SetCameraBehindPlayer(playerid);
	SetPVarInt(playerid, "Created", 1337);
	FreezePlayer(playerid, 2000);
	SetPVarInt(playerid, "Age", GetPVarInt(playerid, "Registration1"));
	SetPVarInt(playerid, "Sex", GetPVarInt(playerid, "Registration2"));
	SetPVarInt(playerid, "Skin", GetPVarInt(playerid, "Registration3"));
	SetPVarInt(playerid, "Weight", GetPVarInt(playerid, "Registration4"));
	SetPVarInt(playerid, "Height", GetPVarInt(playerid, "Registration5"));
	SetPVarInt(playerid, "Spawn", GetPVarInt(playerid, "Registration6"));
	SetPVarInt(playerid, "SkinTone", GetPVarInt(playerid, "Registration7"));
	SetPVarInt(playerid, "EyeColor", GetPVarInt(playerid, "Registration8"));
	SetPVarInt(playerid, "EyeShape", GetPVarInt(playerid, "Registration9"));
	SetPVarInt(playerid, "HairColor", GetPVarInt(playerid, "Registration10"));
	SetPVarInt(playerid, "HairSize", GetPVarInt(playerid, "Registration11"));
	SetPVarInt(playerid, "BodyTone", GetPVarInt(playerid, "Registration12"));
	SavePlayerData(playerid);
	CancelSelectTextDraw(playerid);
	return ShowPlayerDialog(playerid, DIALOG_TUTORIAL, DIALOG_STYLE_MSGBOX, "Tutorial", "Este gamemode não possui comandos;\nPara entender como funciona os chats e ações do jogo, recomendamos que faça o tutorial;\nVocê deseja ver o tutorial?", "SIM", "NÃO"); 
}

/***
   * UpdateRegisterInfo(playerid, titleid, info[]);
   * Função para adicionar um texto ao textdraw de registro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock UpdateRegisterInfo(playerid, titleid, info[])
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(titleid < 1 || titleid > 12) return 0;
	if(strlen(info) > 24) format(info, 24, "%s", info);
	convert_encoding(info);
	TextDrawSetString(RegisterText[playerid][titleid*4], info);
	return 1;
}

/***
   * AddRegisterSelection(playerid, titleid, title[], info[]);
   * Função para adicionar um título e texto ao textdraw de registro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock AddRegisterSelection(playerid, titleid, title[], info[])
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(titleid < 1 || titleid > 12) return 0;
	if(strlen(title) > 24) format(title, 24, "%s", title);
	if(strlen(info) > 24) format(info, 24, "%s", info);
	convert_encoding(title);
	convert_encoding(info);
	TextDrawSetString(RegisterText[playerid][1+(titleid*4)], title);
	TextDrawSetString(RegisterText[playerid][titleid*4], info);
	return 1;
}

/***
   * GetVehiclePanelsDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight, &WindShield, &FrontBumper, &RearBumper);
   * Função para coletar o dano dos paineis do carro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetVehiclePanelsDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight, &WindShield, &FrontBumper, &RearBumper)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	FrontLeft = Panels & 15;
	FrontRight = Panels >> 4 & 15;
	RearLeft = Panels >> 8 & 15;
	RearRight = Panels >> 12 & 15;
	WindShield = Panels >> 16 & 15;
	FrontBumper = Panels >> 20 & 15;
	RearBumper = Panels >> 24 & 15;
	return true;
}

/***
   * GetVehicleDoorsDamageStatus(vehicleid, &Bonnet, &Boot, &FrontLeft, &FrontRight, &RearLeft, &RearRight);
   * Função para coletar o dano das portas do carro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetVehicleDoorsDamageStatus(vehicleid, &Bonnet, &Boot, &FrontLeft, &FrontRight, &RearLeft, &RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	Bonnet = Doors & 7;
	Boot = Doors >> 8 & 7;
	FrontLeft = Doors >> 16 & 7;
	FrontRight = Doors >> 24 & 7;
	RearLeft = Doors >> 32 & 7;
	RearRight = Doors >> 40 & 7;
	return true;
}

/***
   * GetVehicleLightsDamageStatus(vehicleid, &First, &Second, &Third, &Fourth);
   * Função para coletar o dano das luzes do carro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetVehicleLightsDamageStatus(vehicleid, &First, &Second, &Third, &Fourth)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	First = Lights & 1;
	Second = Lights >> 1 & 1;
	Third = Lights >> 2 & 1;
	Fourth = Lights >> 3 & 1;
	return true;
}

/***
   * GetVehicleTiresDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight);
   * Função para coletar o dano das rodas do carro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetVehicleTiresDamageStatus(vehicleid, &FrontLeft, &FrontRight, &RearLeft, &RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	if(GetVehicleType(vehicleid) == TYPE_MOTORBIKE || GetVehicleType(vehicleid) == TYPE_BIKE) FrontLeft = Tires >> 1 & 1, FrontRight = Tires & 1;
	else
	{
		RearRight = Tires & 1;
		FrontRight = Tires >> 1 & 1;
		RearLeft = Tires >> 2 & 1;
		FrontLeft = Tires >> 3 & 1;
	}
	return true;
}

/***
   * UpdateVehiclePanelsDamageStatus(vehicleid, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper);
   * Função para atualizar o dano dos paineis do carro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock UpdateVehiclePanelsDamageStatus(vehicleid, FrontLeft, FrontRight, RearLeft, RearRight, WindShield, FrontBumper, RearBumper)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	return UpdateVehicleDamageStatus(vehicleid, FrontLeft | (FrontRight << 4) | (RearLeft << 8) | (RearRight << 12) | (WindShield << 16) | (FrontBumper << 20) | (RearBumper << 24), Doors, Lights, Tires);
}

/***
   * UpdateVehicleDoorsDamageStatus(vehicleid, Bonnet, Boot, FrontLeft, FrontRight, RearLeft, RearRight);
   * Função para atualizar o dano das portas do carro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock UpdateVehicleDoorsDamageStatus(vehicleid, Bonnet, Boot, FrontLeft, FrontRight, RearLeft, RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	return UpdateVehicleDamageStatus(vehicleid, Panels, Bonnet | (Boot << 8) | (FrontLeft << 16) | (FrontRight << 24) | (RearLeft << 32) | (RearRight << 40), Lights, Tires);
}

/***
   * UpdateVehicleLightsDamageStatus(vehicleid, First, Second, Third, Fourth);
   * Função para atualizar o dano das luzes do carro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock UpdateVehicleLightsDamageStatus(vehicleid, First, Second, Third, Fourth)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	return UpdateVehicleDamageStatus(vehicleid, Panels, Doors, First | (Second << 1) | (Third << 2) | (Fourth << 3), Tires);
}

/***
   * GetVehicleType(vehicleid);
   * Função para retornar o tipo de veículo, baseado no modelo dele;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetVehicleType(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 400 .. 416, 418 .. 424, 426 .. 429, 431 .. 434, 436 .. 440, 442 .. 445, 451, 455 .. 459, 466, 467, 470, 471, 474, 475, 477 .. 480, 482, 483, 485, 486, 489 .. 492, 494 .. 496, 498 .. 500, 502 .. 508, 514 .. 518, 524 .. 536, 539 .. 547, 549 .. 552, 554 .. 562, 565 .. 568, 571 .. 576, 578 .. 580, 582, 583, 585, 587 .. 589, 596 .. 605, 609: return TYPE_CAR;
		case 481, 509, 510: return TYPE_BIKE;
		case 448, 461 .. 463, 468, 521 .. 523, 581, 586: return TYPE_MOTORBIKE;
		case 430, 446, 452 .. 454, 472, 473, 484, 493, 595: return TYPE_BOAT;
		case 460, 476, 511 .. 513, 519, 520, 553, 577, 592, 593: return TYPE_PLANE;
		case 441, 464, 465, 501, 564, 594: return TYPE_RC;
		case 449, 537, 538, 569, 570, 590: return TYPE_TRAIN;
		case 435, 450, 584, 591, 606 .. 608, 610, 611: return TYPE_TRAILER;
		case 417, 425, 447, 469, 487, 488, 497, 548, 563: return TYPE_HELICOPTER;
	}
	return -1;
}

/***
   * UpdateVehicleTiresDamageStatus(vehicleid, FrontLeft, FrontRight, RearLeft, RearRight);
   * Função para atualizar o dano das rodas do carro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock UpdateVehicleTiresDamageStatus(vehicleid, FrontLeft, FrontRight, RearLeft, RearRight)
{
	new Panels, Doors, Lights, Tires;
	GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
	if(GetVehicleType(vehicleid) == TYPE_MOTORBIKE || GetVehicleType(vehicleid) == TYPE_BIKE) return UpdateVehicleDamageStatus(vehicleid, Panels, Doors, Lights, FrontRight | (FrontLeft << 1));
	else return UpdateVehicleDamageStatus(vehicleid, Panels, Doors, Lights, RearRight | (FrontRight << 1) | (RearLeft << 2) | (FrontLeft << 3));
}

/***
   * GetInteriorDialog(playerid);
   * Função para retornar a string dos interiores;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetInteriorDialog(playerid)
{
	new dialog_string[2600];
    for(new i = 0; i < sizeof(InteriorNames); i++) {
        if(!i) {
            format(dialog_string, sizeof(dialog_string), InteriorNames[i]);
        }
        else {
            format(dialog_string, sizeof(dialog_string), "%s\n%s", dialog_string, InteriorNames[i]);
        }
    }
	return dialog_string;
}

/***
   * PlayerLog(playerid, reason[]);
   * Função para inserir um log na tabela de logs de jogadores;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock PlayerLog(playerid, reason[])
{
	new string[384];
	mysql_format(db, string, 384, "INSERT INTO playerlogs (playerID, logText) VALUES('%i', '%e')", GetPVarInt(playerid, "InternalID"), reason);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * FactionLog(faction, reason[]);
   * Função para inserir um log na tabela de logs de facções;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock FactionLog(faction, reason[])
{
	new string[384];
	mysql_format(db, string, 384, "INSERT INTO factionlogs (factionID, logText) VALUES('%i', '%e')", faction, reason);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * CameraLog(biz, reason[]);
   * Função para inserir um log na tabela de logs das câmeras de empresa;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock CameraLog(biz, reason[])
{
	new string[384];
	mysql_format(db, string, 384, "INSERT INTO cameralogs (businessID, logText) VALUES('%i', '%e')", biz, reason);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * AdminLog(playerid, reason[]);
   * Função para inserir um log na tabela de logs de admins;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock AdminLog(reason[])
{
	new string[384];
	mysql_format(db, string, 384, "INSERT INTO adminlogs (logText) VALUES('%e')", reason);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * GlobalLog(playerid, reason[]);
   * Função para inserir um log na tabela de logs de admins;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GlobalLog(reason[])
{
	new string[384];
	mysql_format(db, string, 384, "INSERT INTO globallog (logText) VALUES('%e')", reason);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * WhatsLog(cellphone, reason[]);
   * Função para inserir um log na tabela de logs do whatsapp;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock WhatsLog(cellphone, reason[])
{
	new string[384];
	mysql_format(db, string, 384, "INSERT INTO whatslogs (cellphoneID, logText) VALUES('%i', '%e')", cellphone, reason);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * WalkieLog(freq, reason[]);
   * Função para inserir um log na tabela de logs do walkietalkie;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock WalkieLog(freq, reason[])
{
	new string[384];
	mysql_format(db, string, 384, "INSERT INTO walkielogs (freqID, logText) VALUES('%i', '%e')", freq, reason);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * CellLog(cellphone, reason[]);
   * Função para inserir um log na tabela de logs do celular;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock CellLog(cellphone, reason[])
{
	new string[384];
	mysql_format(db, string, 384, "INSERT INTO celllogs (cellphoneID, logText) VALUES('%i', '%e')", cellphone, reason);
	mysql_function_query(db, string, false, "", "");
	return 1;
}

/***
   * GetPVarStringEx(playerid, slotname[]);
   * Função para retornar a string guardada em um PVar, sem precisar extrair ela pra uma string (gambiarra);
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetPVarStringEx(playerid, slotname[])
{
	new str[128];
	GetPVarString(playerid, slotname, str, 128);
	return str;
}

/***
   * IsPlayerNearPlayer(playerid, targetid, Float:range);
   * Função para retornar se o jogador está na região (range) do jogador alvo (target);
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock IsPlayerNearPlayer(playerid, targetid, Float:range)
{
	new Float:fp[3];
	GetPlayerPos(targetid, fp[0], fp[1], fp[2]);
	return IsPlayerInRangeOfPoint(playerid, range, fp[0], fp[1], fp[2]);
}

/***
   * FreezePlayer(playerid, time);
   * Função para congelar um jogador por um determinado tempo;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock FreezePlayer(playerid, time)
{
	TogglePlayerControllable(playerid, false);
	SetTimerEx("UnfreezePlayer", time, 0, "i", playerid);
	return 1;
}

/***
   * IsNumeric(const string[]);
   * Função para verificar se uma string é puramente numérica;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock IsNumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}

/***
   * GetWeaponModel(weaponid);
   * Função para retornar o modelo de objeto de uma arma;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetWeaponModel(weaponid)
{

	new model;
	switch(weaponid)
	{
		case 1: model=331; case 2: model=333; case 3: model=334;
		case 4: model=335; case 5: model=336; case 6: model=337;
		case 7: model=338; case 8: model=339; case 9: model=341;
		case 10: model=321; case 11: model=322; case 12: model=323;
		case 13: model=324; case 14: model=325; case 15: model=326;
		case 16: model=342; case 17: model=343; case 18: model=344;
		case 22: model=346; case 23: model=347; case 24: model=348;
		case 25: model=349; case 26: model=350; case 27: model=351;
		case 28: model=352; case 29: model=353; case 30: model=355;
		case 31: model=356; case 32: model=372; case 33: model=357;
		case 34: model=358; case 35: model=359; case 36: model=360;
		case 37: model=361; case 38: model=362; case 39: model=363;
		case 41: model=365; case 42: model=366; case 43: model=367;
		case 44: model=368; case 45: model=369; case 46: model=371;
	}
	if(model < 300) return -1;
	return model;
}

/***
   * SendSplitClientMessage(playerid, color, text[], minlen = 110, maxlen = 120);
   * Função para mandar uma mensagem pro jogador em duas linhas (quando o texto excede 128 caracteres);
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SendSplitClientMessage(playerid, color, text[], minlen = 110, maxlen = 120)
{
    new str[256];
    if(strlen(text) > maxlen)
    {
        new pos = maxlen;
        while(text[--pos] > ' ') {}
        if(pos < minlen) pos = maxlen;
        format(str, sizeof(str), "%.*s ...", pos, text);
        SendClientMessage(playerid,color,str);
        format(str, sizeof(str), ".... %s", text[pos+1]);
        SendClientMessage(playerid,color,str);
		PlayerLog(playerid, str);
    }
    else format(str, sizeof(str), "%s", text), SendClientMessage(playerid,color,str);
    return true;
}

/***
   * SendLoggedClientMessage(playerid, color, text[]);
   * Função pra mandar uma mensagem pro jogador, que será logada;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SendLoggedClientMessage(playerid, color, text[])
{
	PlayerLog(playerid, text);
	SendClientMessage(playerid, color, text);
	return;
}

/***
   * GetCardText(card);
   * Retorna o nome do textdraw da carta;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetCardText(card)
{
	new text[24];
	switch (card)
	{
		case 0 .. 12: format(text, 24, "ld_card:cd%ic", (card+1));
		case 13 .. 25: format(text, 24, "ld_card:cd%id", (card+1));
		case 26 .. 38: format(text, 24, "ld_card:cd%ih", (card+1));
		case 39 .. 52: format(text, 24, "ld_card:cd%is", (card+1));
	}
	return text;
}

/***
   * GetCardName(card);
   * Retorna o nome da carta;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetCardName(card)
{
	new text[24];
	switch (card)
	{
		case 0: format(text, 24, "Ás de Paus", (card+1));
		case 1 .. 9: format(text, 24, "%i de Paus", (card+1));
		case 10: format(text, 24, "Valete de Paus", (card+1));
		case 11: format(text, 24, "Dama de Paus", (card+1));
		case 12: format(text, 24, "Rei de Paus", (card+1));
		case 13: format(text, 24, "Ás de Ouros", (card+1));
		case 14 .. 22: format(text, 24, "%i de Ouros", (card-12));
		case 23: format(text, 24, "Valete de Ouros", (card+1));
		case 24: format(text, 24, "Dama de Ouros", (card+1));
		case 25: format(text, 24, "Rei de Ouros", (card+1));
		case 26: format(text, 24, "Ás de Copas", (card+1));
		case 27 .. 35: format(text, 24, "%i de Copas", (card-25));
		case 36: format(text, 24, "Valete de Copas", (card+1));
		case 37: format(text, 24, "Dama de Copas", (card+1));
		case 38: format(text, 24, "Rei de Copas", (card+1));
		case 39: format(text, 24, "Ás de Espadas", (card+1));
		case 40 .. 48: format(text, 24, "%i de Espadas", (card-38));
		case 49: format(text, 24, "Valete de Espadas", (card+1));
		case 50: format(text, 24, "Dama de Espadas", (card+1));
		case 51: format(text, 24, "Rei de Espadas", (card+1));
	}
	return text;
}

/***
   * SetDefaultVariables(playerid);
   * Função pra setar os valores-padrão de variáveis utilizadas pelo sistema dos jogadores, utilizada no login;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock SetDefaultVariables(playerid)
{
	SetPVarInt(playerid, "ReadGlobalChat", 1);
	SetPVarInt(playerid, "TutorialActor", INVALID_ACTOR_ID);
	SetPVarInt(playerid, "SpectatingPlayer", INVALID_PLAYER_ID);
	SetPVarInt(playerid, "SpectatingVehicle", INVALID_VEHICLE_ID);
	SetPVarInt(playerid, "HUD", 1337);
	SetPVarInt(playerid, "PMT", INVALID_PLAYER_ID);
	SetPVarInt(playerid, "PanelOpen", -1);
	return;
}

/***
   * GetWeaponSlot(weaponid);
   * Função pra retornar o slot de uma arma;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetWeaponSlot(weaponid)
{
	switch(weaponid)
	{
		case 0,1: return 0;
		case 2 .. 9: return 1;
		case 10 .. 15: return 10;
		case 16 .. 18, 39: return 8;
		case 22 .. 24: return 2;
		case 25 .. 27: return 3;
		case 28, 29, 32: return 4;
		case 30, 31: return 5;
		case 33, 34: return 6;
		case 35 .. 38: return 7;
		case 40: return 12;
		case 41 .. 43: return 9;
		case 44 .. 46: return 11;
		default: return 0;
	}
	return 0;
}

stock GetPlayer2DZone(playerid, zone[], len) 
{
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        for(new i = 0; i != sizeof(ZoneData); i++ )
        {
                if(x >= ZoneData[i][zArea][0] && x <= ZoneData[i][zArea][3] && y >= ZoneData[i][zArea][1] && y <= ZoneData[i][zArea][4])
                {
                    return format(zone, len, ZoneData[i][zName], 0);
                }
        }
        return 0;
}
 
/***
   * GetPlayer3DZone(playerid, zone[], len);
   * Função pra verificar a zona e a altura do jogador;
   * Por: Cueball, Betamaster, Makabo e Simon;
   * Versão: 2.0;
***/
 
stock GetPlayer3DZone(playerid, zone[], len) 
{
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        for(new i = 0; i != sizeof(ZoneData); i++ )
        {
                if(x >= ZoneData[i][zArea][0] && x <= ZoneData[i][zArea][3] && y >= ZoneData[i][zArea][1] && y <= ZoneData[i][zArea][4] && z >= ZoneData[i][zArea][2] && z <= ZoneData[i][zArea][5])
                {
                    return format(zone, len, ZoneData[i][zName], 0);
                }
        }
        return 0;
}
 
/***
   * IsPlayerInZone(playerid, zone[]);
   * Função pra retornar a zona em que o jogador está;
   * Por: Cueball, Betamaster, Makabo e Simon;
   * Versão: 2.0;
***/

stock IsPlayerInZone(playerid, zone[]) 
{
        new TmpZone[28];
        GetPlayer3DZone(playerid, TmpZone, sizeof(TmpZone));
        for(new i = 0; i != sizeof(ZoneData); i++)
        {
                if(strfind(TmpZone, zone, true) != -1)
                        return 1;
        }
        return 0;
}

/***
   * GetStreetAddress(playerid);
   * Função pra retornar o endereço de onde o jogador está;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock GetStreetAddress(playerid)
{
	new Float:pos[3], string[128], zone[28];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	GetPlayer2DZone(playerid, zone, 28);
	if(pos[0] > pos[1]) format(string, 128, "%.0f %s", pos[0], zone);
	else format(string, 128, "%.0f %s", pos[1], zone);
	return string;
}

/***
   * FormatNumber(number, prefix[] = "");
   * Função formatar um número com vírgulas (exemplo: 19200 vira 19,200);
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock FormatNumber(number, prefix[] = "")
{
	static
		value[32],
		length;

	format(value, sizeof(value), "%d", (number < 0) ? (-number) : (number));

	if ((length = strlen(value)) > 3)
	{
		for (new i = length, l = 0; --i >= 0; l ++) {
		    if ((l > 0) && (l % 3 == 0)) strins(value, ",", i + 1);
		}
	}
	if (prefix[0] != 0)
	    strins(value, prefix, 0);

	if (number < 0)
		strins(value, "-", 0);

	return value;
}

/***
   * StartTutorial(playerid);
   * Inicia o tutorial;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock StartTutorial(playerid)
{
	SetPVarInt(playerid, "Tutorial", 1);
	SetPlayerPos(playerid, 748.8595,1769.3883,5.8858);
	SetPlayerFacingAngle(playerid, 37.9370);
	SetPlayerVirtualWorld(playerid, 1000+playerid);
	new x = CreateActor(183, 732.0733,1787.5806,5.8858,271.5175);
	SetActorVirtualWorld(x, 1000+playerid);
	ApplyActorAnimation(x,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);
	SetPVarInt(playerid, "TutorialActor", x);
	TutorialActorText[playerid] = CreateDynamic3DTextLabel("Mano [1337]", COLOR_PURPLE, 732.0733,1787.5806, 7, 30, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 1000+playerid);
	SendActionMessage(playerid, "Bem vindo ao Santa Faria Roleplay! Este tutorial irá lhe ensinar o básico do modo de jogo deste servidor;");
	SendActionMessage(playerid, "Esta pequena cidade é vizinha a Santa Faria, e servirá de introdução;");
	SendActionMessage(playerid, "Este servidor não possui comandos, tendo todas as ações realizadas por botões ou menus;");
	SendActionMessage(playerid, "Para continuar, caminhe até o homem sentado no banco e diga \"Oi\" no chat IC;");
	return 1;
}

/***
   * TutorialSteps(playerid);
   * Passos do Tutorial;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

stock TutorialSteps(playerid)
{
	new str[1500];
	switch(GetPVarInt(playerid, "Tutorial"))
	{
		case 2:
		{
			strcat(str, "{a9c4e4}Os jogadores e NPC's de Santa Faria serão identificados por suas características ou apelido/nome, e uma ID única;");
			strcat(str, "\nPara fazer uma ação, você precisa trocar de chat. Para isso, aperte Y;");
			strcat(str, "\nPara prosseguir no tutorial, faça a seguinte ação: \"{c2a2da}senta na cadeira ao lado do mano.{a9c4e4}\";");
			strcat(str, "\nPara realizar a ação acima, aperte Y até selecionar o chat \"{c2a2da}AÇÃO{a9c4e4}\", e então digite a mensagem normalmente (apertando T);");
		}
		case 3:
		{
			strcat(str, "{a9c4e4}Como o servidor não possui comandos, para fazer /me, /do, /b, entre outros \"chats\", é necessário apertar Y até selecionar o chat desejado;");
			strcat(str, "\nAo selecionar um chat e digitar uma mensagem, o sistema automaticamente retornará seu chat para o chat IC;");
			strcat(str, "\nPara voltar ao chat selecionado anteriormente (no exemplo agora, o chat de Ação), basta apertar Y novamente;");
			strcat(str, "\nPara prosseguir, aperte Y uma vez somente, para voltar ao chat de ação, e digite \"{c2a2da}olha para o Mano.{a9c4e4}\";");
		}
		case 4:
		{
			strcat(str, "{a9c4e4}Os chats disponíveis são: OOC Local, OOC Global (geralmente desativado), IC, MP (mensagens privadas), Ação (/me) e Descrição (/do);");
			strcat(str, "\nExperimente outros chats, e, quando estiver pronto para seguir no tutorial, mande uma MP para o Mano com o texto: \"{c2a2da}salve.{a9c4e4}\";");
			strcat(str, "\nDica: Para mandar uma MP, aperte Y até selecionar o chat MP, digite o ID do Mano [1337], e digite a mensagem;");
		}
		case 5:
		{
			strcat(str, "{a9c4e4}Este tutorial cobriu o básico do servidor!");
			strcat(str, "\nPara maiores informações e ajuda, utilize o painel (Aperte N - Selecione Painel);");
			strcat(str, "\nBom jogo!");
			SetPVarInt(playerid, "Tutorial", 0);
			if(IsValidActor(GetPVarInt(playerid, "TutorialActor"))) DestroyActor(GetPVarInt(playerid, "TutorialActor"));
			if(IsValidDynamic3DTextLabel(TutorialActorText[playerid])) DestroyDynamic3DTextLabel(TutorialActorText[playerid]);
			SetPlayerPos(playerid, -146.1487,1124.4265,19.7422);
			SetPlayerVirtualWorld(playerid, 0);
		}
	}
	return ShowPlayerDialog(playerid, DIALOG_NULL, DIALOG_STYLE_MSGBOX, "Tutorial", str, "Prosseguir", "");
}

//##############################################################################################

/***
   * GetDistanceBetweenPlayerToPoint(playerid, Float:pX, Float:pY, Float:pZ);
   * Retorna a distância de um jogador do ponto X, Y, Z;
   * Por: ?;
   * Versão: 1.0;
***/

public Float:GetDistanceBetweenPlayerToPoint(playerid, Float:pX, Float:pY, Float:pZ)
{
	if(!IsPlayerConnected(playerid)) return -1.00;
	new Float:x1, Float:y1, Float:z1, Float:x2, Float:y2, Float:z2;
	GetPlayerPos(playerid, x1, y1, z1);
	x2 = pX;
	y2 = pY;
	z2 = pZ;
	return floatsqroot(floatpower(floatabs(floatsub(x2, x1)), 2) + floatpower(floatabs(floatsub(y2, y1)), 2) + floatpower(floatabs(floatsub(z2, z1)), 2));
}

/***
   * UnfreezePlayer(playerid);
   * Descongela um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public UnfreezePlayer(playerid)
	return TogglePlayerControllable(playerid, true);

/***
   * RemoveOfflinePlayer(playerid);
   * Remove o jogador deslogado;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public RemoveOfflinePlayer(playerid)
{
	DestroyActor(playerid);
	DestroyDynamic3DTextLabel(ActorText[playerid]);
	return 1;
}	

/***
   * SendErrorMessage(playerid, msg[]);
   * Manda uma mensagem de erro;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendErrorMessage(playerid, msg[])
{
	new lengths[128], length2[128], message[128];
    strmid(lengths, msg, 0, 118);
    strmid(length2, msg, 118, 256);
    if(strlen(msg) > 118)
    {
        format(message, 128, "[ERRO] %s ...", lengths);
        SendClientMessage(playerid, COLOR_ERROR, message);
        PlayerLog(playerid, message);
		format(message, 128, "... %s", length2);
        SendClientMessage(playerid, COLOR_ERROR, message);
		PlayerLog(playerid, message);
    }
    else
    {
        format(message, 128, "[ERRO] %s", msg);
		SendClientMessage(playerid, COLOR_ERROR, message);
		PlayerLog(playerid, message);
    }
	return 1;
}

/***
   * SendSystemMessage(playerid, msg[]);
   * Manda uma mensagem do sistema;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendSystemMessage(playerid, msg[])
{
	new lengths[128], length2[128], message[128], result[256];
    strmid(result, msg, 0, 256);
    strmid(lengths, result, 0, 95);
    strmid(length2, msg, 95, 256);
    if(strlen(msg) > 95)
    {
        format(message, 128, "[{C2A2DA}#{A9C4E4}] %s ...", lengths);
        SendClientMessage(playerid, COLOR_SYSTEM, message);
		PlayerLog(playerid, message);
        format(message, 128, "... %s", length2);
        SendClientMessage(playerid, COLOR_SYSTEM, message);
		PlayerLog(playerid, message);
    }
    else
    {
        format(message, 128, "[{C2A2DA}#{A9C4E4}] %s", msg);
        SendClientMessage(playerid, COLOR_SYSTEM, message);
		PlayerLog(playerid, message);
    }
	return 1;
}

/***
   * SendActionMessage(playerid, msg[]);
   * Manda uma mensagem de ação;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendActionMessage(playerid, msg[])
{
	new lengths[128], length2[128], message[128], result[256];
    strmid(result, msg, 0, 256);
    strmid(lengths, result, 0, 95);
    strmid(length2, msg, 95, 256);
    if(strlen(msg) > 95)
    {
        format(message, 128, "[{C2A2DA}#{AFAFAF}] %s ...", lengths);
        SendClientMessage(playerid, 0xAFAFAFFF, message);
		PlayerLog(playerid, message);
        format(message, 128, "... %s", length2);
        SendClientMessage(playerid, 0xAFAFAFFF, message);
		PlayerLog(playerid, message);
    }
    else
    {
        format(message, 128, "[{C2A2DA}#{AFAFAF}] %s", msg);
        SendClientMessage(playerid, 0xAFAFAFFF, message);
		PlayerLog(playerid, message);
    }
	return 1;
}

/***
   * SendAdminBroadcast(msg[]);
   * Manda um aviso para todos os administradores;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendAdminBroadcast(msg[])
{
	new lengths[128], length2[128], message[128], result[256], message2[128];
    strmid(result, msg, 0, 256);
	strmid(lengths, result, 0, 95);
	strmid(length2, msg, 95, 256);
	if(strlen(msg) > 95)
	{
		format(message, 128, "[{A9C4E4}#{F97804}] %s ...", lengths);
		format(message2, 128, "... %s", length2);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "Admin") > 0 && GetPVarInt(i, "ReadAdminBroadcast") > 0)
			{
				SendClientMessage(i, COLOR_HOTORANGE, message);
				SendClientMessage(i, COLOR_HOTORANGE, message2);
			}
		}
	}		
	else
	{
		format(message, 128, "[{A9C4E4}#{F97804}] %s", msg);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "Admin") > 0 && GetPVarInt(i, "ReadAdminBroadcast") > 0)
			{
				SendClientMessage(i, COLOR_HOTORANGE, msg);
			}
		}
	}
	AdminLog(msg);
	return 1;
}

/***
   * SendAdminColoredBroadcast(msg[], color);
   * Manda um aviso aos administradores, com cor;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendAdminColoredBroadcast(msg[], color)
{
	new lengths[128], length2[128], message[128], result[256], message2[128];
    strmid(result, msg, 0, 256);
	strmid(lengths, result, 0, 121);
	strmid(length2, msg, 121, 256);
	if(strlen(msg) > 121)
	{
		format(message, 128, "%s ...", lengths);
		format(message2, 128, "... %s", length2);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "Admin") > 0 && GetPVarInt(i, "ReadAdminBroadcast") > 0)
			{
				SendClientMessage(i, color, message);
				SendClientMessage(i, color, message2);
			}
		}
	}		
	else
	{
		format(message, 128, "%s", msg);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "Admin") > 0 && GetPVarInt(i, "ReadAdminBroadcast") > 0)
			{
				SendClientMessage(i, color, msg);
			}
		}
	}
	AdminLog(msg);
	return 1;
}

/***
   * SendNewbieMessage(msg[]);
   * Manda uma mensagem no chat de newbies;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendNewbieMessage(msg[])
{
	new lengths[128], length2[128], message[128], result[256], message2[128];
    strmid(result, msg, 0, 256);
	strmid(lengths, result, 0, 95);
	strmid(length2, msg, 95, 256);
	if(strlen(msg) > 95)
	{
		format(message, 128, "[{BED9EF}N{0077BF}] %s ...", lengths);
		format(message2, 128, "... %s", length2);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "ReadNewbieChat") > 0)
			{
				SendClientMessage(i, 0x0077BFFF, message);
				SendClientMessage(i, 0x0077BFFF, message2);
			}
		}
	}		
	else
	{
		format(message, 128, "[{BED9EF}N{0077BF}] %s", msg);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "ReadNewbieChat") > 0)
			{
				SendClientMessage(i, 0x0077BFFF, msg);
			}
		}
	}
	return 1;
}

/***
   * SendAdminMessage(msg[]);
   * Manda uma mensagem no chat de admins;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendAdminMessage(msg[])
{
	new lengths[128], length2[128], message[128], result[256], message2[128];
    strmid(result, msg, 0, 256);
	strmid(lengths, result, 0, 95);
	strmid(length2, msg, 95, 256);
	if(strlen(msg) > 95)
	{
		format(message, 128, "[{F97804}*{0195EF}] %s ...", lengths);
		format(message2, 128, "... %s", length2);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "Admin") > 0 && GetPVarInt(i, "ReadAdminMessage") > 0)
			{
				SendClientMessage(i, 0x0195EFFF, message);
				SendClientMessage(i, 0x0195EFFF, message2);
			}
		}
	}		
	else
	{
		format(message, 128, "[{F97804}*{0195EF}] %s", msg);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "Admin") > 0 && GetPVarInt(i, "ReadAdminMessage") > 0)
			{
				SendClientMessage(i, 0x0195EFFF, msg);
			}
		}
	}
	AdminLog(msg);
	return 1;
}

/***
   * SendPrivateMessage(playerid, forplayerid, msg[]);
   * Manda uma mensagem privada de um jogador (playerid) a outro (forplayerid);
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendPrivateMessage(playerid, forplayerid, msg[])
{
	new lengths[128], length2[128], message[128], result[256], message2[128];
    strmid(result, msg, 0, 256);
	strmid(lengths, result, 0, 95);
	strmid(length2, msg, 95, 256);
	if(strlen(msg) > 95)
	{
		format(message, 128, "(( PM de %s [%d]: %s ...", ReturnPlayerNameEx(playerid), playerid, lengths);
		format(message2, 128, "... %s ))", length2);
		SendClientMessage(forplayerid, COLOR_YELLOW, message);
		SendClientMessage(forplayerid, COLOR_YELLOW, message2);
		format(message, 128, "(( PM para %s [%d]: %s ...", ReturnPlayerNameEx(forplayerid), forplayerid, lengths);
		format(message2, 128, "... %s ))", length2);
		SendClientMessage(playerid, COLOR_YELLOW, message);
		SendClientMessage(playerid, COLOR_YELLOW, message2);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "ReadPrivateMessage") >= 1)
			{
				format(message, 128, "(( PM de %s [%d] para %s [%d]: %s ...", ReturnPlayerNameEx(playerid), playerid, ReturnPlayerNameEx(forplayerid), forplayerid, lengths);
				format(message2, 128, "... %s ))", length2);
				SendClientMessage(i, COLOR_YELLOW, message);
				SendClientMessage(i, COLOR_YELLOW, message2);
			}
		}
	}		
	else
	{
		format(message, 128, "(( PM de %s [%d]: %s ))", ReturnPlayerNameEx(playerid), playerid, msg);
		SendClientMessage(forplayerid, COLOR_YELLOW, message);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "ReadPrivateMessage") >= 1)
			{
				format(message, 128, "(( PM de %s [%d] para %s [%d]: %s ))", ReturnPlayerNameEx(playerid), playerid, ReturnPlayerNameEx(forplayerid), forplayerid, msg);
				SendClientMessage(i, COLOR_YELLOW, message);
			}
		}
		format(message, 128, "(( PM para %s [%d]: %s ))", ReturnPlayerNameEx(forplayerid), forplayerid, msg);
		SendClientMessage(playerid, COLOR_YELLOW, message);
	}
	format(result, 256, "(( PM de %s [%d] para %s [%d]: %s ))", ReturnPlayerNameEx(playerid), playerid, ReturnPlayerNameEx(forplayerid), forplayerid, msg);
    GlobalLog(result);	
	return 1;
}

/***
   * SendWarningMessage(playerid, msg[]);
   * Manda uma mensagem de aviso;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendWarningMessage(playerid, msg[])
{
	new lengths[128], length2[128], message[128];
    strmid(lengths, msg, 0, 118);
    strmid(length2, msg, 118, 256);
    if(strlen(msg) > 118)
    {
        format(message, 128, "[!] %s ...", lengths);
        SendClientMessage(playerid, COLOR_WARNING, message);
		PlayerLog(playerid, message);
        format(message, 128, "... %s", length2);
        SendClientMessage(playerid, COLOR_WARNING, message);
		PlayerLog(playerid, message);
    }
    else
    {
        format(message, 128, "[!] %s", msg);
        SendClientMessage(playerid, COLOR_WARNING, message);
		PlayerLog(playerid, message);
    }
	return 1;
}

/***
   * SendFactionMessage(faction, msg[]);
   * Manda uma mensagem a uma facção;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendFactionMessage(faction, msg[])
{
	new lengths[128], length2[128], message[128];
    strmid(lengths, msg, 0, 118);
    strmid(length2, msg, 118, 256);
	foreach(Player, playerid)
	{
		if(GetPVarInt(playerid, "Faction") == faction)
		{
			if(strlen(msg) > 118)
			{
				format(message, 128, "%s ...", lengths);
				SendClientMessage(playerid, 0xC2A2DAFF, message);
				FactionLog(faction, message);
				format(message, 128, "... %s", length2);
				SendClientMessage(playerid, 0xC2A2DAFF, message);
				FactionLog(faction, message);
			}
			else
			{
				format(message, 128, "%s", msg);
				SendClientMessage(playerid, 0xC2A2DAFF, message);
				FactionLog(faction, message);
			}
		}	
	}
	return 1;
}

/***
   * SendFactionChat(faction, msg[]);
   * Manda uma mensagem de chat a uma facção;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendFactionChat(faction, msg[])
{
	new lengths[128], length2[128], message[128];
    strmid(lengths, msg, 0, 118);
    strmid(length2, msg, 118, 256);
	foreach(Player, playerid)
	{
		if(GetPVarInt(playerid, "Faction") == faction)
		{
			if(strlen(msg) > 118)
			{
				format(message, 128, "(( %s ...", lengths);
				SendClientMessage(playerid, 0xBDF38BFF, message);
				FactionLog(faction, message);
				format(message, 128, "... %s ))", length2);
				SendClientMessage(playerid, 0xBDF38BFF, message);
				FactionLog(faction, message);
			}
			else
			{
				format(message, 128, "(( %s ))", msg);
				SendClientMessage(playerid, 0xBDF38BFF, message);
				FactionLog(faction, message);
			}
		}
	}
	return 1;
}

/***
   * SendRPMessage(playerid, msg[]);
   * Manda uma mensagem de RP;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendRPMessage(playerid, msg[])
{
	new lengths[128], length2[128], message[128];
    strmid(lengths, msg, 0, 119);
    strmid(length2, msg, 119, 256);
    if(strlen(msg) > 119)
    {
        format(message, 128, "* %s ...", lengths);
        SendClientMessage(playerid, 0xC2A2DAFF, message);
		PlayerLog(playerid, message);
        format(message, 128, "... %s", length2);
        SendClientMessage(playerid, 0xC2A2DAFF, message);
		PlayerLog(playerid, message);
    }
    else
    {
        format(message, 128, "* %s", msg);
        SendClientMessage(playerid, 0xC2A2DAFF, message);
		PlayerLog(playerid, message);
    }
	return 1;
}

/***
   * SendChatMessage(playerid, msg[]);
   * Manda uma mensagem no chat;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendChatMessage(playerid, msg[])
{
	new lengths[128], length2[128], message[128];
    strmid(lengths, msg, 0, 119);
    strmid(length2, msg, 119, 256);
    if(strlen(msg) > 119)
    {
        format(message, 128, "%s ...", lengths);
        SendClientMessage(playerid, 0xFFFFFFFF, message);
		PlayerLog(playerid, message);
        format(message, 128, "... %s", length2);
        SendClientMessage(playerid, 0xFFFFFFFF, message);
		PlayerLog(playerid, message);
    }
    else
    {
        format(message, 128, "%s", msg);
        SendClientMessage(playerid, 0xFFFFFFFF, message);
		PlayerLog(playerid, message);
    }
	return 1;
}

/***
   * SendColoredMessage(playerid, color, msg[]);
   * Manda uma mensagem com cor;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendColoredMessage(playerid, color, msg[])
{

	new lengths[128], length2[128], message[128];
    strmid(lengths, msg, 0, 119);
    strmid(length2, msg, 119, 256);
    if(strlen(msg) > 119)
    {
        format(message, 128, "%s ...", lengths);
        SendClientMessage(playerid, color, message);
		PlayerLog(playerid, message);
        format(message, 128, "... %s", length2);
        SendClientMessage(playerid, color, message);
		PlayerLog(playerid, message);
    }
    else
    {
        format(message, 128, "%s", msg);
        SendClientMessage(playerid, color, message);
		PlayerLog(playerid, message);
    }
	return 1;
}

/***
   * SendServerBroadcast(msg[]);
   * Manda uma mensagem a todos do servidor;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendServerBroadcast(msg[])
{
	new lengths[128], length2[128], message[128], result[256], message2[128];
    strmid(result, msg, 0, 256);
	strmid(lengths, result, 0, 120);
	strmid(length2, msg, 120, 256);
	if(strlen(msg) > 120)
	{
		format(message, 128, "%s ...", lengths);
		format(message2, 128, "... %s", length2);
		SendClientMessageToAll(COLOR_WARNING, message);
		SendClientMessageToAll(COLOR_WARNING, message2);
	}		
	else
	{
		format(message, 128, "%s ", msg);
		SendClientMessageToAll(COLOR_WARNING, msg);
	}
	GlobalLog(msg);
	return 1;
}

/***
   * SendServerBroadcast(color, msg[]);
   * Manda uma mensagem com cor a todos do servidor;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendColoredServerBroadcast(color, msg[])
{
	new lengths[128], length2[128], message[128], result[256], message2[128];
    strmid(result, msg, 0, 256);
	strmid(lengths, result, 0, 121);
	strmid(length2, msg, 121, 256);
	if(strlen(msg) > 121)
	{
		format(message, 128, "%s ...", lengths);
		format(message2, 128, "... %s", length2);
		SendClientMessageToAll(color, message);
		SendClientMessageToAll(color, message2);
	}		
	else
	{
		format(message, 128, "%s", msg);
		SendClientMessageToAll(color, msg);
	}
	GlobalLog(msg);
	return 1;
}

/***
   * SendServerChat(msg[]);
   * Manda uma mensagem de chat a todos do servidor;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendServerChat(msg[])
{
	new lengths[128], length2[128], message[128], result[256], message2[128];
    strmid(result, msg, 0, 256);
	strmid(lengths, result, 0, 120);
	strmid(length2, msg, 120, 256);
	if(strlen(msg) > 120)
	{
		format(message, 128, "(( %s ...", lengths);
		format(message2, 128, "... %s ))", length2);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "ReadGlobalChat") > 0)
			{
				SendClientMessage(i, COLOR_SMS, message);
				SendClientMessage(i, COLOR_SMS, message2);
			}
		}
	}		
	else
	{
		format(message, 128, "(( %s ))", msg);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "ReadGlobalChat") > 0)
			{
				SendClientMessage(i, COLOR_SMS, msg);
			}
		}
	}
	GlobalLog(msg);
	return 1;
}

/***
   * SendColoredServerChat(color, msg[]);
   * Manda uma mensagem de chat colorida a todos do servidor;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SendColoredServerChat(color, msg[])
{
	new lengths[128], length2[128], message[128], result[256], message2[128];
    strmid(result, msg, 0, 256);
	strmid(lengths, result, 0, 121);
	strmid(length2, msg, 121, 256);
	if(strlen(msg) > 121)
	{
		format(message, 128, "(( %s ...", lengths);
		format(message2, 128, "... %s ))", length2);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "ReadGlobalChat") > 0)
			{
				SendClientMessage(i, color, message);
				SendClientMessage(i, color, message2);
			}
		}
	}		
	else
	{
		format(message, 128, "(( %s ))", msg);
		foreach(Player, i)
		{
			if(GetPVarInt(i, "ReadGlobalChat") > 0)
			{
				SendClientMessage(i, color, msg);
			}
		}
	}
	GlobalLog(msg);
	return 1;
}

/***
   * BroadcastRPMessage(message[], playerid, Float:radius);
   * Manda uma mensagem de RP ao redor, utilizada pelo /me, /do e similares;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public BroadcastRPMessage(message[], playerid, Float:radius)
{
	new Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ);
    foreach (Player, i)
    {
        if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(playerid) == GetPlayerInterior(i) && IsPlayerInRangeOfPoint(i, radius, pX, pY, pZ)) SendRPMessage(i, message);
    }
	SetPlayerChatBubble(playerid, message, COLOR_PURPLE, radius, 5000);
	return 1;
}

/***
   * BroadcastChat(message[], playerid, Float:radius);
   * Manda uma mensagem ao redor, utilizada pelo /b e similares;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public BroadcastChat(message[], playerid, Float:radius)
{
	new Float:pX, Float:pY, Float:pZ, dist;
	GetPlayerPos(playerid, pX, pY, pZ);
    foreach (Player, i)
    {
        if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(playerid) == GetPlayerInterior(i) && IsPlayerInRangeOfPoint(i, radius, pX, pY, pZ)) 
		{
			dist = floatround(radius);
		    switch(dist)
		    {
		        case 0 .. 10: SendColoredMessage(i, 0xFFFFFFFF, message);
			    case 11 .. 15: SendColoredMessage(i, 0xC9C9C996, message);
			    case 16 .. 20: SendColoredMessage(i, 0xB5B5B596, message);
			    case 21 .. 25: SendColoredMessage(i, 0xA3A3A396, message);
				default: SendColoredMessage(i, 0xAFAFAFFF, message);
		   }
		}
    }
	SetPlayerChatBubble(playerid, message, COLOR_WHITE, radius, 5000);
	return 1;
}

/***
   * BroadcastMessage(message[], color, playerid, Float:radius);
   * Manda uma mensagem com cor ao redor;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public BroadcastMessage(message[], color, playerid, Float:radius)
{
	new Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ);
    foreach (Player, i) if(GetPlayerVirtualWorld(i) == GetPlayerVirtualWorld(playerid) && GetPlayerInterior(playerid) == GetPlayerInterior(i) && IsPlayerInRangeOfPoint(i, radius, pX, pY, pZ)) SendColoredMessage(i, color, message);
	SetPlayerChatBubble(playerid, message, color, radius, 5000);
	return 1;
}

/***
   * OnQueryError(errorid, error[], callback[], query[], connectionHandle);
   * Utilizada para retornar erros no mysql;
   * Por: BlueG(?);
   * Versão: ?;
***/

public OnQueryError(errorid, error[], callback[], query[], connectionHandle)
{
	if(!strcmp(query,"SELECT * FROM playerdata WHERE Name = 'ERRORQUERY'", true))
	{	
		print("[ERRO] A conexão com o banco de dados não pode ser estabelecida. Desligue o servidor e cheque a conexão ou o erro MYSQL.");
		printf("[MYSQL] ERRO %d - \"%s\" - \"%s\" - \"%s\" - %d", errorid, error,  callback, query, connectionHandle);
		return 0;
	}	
	return printf("[MYSQL] ERRO %d - \"%s\" - \"%s\" - \"%s\" - %d", errorid, error,  callback, query, connectionHandle);
}

/***
   * CheckAccount(playerid);
   * Utilizada para verificar se uma conta existe, no login;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public CheckAccount(playerid)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows >= 1) SetPVarInt(playerid, "AccountExists", 1);
	else SetPVarInt(playerid, "AccountExists", 0);
	cache_get_row(0, 0, result);
	SetPVarInt(playerid, "InternalID", strval(result));
	cache_get_row(0, 1, result);
	SetPVarInt(playerid, "Created", strval(result));
	return 1;
}

/***
   * ShowReportInfoBox(playerid);
   * Mostra um relatório para um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public ShowReportInfoBox(playerid)
{
	new rows, fields, result[128];
	cache_get_data(rows, fields);
	if(rows == 1)
	{
		cache_get_row(0, 1, result);
		SetPVarInt(playerid, "ReporteeID", strval(result));
		cache_get_row(0, 2, result);
		SetPVarInt(playerid, "ReportedID", strval(result));
		cache_get_row(0, 3, result);
		convert_encoding(result);
		SetPVarString(playerid, "ReportReason", result);
		cache_get_row(0, 4, result);
		convert_encoding(result);
		SetPVarString(playerid, "ReportExtra", result);
		cache_get_row(0, 5, result);
		SetPVarString(playerid, "ReportDate", result);
		cache_get_row(0, 6, result);
		SetPVarInt(playerid, "ReportStatus", strval(result));
		format(result, 128, "SELECT playerName FROM playerdata WHERE playerID = '%i'", GetPVarInt(playerid, "ReporteeID"));
		mysql_function_query(db, result, true, "GetReporteeName", "i", playerid);
		return 1;
	}
	else return SendErrorMessage(playerid, "Relatório inválido;");
}

/***
   * ShowSuggestionInfoBox(playerid);
   * Mostra a caixa de informações da suegestão de um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public ShowSuggestionInfoBox(playerid)
{
	new rows, fields, result[128];
	cache_get_data(rows, fields);
	if(rows == 1)
	{
		OpenInfoBox(playerid);
		AddInfoBoxTitle(playerid, 1, "Sugestão");
		cache_get_row(0, 1, result);
		convert_encoding(result);
		AddInfoBoxMessage(playerid, 1, result);
		cache_get_row(0, 2, result);
		AddInfoBoxTitle(playerid, 1, "Comentários");
		convert_encoding(result);
		AddInfoBoxMessage(playerid, 2, result);
		AddInfoBoxTitle(playerid, 1, "Data");
		cache_get_row(0, 3, result);
		AddInfoBoxMessage(playerid, 3, result);
		return 1;
	}
	else return SendErrorMessage(playerid, "Sugestão inválida;");
}

/***
   * ShowBugTrackerInfoBox(playerid);
   * Mostra a caixa de informações do relatório de erros de um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public ShowBugTrackerInfoBox(playerid)
{
	new rows, fields, result[128];
	cache_get_data(rows, fields);
	if(rows == 1)
	{
		OpenInfoBox(playerid);
		cache_get_row(0, 2, result);
		convert_encoding(result);
		AddInfoBoxTitle(playerid, 1, result);
		cache_get_row(0, 3, result);
		convert_encoding(result);
		AddInfoBoxMessage(playerid, 1, result);
		cache_get_row(0, 4, result);
		AddInfoBoxTitle(playerid, 2, "Detalhes");
		convert_encoding(result);
		AddInfoBoxMessage(playerid, 2, result);
		AddInfoBoxTitle(playerid, 3, "Data");
		cache_get_row(0, 5, result);
		AddInfoBoxMessage(playerid, 3, result);
		return 1;
	}
	else return SendErrorMessage(playerid, "Relatório de erro inválido;");
}

/***
   * GetReporteeName(playerid);
   * Retorna o Nome de quem fez um relatório;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetReporteeName(playerid)
{
	new rows, fields, result[128];
	cache_get_data(rows, fields);
	if(rows == 1)
	{
		cache_get_row(0, 0, result);
		SetPVarString(playerid, "ReporteeName", result);
		format(result, 128, "SELECT playerName FROM playerdata WHERE playerID = '%i'", GetPVarInt(playerid, "ReportedID"));
		mysql_function_query(db, result, true, "GetReportedName", "i", playerid);
		return 1;
	}
	else return SendErrorMessage(playerid, "Relatório inválido;");
}

/***
   * GetReportedName(playerid);
   * Retorna o Nome de quem foi reportado em um relatório;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetReportedName(playerid)
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1)
	{
		cache_get_row(0, 0, result);
		SetPVarString(playerid, "ReportedName", result);
		OpenInfoBox(playerid);
		AddInfoBoxTitle(playerid, 1, "Denunciante");
		AddInfoBoxMessage(playerid, 1, GetPVarStringEx(playerid, "ReporteeName"));
		AddInfoBoxTitle(playerid, 2, "Denunciado");
		AddInfoBoxMessage(playerid, 2, GetPVarStringEx(playerid, "ReportedName"));
		AddInfoBoxTitle(playerid, 3, "Data e Hora");
		AddInfoBoxMessage(playerid, 3, GetPVarStringEx(playerid, "ReportDate"));
		AddInfoBoxTitle(playerid, 4, "Motivo");
		AddInfoBoxMessage(playerid, 4, GetPVarStringEx(playerid, "ReportReason"));
		AddInfoBoxTitle(playerid, 5, "Extras");
		AddInfoBoxMessage(playerid, 5, GetPVarStringEx(playerid, "ReportExtra"));
		return 1;
	}
	else return SendErrorMessage(playerid, "Relatório inválido;");
}

/***
   * GetReporteeReports(playerid);
   * Mostra quantos relatórios um jogador fez;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetReporteeReports(playerid)
{
	new rows, fields, result[24], other[24], str[48];
	cache_get_data(rows, fields);
	if(rows >= 1)
	{
		if(rows < 20)
		{
			for(new x = 0; x < 31; x++) TextDrawHideForPlayer(playerid, Panel[playerid][x]);
			for(new i = 0; i < rows; i++)
			{
				ShowPlayerPanel(playerid, PANEL_PLAYER_MYREPORTS);
				cache_get_row(i, 0, result);
				cache_get_row(i, 6, other);
				if(strval(other) == 0) format(str, 24, "%d - ~y~Não Avaliado", strval(result));
				else if(strval(other) == 1) format(str, 24, "%d - ~p~Em Avaliação", strval(result));
				else if(strval(other) == 2) format(str, 24, "%d - ~g~Aceito", strval(result));
				else if(strval(other) == 3) format(str, 24, "%d - ~r~Negado", strval(result));
				AddPanelItem(playerid, i+1, str, true);
				format(str, 48, "PanelItem%iExtra", i+1);
				SetPVarString(playerid, str, result);
			}
		}
		return 1;
	}
	else return SendWarningMessage(playerid, "Não existem relatórios feitos por você;");
}

/***
   * GetReportedReports(playerid);
   * Mostra quantos relatórios um jogador fez;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetReportedReports(playerid)
{
	new rows, fields, result[24], other[24], str[48];
	cache_get_data(rows, fields);
	if(rows >= 1)
	{
		if(rows < 20)
		{
			for(new x = 0; x < 31; x++) TextDrawHideForPlayer(playerid, Panel[playerid][x]);
			for(new i = 0; i < rows; i++)
			{
				ShowPlayerPanel(playerid, PANEL_PLAYER_REPORTEDBY);
				cache_get_row(i, 0, result);
				cache_get_row(i, 6, other);
				if(strval(other) == 0) format(str, 24, "%d - ~y~Não Avaliado", strval(result));
				else if(strval(other) == 1) format(str, 24, "%d - ~p~Em Avaliação", strval(result));
				else if(strval(other) == 2) format(str, 24, "%d - ~g~Aceito", strval(result));
				else if(strval(other) == 3) format(str, 24, "%d - ~r~Negado", strval(result));
				AddPanelItem(playerid, i+1, str, true);
				format(str, 48, "PanelItem%iExtra", i+1);
				SetPVarString(playerid, str, result);
			}
		}
		return 1;
	}
	else return SendWarningMessage(playerid, "Não existem relatórios contra você;");
}

/***
   * GetSuggestion(playerid);
   * Mostra as sugestões de um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetSuggestion(playerid)
{
	new rows, fields, result[24], other[24], str[48];
	cache_get_data(rows, fields);
	if(rows >= 1)
	{
		if(rows < 20)
		{
			for(new x = 0; x < 31; x++) TextDrawHideForPlayer(playerid, Panel[playerid][x]);
			for(new i = 0; i < rows; i++)
			{
				ShowPlayerPanel(playerid, PANEL_PLAYER_MYSUGGESTIONS);
				cache_get_row(i, 0, result);
				cache_get_row(i, 5, other);
				if(strval(other) == 0) format(str, 24, "%d - ~y~Não Avaliada", strval(result));
				else if(strval(other) == 1) format(str, 24, "%d - ~p~Em Avaliação", strval(result));
				else if(strval(other) == 2) format(str, 24, "%d - ~g~Aceita", strval(result));
				else if(strval(other) == 3) format(str, 24, "%d - ~r~Negada", strval(result));
				AddPanelItem(playerid, i+1, str, true);
				format(str, 48, "PanelItem%iExtra", i+1);
				SetPVarString(playerid, str, result);
			}
		}
		return 1;
	}
	else return SendWarningMessage(playerid, "Não existem sugestões enviadas por você;");
}

/***
   * GetBugTracker(playerid);
   * Mostra os bugs que um jogador relatou;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GetBugTracker(playerid)
{
	new rows, fields, result[24], other[24], str[48];
	cache_get_data(rows, fields);
	if(rows >= 1)
	{
		if(rows < 20)
		{
			for(new x = 0; x < 31; x++) TextDrawHideForPlayer(playerid, Panel[playerid][x]);
			for(new i = 0; i < rows; i++)
			{
				ShowPlayerPanel(playerid, PANEL_PLAYER_MYBUGS);
				cache_get_row(i, 0, result);
				cache_get_row(i, 6, other);
				if(strval(other) == 0) format(str, 24, "%d - ~y~Não Avaliado", strval(result));
				else if(strval(other) == 1) format(str, 24, "%d - ~p~Em Avaliação", strval(result));
				else if(strval(other) == 2) format(str, 24, "%d - ~g~Validado/Corrigido", strval(result));
				else if(strval(other) == 3) format(str, 24, "%d - ~r~Invalidado", strval(result));
				AddPanelItem(playerid, i+1, str, true);
				format(str, 48, "PanelItem%iExtra", i+1);
				SetPVarString(playerid, str, result);
			}
		}
		return 1;
	}
	else return SendWarningMessage(playerid, "Não existem relatórios de erros enviados por você;");
}

/***
   * CheckExist(playerid, name[]);
   * Utilizada para verificar se uma conta existe, ao reportar um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public CheckExist(playerid, name[])
{
	new rows, fields, result[24];
	cache_get_data(rows, fields);
	if(rows == 1)
	{
		cache_get_row(0, 0, result);
		SetPVarInt(playerid, "ReportedPlayerID", strval(result));
		cache_get_row(0, 1, result);
		SetPVarString(playerid, "ReportedPlayer", result);
		SetPVarInt(playerid, "OfflineReport", 1337);
		new str[256];
		format(str, 256, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n{a9c4e4}Digite o motivo que você deseja reportar esse jogador.\nAtenção: Limite de 128 caracteres;", GetPVarStringEx(playerid, "ReportedPlayer"));
		SetPVarInt(playerid, "Reporting", 1338);
		return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", str, "Reportar", "Voltar");
	}
	else return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", "{FF0000}ERRO: Jogador inválido;\n{A9C4E4}Digite abaixo o ID ou nome de quem você deseja reportar;", "Reportar", "Sair");
}

/***
   * ShutServerDown();
   * Utilizada para reiniciar o servidor;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public ShutServerDown() 
{
	SendRconCommand("gmx");
	return 1;
}

/***
   * OnPlayerRegister(playerid);
   * Utilizada para registrar um jogador, todos os valores padrão de um jogador devem ser colocados aqui;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public OnPlayerRegister(playerid)
{
	new i = cache_insert_id();
	SetPVarInt(playerid, "InternalID", i);
	SetPlayerCameraPos(playerid, 679.7236,1921.0554,11.0359);
	SetPlayerPos(playerid, 687.8969,1888.9232,1.0359);
	SetPlayerVirtualWorld(playerid, 2);
	SetPlayerCameraLookAt(playerid, 687.8969,1888.9232,7.4442);
	SetPVarInt(playerid, "AccountExists", 1);
	SetPVarInt(playerid, "Logged", 1);
	new pass[24];
	GetPVarString(playerid, "InputPass", pass, 24);
	SetPVarString(playerid, "Password", pass);
	SetPVarInt(playerid, "RightHandItem", -1);
	SetPVarInt(playerid, "LeftHandItem", -1);
	SetPVarInt(playerid, "BackItem", -1);
	ShowPlayerDialog(playerid, DIALOG_REGISTEREX, DIALOG_STYLE_INPUT, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "Senha registrada!\nPor favor, informe abaixo um email para esta conta;", "Continuar", "Sair");
	return 1;
}

/***
   * OnPlayerLogin(playerid);
   * Utilizada para carregar os dados de um jogador,;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public OnPlayerLogin(playerid)
{
	new result[128], rows, fields;
	cache_get_data(rows, fields);
	if(rows) 
	{
		cache_get_row(0, 0, result);
		SetPVarInt(playerid, "InternalID", strval(result));
		cache_get_row(0, 1, result);
		SetPVarString(playerid, "Name", result);
		cache_get_row(0, 2, result);
		SetPVarString(playerid, "Password", result);
		cache_get_row(0, 3, result);
		SetPVarInt(playerid, "Admin", strval(result));
		cache_get_row(0, 4, result);
		SetPVarInt(playerid, "Spawn", strval(result));
		cache_get_row(0, 5, result);
		SetPVarFloat(playerid, "PosX", floatstr(result));
		cache_get_row(0, 6, result);
		SetPVarFloat(playerid, "PosY", floatstr(result));
		cache_get_row(0, 7, result);
		SetPVarFloat(playerid, "PosZ", floatstr(result));
		cache_get_row(0, 8, result);
		SetPVarInt(playerid, "Int", strval(result));
		cache_get_row(0, 9, result);
		SetPVarInt(playerid, "VW", strval(result));
		cache_get_row(0, 10, result);
		SetPVarInt(playerid, "Created", strval(result));
		cache_get_row(0, 11, result);
		SetPVarString(playerid, "Username", result);
		cache_get_row(0, 12, result);
		SetPVarInt(playerid, "RightHandItem", strval(result));
		cache_get_row(0, 13, result);
		SetPVarInt(playerid, "LeftHandItem", strval(result));
		cache_get_row(0, 14, result);
		SetPVarInt(playerid, "BackItem", strval(result));
		SetPVarInt(playerid, "Logged", 1);
		SetPVarInt(playerid, "ReadNewbieChat", 1);
		SetPVarInt(playerid, "TogglePrivateMessage", 1337);
		SpawnPlayer(playerid);
		//Default Settings
		new string[128];
		SetDefaultVariables(playerid);
		if(GetPVarString(playerid, "Accent", string, 24) > 3 || !strcmp(GetPVarStringEx(playerid, "Accent"), "Desligado", true, 9)) SetPVarInt(playerid, "AccentOn", 0);
		SetPlayerPos(playerid, GetPVarFloat(playerid, "PosX"), GetPVarFloat(playerid, "PosY"), GetPVarFloat(playerid, "PosZ"));
		SetPlayerVirtualWorld(playerid, GetPVarInt(playerid, "Int"));
		SetPlayerInterior(playerid, GetPVarInt(playerid, "VW"));
		SetCameraBehindPlayer(playerid);
		FreezePlayer(playerid, 3000);
		if(GetPVarInt(playerid, "Admin") > 0) return ShowPlayerDialog(playerid, DIALOG_ADMINLOGIN, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria", "Esta é uma conta administrativa\nPor favor, digite a senha administrativa", "Continuar", "Sair do Servidor");
		return 1;
	}
	else
	{
		new la = GetPVarInt(playerid, "LoginAttempts");
		SetPVarInt(playerid, "LoginAttempts", la+1);
		if(la == 4)
		{
			SendSystemMessage(playerid, "Seu IP será banido imediatamente por errar quatro vezes sua senha.");
			BanEx(playerid, "[SISTEMA] Errou quatro vezes a senha.");
			return 1;
		}
		return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "ERRO: Senha inválida\nPor favor, digite a senha desta conta.", "Continuar", "Sair do Servidor");
	}
}

/***
   * SavePlayerData(playerid);
   * Utilizada para salvar os dados de um jogador;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public SavePlayerData(playerid)
{
	if(!GetPVarInt(playerid, "Logged") || GetPVarInt(playerid, "Created") != 1337) return 1;
	{
		new string[128];
		mysql_format(db, string, 128, "UPDATE playerdata SET playerName = '%e' WHERE playerID = '%d'", ReturnPlayerNameEx(playerid), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		mysql_format(db, string, 128, "UPDATE playerdata SET playerPass = '%e' WHERE playerID = '%d'", GetPVarStringEx(playerid, "Password"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerAdmin = '%d' WHERE playerID = '%d'", GetPVarInt(playerid, "Admin"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerSpawn = '%d' WHERE playerID = '%d'", GetPVarInt(playerid, "Spawn"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerX = '%f' WHERE playerID = '%d'", GetPVarFloat(playerid, "PosX"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerY = '%f' WHERE playerID = '%d'", GetPVarFloat(playerid, "PosY"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerZ = '%f' WHERE playerID = '%d'", GetPVarFloat(playerid, "PosZ"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerInt = '%d' WHERE playerID = '%d'", GetPVarInt(playerid, "Interior"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerVW = '%d' WHERE playerID = '%d'", GetPVarInt(playerid, "VW"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerCreated = '%d' WHERE playerID = '%d'", GetPVarInt(playerid, "Created"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		mysql_format(db, string, 128, "UPDATE playerdata SET playerUsername = '%e' WHERE playerID = '%d'", GetPVarStringEx(playerid, "Username"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerRightHandItem = '%d' WHERE playerID = '%d'", GetPVarInt(playerid, "LeftHandItem"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerLeftHandItem = '%d' WHERE playerID = '%d'", GetPVarInt(playerid, "RightHandItem"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		format(string, 128, "UPDATE playerdata SET playerBackItem = '%d' WHERE playerID = '%d'", GetPVarInt(playerid, "BackItem"), GetPVarInt(playerid, "InternalID"));
		mysql_function_query(db, string, false, "", "");
		return 1;
	}
}

/***
   * GlobalTimer();
   * Temporizador global de um segundo;
   * Por: LeLeTe;
   * Versão: 1.0;
***/

public GlobalTimer()
{
	hourcounter++;
	foreach(Player, playerid)
	{
		new savetimer = GetPVarInt(playerid, "SaveTimer");
		savetimer++;
		SetPVarInt(playerid, "SaveTimer", savetimer);
		if(savetimer >= 3600) 
		{
			SetPVarInt(playerid, "SaveTimer", 0);
			SavePlayerData(playerid);
		}
	}
	return;
}

public InsertionQuery(queryid, playerid, extraint, Float:extrafloat, extrastr[])
{
	switch (queryid)
	{
		case QUERY_INSERT_ITEM:
		{
		
		}
		default: return;
	}
	return;
}

//##############################################################################################

public OnGameModeInit()
{
	#if defined DEBUG
		mysql_debug(1);
		print("[DEBUG] OnGameModeInit()");
	#endif
	db = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_DB, MYSQL_PASS);
	mysql_function_query(db, "SELECT * FROM placeditems", true, "LoadPlacedItems", "");
	ShowPlayerMarkers(0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
    ShowNameTags(0);
	AddPlayerClass(183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	SetGameModeText(SERVER_VERSION);
    SendRconCommand("mapname Los Santos");
	SendRconCommand(SERVER_TEXT);
	SetTimer("GlobalTimer", 1000, 1);
		
	//TEXTDRAWS
	
	BlankScreen = TextDrawCreate(-1.333338, -0.000000, "LD_SPAC:white");
	TextDrawLetterSize(BlankScreen, 0.000000, 0.000000);
	TextDrawTextSize(BlankScreen, 645.666503, 450.903839);
	TextDrawAlignment(BlankScreen, 1);
	TextDrawColor(BlankScreen, -1);
	TextDrawSetShadow(BlankScreen, 0);
	TextDrawSetOutline(BlankScreen, 0);
	TextDrawFont(BlankScreen, 4);
	
	MenuDisc[0] = TextDrawCreate(257.333404, 158.459259, "hud:radardisc");
	TextDrawLetterSize(MenuDisc[0], 0.000000, 0.000000);
	TextDrawTextSize(MenuDisc[0], 60.000000, 61.807453);
	TextDrawAlignment(MenuDisc[0], 1);
	TextDrawColor(MenuDisc[0], -1);
	TextDrawSetShadow(MenuDisc[0], 0);
	TextDrawSetOutline(MenuDisc[0], 0);
	TextDrawFont(MenuDisc[0], 4);

	MenuDisc[1] = TextDrawCreate(377.000061, 158.214859, "hud:radardisc");
	TextDrawLetterSize(MenuDisc[1], 0.000000, 0.000000);
	TextDrawTextSize(MenuDisc[1], -60.000000, 61.807453);
	TextDrawAlignment(MenuDisc[1], 1);
	TextDrawColor(MenuDisc[1], -1);
	TextDrawSetShadow(MenuDisc[1], 0);
	TextDrawSetOutline(MenuDisc[1], 0);
	TextDrawFont(MenuDisc[1], 4);

	MenuDisc[2] = TextDrawCreate(376.999969, 279.511230, "hud:radardisc");
	TextDrawLetterSize(MenuDisc[2], 0.000000, 0.000000);
	TextDrawTextSize(MenuDisc[2], -60.000015, -60.148086);
	TextDrawAlignment(MenuDisc[2], 1);
	TextDrawColor(MenuDisc[2], -1);
	TextDrawSetShadow(MenuDisc[2], 0);
	TextDrawSetOutline(MenuDisc[2], 0);
	TextDrawFont(MenuDisc[2], 4);

	MenuDisc[3] = TextDrawCreate(257.333221, 279.681396, "hud:radardisc");
	TextDrawLetterSize(MenuDisc[3], 0.000000, 0.000000);
	TextDrawTextSize(MenuDisc[3], 59.999980, -60.148086);
	TextDrawAlignment(MenuDisc[3], 1);
	TextDrawColor(MenuDisc[3], -1);
	TextDrawSetShadow(MenuDisc[3], 0);
	TextDrawSetOutline(MenuDisc[3], 0);
	TextDrawFont(MenuDisc[3], 4);

	MenuDisc[4] = TextDrawCreate(294.666656, 172.977798, "INVENTÁRIO");
	TextDrawLetterSize(MenuDisc[4], 0.261333, 1.089777);
	TextDrawAlignment(MenuDisc[4], 1);
	TextDrawColor(MenuDisc[4], -1);
	TextDrawSetShadow(MenuDisc[4], 0);
	TextDrawSetOutline(MenuDisc[4], 1);
	TextDrawBackgroundColor(MenuDisc[4], 51);
	TextDrawFont(MenuDisc[4], 3);
	TextDrawSetProportional(MenuDisc[4], 1);

	MenuDisc[5] = TextDrawCreate(247.000045, 227.903762, "STATS");
	TextDrawLetterSize(MenuDisc[5], 0.261333, 1.089777);
	TextDrawAlignment(MenuDisc[5], 1);
	TextDrawColor(MenuDisc[5], -1);
	TextDrawSetShadow(MenuDisc[5], 0);
	TextDrawSetOutline(MenuDisc[5], 1);
	TextDrawBackgroundColor(MenuDisc[5], 51);
	TextDrawFont(MenuDisc[5], 3);
	TextDrawSetProportional(MenuDisc[5], 1);

	MenuDisc[6] = TextDrawCreate(304.333404, 285.733428, "PAINEL");
	TextDrawLetterSize(MenuDisc[6], 0.261333, 1.089777);
	TextDrawAlignment(MenuDisc[6], 1);
	TextDrawColor(MenuDisc[6], -1);
	TextDrawSetShadow(MenuDisc[6], 0);
	TextDrawSetOutline(MenuDisc[6], 1);
	TextDrawBackgroundColor(MenuDisc[6], 51);
	TextDrawFont(MenuDisc[6], 3);
	TextDrawSetProportional(MenuDisc[6], 1);

	MenuDisc[7] = TextDrawCreate(346.333435, 230.318649, "PERSONAGENS");
	TextDrawLetterSize(MenuDisc[7], 0.261333, 1.089777);
	TextDrawAlignment(MenuDisc[7], 1);
	TextDrawColor(MenuDisc[7], -1);
	TextDrawSetShadow(MenuDisc[7], 0);
	TextDrawSetOutline(MenuDisc[7], 1);
	TextDrawBackgroundColor(MenuDisc[7], 51);
	TextDrawFont(MenuDisc[7], 3);
	TextDrawSetProportional(MenuDisc[7], 1);
	
	new string[64];
	
	format(string, 64, "ADMINISTRATIVO");
	convert_encoding(string);
	
	MenuDisc[8] = TextDrawCreate(318.999938, 219.022216, string);
	TextDrawLetterSize(MenuDisc[8], 0.276333, 1.127110);
	TextDrawAlignment(MenuDisc[8], 2);
	TextDrawColor(MenuDisc[8], -1);
	TextDrawSetShadow(MenuDisc[8], 0);
	TextDrawSetOutline(MenuDisc[8], 1);
	TextDrawBackgroundColor(MenuDisc[8], 51);
	TextDrawFont(MenuDisc[8], 3);
	TextDrawSetProportional(MenuDisc[8], 1);
	
	
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		MenuInventory[i] = TextDrawCreate(305.000061, 143.525894, "hud:radar_gangp");
		TextDrawLetterSize(MenuInventory[i], 0.000000, 0.000000);
		TextDrawTextSize(MenuInventory[i], 26.000013, 29.866659);
		TextDrawAlignment(MenuInventory[i], 1);
		TextDrawColor(MenuInventory[i], -1);
		TextDrawSetShadow(MenuInventory[i], 0);
		TextDrawSetOutline(MenuInventory[i], 0);
		TextDrawFont(MenuInventory[i], 4);
		TextDrawSetSelectable(MenuInventory[i], true);

		MenuStats[i] = TextDrawCreate(249.333297, 197.622131, "hud:radar_cash");
		TextDrawLetterSize(MenuStats[i], 0.000000, 0.000000);
		TextDrawTextSize(MenuStats[i], 26.000013, 29.866659);
		TextDrawAlignment(MenuStats[i], 1);
		TextDrawColor(MenuStats[i], -1);
		TextDrawSetShadow(MenuStats[i], 0);
		TextDrawSetOutline(MenuStats[i], 0);
		TextDrawFont(MenuStats[i], 4);
		TextDrawSetSelectable(MenuStats[i], true);

		MenuPanel[i] = TextDrawCreate(304.999938, 254.355560, "hud:radar_hostpital");
		TextDrawLetterSize(MenuPanel[i], 0.000000, 0.000000);
		TextDrawTextSize(MenuPanel[i], 26.000013, 29.866659);
		TextDrawAlignment(MenuPanel[i], 1);
		TextDrawColor(MenuPanel[i], -1);
		TextDrawSetShadow(MenuPanel[i], 0);
		TextDrawSetOutline(MenuPanel[i], 0);
		TextDrawFont(MenuPanel[i], 4);
		TextDrawSetSelectable(MenuPanel[i], true);

		MenuCharacters[i] = TextDrawCreate(362.999938, 193.963027, "hud:radar_modgarage");
		TextDrawLetterSize(MenuCharacters[i], 0.000000, 0.000000);
		TextDrawTextSize(MenuCharacters[i], 26.000013, 29.866659);
		TextDrawAlignment(MenuCharacters[i], 1);
		TextDrawColor(MenuCharacters[i], -1);
		TextDrawSetShadow(MenuCharacters[i], 0);
		TextDrawSetOutline(MenuCharacters[i], 0);
		TextDrawFont(MenuCharacters[i], 4);
		TextDrawSetSelectable(MenuCharacters[i], true);
		
		MenuAdmin[i] = TextDrawCreate(308.999969, 194.133361, "hud:radar_triadscasino");
		TextDrawLetterSize(MenuAdmin[i], 0.000000, 0.000000);
		TextDrawTextSize(MenuAdmin[i], 19.000007, 24.888898);
		TextDrawAlignment(MenuAdmin[i], 1);
		TextDrawColor(MenuAdmin[i], -1);
		TextDrawSetShadow(MenuAdmin[i], 0);
		TextDrawSetOutline(MenuAdmin[i], 0);
		TextDrawFont(MenuAdmin[i], 4);
		TextDrawSetSelectable(MenuAdmin[i], true);		
		
		ChatIndicator[i] = TextDrawCreate(48.366203, 433.311187, "Chat: IC");
		TextDrawLetterSize(ChatIndicator[i], 0.216998, 1.010962);
		TextDrawAlignment(ChatIndicator[i], 1);
		TextDrawColor(ChatIndicator[i], -1);
		TextDrawSetShadow(ChatIndicator[i], 0);
		TextDrawSetOutline(ChatIndicator[i], 1);
		TextDrawBackgroundColor(ChatIndicator[i], 255);
		TextDrawFont(ChatIndicator[i], 2);
		TextDrawSetProportional(ChatIndicator[i], 1);
		TextDrawSetShadow(ChatIndicator[i], 0);


		Cards[0][i] = TextDrawCreate(152.333312, 312.355712, "ld_card:cd1c");
		TextDrawLetterSize(Cards[0][i], 0.000000, 0.000000);
		TextDrawTextSize(Cards[0][i], 61.666664, 90.014762);
		TextDrawAlignment(Cards[0][i], 1);
		TextDrawColor(Cards[0][i], -1);
		TextDrawSetShadow(Cards[0][i], 0);
		TextDrawSetOutline(Cards[0][i], 0);
		TextDrawFont(Cards[0][i], 4);
		TextDrawSetSelectable(Cards[0][i], true);

		Cards[1][i] = TextDrawCreate(222.666595, 311.696472, "ld_card:cd1c");
		TextDrawLetterSize(Cards[1][i], 0.000000, 0.000000);
		TextDrawTextSize(Cards[1][i], 61.666664, 90.014762);
		TextDrawAlignment(Cards[1][i], 1);
		TextDrawColor(Cards[1][i], -1);
		TextDrawSetShadow(Cards[1][i], 0);
		TextDrawSetOutline(Cards[1][i], 0);
		TextDrawFont(Cards[1][i], 4);
		TextDrawSetSelectable(Cards[1][i], true);

		Cards[2][i] = TextDrawCreate(294.666534, 312.281860, "ld_card:cd1c");
		TextDrawLetterSize(Cards[2][i], 0.000000, 0.000000);
		TextDrawTextSize(Cards[2][i], 61.666664, 90.014762);
		TextDrawAlignment(Cards[2][i], 1);
		TextDrawColor(Cards[2][i], -1);
		TextDrawSetShadow(Cards[2][i], 0);
		TextDrawSetOutline(Cards[2][i], 0);
		TextDrawFont(Cards[2][i], 4);
		TextDrawSetSelectable(Cards[2][i], true);

		Cards[3][i] = TextDrawCreate(366.999786, 311.207763, "ld_card:cd1c");
		TextDrawLetterSize(Cards[3][i], 0.000000, 0.000000);
		TextDrawTextSize(Cards[3][i], 61.666664, 90.014762);
		TextDrawAlignment(Cards[3][i], 1);
		TextDrawColor(Cards[3][i], -1);
		TextDrawSetShadow(Cards[3][i], 0);
		TextDrawSetOutline(Cards[3][i], 0);
		TextDrawFont(Cards[3][i], 4);
		TextDrawSetSelectable(Cards[3][i], true);

		Cards[4][i] = TextDrawCreate(439.333251, 310.548461, "ld_card:cd1c");
		TextDrawLetterSize(Cards[4][i], 0.000000, 0.000000);
		TextDrawTextSize(Cards[4][i], 61.666664, 90.014762);
		TextDrawAlignment(Cards[4][i], 1);
		TextDrawColor(Cards[4][i], -1);
		TextDrawSetShadow(Cards[4][i], 0);
		TextDrawSetOutline(Cards[4][i], 0);
		TextDrawFont(Cards[4][i], 4);
		TextDrawSetSelectable(Cards[4][i], true);
		
		MessageBox[i][0] = TextDrawCreate(633.000122, 105.618522, "usebox");
		TextDrawLetterSize(MessageBox[i][0], 0.000000, 8.770157);
		TextDrawTextSize(MessageBox[i][0], 396.000061, 0.000000);
		TextDrawAlignment(MessageBox[i][0], 1);
		TextDrawColor(MessageBox[i][0], 0);
		TextDrawUseBox(MessageBox[i][0], true);
		TextDrawBoxColor(MessageBox[i][0], 153);
		TextDrawSetShadow(MessageBox[i][0], 0);
		TextDrawSetOutline(MessageBox[i][0], 0);
		TextDrawBackgroundColor(MessageBox[i][0], 221);
		TextDrawFont(MessageBox[i][0], 0);

		MessageBox[i][1] = TextDrawCreate(390.666717, 93.748153, "Info");
		TextDrawLetterSize(MessageBox[i][1], 0.449999, 1.600000);
		TextDrawAlignment(MessageBox[i][1], 1);
		TextDrawColor(MessageBox[i][1], -1446714113);
		TextDrawSetShadow(MessageBox[i][1], 0);
		TextDrawSetOutline(MessageBox[i][1], 1);
		TextDrawBackgroundColor(MessageBox[i][1], 51);
		TextDrawFont(MessageBox[i][1], 0);
		TextDrawSetProportional(MessageBox[i][1], 1);

		MessageBox[i][2] = TextDrawCreate(403.333435, 116.148101, "Esta string contém exatamente cento e vinte e oito caracteres, utilizados para transmitir as mensagens de informação na caixita");
		TextDrawLetterSize(MessageBox[i][2], 0.281999, 1.396742);
		TextDrawTextSize(MessageBox[i][2], 629.666809, 12.859254);
		TextDrawAlignment(MessageBox[i][2], 1);
		TextDrawColor(MessageBox[i][2], -1);
		TextDrawUseBox(MessageBox[i][2], true);
		TextDrawBoxColor(MessageBox[i][2], -256);
		TextDrawSetShadow(MessageBox[i][2], 0);
		TextDrawSetOutline(MessageBox[i][2], 1);
		TextDrawBackgroundColor(MessageBox[i][2], 255);
		TextDrawFont(MessageBox[i][2], 2);
		TextDrawSetProportional(MessageBox[i][2], 1);
		
		Panel[i][0] = TextDrawCreate(639.999572, 125.114807, "usebox");
		TextDrawLetterSize(Panel[i][0], 0.000000, 31.991991);
		TextDrawTextSize(Panel[i][0], 486.333374, 0.000000);
		TextDrawAlignment(Panel[i][0], 1);
		TextDrawColor(Panel[i][0], 0);
		TextDrawUseBox(Panel[i][0], true);
		TextDrawBoxColor(Panel[i][0], 170);
		TextDrawSetShadow(Panel[i][0], 0);
		TextDrawSetOutline(Panel[i][0], 0);
		TextDrawFont(Panel[i][0], 0);

		Panel[i][1] = TextDrawCreate(635.666076, 167.425918, "usebox");
		TextDrawLetterSize(Panel[i][1], 0.000000, 26.746715);
		TextDrawTextSize(Panel[i][1], 490.333343, 0.000000);
		TextDrawAlignment(Panel[i][1], 1);
		TextDrawColor(Panel[i][1], 0);
		TextDrawUseBox(Panel[i][1], true);
		TextDrawBoxColor(Panel[i][1], 1431655850);
		TextDrawSetShadow(Panel[i][1], 0);
		TextDrawSetOutline(Panel[i][1], 0);
		TextDrawFont(Panel[i][1], 0);
		TextDrawSetSelectable(Panel[i][1], true);

		Panel[i][2] = TextDrawCreate(635.333007, 167.840835, "usebox");
		TextDrawLetterSize(Panel[i][2], 0.000000, 26.676744);
		TextDrawTextSize(Panel[i][2], 619.999572, 0.000000);
		TextDrawAlignment(Panel[i][2], 1);
		TextDrawColor(Panel[i][2], 0);
		TextDrawUseBox(Panel[i][2], true);
		TextDrawBoxColor(Panel[i][2], 1717986918);
		TextDrawSetShadow(Panel[i][2], 0);
		TextDrawSetOutline(Panel[i][2], 0);
		TextDrawFont(Panel[i][2], 0);

		Panel[i][3] = TextDrawCreate(488.000061, 111.585174, "Painel");
		TextDrawLetterSize(Panel[i][3], 0.449999, 1.600000);
		TextDrawAlignment(Panel[i][3], 1);
		TextDrawColor(Panel[i][3], -1446714113);
		TextDrawSetShadow(Panel[i][3], 0);
		TextDrawSetOutline(Panel[i][3], 1);
		TextDrawBackgroundColor(Panel[i][3], 51);
		TextDrawFont(Panel[i][3], 0);
		TextDrawSetProportional(Panel[i][3], 1);

		Panel[i][4] = TextDrawCreate(563.333251, 142.696350, "vinte e quatro caractere");
		TextDrawLetterSize(Panel[i][4], 0.173333, 0.749628);
		TextDrawTextSize(Panel[i][4], 43.333339, 139.377838);
		TextDrawAlignment(Panel[i][4], 2);
		TextDrawColor(Panel[i][4], -1446714113);
		TextDrawSetShadow(Panel[i][4], 0);
		TextDrawSetOutline(Panel[i][4], 1);
		TextDrawBackgroundColor(Panel[i][4], 51);
		TextDrawFont(Panel[i][4], 2);
		TextDrawSetProportional(Panel[i][4], 1);

		Panel[i][5] = TextDrawCreate(619.999450, 140.207382, "ld_beat:right");
		TextDrawLetterSize(Panel[i][5], 0.000000, 0.000000);
		TextDrawTextSize(Panel[i][5], 13.000000, 13.000000);
		TextDrawAlignment(Panel[i][5], 1);
		TextDrawColor(Panel[i][5], -1);
		TextDrawSetShadow(Panel[i][5], 0);
		TextDrawSetOutline(Panel[i][5], 0);
		TextDrawFont(Panel[i][5], 4);
		TextDrawSetSelectable(Panel[i][5], true);

		Panel[i][6] = TextDrawCreate(492.999908, 139.792602, "ld_beat:left");
		TextDrawLetterSize(Panel[i][6], 0.000000, 0.000000);
		TextDrawTextSize(Panel[i][6], 13.000000, 13.000000);
		TextDrawAlignment(Panel[i][6], 1);
		TextDrawColor(Panel[i][6], -1);
		TextDrawSetShadow(Panel[i][6], 0);
		TextDrawSetOutline(Panel[i][6], 0);
		TextDrawFont(Panel[i][6], 4);
		TextDrawSetProportional(Panel[i][6], 1);
		TextDrawSetSelectable(Panel[i][6], true);

		Panel[i][7] = TextDrawCreate(621.000000, 165.925933, "ld_beat:up");
		TextDrawLetterSize(Panel[i][7], 0.000000, 0.000000);
		TextDrawTextSize(Panel[i][7], 13.000000, 13.000000);
		TextDrawAlignment(Panel[i][7], 1);
		TextDrawColor(Panel[i][7], -1);
		TextDrawSetShadow(Panel[i][7], 0);
		TextDrawSetOutline(Panel[i][7], 0);
		TextDrawFont(Panel[i][7], 4);
		TextDrawSetSelectable(Panel[i][7], true);

		Panel[i][8] = TextDrawCreate(620.999755, 396.977813, "ld_beat:down");
		TextDrawLetterSize(Panel[i][8], 0.000000, 0.000000);
		TextDrawTextSize(Panel[i][8], 13.000000, 13.000000);
		TextDrawAlignment(Panel[i][8], 1);
		TextDrawColor(Panel[i][8], -1);
		TextDrawSetShadow(Panel[i][8], 0);
		TextDrawSetOutline(Panel[i][8], 0);
		TextDrawFont(Panel[i][8], 4);
		TextDrawSetSelectable(Panel[i][8], true);

		Panel[i][9] = TextDrawCreate(618.999877, 106.607383, "ld_chat:thumbdn");
		TextDrawLetterSize(Panel[i][9], 0.000000, 0.000000);
		TextDrawTextSize(Panel[i][9], 21.000000, 21.000000);
		TextDrawAlignment(Panel[i][9], 1);
		TextDrawColor(Panel[i][9], -1);
		TextDrawSetShadow(Panel[i][9], 0);
		TextDrawSetOutline(Panel[i][9], 0);
		TextDrawFont(Panel[i][9], 4);
		TextDrawSetSelectable(Panel[i][9], true);

		Panel[i][10] = TextDrawCreate(494.000213, 168.000122, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][10], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][10], 620.333007, 7.044452);
		TextDrawAlignment(Panel[i][10], 1);
		TextDrawColor(Panel[i][10], -1);
		TextDrawUseBox(Panel[i][10], true);
		TextDrawBoxColor(Panel[i][10], -2013265750);
		TextDrawSetShadow(Panel[i][10], 0);
		TextDrawSetOutline(Panel[i][10], -1);
		TextDrawBackgroundColor(Panel[i][10], 255);
		TextDrawFont(Panel[i][10], 2);
		TextDrawSetProportional(Panel[i][10], 1);
		TextDrawSetSelectable(Panel[i][10], true);

		Panel[i][11] = TextDrawCreate(494.000213, 179.666122, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][11], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][11], 620.333007, 7.044452);
		TextDrawAlignment(Panel[i][11], 1);
		TextDrawColor(Panel[i][11], -1);
		TextDrawUseBox(Panel[i][11], true);
		TextDrawBoxColor(Panel[i][11], -2013265750);
		TextDrawSetShadow(Panel[i][11], 0);
		TextDrawSetOutline(Panel[i][11], -1);
		TextDrawBackgroundColor(Panel[i][11], 255);
		TextDrawFont(Panel[i][11], 2);
		TextDrawSetProportional(Panel[i][11], 1);
		TextDrawSetSelectable(Panel[i][11], true);

		Panel[i][12] = TextDrawCreate(494.000213, 191.332122, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][12], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][12], 620.333007, 7.044452);
		TextDrawAlignment(Panel[i][12], 1);
		TextDrawColor(Panel[i][12], -1);
		TextDrawUseBox(Panel[i][12], true);
		TextDrawBoxColor(Panel[i][12], -2013265750);
		TextDrawSetShadow(Panel[i][12], 0);
		TextDrawSetOutline(Panel[i][12], -1);
		TextDrawBackgroundColor(Panel[i][12], 255);
		TextDrawFont(Panel[i][12], 2);
		TextDrawSetProportional(Panel[i][12], 1);
		TextDrawSetSelectable(Panel[i][12], true);

		Panel[i][13] = TextDrawCreate(494.000213, 202.998123, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][13], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][13], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][13], 1);
		TextDrawColor(Panel[i][13], -1);
		TextDrawUseBox(Panel[i][13], true);
		TextDrawBoxColor(Panel[i][13], -2013265750);
		TextDrawSetShadow(Panel[i][13], 0);
		TextDrawSetOutline(Panel[i][13], -1);
		TextDrawBackgroundColor(Panel[i][13], 255);
		TextDrawFont(Panel[i][13], 2);
		TextDrawSetProportional(Panel[i][13], 1);
		TextDrawSetSelectable(Panel[i][13], true);

		Panel[i][14] = TextDrawCreate(494.000213, 214.664123, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][14], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][14], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][14], 1);
		TextDrawColor(Panel[i][14], -1);
		TextDrawUseBox(Panel[i][14], true);
		TextDrawBoxColor(Panel[i][14], -2013265750);
		TextDrawSetShadow(Panel[i][14], 0);
		TextDrawSetOutline(Panel[i][14], -1);
		TextDrawBackgroundColor(Panel[i][14], 255);
		TextDrawFont(Panel[i][14], 2);
		TextDrawSetProportional(Panel[i][14], 1);
		TextDrawSetSelectable(Panel[i][14], true);

		Panel[i][15] = TextDrawCreate(494.000213, 226.333114, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][15], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][15], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][15], 1);
		TextDrawColor(Panel[i][15], -1);
		TextDrawUseBox(Panel[i][15], true);
		TextDrawBoxColor(Panel[i][15], -2013265750);
		TextDrawSetShadow(Panel[i][15], 0);
		TextDrawSetOutline(Panel[i][15], -1);
		TextDrawBackgroundColor(Panel[i][15], 255);
		TextDrawFont(Panel[i][15], 2);
		TextDrawSetProportional(Panel[i][15], 1);
		TextDrawSetSelectable(Panel[i][15], true);

		Panel[i][16] = TextDrawCreate(494.000213, 237.999114, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][16], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][16], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][16], 1);
		TextDrawColor(Panel[i][16], -1);
		TextDrawUseBox(Panel[i][16], true);
		TextDrawBoxColor(Panel[i][16], -2013265750);
		TextDrawSetShadow(Panel[i][16], 0);
		TextDrawSetOutline(Panel[i][16], -1);
		TextDrawBackgroundColor(Panel[i][16], 255);
		TextDrawFont(Panel[i][16], 2);
		TextDrawSetProportional(Panel[i][16], 1);
		TextDrawSetSelectable(Panel[i][16], true);

		Panel[i][17] = TextDrawCreate(494.000213, 249.665115, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][17], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][17], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][17], 1);
		TextDrawColor(Panel[i][17], -1);
		TextDrawUseBox(Panel[i][17], true);
		TextDrawBoxColor(Panel[i][17], -2013265750);
		TextDrawSetShadow(Panel[i][17], 0);
		TextDrawSetOutline(Panel[i][17], -1);
		TextDrawBackgroundColor(Panel[i][17], 255);
		TextDrawFont(Panel[i][17], 2);
		TextDrawSetProportional(Panel[i][17], 1);
		TextDrawSetSelectable(Panel[i][17], true);

		Panel[i][18] = TextDrawCreate(494.000213, 261.331115, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][18], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][18], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][18], 1);
		TextDrawColor(Panel[i][18], -1);
		TextDrawUseBox(Panel[i][18], true);
		TextDrawBoxColor(Panel[i][18], -2013265750);
		TextDrawSetShadow(Panel[i][18], 0);
		TextDrawSetOutline(Panel[i][18], -1);
		TextDrawBackgroundColor(Panel[i][18], 255);
		TextDrawFont(Panel[i][18], 2);
		TextDrawSetProportional(Panel[i][18], 1);
		TextDrawSetSelectable(Panel[i][18], true);

		Panel[i][19] = TextDrawCreate(494.000213, 272.997131, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][19], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][19], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][19], 1);
		TextDrawColor(Panel[i][19], -1);
		TextDrawUseBox(Panel[i][19], true);
		TextDrawBoxColor(Panel[i][19], -2013265750);
		TextDrawSetShadow(Panel[i][19], 0);
		TextDrawSetOutline(Panel[i][19], -1);
		TextDrawBackgroundColor(Panel[i][19], 255);
		TextDrawFont(Panel[i][19], 2);
		TextDrawSetProportional(Panel[i][19], 1);
		TextDrawSetSelectable(Panel[i][19], true);

		Panel[i][20] = TextDrawCreate(494.000213, 284.663116, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][20], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][20], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][20], 1);
		TextDrawColor(Panel[i][20], -1);
		TextDrawUseBox(Panel[i][20], true);
		TextDrawBoxColor(Panel[i][20], -2013265750);
		TextDrawSetShadow(Panel[i][20], 0);
		TextDrawSetOutline(Panel[i][20], -1);
		TextDrawBackgroundColor(Panel[i][20], 255);
		TextDrawFont(Panel[i][20], 2);
		TextDrawSetProportional(Panel[i][20], 1);
		TextDrawSetSelectable(Panel[i][20], true);

		Panel[i][21] = TextDrawCreate(494.000213, 296.329132, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][21], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][21], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][21], 1);
		TextDrawColor(Panel[i][21], -1);
		TextDrawUseBox(Panel[i][21], true);
		TextDrawBoxColor(Panel[i][21], -2013265750);
		TextDrawSetShadow(Panel[i][21], 0);
		TextDrawSetOutline(Panel[i][21], -1);
		TextDrawBackgroundColor(Panel[i][21], 255);
		TextDrawFont(Panel[i][21], 2);
		TextDrawSetProportional(Panel[i][21], 1);
		TextDrawSetSelectable(Panel[i][21], true);

		Panel[i][22] = TextDrawCreate(494.000213, 307.995117, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][22], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][22], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][22], 1);
		TextDrawColor(Panel[i][22], -1);
		TextDrawUseBox(Panel[i][22], true);
		TextDrawBoxColor(Panel[i][22], -2013265750);
		TextDrawSetShadow(Panel[i][22], 0);
		TextDrawSetOutline(Panel[i][22], -1);
		TextDrawBackgroundColor(Panel[i][22], 255);
		TextDrawFont(Panel[i][22], 2);
		TextDrawSetProportional(Panel[i][22], 1);
		TextDrawSetSelectable(Panel[i][22], true);

		Panel[i][23] = TextDrawCreate(494.000213, 319.661132, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][23], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][23], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][23], 1);
		TextDrawColor(Panel[i][23], -1);
		TextDrawUseBox(Panel[i][23], true);
		TextDrawBoxColor(Panel[i][23], -2013265750);
		TextDrawSetShadow(Panel[i][23], 0);
		TextDrawSetOutline(Panel[i][23], -1);
		TextDrawBackgroundColor(Panel[i][23], 255);
		TextDrawFont(Panel[i][23], 2);
		TextDrawSetProportional(Panel[i][23], 1);
		TextDrawSetSelectable(Panel[i][23], true);

		Panel[i][24] = TextDrawCreate(494.000213, 331.327117, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][24], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][24], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][24], 1);
		TextDrawColor(Panel[i][24], -1);
		TextDrawUseBox(Panel[i][24], true);
		TextDrawBoxColor(Panel[i][24], -2013265750);
		TextDrawSetShadow(Panel[i][24], 0);
		TextDrawSetOutline(Panel[i][24], -1);
		TextDrawBackgroundColor(Panel[i][24], 255);
		TextDrawFont(Panel[i][24], 2);
		TextDrawSetProportional(Panel[i][24], 1);
		TextDrawSetSelectable(Panel[i][24], true);

		Panel[i][25] = TextDrawCreate(494.000213, 342.993133, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][25], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][25], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][25], 1);
		TextDrawColor(Panel[i][25], -1);
		TextDrawUseBox(Panel[i][25], true);
		TextDrawBoxColor(Panel[i][25], -2013265750);
		TextDrawSetShadow(Panel[i][25], 0);
		TextDrawSetOutline(Panel[i][25], -1);
		TextDrawBackgroundColor(Panel[i][25], 255);
		TextDrawFont(Panel[i][25], 2);
		TextDrawSetProportional(Panel[i][25], 1);
		TextDrawSetSelectable(Panel[i][25], true);

		Panel[i][26] = TextDrawCreate(494.000213, 354.659118, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][26], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][26], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][26], 1);
		TextDrawColor(Panel[i][26], -1);
		TextDrawUseBox(Panel[i][26], true);
		TextDrawBoxColor(Panel[i][26], -2013265750);
		TextDrawSetShadow(Panel[i][26], 0);
		TextDrawSetOutline(Panel[i][26], -1);
		TextDrawBackgroundColor(Panel[i][26], 255);
		TextDrawFont(Panel[i][26], 2);
		TextDrawSetProportional(Panel[i][26], 1);
		TextDrawSetSelectable(Panel[i][26], true);

		Panel[i][27] = TextDrawCreate(494.000213, 366.325134, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][27], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][27], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][27], 1);
		TextDrawColor(Panel[i][27], -1);
		TextDrawUseBox(Panel[i][27], true);
		TextDrawBoxColor(Panel[i][27], -2013265750);
		TextDrawSetShadow(Panel[i][27], 0);
		TextDrawSetOutline(Panel[i][27], -1);
		TextDrawBackgroundColor(Panel[i][27], 255);
		TextDrawFont(Panel[i][27], 2);
		TextDrawSetProportional(Panel[i][27], 1);
		TextDrawSetSelectable(Panel[i][27], true);

		Panel[i][28] = TextDrawCreate(494.000213, 377.991119, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][28], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][28], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][28], 1);
		TextDrawColor(Panel[i][28], -1);
		TextDrawUseBox(Panel[i][28], true);
		TextDrawBoxColor(Panel[i][28], -2013265750);
		TextDrawSetShadow(Panel[i][28], 0);
		TextDrawSetOutline(Panel[i][28], -1);
		TextDrawBackgroundColor(Panel[i][28], 255);
		TextDrawFont(Panel[i][28], 2);
		TextDrawSetProportional(Panel[i][28], 1);
		TextDrawSetSelectable(Panel[i][28], true);

		Panel[i][29] = TextDrawCreate(494.000213, 389.657135, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][29], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][29], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][29], 1);
		TextDrawColor(Panel[i][29], -1);
		TextDrawUseBox(Panel[i][29], true);
		TextDrawBoxColor(Panel[i][29], -2013265750);
		TextDrawSetShadow(Panel[i][29], 0);
		TextDrawSetOutline(Panel[i][29], -1);
		TextDrawBackgroundColor(Panel[i][29], 255);
		TextDrawFont(Panel[i][29], 2);
		TextDrawSetProportional(Panel[i][29], 1);
		TextDrawSetSelectable(Panel[i][29], true);

		Panel[i][30] = TextDrawCreate(494.000213, 401.323120, "quarenta e oito caracteres pra ver se cabe okay");
		TextDrawLetterSize(Panel[i][30], 0.117333, 0.737185);
		TextDrawTextSize(Panel[i][30], 620.333007, 7.00000);
		TextDrawAlignment(Panel[i][30], 1);
		TextDrawColor(Panel[i][30], -1);
		TextDrawUseBox(Panel[i][30], true);
		TextDrawBoxColor(Panel[i][30], -2013265750);
		TextDrawSetShadow(Panel[i][30], 0);
		TextDrawSetOutline(Panel[i][30], -1);
		TextDrawBackgroundColor(Panel[i][30], 255);
		TextDrawFont(Panel[i][30], 2);
		TextDrawSetProportional(Panel[i][30], 1);
		TextDrawSetSelectable(Panel[i][30], true);
		
		InfoBox[i][0] = TextDrawCreate(486.333160, 128.433349, "usebox");
		TextDrawLetterSize(InfoBox[i][0], 0.000000, 32.815841);
		TextDrawTextSize(InfoBox[i][0], 144.666717, 0.000000);
		TextDrawAlignment(InfoBox[i][0], 1);
		TextDrawColor(InfoBox[i][0], 0);
		TextDrawUseBox(InfoBox[i][0], true);
		TextDrawBoxColor(InfoBox[i][0], 143);
		TextDrawSetShadow(InfoBox[i][0], 0);
		TextDrawSetOutline(InfoBox[i][0], 0);
		TextDrawFont(InfoBox[i][0], 0);

		InfoBox[i][1] = TextDrawCreate(143.333374, 116.977767, "Info");
		TextDrawLetterSize(InfoBox[i][1], 0.449999, 1.600000);
		TextDrawAlignment(InfoBox[i][1], 1);
		TextDrawColor(InfoBox[i][1], -1446714113);
		TextDrawSetShadow(InfoBox[i][1], 0);
		TextDrawSetOutline(InfoBox[i][1], 2);
		TextDrawBackgroundColor(InfoBox[i][1], 255);
		TextDrawFont(InfoBox[i][1], 0);
		TextDrawSetProportional(InfoBox[i][1], 1);

		InfoBox[i][2] = TextDrawCreate(480.333465, 135.070404, "usebox");
		TextDrawLetterSize(InfoBox[i][2], 0.000000, 31.392393);
		TextDrawTextSize(InfoBox[i][2], 149.999984, 0.000000);
		TextDrawAlignment(InfoBox[i][2], 1);
		TextDrawColor(InfoBox[i][2], 0);
		TextDrawUseBox(InfoBox[i][2], true);
		TextDrawBoxColor(InfoBox[i][2], 1717986918);
		TextDrawSetShadow(InfoBox[i][2], 0);
		TextDrawSetOutline(InfoBox[i][2], 0);
		TextDrawFont(InfoBox[i][2], 0);

		InfoBox[i][3] = TextDrawCreate(153.666748, 135.000000, "Titulo de 24 caracteres");
		TextDrawLetterSize(InfoBox[i][3], 0.389999, 1.268146);
		TextDrawAlignment(InfoBox[i][3], 1);
		TextDrawColor(InfoBox[i][3], -1029514497);
		TextDrawSetShadow(InfoBox[i][3], 0);
		TextDrawSetOutline(InfoBox[i][3], 1);
		TextDrawBackgroundColor(InfoBox[i][3], 255);
		TextDrawFont(InfoBox[i][3], 3);
		TextDrawSetProportional(InfoBox[i][3], 1);

		InfoBox[i][4] = TextDrawCreate(160.999984, 152.000000, "preciso de cento e vinte e oito caracteres por linha para ter certeza de que o box vai mostrar uma mensagem grande e dahora");
		TextDrawLetterSize(InfoBox[i][4], 0.213331, 1.052443);
		TextDrawTextSize(InfoBox[i][4], 469.666717, -5.392590);
		TextDrawAlignment(InfoBox[i][4], 1);
		TextDrawColor(InfoBox[i][4], -1);
		TextDrawUseBox(InfoBox[i][4], true);
		TextDrawBoxColor(InfoBox[i][4], 0);
		TextDrawSetShadow(InfoBox[i][4], 0);
		TextDrawSetOutline(InfoBox[i][4], 1);
		TextDrawBackgroundColor(InfoBox[i][4], 255);
		TextDrawFont(InfoBox[i][4], 2);
		TextDrawSetProportional(InfoBox[i][4], 1);

		InfoBox[i][5] = TextDrawCreate(153.666748, 191.000000, "Titulo de 24 caracteres");
		TextDrawLetterSize(InfoBox[i][5], 0.389999, 1.268146);
		TextDrawAlignment(InfoBox[i][5], 1);
		TextDrawColor(InfoBox[i][5], -1029514497);
		TextDrawSetShadow(InfoBox[i][5], 0);
		TextDrawSetOutline(InfoBox[i][5], 1);
		TextDrawBackgroundColor(InfoBox[i][5], 51);
		TextDrawFont(InfoBox[i][5], 3);
		TextDrawSetProportional(InfoBox[i][5], 1);

		InfoBox[i][6] = TextDrawCreate(160.999984, 208.000000, "preciso de cento e vinte e oito caracteres por linha para ter certeza de que o box vai mostrar uma mensagem grande e dahora");
		TextDrawLetterSize(InfoBox[i][6], 0.213331, 1.052443);
		TextDrawTextSize(InfoBox[i][6], 469.666717, -5.392590);
		TextDrawAlignment(InfoBox[i][6], 1);
		TextDrawColor(InfoBox[i][6], -1);
		TextDrawUseBox(InfoBox[i][6], true);
		TextDrawBoxColor(InfoBox[i][6], 0);
		TextDrawSetShadow(InfoBox[i][6], 0);
		TextDrawSetOutline(InfoBox[i][6], 1);
		TextDrawBackgroundColor(InfoBox[i][6], 255);
		TextDrawFont(InfoBox[i][6], 2);
		TextDrawSetProportional(InfoBox[i][6], 1);

		InfoBox[i][7] = TextDrawCreate(153.666748, 247.000000, "Titulo de 24 caracteres");
		TextDrawLetterSize(InfoBox[i][7], 0.389999, 1.268146);
		TextDrawAlignment(InfoBox[i][7], 1);
		TextDrawColor(InfoBox[i][7], -1029514497);
		TextDrawSetShadow(InfoBox[i][7], 0);
		TextDrawSetOutline(InfoBox[i][7], 1);
		TextDrawBackgroundColor(InfoBox[i][7], 51);
		TextDrawFont(InfoBox[i][7], 3);
		TextDrawSetProportional(InfoBox[i][7], 1);

		InfoBox[i][8] = TextDrawCreate(160.999984, 264.000000, "preciso de cento e vinte e oito caracteres por linha para ter certeza de que o box vai mostrar uma mensagem grande e dahora");
		TextDrawLetterSize(InfoBox[i][8], 0.213331, 1.052443);
		TextDrawTextSize(InfoBox[i][8], 469.666717, -5.392590);
		TextDrawAlignment(InfoBox[i][8], 1);
		TextDrawColor(InfoBox[i][8], -1);
		TextDrawUseBox(InfoBox[i][8], true);
		TextDrawBoxColor(InfoBox[i][8], 0);
		TextDrawSetShadow(InfoBox[i][8], 0);
		TextDrawSetOutline(InfoBox[i][8], 1);
		TextDrawBackgroundColor(InfoBox[i][8], 255);
		TextDrawFont(InfoBox[i][8], 2);
		TextDrawSetProportional(InfoBox[i][8], 1);

		InfoBox[i][9] = TextDrawCreate(153.666748, 303.000000, "Titulo de 24 caracteres");
		TextDrawLetterSize(InfoBox[i][9], 0.389999, 1.268146);
		TextDrawAlignment(InfoBox[i][9], 1);
		TextDrawColor(InfoBox[i][9], -1029514497);
		TextDrawSetShadow(InfoBox[i][9], 0);
		TextDrawSetOutline(InfoBox[i][9], 1);
		TextDrawBackgroundColor(InfoBox[i][9], 51);
		TextDrawFont(InfoBox[i][9], 3);
		TextDrawSetProportional(InfoBox[i][9], 1);

		InfoBox[i][10] = TextDrawCreate(160.999984, 320.000000, "preciso de cento e vinte e oito caracteres por linha para ter certeza de que o box vai mostrar uma mensagem grande e dahora");
		TextDrawLetterSize(InfoBox[i][10], 0.213331, 1.052443);
		TextDrawTextSize(InfoBox[i][10], 469.666717, -5.392590);
		TextDrawAlignment(InfoBox[i][10], 1);
		TextDrawColor(InfoBox[i][10], -1);
		TextDrawUseBox(InfoBox[i][10], true);
		TextDrawBoxColor(InfoBox[i][10], 0);
		TextDrawSetShadow(InfoBox[i][10], 0);
		TextDrawSetOutline(InfoBox[i][10], 1);
		TextDrawBackgroundColor(InfoBox[i][10], 255);
		TextDrawFont(InfoBox[i][10], 2);
		TextDrawSetProportional(InfoBox[i][10], 1);

		InfoBox[i][11] = TextDrawCreate(153.666748, 359.000000, "Titulo de 24 caracteres");
		TextDrawLetterSize(InfoBox[i][11], 0.389999, 1.268146);
		TextDrawAlignment(InfoBox[i][11], 1);
		TextDrawColor(InfoBox[i][11], -1029514497);
		TextDrawSetShadow(InfoBox[i][11], 0);
		TextDrawSetOutline(InfoBox[i][11], 1);
		TextDrawBackgroundColor(InfoBox[i][11], 51);
		TextDrawFont(InfoBox[i][11], 3);
		TextDrawSetProportional(InfoBox[i][11], 1);

		InfoBox[i][12] = TextDrawCreate(160.999984, 376.000000, "preciso de cento e vinte e oito caracteres por linha para ter certeza de que o box vai mostrar uma mensagem grande e dahora");
		TextDrawLetterSize(InfoBox[i][12], 0.213331, 1.052443);
		TextDrawTextSize(InfoBox[i][12], 469.666717, -5.392590);
		TextDrawAlignment(InfoBox[i][12], 1);
		TextDrawColor(InfoBox[i][12], -1);
		TextDrawUseBox(InfoBox[i][12], true);
		TextDrawBoxColor(InfoBox[i][12], 0);
		TextDrawSetShadow(InfoBox[i][12], 0);
		TextDrawSetOutline(InfoBox[i][12], 1);
		TextDrawBackgroundColor(InfoBox[i][12], 255);
		TextDrawFont(InfoBox[i][12], 2);
		TextDrawSetProportional(InfoBox[i][12], 1);

		InfoBox[i][13] = TextDrawCreate(471.333374, 115.318511, "ld_chat:thumbdn");
		TextDrawLetterSize(InfoBox[i][13], 0.000000, 0.000000);
		TextDrawTextSize(InfoBox[i][13], 25.000000, 25.000000);
		TextDrawAlignment(InfoBox[i][13], 1);
		TextDrawColor(InfoBox[i][13], -1);
		TextDrawSetShadow(InfoBox[i][13], 0);
		TextDrawSetOutline(InfoBox[i][13], 0);
		TextDrawFont(InfoBox[i][13], 4);
		TextDrawSetSelectable(InfoBox[i][13], true);
		
		RegisterText[i][0] = TextDrawCreate(170.666625, 120.551849, "usebox");
		TextDrawLetterSize(RegisterText[i][0], 0.000000, 24.000000);
		TextDrawTextSize(RegisterText[i][0], 6.666666, 0.000000);
		TextDrawAlignment(RegisterText[i][0], 1);
		TextDrawColor(RegisterText[i][0], 0);
		TextDrawUseBox(RegisterText[i][0], true);
		TextDrawBoxColor(RegisterText[i][0], 146);
		TextDrawSetShadow(RegisterText[i][0], 0);
		TextDrawSetOutline(RegisterText[i][0], 0);
		TextDrawFont(RegisterText[i][0], 0);

		RegisterText[i][1] = TextDrawCreate(628.000427, 120.136993, "usebox");
		TextDrawLetterSize(RegisterText[i][1], 0.000000, 24.000000);
		TextDrawTextSize(RegisterText[i][1], 468.666503, 0.000000);
		TextDrawAlignment(RegisterText[i][1], 1);
		TextDrawColor(RegisterText[i][1], 0);
		TextDrawUseBox(RegisterText[i][1], true);
		TextDrawBoxColor(RegisterText[i][1], 102);
		TextDrawSetShadow(RegisterText[i][1], 0);
		TextDrawSetOutline(RegisterText[i][1], 0);
		TextDrawFont(RegisterText[i][1], 0);
		
		format(string, 64, "Aparência");
		convert_encoding(string);

		RegisterText[i][2] = TextDrawCreate(4.333361, 107.437019, string);
		TextDrawLetterSize(RegisterText[i][2], 0.449999, 1.600000);
		TextDrawAlignment(RegisterText[i][2], 1);
		TextDrawColor(RegisterText[i][2], -1029514497);
		TextDrawSetShadow(RegisterText[i][2], 0);
		TextDrawSetOutline(RegisterText[i][2], 1);
		TextDrawBackgroundColor(RegisterText[i][2], 255);
		TextDrawFont(RegisterText[i][2], 0);
		TextDrawSetProportional(RegisterText[i][2], 1);
		
		format(string, 64, "Informações");
		convert_encoding(string);

		RegisterText[i][3] = TextDrawCreate(463.333435, 104.948143, string);
		TextDrawLetterSize(RegisterText[i][3], 0.449999, 1.600000);
		TextDrawAlignment(RegisterText[i][3], 1);
		TextDrawColor(RegisterText[i][3], -1029514497);
		TextDrawSetShadow(RegisterText[i][3], 0);
		TextDrawSetOutline(RegisterText[i][3], 1);
		TextDrawBackgroundColor(RegisterText[i][3], 255);
		TextDrawFont(RegisterText[i][3], 0);
		TextDrawSetProportional(RegisterText[i][3], 1);

		RegisterText[i][4] = TextDrawCreate(90.000000, 138.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][4], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][4], 2);
		TextDrawColor(RegisterText[i][4], 257552383);
		TextDrawSetShadow(RegisterText[i][4], 0);
		TextDrawSetOutline(RegisterText[i][4], 1);
		TextDrawBackgroundColor(RegisterText[i][4], 255);
		TextDrawFont(RegisterText[i][4], 3);
		TextDrawSetProportional(RegisterText[i][4], 1);

		RegisterText[i][5] = TextDrawCreate(90.000000, 126.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][5], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][5], 2);
		TextDrawColor(RegisterText[i][5], -1);
		TextDrawSetShadow(RegisterText[i][5], 0);
		TextDrawSetOutline(RegisterText[i][5], 1);
		TextDrawBackgroundColor(RegisterText[i][5], 51);
		TextDrawFont(RegisterText[i][5], 2);
		TextDrawSetProportional(RegisterText[i][5], 1);

		RegisterText[i][6] = TextDrawCreate(12.000000, 136.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][6], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][6], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][6], 1);
		TextDrawColor(RegisterText[i][6], -1);
		TextDrawSetShadow(RegisterText[i][6], 0);
		TextDrawSetOutline(RegisterText[i][6], 0);
		TextDrawFont(RegisterText[i][6], 4);
		TextDrawSetSelectable(RegisterText[i][6], true);

		RegisterText[i][7] = TextDrawCreate(153.000000, 136.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][7], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][7], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][7], 1);
		TextDrawColor(RegisterText[i][7], -1);
		TextDrawSetShadow(RegisterText[i][7], 0);
		TextDrawSetOutline(RegisterText[i][7], 0);
		TextDrawFont(RegisterText[i][7], 4);
		TextDrawSetSelectable(RegisterText[i][7], true);

		RegisterText[i][8] = TextDrawCreate(90.000000, 172.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][8], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][8], 2);
		TextDrawColor(RegisterText[i][8], 257552383);
		TextDrawSetShadow(RegisterText[i][8], 0);
		TextDrawSetOutline(RegisterText[i][8], 1);
		TextDrawBackgroundColor(RegisterText[i][8], 255);
		TextDrawFont(RegisterText[i][8], 3);
		TextDrawSetProportional(RegisterText[i][8], 1);

		RegisterText[i][9] = TextDrawCreate(90.000000, 160.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][9], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][9], 2);
		TextDrawColor(RegisterText[i][9], -1);
		TextDrawSetShadow(RegisterText[i][9], 0);
		TextDrawSetOutline(RegisterText[i][9], 1);
		TextDrawBackgroundColor(RegisterText[i][9], 51);
		TextDrawFont(RegisterText[i][9], 2);
		TextDrawSetProportional(RegisterText[i][9], 1);

		RegisterText[i][10] = TextDrawCreate(12.000000, 170.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][10], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][10], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][10], 1);
		TextDrawColor(RegisterText[i][10], -1);
		TextDrawSetShadow(RegisterText[i][10], 0);
		TextDrawSetOutline(RegisterText[i][10], 0);
		TextDrawFont(RegisterText[i][10], 4);
		TextDrawSetSelectable(RegisterText[i][10], true);

		RegisterText[i][11] = TextDrawCreate(153.000000, 170.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][11], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][11], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][11], 1);
		TextDrawColor(RegisterText[i][11], -1);
		TextDrawSetShadow(RegisterText[i][11], 0);
		TextDrawSetOutline(RegisterText[i][11], 0);
		TextDrawFont(RegisterText[i][11], 4);
		TextDrawSetSelectable(RegisterText[i][11], true);

		RegisterText[i][12] = TextDrawCreate(90.000000, 206.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][12], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][12], 2);
		TextDrawColor(RegisterText[i][12], 257552383);
		TextDrawSetShadow(RegisterText[i][12], 0);
		TextDrawSetOutline(RegisterText[i][12], 1);
		TextDrawBackgroundColor(RegisterText[i][12], 255);
		TextDrawFont(RegisterText[i][12], 3);
		TextDrawSetProportional(RegisterText[i][12], 1);

		RegisterText[i][13] = TextDrawCreate(90.000000, 194.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][13], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][13], 2);
		TextDrawColor(RegisterText[i][13], -1);
		TextDrawSetShadow(RegisterText[i][13], 0);
		TextDrawSetOutline(RegisterText[i][13], 1);
		TextDrawBackgroundColor(RegisterText[i][13], 51);
		TextDrawFont(RegisterText[i][13], 2);
		TextDrawSetProportional(RegisterText[i][13], 1);

		RegisterText[i][14] = TextDrawCreate(12.000000, 204.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][14], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][14], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][14], 1);
		TextDrawColor(RegisterText[i][14], -1);
		TextDrawSetShadow(RegisterText[i][14], 0);
		TextDrawSetOutline(RegisterText[i][14], 0);
		TextDrawFont(RegisterText[i][14], 4);
		TextDrawSetSelectable(RegisterText[i][14], true);

		RegisterText[i][15] = TextDrawCreate(153.000000, 204.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][15], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][15], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][15], 1);
		TextDrawColor(RegisterText[i][15], -1);
		TextDrawSetShadow(RegisterText[i][15], 0);
		TextDrawSetOutline(RegisterText[i][15], 0);
		TextDrawFont(RegisterText[i][15], 4);
		TextDrawSetSelectable(RegisterText[i][15], true);

		RegisterText[i][16] = TextDrawCreate(90.000000, 240.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][16], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][16], 2);
		TextDrawColor(RegisterText[i][16], 257552383);
		TextDrawSetShadow(RegisterText[i][16], 0);
		TextDrawSetOutline(RegisterText[i][16], 1);
		TextDrawBackgroundColor(RegisterText[i][16], 255);
		TextDrawFont(RegisterText[i][16], 3);
		TextDrawSetProportional(RegisterText[i][16], 1);

		RegisterText[i][17] = TextDrawCreate(90.000000, 228.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][17], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][17], 2);
		TextDrawColor(RegisterText[i][17], -1);
		TextDrawSetShadow(RegisterText[i][17], 0);
		TextDrawSetOutline(RegisterText[i][17], 1);
		TextDrawBackgroundColor(RegisterText[i][17], 51);
		TextDrawFont(RegisterText[i][17], 2);
		TextDrawSetProportional(RegisterText[i][17], 1);

		RegisterText[i][18] = TextDrawCreate(12.000000, 238.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][18], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][18], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][18], 1);
		TextDrawColor(RegisterText[i][18], -1);
		TextDrawSetShadow(RegisterText[i][18], 0);
		TextDrawSetOutline(RegisterText[i][18], 0);
		TextDrawFont(RegisterText[i][18], 4);
		TextDrawSetSelectable(RegisterText[i][18], true);

		RegisterText[i][19] = TextDrawCreate(153.000000, 238.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][19], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][19], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][19], 1);
		TextDrawColor(RegisterText[i][19], -1);
		TextDrawSetShadow(RegisterText[i][19], 0);
		TextDrawSetOutline(RegisterText[i][19], 0);
		TextDrawFont(RegisterText[i][19], 4);
		TextDrawSetSelectable(RegisterText[i][19], true);

		RegisterText[i][20] = TextDrawCreate(90.000000, 274.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][20], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][20], 2);
		TextDrawColor(RegisterText[i][20], 257552383);
		TextDrawSetShadow(RegisterText[i][20], 0);
		TextDrawSetOutline(RegisterText[i][20], 1);
		TextDrawBackgroundColor(RegisterText[i][20], 255);
		TextDrawFont(RegisterText[i][20], 3);
		TextDrawSetProportional(RegisterText[i][20], 1);

		RegisterText[i][21] = TextDrawCreate(90.000000, 262.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][21], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][21], 2);
		TextDrawColor(RegisterText[i][21], -1);
		TextDrawSetShadow(RegisterText[i][21], 0);
		TextDrawSetOutline(RegisterText[i][21], 1);
		TextDrawBackgroundColor(RegisterText[i][21], 51);
		TextDrawFont(RegisterText[i][21], 2);
		TextDrawSetProportional(RegisterText[i][21], 1);

		RegisterText[i][22] = TextDrawCreate(12.000000, 272.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][22], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][22], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][22], 1);
		TextDrawColor(RegisterText[i][22], -1);
		TextDrawSetShadow(RegisterText[i][22], 0);
		TextDrawSetOutline(RegisterText[i][22], 0);
		TextDrawFont(RegisterText[i][22], 4);
		TextDrawSetSelectable(RegisterText[i][22], true);

		RegisterText[i][23] = TextDrawCreate(153.000000, 272.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][23], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][23], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][23], 1);
		TextDrawColor(RegisterText[i][23], -1);
		TextDrawSetShadow(RegisterText[i][23], 0);
		TextDrawSetOutline(RegisterText[i][23], 0);
		TextDrawFont(RegisterText[i][23], 4);
		TextDrawSetSelectable(RegisterText[i][23], true);

		RegisterText[i][24] = TextDrawCreate(90.000000, 308.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][24], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][24], 2);
		TextDrawColor(RegisterText[i][24], 257552383);
		TextDrawSetShadow(RegisterText[i][24], 0);
		TextDrawSetOutline(RegisterText[i][24], 1);
		TextDrawBackgroundColor(RegisterText[i][24], 255);
		TextDrawFont(RegisterText[i][24], 3);
		TextDrawSetProportional(RegisterText[i][24], 1);

		RegisterText[i][25] = TextDrawCreate(90.000000, 296.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][25], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][25], 2);
		TextDrawColor(RegisterText[i][25], -1);
		TextDrawSetShadow(RegisterText[i][25], 0);
		TextDrawSetOutline(RegisterText[i][25], 1);
		TextDrawBackgroundColor(RegisterText[i][25], 51);
		TextDrawFont(RegisterText[i][25], 2);
		TextDrawSetProportional(RegisterText[i][25], 1);

		RegisterText[i][26] = TextDrawCreate(12.000000, 306.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][26], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][26], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][26], 1);
		TextDrawColor(RegisterText[i][26], -1);
		TextDrawSetShadow(RegisterText[i][26], 0);
		TextDrawSetOutline(RegisterText[i][26], 0);
		TextDrawFont(RegisterText[i][26], 4);
		TextDrawSetSelectable(RegisterText[i][26], true);

		RegisterText[i][27] = TextDrawCreate(153.000000, 306.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][27], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][27], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][27], 1);
		TextDrawColor(RegisterText[i][27], -1);
		TextDrawSetShadow(RegisterText[i][27], 0);
		TextDrawSetOutline(RegisterText[i][27], 0);
		TextDrawFont(RegisterText[i][27], 4);
		TextDrawSetSelectable(RegisterText[i][27], true);

		RegisterText[i][28] = TextDrawCreate(550.000000, 138.000000, "itemns de 24 informação");
		TextDrawLetterSize(RegisterText[i][28], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][28], 2);
		TextDrawColor(RegisterText[i][28], 257552383);
		TextDrawSetShadow(RegisterText[i][28], 0);
		TextDrawSetOutline(RegisterText[i][28], 1);
		TextDrawBackgroundColor(RegisterText[i][28], 255);
		TextDrawFont(RegisterText[i][28], 3);
		TextDrawSetProportional(RegisterText[i][28], 1);

		RegisterText[i][29] = TextDrawCreate(550.000000, 126.000000, "Titulo de 24 informação");
		TextDrawLetterSize(RegisterText[i][29], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][29], 2);
		TextDrawColor(RegisterText[i][29], -1);
		TextDrawSetShadow(RegisterText[i][29], 0);
		TextDrawSetOutline(RegisterText[i][29], 1);
		TextDrawBackgroundColor(RegisterText[i][29], 51);
		TextDrawFont(RegisterText[i][29], 2);
		TextDrawSetProportional(RegisterText[i][29], 1);

		RegisterText[i][30] = TextDrawCreate(472.000000, 136.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][30], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][30], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][30], 1);
		TextDrawColor(RegisterText[i][30], -1);
		TextDrawSetShadow(RegisterText[i][30], 0);
		TextDrawSetOutline(RegisterText[i][30], 0);
		TextDrawFont(RegisterText[i][30], 4);
		TextDrawSetSelectable(RegisterText[i][30], true);

		RegisterText[i][31] = TextDrawCreate(613.000000, 136.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][31], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][31], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][31], 1);
		TextDrawColor(RegisterText[i][31], -1);
		TextDrawSetShadow(RegisterText[i][31], 0);
		TextDrawSetOutline(RegisterText[i][31], 0);
		TextDrawFont(RegisterText[i][31], 4);
		TextDrawSetSelectable(RegisterText[i][31], true);

		RegisterText[i][32] = TextDrawCreate(550.000000, 172.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][32], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][32], 2);
		TextDrawColor(RegisterText[i][32], 257552383);
		TextDrawSetShadow(RegisterText[i][32], 0);
		TextDrawSetOutline(RegisterText[i][32], 1);
		TextDrawBackgroundColor(RegisterText[i][32], 255);
		TextDrawFont(RegisterText[i][32], 3);
		TextDrawSetProportional(RegisterText[i][32], 1);

		RegisterText[i][33] = TextDrawCreate(550.000000, 160.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][33], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][33], 2);
		TextDrawColor(RegisterText[i][33], -1);
		TextDrawSetShadow(RegisterText[i][33], 0);
		TextDrawSetOutline(RegisterText[i][33], 1);
		TextDrawBackgroundColor(RegisterText[i][33], 51);
		TextDrawFont(RegisterText[i][33], 2);
		TextDrawSetProportional(RegisterText[i][33], 1);

		RegisterText[i][34] = TextDrawCreate(472.000000, 170.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][34], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][34], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][34], 1);
		TextDrawColor(RegisterText[i][34], -1);
		TextDrawSetShadow(RegisterText[i][34], 0);
		TextDrawSetOutline(RegisterText[i][34], 0);
		TextDrawFont(RegisterText[i][34], 4);
		TextDrawSetSelectable(RegisterText[i][34], true);

		RegisterText[i][35] = TextDrawCreate(613.000000, 170.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][35], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][35], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][35], 1);
		TextDrawColor(RegisterText[i][35], -1);
		TextDrawSetShadow(RegisterText[i][35], 0);
		TextDrawSetOutline(RegisterText[i][35], 0);
		TextDrawFont(RegisterText[i][35], 4);
		TextDrawSetSelectable(RegisterText[i][35], true);

		RegisterText[i][36] = TextDrawCreate(550.000000, 206.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][36], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][36], 2);
		TextDrawColor(RegisterText[i][36], 257552383);
		TextDrawSetShadow(RegisterText[i][36], 0);
		TextDrawSetOutline(RegisterText[i][36], 1);
		TextDrawBackgroundColor(RegisterText[i][36], 255);
		TextDrawFont(RegisterText[i][36], 3);
		TextDrawSetProportional(RegisterText[i][36], 1);

		RegisterText[i][37] = TextDrawCreate(550.000000, 194.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][37], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][37], 2);
		TextDrawColor(RegisterText[i][37], -1);
		TextDrawSetShadow(RegisterText[i][37], 0);
		TextDrawSetOutline(RegisterText[i][37], 1);
		TextDrawBackgroundColor(RegisterText[i][37], 51);
		TextDrawFont(RegisterText[i][37], 2);
		TextDrawSetProportional(RegisterText[i][37], 1);

		RegisterText[i][38] = TextDrawCreate(472.000000, 204.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][38], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][38], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][38], 1);
		TextDrawColor(RegisterText[i][38], -1);
		TextDrawSetShadow(RegisterText[i][38], 0);
		TextDrawSetOutline(RegisterText[i][38], 0);
		TextDrawFont(RegisterText[i][38], 4);
		TextDrawSetSelectable(RegisterText[i][38], true);

		RegisterText[i][39] = TextDrawCreate(613.000000, 204.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][39], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][39], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][39], 1);
		TextDrawColor(RegisterText[i][39], -1);
		TextDrawSetShadow(RegisterText[i][39], 0);
		TextDrawSetOutline(RegisterText[i][39], 0);
		TextDrawFont(RegisterText[i][39], 4);
		TextDrawSetSelectable(RegisterText[i][39], true);

		RegisterText[i][40] = TextDrawCreate(550.000000, 240.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][40], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][40], 2);
		TextDrawColor(RegisterText[i][40], 257552383);
		TextDrawSetShadow(RegisterText[i][40], 0);
		TextDrawSetOutline(RegisterText[i][40], 1);
		TextDrawBackgroundColor(RegisterText[i][40], 255);
		TextDrawFont(RegisterText[i][40], 3);
		TextDrawSetProportional(RegisterText[i][40], 1);

		RegisterText[i][41] = TextDrawCreate(550.000000, 228.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][41], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][41], 2);
		TextDrawColor(RegisterText[i][41], -1);
		TextDrawSetShadow(RegisterText[i][41], 0);
		TextDrawSetOutline(RegisterText[i][41], 1);
		TextDrawBackgroundColor(RegisterText[i][41], 51);
		TextDrawFont(RegisterText[i][41], 2);
		TextDrawSetProportional(RegisterText[i][41], 1);

		RegisterText[i][42] = TextDrawCreate(472.000000, 238.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][42], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][42], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][42], 1);
		TextDrawColor(RegisterText[i][42], -1);
		TextDrawSetShadow(RegisterText[i][42], 0);
		TextDrawSetOutline(RegisterText[i][42], 0);
		TextDrawFont(RegisterText[i][42], 4);
		TextDrawSetSelectable(RegisterText[i][42], true);

		RegisterText[i][43] = TextDrawCreate(613.000000, 238.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][43], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][43], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][43], 1);
		TextDrawColor(RegisterText[i][43], -1);
		TextDrawSetShadow(RegisterText[i][43], 0);
		TextDrawSetOutline(RegisterText[i][43], 0);
		TextDrawFont(RegisterText[i][43], 4);
		TextDrawSetSelectable(RegisterText[i][43], true);

		RegisterText[i][44] = TextDrawCreate(550.000000, 274.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][44], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][44], 2);
		TextDrawColor(RegisterText[i][44], 257552383);
		TextDrawSetShadow(RegisterText[i][44], 0);
		TextDrawSetOutline(RegisterText[i][44], 1);
		TextDrawBackgroundColor(RegisterText[i][44], 255);
		TextDrawFont(RegisterText[i][44], 3);
		TextDrawSetProportional(RegisterText[i][44], 1);

		RegisterText[i][45] = TextDrawCreate(550.000000, 262.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][45], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][45], 2);
		TextDrawColor(RegisterText[i][45], -1);
		TextDrawSetShadow(RegisterText[i][45], 0);
		TextDrawSetOutline(RegisterText[i][45], 1);
		TextDrawBackgroundColor(RegisterText[i][45], 51);
		TextDrawFont(RegisterText[i][45], 2);
		TextDrawSetProportional(RegisterText[i][45], 1);

		RegisterText[i][46] = TextDrawCreate(472.000000, 272.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][46], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][46], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][46], 1);
		TextDrawColor(RegisterText[i][46], -1);
		TextDrawSetShadow(RegisterText[i][46], 0);
		TextDrawSetOutline(RegisterText[i][46], 0);
		TextDrawFont(RegisterText[i][46], 4);
		TextDrawSetSelectable(RegisterText[i][46], true);

		RegisterText[i][47] = TextDrawCreate(613.000000, 272.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][47], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][47], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][47], 1);
		TextDrawColor(RegisterText[i][47], -1);
		TextDrawSetShadow(RegisterText[i][47], 0);
		TextDrawSetOutline(RegisterText[i][47], 0);
		TextDrawFont(RegisterText[i][47], 4);
		TextDrawSetSelectable(RegisterText[i][47], true);

		RegisterText[i][48] = TextDrawCreate(550.000000, 308.000000, "itemns de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][48], 0.207662, 0.965331);
		TextDrawAlignment(RegisterText[i][48], 2);
		TextDrawColor(RegisterText[i][48], 257552383);
		TextDrawSetShadow(RegisterText[i][48], 0);
		TextDrawSetOutline(RegisterText[i][48], 1);
		TextDrawBackgroundColor(RegisterText[i][48], 255);
		TextDrawFont(RegisterText[i][48], 3);
		TextDrawSetProportional(RegisterText[i][48], 1);

		RegisterText[i][49] = TextDrawCreate(550.000000, 296.000000, "Titulo de 24 aparencias");
		TextDrawLetterSize(RegisterText[i][49], 0.211333, 1.131258);
		TextDrawAlignment(RegisterText[i][49], 2);
		TextDrawColor(RegisterText[i][49], -1);
		TextDrawSetShadow(RegisterText[i][49], 0);
		TextDrawSetOutline(RegisterText[i][49], 1);
		TextDrawBackgroundColor(RegisterText[i][49], 51);
		TextDrawFont(RegisterText[i][49], 2);
		TextDrawSetProportional(RegisterText[i][49], 1);

		RegisterText[i][50] = TextDrawCreate(472.000000, 306.000000, "ld_beat:left");
		TextDrawLetterSize(RegisterText[i][50], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][50], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][50], 1);
		TextDrawColor(RegisterText[i][50], -1);
		TextDrawSetShadow(RegisterText[i][50], 0);
		TextDrawSetOutline(RegisterText[i][50], 0);
		TextDrawFont(RegisterText[i][50], 4);
		TextDrawSetSelectable(RegisterText[i][50], true);

		RegisterText[i][51] = TextDrawCreate(613.000000, 306.000000, "ld_beat:right");
		TextDrawLetterSize(RegisterText[i][51], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][51], 11.666666, 14.103693);
		TextDrawAlignment(RegisterText[i][51], 1);
		TextDrawColor(RegisterText[i][51], -1);
		TextDrawSetShadow(RegisterText[i][51], 0);
		TextDrawSetOutline(RegisterText[i][51], 0);
		TextDrawFont(RegisterText[i][51], 4);
		TextDrawSetSelectable(RegisterText[i][51], true);

		RegisterText[i][52] = TextDrawCreate(10.666603, 344.711364, "ld_chat:thumbup");
		TextDrawLetterSize(RegisterText[i][52], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][52], 21.666681, 26.962947);
		TextDrawAlignment(RegisterText[i][52], 1);
		TextDrawColor(RegisterText[i][52], -1);
		TextDrawSetShadow(RegisterText[i][52], 0);
		TextDrawSetOutline(RegisterText[i][52], 0);
		TextDrawFont(RegisterText[i][52], 4);
		TextDrawSetSelectable(RegisterText[i][52], true);

		RegisterText[i][53] = TextDrawCreate(146.333282, 341.563293, "ld_chat:thumbdn");
		TextDrawLetterSize(RegisterText[i][53], 0.000000, 0.000000);
		TextDrawTextSize(RegisterText[i][53], 21.666681, 26.962947);
		TextDrawAlignment(RegisterText[i][53], 1);
		TextDrawColor(RegisterText[i][53], -1);
		TextDrawSetShadow(RegisterText[i][53], 0);
		TextDrawSetOutline(RegisterText[i][53], 0);
		TextDrawFont(RegisterText[i][53], 4);
		TextDrawSetSelectable(RegisterText[i][53], true);
		
		ItemBox[i][0] = TextDrawCreate(425.000030, 138.803726, "usebox");
		TextDrawLetterSize(ItemBox[i][0], 0.000000, 27.649143);
		TextDrawTextSize(ItemBox[i][0], 221.666656, 0.000000);
		TextDrawAlignment(ItemBox[i][0], 1);
		TextDrawColor(ItemBox[i][0], 0);
		TextDrawUseBox(ItemBox[i][0], true);
		TextDrawBoxColor(ItemBox[i][0], 153);
		TextDrawSetShadow(ItemBox[i][0], 0);
		TextDrawSetOutline(ItemBox[i][0], 0);
		TextDrawFont(ItemBox[i][0], 0);

		ItemBox[i][1] = TextDrawCreate(215.666625, 126.518478, "Item");
		TextDrawLetterSize(ItemBox[i][1], 0.449999, 1.600000);
		TextDrawAlignment(ItemBox[i][1], 1);
		TextDrawColor(ItemBox[i][1], -1446714113);
		TextDrawSetShadow(ItemBox[i][1], 0);
		TextDrawSetOutline(ItemBox[i][1], 1);
		TextDrawBackgroundColor(ItemBox[i][1], 255);
		TextDrawFont(ItemBox[i][1], 0);
		TextDrawSetProportional(ItemBox[i][1], 1);

		ItemBox[i][2] = TextDrawCreate(229.666641, 143.940719, "_");
		TextDrawLetterSize(ItemBox[i][2], 0.000000, 0.000000);
		TextDrawTextSize(ItemBox[i][2], 186.0, 186.0);
		TextDrawAlignment(ItemBox[i][2], 1);
		TextDrawColor(ItemBox[i][2], -1);
		TextDrawSetShadow(ItemBox[i][2], 0);
		TextDrawSetOutline(ItemBox[i][2], 0);
		TextDrawFont(ItemBox[i][2], TEXT_DRAW_FONT_MODEL_PREVIEW);
		TextDrawSetPreviewModel(ItemBox[i][2], 411);

		ItemBox[i][3] = TextDrawCreate(323.0, 336.414886, "Titulo de 24 caractere");
		TextDrawLetterSize(ItemBox[i][3], 0.302000, 1.085629);
		TextDrawTextSize(ItemBox[i][3], 131.666641, 182.933303);
		TextDrawAlignment(ItemBox[i][3], 2);
		TextDrawColor(ItemBox[i][3], -1);
		TextDrawUseBox(ItemBox[i][3], true);
		TextDrawBoxColor(ItemBox[i][3], 0);
		TextDrawSetShadow(ItemBox[i][3], 0);
		TextDrawSetOutline(ItemBox[i][3], 1);
		TextDrawBackgroundColor(ItemBox[i][3], 51);
		TextDrawFont(ItemBox[i][3], 2);
		TextDrawSetProportional(ItemBox[i][3], 1);

		ItemBox[i][4] = TextDrawCreate(323.0, 349.859375, "pesoss de 24 caractere");
		TextDrawLetterSize(ItemBox[i][4], 0.302000, 1.085629);
		TextDrawTextSize(ItemBox[i][4], 131.666641, 182.933303);
		TextDrawAlignment(ItemBox[i][4], 2);
		TextDrawColor(ItemBox[i][4], -1);
		TextDrawUseBox(ItemBox[i][4], true);
		TextDrawBoxColor(ItemBox[i][4], 0);
		TextDrawSetShadow(ItemBox[i][4], 0);
		TextDrawSetOutline(ItemBox[i][4], 1);
		TextDrawBackgroundColor(ItemBox[i][4], 51);
		TextDrawFont(ItemBox[i][4], 2);
		TextDrawSetProportional(ItemBox[i][4], 1);

		ItemBox[i][5] = TextDrawCreate(212.0, 362.889099, "volume de 24 caractere");
		TextDrawLetterSize(ItemBox[i][5], 0.302000, 1.085629);
		TextDrawTextSize(ItemBox[i][5], 131.666641, 182.933303);
		TextDrawAlignment(ItemBox[i][5], 2);
		TextDrawColor(ItemBox[i][5], -1);
		TextDrawUseBox(ItemBox[i][5], true);
		TextDrawBoxColor(ItemBox[i][5], 0);
		TextDrawSetShadow(ItemBox[i][5], 0);
		TextDrawSetOutline(ItemBox[i][5], 1);
		TextDrawBackgroundColor(ItemBox[i][5], 51);
		TextDrawFont(ItemBox[i][5], 2);
		TextDrawSetProportional(ItemBox[i][5], 1);

		ItemBox[i][6] = TextDrawCreate(416.999969, 121.125938, "ld_chat:thumbdn");
		TextDrawLetterSize(ItemBox[i][6], 0.000000, 0.000000);
		TextDrawTextSize(ItemBox[i][6], 18.0, 18.0);
		TextDrawAlignment(ItemBox[i][6], 1);
		TextDrawColor(ItemBox[i][6], -1);
		TextDrawSetShadow(ItemBox[i][6], 0);
		TextDrawSetOutline(ItemBox[i][6], 0);
		TextDrawFont(ItemBox[i][6], 4);
		TextDrawSetSelectable(ItemBox[i][6], true);

		ItemBox[i][7] = TextDrawCreate(312.666595, 379.311218, "ld_chat:thumbup");
		TextDrawLetterSize(ItemBox[i][7], 0.000000, 0.000000);
		TextDrawTextSize(ItemBox[i][7], 18.0, 18.0);
		TextDrawAlignment(ItemBox[i][7], 1);
		TextDrawColor(ItemBox[i][7], -1);
		TextDrawSetShadow(ItemBox[i][7], 0);
		TextDrawSetOutline(ItemBox[i][7], 0);
		TextDrawFont(ItemBox[i][7], 4);
		TextDrawSetSelectable(ItemBox[i][7], true);

	}
	//FORT CARSON UPGRADE BY: NICK
	CreateDynamicObject(4018,-108.4349594,1085.0334473,18.7421875,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(newbuildsm02) (1)
	CreateDynamicObject(4176,-216.4863281,1171.0615234,24.0592690,0.0000000,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(bailbonds2_lan) (1)
	CreateDynamicObject(4594,-216.3759766,1145.3330078,18.6012402,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(lan2buildblk02) (1)
	CreateDynamicObject(10183,-222.5712891,1220.3359375,18.7541313,0.0000000,0.0000000,45.9997559, -1, -1, -1, 400, 400); //object(ferspaces) (1)
	CreateDynamicObject(1215,-237.5797119,1210.3516846,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (1)
	CreateDynamicObject(1215,-237.5508881,1208.3070068,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (2)
	CreateDynamicObject(1215,-237.5596924,1206.0791016,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (3)
	CreateDynamicObject(1215,-259.4099731,1208.3896484,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (4)
	CreateDynamicObject(1216,-254.1552429,1210.4699707,19.4341908,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(phonebooth1) (3)
	CreateDynamicObject(1231,-244.3533020,1205.9851074,21.4725800,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(1257,-254.1892090,1205.3067627,20.0213795,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(bustopm) (1)
	CreateDynamicObject(1258,-239.3197784,1206.4340820,19.4039078,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(mpostbox1) (1)
	CreateDynamicObject(1367,-246.2751923,1210.4240723,19.3871384,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_postbox) (1)
	CreateDynamicObject(1498,-249.0188904,1210.8021240,18.7421875,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(gen_doorext03) (1)
	CreateDynamicObject(1256,-243.4422302,1210.3586426,19.4016438,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (1)
	CreateDynamicObject(1256,-240.1943665,1210.3947754,19.4016438,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (2)
	CreateDynamicObject(11010,-174.2548828,1018.0224609,24.7043705,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(crackbuild_sfs) (1)
	CreateDynamicObject(983,-302.2988586,1055.7413330,45.8015633,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (7)
	CreateDynamicObject(983,-300.1303101,1005.3304443,19.2683449,0.0000000,0.0000000,270.3111572, -1, -1, -1, 400, 400); //object(fenceshit3) (10)
	CreateDynamicObject(983,-305.7870483,1005.3435059,19.2684975,0.0000000,0.0000000,270.3076172, -1, -1, -1, 400, 400); //object(fenceshit3) (12)
	CreateDynamicObject(983,-309.0748596,1008.7890015,19.2773056,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (13)
	CreateDynamicObject(983,-309.0957642,1015.1422119,19.2773056,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (14)
	CreateDynamicObject(983,-309.1171265,1018.6593628,19.2773056,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (15)
	CreateDynamicObject(983,-312.2566528,1021.8889160,19.4067764,0.0000000,0.0000000,270.3076172, -1, -1, -1, 400, 400); //object(fenceshit3) (16)
	CreateDynamicObject(983,-318.6901855,1021.8365479,19.4169464,0.0000000,0.0000000,270.3076172, -1, -1, -1, 400, 400); //object(fenceshit3) (17)
	CreateDynamicObject(983,-325.1044922,1021.8443604,19.4257431,0.0000000,0.0000000,270.3076172, -1, -1, -1, 400, 400); //object(fenceshit3) (18)
	CreateDynamicObject(983,-327.3110046,1021.8426514,19.4257431,0.0000000,0.0000000,270.3076172, -1, -1, -1, 400, 400); //object(fenceshit3) (19)
	CreateDynamicObject(983,-330.4481812,1025.0139160,19.4257431,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (20)
	CreateDynamicObject(983,-330.4571533,1031.3974609,19.4257431,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (21)
	CreateDynamicObject(983,-330.4562683,1035.1186523,19.4257431,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (22)
	CreateDynamicObject(983,-333.6171875,1038.3880615,19.4257431,0.0000000,0.0000000,270.3076172, -1, -1, -1, 400, 400); //object(fenceshit3) (23)
	CreateDynamicObject(983,-331.3638306,1065.7283936,19.4257431,0.0000000,0.0000000,270.3076172, -1, -1, -1, 400, 400); //object(fenceshit3) (29)
	CreateDynamicObject(983,-328.9447632,1065.7132568,19.4257431,0.0000000,0.0000000,270.3076172, -1, -1, -1, 400, 400); //object(fenceshit3) (30)
	CreateDynamicObject(983,-300.8663635,1053.1364746,19.4247932,0.0000000,0.0000000,270.3076172, -1, -1, -1, 400, 400); //object(fenceshit3) (31)
	CreateDynamicObject(8079,-314.7890625,1048.0771484,31.8680077,0.0000000,0.0000000,0.1353760, -1, -1, -1, 400, 400); //object(hospital01_lvs) (1)
	CreateDynamicObject(1257,-281.9109192,1031.6917725,20.0213795,0.0000000,0.0000000,181.5100098, -1, -1, -1, 400, 400); //object(bustopm) (1)
	CreateDynamicObject(1256,-289.3264771,1028.3505859,19.2884312,0.0000000,0.0000000,179.6759033, -1, -1, -1, 400, 400); //object(stonebench1) (4)
	CreateDynamicObject(1256,-289.5062561,1052.7537842,19.4025421,0.0000000,0.0000000,179.6813965, -1, -1, -1, 400, 400); //object(stonebench1) (4)
	CreateDynamicObject(5737,-269.9482422,998.1412354,24.7295609,0.0000000,0.0000000,178.5278320, -1, -1, -1, 400, 400); //object(archshop07_law02) (3)
	CreateDynamicObject(5738,-236.8554688,1001.0406494,32.7934418,0.0000000,0.0000000,180.5328369, -1, -1, -1, 400, 400); //object(hothol02_law01) (1)
	CreateDynamicObject(4176,-216.4944153,1046.3724365,24.2223053,0.0000000,0.0000000,89.7193604, -1, -1, -1, 400, 400); //object(bailbonds2_lan) (1)
	CreateDynamicObject(4048,-310.5419922,1116.0688477,30.7070942,0.0000000,0.0000000,0.5328369, -1, -1, -1, 400, 400); //object(lacityhall4_lan) (2)
	CreateDynamicObject(5709,-26.1015625,1175.7470703,26.9278717,0.0000000,0.0000000,180.5383301, -1, -1, -1, 400, 400); //object(shop03_law01) (1)
	CreateDynamicObject(5819,-21.7490234,1171.1591797,18.0699520,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(lawnbuildg) (1)
	CreateDynamicObject(6157,55.1757812,1215.5371094,28.4261246,0.0000000,0.0000000,88.7750244, -1, -1, -1, 400, 400); //object(gaz22_law) (1)
	CreateDynamicObject(8068,0.7080078,1215.7167969,25.0772705,0.0000000,0.0000000,89.9780273, -1, -1, -1, 400, 400); //object(hseing04_lvs) (1)
	CreateDynamicObject(982,138.8922882,1049.9588623,13.2929296,0.0000000,0.0000000,354.7340088, -1, -1, -1, 400, 400); //object(fenceshit) (1)
	CreateDynamicObject(982,114.0400391,1039.0000000,13.2929296,0.0000000,0.0000000,265.9075928, -1, -1, -1, 400, 400); //object(fenceshit) (2)
	CreateDynamicObject(982,85.2242966,1051.9980469,13.2929296,0.0000000,0.0000000,7.7021484, -1, -1, -1, 400, 400); //object(fenceshit) (5)
	CreateDynamicObject(982,81.5937500,1077.3349609,13.2929296,0.0000000,0.0000000,8.4484863, -1, -1, -1, 400, 400); //object(fenceshit) (6)
	CreateDynamicObject(983,101.7797775,1113.0256348,13.2929296,0.0000000,0.0000000,275.7353516, -1, -1, -1, 400, 400); //object(fenceshit3) (9)
	CreateDynamicObject(983,108.1291046,1113.6800537,13.2929296,0.0000000,0.0000000,275.7348633, -1, -1, -1, 400, 400); //object(fenceshit3) (24)
	CreateDynamicObject(983,114.5099182,1114.4194336,13.2929296,0.0000000,0.0000000,275.7348633, -1, -1, -1, 400, 400); //object(fenceshit3) (25)
	CreateDynamicObject(983,120.8916016,1115.1425781,13.2929296,0.0000000,0.0000000,275.7293701, -1, -1, -1, 400, 400); //object(fenceshit3) (26)
	CreateDynamicObject(983,122.4533615,1115.3260498,13.2929296,0.0000000,0.0000000,275.7348633, -1, -1, -1, 400, 400); //object(fenceshit3) (27)
	CreateDynamicObject(18284,130.3931732,1079.4394531,15.5601978,0.0000000,0.0000000,89.6813965, -1, -1, -1, 400, 400); //object(cw_tscanopy) (1)
	CreateDynamicObject(11417,117.2451172,1083.6308594,17.4832230,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(xenonsign2_sfse) (1)
	CreateDynamicObject(1290,123.7929459,1039.6071777,18.6327972,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(lamppost2) (2)
	CreateDynamicObject(1290,101.1276398,1040.3532715,18.6387787,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(lamppost2) (3)
	CreateDynamicObject(5725,21.3732834,1186.0146484,27.2197838,0.0000000,0.0000000,359.7308350, -1, -1, -1, 400, 400); //object(holpacific2_law) (1)
	CreateDynamicObject(5738,0.9609375,1117.6406250,33.2108765,0.0000000,0.0000000,0.2471924, -1, -1, -1, 400, 400); //object(hothol02_law01) (2)
	CreateDynamicObject(5738,0.9804688,1128.6435547,33.2147141,0.0000000,0.0000000,0.2471924, -1, -1, -1, 400, 400); //object(hothol02_law01) (3)
	CreateDynamicObject(4594,-17.4052734,1120.0830078,18.7421875,0.0000000,0.0000000,270.2691650, -1, -1, -1, 400, 400); //object(lan2buildblk02) (1)
	CreateDynamicObject(8068,0.8429844,1231.7534180,25.0781670,0.0000000,0.0000000,89.9780273, -1, -1, -1, 400, 400); //object(hseing04_lvs) (1)
	CreateDynamicObject(5737,-34.4101562,1219.8164062,24.3990688,0.0000000,0.0000000,270.2197266, -1, -1, -1, 400, 400); //object(archshop07_law02) (3)
	CreateDynamicObject(4176,-247.9150391,1176.4326172,24.2301025,0.0000000,0.0000000,180.4504395, -1, -1, -1, 400, 400); //object(bailbonds2_lan) (1)
	CreateDynamicObject(10631,-257.1689453,1153.2841797,22.8322582,0.0000000,0.0000000,88.9123535, -1, -1, -1, 400, 400); //object(ammunation_sfs) (1)
	CreateDynamicObject(1676,138.7129974,1079.5662842,14.3988771,0.0000000,0.0000000,87.7313232, -1, -1, -1, 400, 400); //object(washgaspump) (3)
	CreateDynamicObject(1676,133.0008850,1079.4841309,14.3988771,0.0000000,0.0000000,87.7258301, -1, -1, -1, 400, 400); //object(washgaspump) (3)
	CreateDynamicObject(1676,127.6414261,1079.1614990,14.3988771,0.0000000,0.0000000,87.7258301, -1, -1, -1, 400, 400); //object(washgaspump) (3)
	CreateDynamicObject(1676,121.9340515,1079.4124756,14.3988771,0.0000000,0.0000000,87.7258301, -1, -1, -1, 400, 400); //object(washgaspump) (3)
	CreateDynamicObject(12843,89.9055862,1076.8824463,12.6093750,0.0000000,0.0000000,97.7150269, -1, -1, -1, 400, 400); //object(cos_liquorshop) (1)
	CreateDynamicObject(12844,90.3163528,1073.9300537,14.5850840,0.0000000,0.0000000,97.6700439, -1, -1, -1, 400, 400); //object(cos_liqinside) (1)
	CreateDynamicObject(12845,89.9948578,1074.0360107,14.7418938,0.0000000,0.0000000,97.4199829, -1, -1, -1, 400, 400); //object(cos_liqinsidebits) (1)
	CreateDynamicObject(6959,100.3652344,1092.4824219,12.6438122,0.0000000,0.0000000,7.9376221, -1, -1, -1, 400, 400); //object(vegasnbball1) (1)
	CreateDynamicObject(6959,124.5087891,1095.4365234,12.6919289,0.0000000,359.5000000,7.9376221, -1, -1, -1, 400, 400); //object(vegasnbball1) (2)
	CreateDynamicObject(6959,104.7613831,1060.9857178,12.6444521,0.0000000,0.0000000,7.9376221, -1, -1, -1, 400, 400); //object(vegasnbball1) (3)
	CreateDynamicObject(6959,122.8511734,1058.3825684,12.6425695,0.0000000,0.0000000,355.9826660, -1, -1, -1, 400, 400); //object(vegasnbball1) (4)
	CreateDynamicObject(982,124.8174973,1038.3028564,13.2989130,0.0000000,0.0000000,265.9075928, -1, -1, -1, 400, 400); //object(fenceshit) (2)
	CreateDynamicObject(983,140.5128937,1065.8436279,13.2948742,0.0000000,0.0000000,352.9128418, -1, -1, -1, 400, 400); //object(fenceshit3) (44)
	CreateDynamicObject(983,141.6477203,1072.3599854,13.2948742,0.0000000,0.0000000,348.1883545, -1, -1, -1, 400, 400); //object(fenceshit3) (44)
	CreateDynamicObject(983,144.6069489,1077.6715088,13.3384819,0.0000000,0.0000000,316.3969727, -1, -1, -1, 400, 400); //object(fenceshit3) (44)
	CreateDynamicObject(6959,139.1365051,1076.1497803,12.6406870,0.0000000,359.4946289,7.9321289, -1, -1, -1, 400, 400); //object(vegasnbball1) (5)
	CreateDynamicObject(983,128.8507233,1116.1224365,13.2566929,0.0000000,0.0000000,276.9793701, -1, -1, -1, 400, 400); //object(fenceshit3) (26)
	CreateDynamicObject(983,135.1811676,1117.0279541,13.2370853,0.0000000,0.0000000,278.9763184, -1, -1, -1, 400, 400); //object(fenceshit3) (26)
	CreateDynamicObject(983,139.0217133,1117.5854492,13.2213717,0.0000000,0.0000000,278.9758301, -1, -1, -1, 400, 400); //object(fenceshit3) (26)
	CreateDynamicObject(983,142.5895996,1114.9785156,13.5240650,0.0000000,0.0000000,7.4200439, -1, -1, -1, 400, 400); //object(fenceshit3) (6)
	CreateDynamicObject(983,143.4033356,1108.6433105,13.5234632,0.0000000,0.0000000,7.4157715, -1, -1, -1, 400, 400); //object(fenceshit3) (6)
	CreateDynamicObject(983,147.0369720,1082.7504883,13.2996311,0.0000000,0.0000000,3.5949707, -1, -1, -1, 400, 400); //object(fenceshit3) (44)
	CreateDynamicObject(983,146.4146271,1089.4421387,13.2333422,0.0000000,0.0000000,7.8291016, -1, -1, -1, 400, 400); //object(fenceshit3) (44)
	CreateDynamicObject(983,145.9270172,1092.3885498,13.3720798,0.0000000,0.0000000,7.8277588, -1, -1, -1, 400, 400); //object(fenceshit3) (44)
	CreateDynamicObject(983,97.8861389,1039.8991699,13.2929296,0.0000000,0.0000000,277.7427979, -1, -1, -1, 400, 400); //object(fenceshit3) (44)
	CreateDynamicObject(983,91.4957581,1039.0247803,13.2967567,0.0000000,0.0000000,277.7398682, -1, -1, -1, 400, 400); //object(fenceshit3) (44)
	CreateDynamicObject(982,79.4719467,1091.5534668,13.2929296,0.0000000,0.0000000,8.4484863, -1, -1, -1, 400, 400); //object(fenceshit) (6)
	CreateDynamicObject(983,80.3379745,1103.6042480,13.2961168,0.0000000,0.0000000,318.6093750, -1, -1, -1, 400, 400); //object(fenceshit3) (26)
	CreateDynamicObject(983,84.6894836,1108.3592529,13.2961168,0.0000000,0.0000000,316.8590088, -1, -1, -1, 400, 400); //object(fenceshit3) (26)
	CreateDynamicObject(983,90.0692978,1111.2515869,13.2961168,0.0000000,0.0000000,279.1419678, -1, -1, -1, 400, 400); //object(fenceshit3) (26)
	CreateDynamicObject(983,96.3956757,1112.2711182,13.2989130,0.0000000,0.0000000,279.1406250, -1, -1, -1, 400, 400); //object(fenceshit3) (26)
	CreateDynamicObject(10183,89.6241608,1061.5007324,12.6251450,0.0000000,0.0000000,144.0000000, -1, -1, -1, 400, 400); //object(ferspaces) (2)
	CreateDynamicObject(1215,179.8099976,1097.6966553,16.1980839,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (7)
	CreateDynamicObject(1215,177.6862793,1097.4904785,16.3442535,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (8)
	CreateDynamicObject(1215,175.4317474,1097.3227539,16.3820496,0.0000000,0.0000000,2.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (9)
	CreateDynamicObject(1215,173.3809204,1097.3034668,16.1657181,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (10)
	CreateDynamicObject(1215,171.2857971,1097.2796631,15.9476109,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (11)
	CreateDynamicObject(1215,169.3331909,1097.2305908,15.7443323,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (12)
	CreateDynamicObject(1215,167.1825867,1097.2282715,15.5204535,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (13)
	CreateDynamicObject(1215,165.0145569,1097.1594238,15.2947445,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (14)
	CreateDynamicObject(1215,162.7817688,1097.1253662,15.0623016,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (15)
	CreateDynamicObject(1215,160.5411072,1097.0808105,14.8323984,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (16)
	CreateDynamicObject(1215,158.1980286,1097.0791016,14.5886574,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (17)
	CreateDynamicObject(1215,155.9080963,1097.0202637,14.3495255,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (18)
	CreateDynamicObject(1215,153.6169434,1096.9836426,14.1103363,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (19)
	CreateDynamicObject(1215,151.2956238,1096.9289551,13.8698597,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (20)
	CreateDynamicObject(1215,149.1122437,1096.8887939,13.6422596,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (22)
	CreateDynamicObject(1215,145.3917999,1095.5648193,13.3406181,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (23)
	CreateDynamicObject(1215,146.9638214,1096.3657227,13.4077148,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(bollardlight) (24)
	CreateDynamicObject(1215,179.3596497,1106.0499268,15.6165791,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (25)
	CreateDynamicObject(1215,177.4519653,1105.6563721,15.7663784,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (26)
	CreateDynamicObject(1215,175.4932251,1105.2601318,15.9162579,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (27)
	CreateDynamicObject(1215,173.5350494,1105.0124512,15.9750557,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (28)
	CreateDynamicObject(1215,171.5491943,1104.7625732,15.9768190,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (29)
	CreateDynamicObject(1215,169.5354309,1104.7426758,15.7686901,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (30)
	CreateDynamicObject(1215,167.5838165,1104.7539062,15.5670309,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (31)
	CreateDynamicObject(1215,165.5500946,1104.7077637,15.3568020,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (32)
	CreateDynamicObject(1215,163.7528229,1104.6915283,15.1710501,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (33)
	CreateDynamicObject(1215,161.3245850,1104.6986084,14.9201317,0.0000000,0.0000000,356.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (34)
	CreateDynamicObject(1215,159.1610718,1104.7390137,14.7037172,0.0000000,0.0000000,355.9954834, -1, -1, -1, 400, 400); //object(bollardlight) (35)
	CreateDynamicObject(1215,157.3003387,1104.8431396,14.5116110,0.0000000,0.0000000,355.9954834, -1, -1, -1, 400, 400); //object(bollardlight) (36)
	CreateDynamicObject(1215,155.0325928,1104.7651367,14.2771320,0.0000000,0.0000000,355.9954834, -1, -1, -1, 400, 400); //object(bollardlight) (37)
	CreateDynamicObject(1215,153.1273651,1104.7531738,14.0802288,0.0000000,0.0000000,353.9954834, -1, -1, -1, 400, 400); //object(bollardlight) (38)
	CreateDynamicObject(1215,147.7953339,1104.7473145,13.5292168,0.0000000,0.0000000,353.9904785, -1, -1, -1, 400, 400); //object(bollardlight) (39)
	CreateDynamicObject(1215,145.4953461,1104.7304688,13.2915106,0.0000000,0.0000000,353.9904785, -1, -1, -1, 400, 400); //object(bollardlight) (40)
	CreateDynamicObject(1215,143.8268127,1105.4078369,13.4059048,0.0000000,0.0000000,353.9904785, -1, -1, -1, 400, 400); //object(bollardlight) (41)
	CreateDynamicObject(1215,115.9140625,1107.0614014,12.5650663,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (42)
	CreateDynamicObject(1215,105.4182281,1106.7683105,12.5650663,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (43)
	CreateDynamicObject(1215,108.9989929,1067.1373291,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (50)
	CreateDynamicObject(1215,95.1222916,1067.1384277,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (51)
	CreateDynamicObject(1215,96.6724243,1057.2700195,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (52)
	CreateDynamicObject(1215,98.6204224,1047.6647949,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (53)
	CreateDynamicObject(1215,112.7797699,1047.5721436,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (54)
	CreateDynamicObject(1215,119.5998535,1047.3726807,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (55)
	CreateDynamicObject(1215,124.9583435,1057.2160645,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (56)
	CreateDynamicObject(1215,122.8700943,1067.0817871,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (57)
	CreateDynamicObject(1215,115.9525452,1067.0518799,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (58)
	CreateDynamicObject(1215,120.9875412,1076.7625732,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (59)
	CreateDynamicObject(1215,128.1367035,1076.6727295,13.3823338,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (60)
	CreateDynamicObject(1215,133.6244202,1076.9320068,13.3823338,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (61)
	CreateDynamicObject(1215,139.1248016,1076.6977539,13.3823338,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (62)
	CreateDynamicObject(1215,91.4914627,1085.7879639,13.3036118,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (63)
	CreateDynamicObject(1215,110.9448929,1057.1508789,13.1775255,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (64)
	CreateDynamicObject(1231,-180.1675415,1170.6186523,21.4725800,0.0000000,3.9990234,84.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(1231,-192.9501953,1187.1503906,21.0194550,0.0000000,1.9995117,0.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(1231,-192.7189026,1109.4515381,21.0194550,0.0000000,1.9995117,0.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(1231,-192.9389801,1087.6087646,21.0194550,0.0000000,1.9995117,354.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(1231,-193.0195160,1029.2393799,21.0194550,0.0000000,1.9995117,353.9959717, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(1231,-192.8857422,1000.5615234,21.5004387,0.0000000,1.9995117,353.9959717, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(6959,-301.2589722,1058.2337646,18.6231174,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (6)
	CreateDynamicObject(6959,-324.8320312,1073.1845703,18.6231174,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (7)
	CreateDynamicObject(6959,-305.6659851,1038.4711914,18.7715549,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (8)
	CreateDynamicObject(6959,-305.6888428,999.9176025,18.7715549,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (9)
	CreateDynamicObject(6959,-297.4812622,1003.4911499,18.7715549,0.0000000,0.0000000,32.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (10)
	CreateDynamicObject(6959,-296.4466553,1001.3555908,18.7715549,0.0000000,0.0000000,53.9976807, -1, -1, -1, 400, 400); //object(vegasnbball1) (11)
	CreateDynamicObject(7191,-305.7744141,972.6328125,17.9330845,0.0000000,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (1)
	CreateDynamicObject(7191,-329.5755920,994.3098145,17.9330845,0.0000000,0.0000000,3.9995117, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (2)
	CreateDynamicObject(6959,-308.4345703,992.7177734,18.7715549,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vegasnbball1) (13)
	CreateDynamicObject(6959,-306.4896240,1026.1275635,18.7715549,0.0000000,0.0000000,14.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (16)
	CreateDynamicObject(3484,-253.0596619,1075.2514648,25.3672791,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(vegasxrexhse03) (1)
	CreateDynamicObject(3485,-250.5269012,1042.9299316,25.7323704,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vegasxrexhse04) (1)
	CreateDynamicObject(10631,-252.1689453,1153.2519531,22.8322582,0.0000000,0.0000000,88.9068604, -1, -1, -1, 400, 400); //object(ammunation_sfs) (1)
	CreateDynamicObject(3487,-251.6969757,1125.6536865,25.4392281,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vegasxrexhse06) (1)
	CreateDynamicObject(7191,-329.5751953,994.3095703,15.1830845,0.0000000,0.0000000,3.9990234, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (5)
	CreateDynamicObject(7191,-305.7744141,972.6328125,14.6830845,0.0000000,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (6)
	CreateDynamicObject(3596,-36.8564453,1044.0185547,20.4683762,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(dingbat02aex_la) (1)
	CreateDynamicObject(3595,-36.8353271,1077.3505859,20.3649979,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(dingbat01aex_la) (1)
	CreateDynamicObject(10022,8.4418192,1077.1306152,25.2294617,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vicstuff_sfe04) (1)
	CreateDynamicObject(6959,-315.9815674,1068.5856934,18.7715549,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (17)
	CreateDynamicObject(1215,-191.0738831,1185.7005615,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (65)
	CreateDynamicObject(1215,-191.0184937,1182.3676758,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (66)
	CreateDynamicObject(1215,-191.0264893,1179.0351562,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (67)
	CreateDynamicObject(1215,-191.0500946,1175.8330078,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (68)
	CreateDynamicObject(1215,-195.0732422,1185.7041016,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (69)
	CreateDynamicObject(1215,-195.0175781,1182.3710938,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (70)
	CreateDynamicObject(1215,-195.0256348,1179.1093750,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (71)
	CreateDynamicObject(1215,-195.0490723,1175.9072266,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (72)
	CreateDynamicObject(1215,-191.0616150,1172.7073975,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (74)
	CreateDynamicObject(1215,-191.0410919,1169.4570312,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (75)
	CreateDynamicObject(1215,-191.0190125,1165.9570312,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (76)
	CreateDynamicObject(1215,-191.0468292,1162.7807617,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (77)
	CreateDynamicObject(1215,-191.0318298,1159.5302734,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (78)
	CreateDynamicObject(1215,-191.0728760,1156.0302734,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (79)
	CreateDynamicObject(1215,-191.0486908,1152.2802734,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (80)
	CreateDynamicObject(1215,-191.0324554,1148.7569580,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (81)
	CreateDynamicObject(1215,-191.1066742,1145.4145508,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (82)
	CreateDynamicObject(1215,-191.0852661,1141.8654785,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (83)
	CreateDynamicObject(1215,-191.0613861,1138.1152344,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (84)
	CreateDynamicObject(1215,-191.0286255,1134.2437744,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (85)
	CreateDynamicObject(1215,-191.0354919,1130.1245117,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (86)
	CreateDynamicObject(1215,-191.0128784,1125.9057617,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (87)
	CreateDynamicObject(1215,-191.0206299,1121.4052734,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (88)
	CreateDynamicObject(1215,-191.0642090,1117.1584473,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (89)
	CreateDynamicObject(1215,-191.1181641,1112.4101562,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.0615234,1172.6972656,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (91)
	CreateDynamicObject(1215,-195.0410156,1169.4628906,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (92)
	CreateDynamicObject(1215,-195.0180664,1166.0136719,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (93)
	CreateDynamicObject(1215,-195.0454102,1162.8369141,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (94)
	CreateDynamicObject(1215,-195.0312500,1159.5361328,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (95)
	CreateDynamicObject(1215,-195.0722656,1156.0361328,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (96)
	CreateDynamicObject(1215,-195.0478516,1152.2861328,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (97)
	CreateDynamicObject(1215,-195.0322266,1148.7626953,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (98)
	CreateDynamicObject(1215,-195.1064453,1145.4199219,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (99)
	CreateDynamicObject(1215,-195.0849609,1141.8710938,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (100)
	CreateDynamicObject(1215,-195.0605469,1138.1210938,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (101)
	CreateDynamicObject(1215,-195.0263672,1134.2391357,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (102)
	CreateDynamicObject(1215,-195.0351562,1130.1435547,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (103)
	CreateDynamicObject(1215,-195.0124512,1125.8740234,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (104)
	CreateDynamicObject(1215,-195.0202637,1121.3740234,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (105)
	CreateDynamicObject(1215,-195.0632324,1117.1269531,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (106)
	CreateDynamicObject(1215,-195.1179199,1112.3789062,19.3611984,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (107)
	CreateDynamicObject(1315,-187.5438995,1107.7408447,22.0112686,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(trafficlight1) (1)
	CreateDynamicObject(1315,-198.1127167,1088.8896484,22.0112686,0.0000000,0.0000000,179.9999390, -1, -1, -1, 400, 400); //object(trafficlight1) (2)
	CreateDynamicObject(1234,-238.3655853,1204.1806641,20.3018684,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(phonesign) (1)
	CreateDynamicObject(4238,87.3630753,1211.1602783,37.3717957,0.0000000,0.0000000,112.0000000, -1, -1, -1, 400, 400); //object(billbrdlan_10) (1)
	CreateDynamicObject(1260,87.5093994,1211.7805176,31.4621372,0.0000000,0.0000000,172.0000000, -1, -1, -1, 400, 400); //object(billbd3) (1)
	CreateDynamicObject(1259,-41.6623764,1210.1265869,29.0422897,0.0000000,0.0000000,99.9999390, -1, -1, -1, 400, 400); //object(billbd1) (1)
	CreateDynamicObject(4729,-41.1169930,1210.6052246,34.8305130,0.0000000,0.0000000,300.0000000, -1, -1, -1, 400, 400); //object(billbrdlan2_01) (1)
	CreateDynamicObject(8329,1.8949702,1137.6052246,43.3574257,0.0000000,0.0000000,306.0000000, -1, -1, -1, 400, 400); //object(vgsbboardsigns16) (1)
	CreateDynamicObject(1315,-198.3381958,1009.5904541,22.0112686,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(trafficlight1) (3)
	CreateDynamicObject(1315,-187.4436035,1025.2851562,22.0112686,0.0000000,0.0000000,359.9945374, -1, -1, -1, 400, 400); //object(trafficlight1) (4)
	CreateDynamicObject(8406,177.6167908,1099.6242676,23.7291298,0.0000000,0.0000000,92.0000000, -1, -1, -1, 400, 400); //object(carparksign01_lvs) (1)
	CreateDynamicObject(11417,181.0664520,1085.6452637,21.2332230,0.0000000,0.0000000,235.9999695, -1, -1, -1, 400, 400); //object(xenonsign2_sfse) (1)
	CreateDynamicObject(8406,177.3684387,1099.5906982,13.2291298,0.0000000,180.0000000,271.9995422, -1, -1, -1, 400, 400); //object(carparksign01_lvs) (5)
	CreateDynamicObject(10281,-285.9037781,1192.0074463,22.0770435,358.0775146,343.9907227,93.4485474, -1, -1, -1, 400, 400); //object(michsign_sfe) (1)
	CreateDynamicObject(6959,-307.3046875,1205.8427734,5.0215549,88.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vegasnbball1) (23)
	CreateDynamicObject(6959,-326.4344177,1185.4097900,4.7715549,88.0000000,0.0000000,92.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (24)
	CreateDynamicObject(6959,-307.7558594,1186.0605469,24.7715549,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(vegasnbball1) (25)
	CreateDynamicObject(6959,-285.9531250,1180.0654297,4.7715549,87.9949951,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(vegasnbball1) (26)
	CreateDynamicObject(6959,-306.5888672,1182.9521484,5.0215549,87.9895020,0.0000000,359.9890137, -1, -1, -1, 400, 400); //object(vegasnbball1) (27)
	CreateDynamicObject(10244,-293.7665710,1209.2382812,21.1921711,0.0000000,0.0000000,182.0000000, -1, -1, -1, 400, 400); //object(vicjump_sfe) (1)
	CreateDynamicObject(1707,-288.6378479,1191.1260986,18.7421875,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(kb_couch01) (1)
	CreateDynamicObject(9361,-291.4794922,1188.7099609,21.3155632,0.0000000,0.0000000,137.9992676, -1, -1, -1, 400, 400); //object(boatoffice_sfn) (1)
	CreateDynamicObject(6959,-306.2416077,1185.9394531,24.7715549,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(vegasnbball1) (29)
	CreateDynamicObject(10847,-298.9306641,1193.9433594,31.1094742,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(gen_whouse03_sfse01) (1)
	CreateDynamicObject(10847,-307.8403015,1193.7591553,31.1094742,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(gen_whouse03_sfse01) (2)
	CreateDynamicObject(1999,-290.1366882,1187.1719971,18.9405632,0.0000000,0.0000000,96.0000000, -1, -1, -1, 400, 400); //object(officedesk2) (1)
	CreateDynamicObject(1671,-289.3846741,1188.0444336,19.4007778,0.0000000,0.0000000,278.0000000, -1, -1, -1, 400, 400); //object(swivelchair_a) (1)
	CreateDynamicObject(1679,-290.7679443,1194.8238525,19.1809921,0.0000000,0.0000000,46.0000000, -1, -1, -1, 400, 400); //object(chairsntableml) (1)
	CreateDynamicObject(1721,-293.7242432,1185.5711670,18.9645710,0.0000000,0.0000000,4.0000000, -1, -1, -1, 400, 400); //object(est_chair1) (2)
	CreateDynamicObject(1721,-294.4310913,1185.5303955,18.9741058,0.0000000,0.0000000,3.9990234, -1, -1, -1, 400, 400); //object(est_chair1) (3)
	CreateDynamicObject(1721,-295.0867004,1185.4990234,18.9829464,0.0000000,0.0000000,3.9990234, -1, -1, -1, 400, 400); //object(est_chair1) (4)
	CreateDynamicObject(1721,-295.4040527,1187.3289795,18.9859257,0.0000000,0.0000000,273.9990234, -1, -1, -1, 400, 400); //object(est_chair1) (5)
	CreateDynamicObject(1721,-295.4723816,1188.1418457,18.9862709,0.0000000,0.0000000,273.9935303, -1, -1, -1, 400, 400); //object(est_chair1) (6)
	CreateDynamicObject(1721,-295.5325928,1189.0137939,18.9864655,0.0000000,0.0000000,273.9935303, -1, -1, -1, 400, 400); //object(est_chair1) (7)
	CreateDynamicObject(2206,-294.0024414,1189.0828857,18.2175465,0.0000000,0.0000000,272.0000000, -1, -1, -1, 400, 400); //object(med_office8_desk_02) (1)
	CreateDynamicObject(2254,-287.3808594,1188.4707031,20.8343277,0.0000000,0.0000000,271.9990234, -1, -1, -1, 400, 400); //object(frame_clip_1) (1)
	CreateDynamicObject(3660,-192.7656250,1175.0214844,20.9882278,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(lasairfbed_las) (1)
	CreateDynamicObject(3660,-192.7074432,1155.4432373,20.9882278,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(lasairfbed_las) (2)
	CreateDynamicObject(3660,-192.7105255,1136.1696777,20.9882278,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(lasairfbed_las) (3)
	CreateDynamicObject(3660,-192.7491760,1121.3575439,20.9882278,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(lasairfbed_las) (4)
	CreateDynamicObject(7662,-193.0623627,1045.9991455,19.3313599,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(miragehedge14) (1)
	CreateDynamicObject(7662,-193.1605835,1037.9641113,19.3313599,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(miragehedge14) (2)
	CreateDynamicObject(18014,-258.7853088,1208.3177490,19.1743908,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(int_rest_veg03) (1)
	CreateDynamicObject(18014,-238.1070099,1208.1993408,19.1743908,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(int_rest_veg03) (3)
	CreateDynamicObject(1217,-298.0195312,1189.1279297,19.4135666,0.0000000,177.9949951,0.0000000, -1, -1, -1, 400, 400); //object(barrel2) (1)
	CreateDynamicObject(1217,-297.0869141,1189.4882812,19.4135666,0.0000000,177.9895020,0.0000000, -1, -1, -1, 400, 400); //object(barrel2) (2)
	CreateDynamicObject(2609,-288.6268921,1190.0683594,19.6722736,0.0000000,0.0000000,3.9980469, -1, -1, -1, 400, 400); //object(cj_p_fileing1) (2)
	CreateDynamicObject(2609,-288.1289673,1190.1230469,19.6722736,0.0000000,0.0000000,3.9935303, -1, -1, -1, 400, 400); //object(cj_p_fileing1) (3)
	CreateDynamicObject(2609,-289.1229248,1190.0136719,19.6722736,0.0000000,0.0000000,3.9935303, -1, -1, -1, 400, 400); //object(cj_p_fileing1) (4)
	CreateDynamicObject(2609,-300.2172852,1184.0076904,19.4738979,0.0000000,0.0000000,181.9935303, -1, -1, -1, 400, 400); //object(cj_p_fileing1) (5)
	CreateDynamicObject(2609,-299.7172241,1184.0273438,19.4738979,0.0000000,0.0000000,181.9885254, -1, -1, -1, 400, 400); //object(cj_p_fileing1) (6)
	CreateDynamicObject(2609,-299.2172241,1184.0478516,19.4738979,0.0000000,0.0000000,181.9885254, -1, -1, -1, 400, 400); //object(cj_p_fileing1) (7)
	CreateDynamicObject(2609,-298.7172241,1184.0683594,19.4738979,0.0000000,0.0000000,181.9885254, -1, -1, -1, 400, 400); //object(cj_p_fileing1) (8)
	CreateDynamicObject(2609,-298.2172241,1184.0888672,19.4738979,0.0000000,0.0000000,181.9885254, -1, -1, -1, 400, 400); //object(cj_p_fileing1) (9)
	CreateDynamicObject(2737,-302.3526611,1183.5932617,20.4427032,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(police_nb_car) (1)
	CreateDynamicObject(18092,-304.6919556,1186.8870850,19.2421875,0.0000000,0.0000000,92.0000000, -1, -1, -1, 400, 400); //object(ammun3_counter) (1)
	CreateDynamicObject(18092,-302.9892578,1188.8359375,19.2421875,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(ammun3_counter) (2)
	CreateDynamicObject(1010,-301.1090393,1189.3382568,19.7427082,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(nto_b_tw) (1)
	CreateDynamicObject(1009,-301.0205078,1188.7060547,19.9927082,0.0000000,90.0000000,0.0000000, -1, -1, -1, 400, 400); //object(nto_b_s) (1)
	CreateDynamicObject(1372,-259.8057251,1220.3657227,18.7421875,0.0000000,0.0000000,267.9990234, -1, -1, -1, 400, 400); //object(cj_dump2_low) (1)
	CreateDynamicObject(1327,-295.9600525,1186.5440674,19.7101612,61.4207153,35.1834412,328.2387390, -1, -1, -1, 400, 400); //object(junk_tyre) (1)
	CreateDynamicObject(1116,-304.2634583,1183.5153809,20.2219887,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fbb_lr_slv2) (1)
	CreateDynamicObject(1428,-296.3222046,1188.8874512,20.3100433,0.0000000,0.0000000,278.0000000, -1, -1, -1, 400, 400); //object(dyn_ladder) (1)
	CreateDynamicObject(2465,-288.1984253,1190.4075928,20.9146919,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(model_box2) (1)
	CreateDynamicObject(1685,-294.8111877,1191.5634766,19.4921875,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(blockpallet) (1)
	CreateDynamicObject(6959,-307.7558594,1186.0605469,18.7715549,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(vegasnbball1) (25)
	CreateDynamicObject(2891,-304.9887085,1189.0317383,19.7427082,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(kmb_packet) (1)
	CreateDynamicObject(1210,-289.9970093,1187.0198975,19.9015007,88.0000000,180.0000000,268.0000000, -1, -1, -1, 400, 400); //object(briefcase) (1)
	CreateDynamicObject(2690,-291.0343018,1190.2204590,20.2999802,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_fire_ext) (1)
	CreateDynamicObject(2690,-305.6943359,1183.5556641,19.6016045,0.0000000,0.0000000,177.9949951, -1, -1, -1, 400, 400); //object(cj_fire_ext) (3)
	CreateDynamicObject(2690,-305.6943359,1183.5556641,20.6016045,0.0000000,0.0000000,177.9949951, -1, -1, -1, 400, 400); //object(cj_fire_ext) (4)
	CreateDynamicObject(1750,-304.6441956,1184.9792480,19.7427082,0.0000000,0.0000000,118.0000000, -1, -1, -1, 400, 400); //object(med_tv_2) (1)
	CreateDynamicObject(3660,-192.8774414,1056.9689941,21.1921310,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(lasairfbed_las) (1)
	CreateDynamicObject(1215,-190.9977112,1085.7036133,19.3427238,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.1091003,1085.6683350,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.1019897,1081.9179688,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.0407257,1078.1683350,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.0395050,1074.2390137,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.0492249,1069.7382812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.0589905,1065.2382812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.0687561,1060.7382812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.0785217,1056.2382812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.0882874,1051.7382812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.0974884,1047.4882812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.1068420,1042.9882812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.1166077,1038.4882812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.1258087,1034.2382812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-195.1323395,1030.9882812,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-191.0449677,1030.9964600,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-190.9820709,1034.2215576,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-190.9862823,1038.4564209,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-190.9939270,1042.9632568,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-191.0096283,1047.4832764,19.3456230,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-190.9864197,1051.9685059,19.3456230,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-191.0786133,1056.1699219,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-191.0688477,1060.6699219,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-191.0585938,1065.2207031,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-191.0532227,1069.9238281,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-191.0393066,1074.2714844,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-191.0405273,1078.0996094,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1215,-191.1018066,1081.9511719,19.3533859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (90)
	CreateDynamicObject(1360,-191.4030762,1000.7565308,19.5450382,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (1)
	CreateDynamicObject(1360,-191.4354248,1004.7450562,19.5573940,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (2)
	CreateDynamicObject(1360,-194.6845703,1004.7457275,19.5573940,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (3)
	CreateDynamicObject(1360,-194.7242584,1000.4951172,19.5573940,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (4)
	CreateDynamicObject(1360,-194.7400513,996.4873657,19.5573940,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (5)
	CreateDynamicObject(1360,-191.2389679,996.2269287,19.5349102,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (6)
	CreateDynamicObject(1361,-193.0404358,995.6052246,19.4933853,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop2) (1)
	CreateDynamicObject(1361,-193.0509796,1005.5715332,19.5313263,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop2) (2)
	CreateDynamicObject(978,-191.9526215,989.5136719,19.2774487,0.0000000,0.0000000,260.0000000, -1, -1, -1, 400, 400); //object(sub_roadright) (1)
	CreateDynamicObject(978,-191.9521484,989.5136719,19.2774487,0.0000000,0.0000000,79.9969482, -1, -1, -1, 400, 400); //object(sub_roadright) (2)
	CreateDynamicObject(978,-194.4521484,989.5289307,19.2774487,0.0000000,0.0000000,99.9969482, -1, -1, -1, 400, 400); //object(sub_roadright) (3)
	CreateDynamicObject(978,-194.4521484,989.5283203,19.2774487,0.0000000,0.0000000,279.9921265, -1, -1, -1, 400, 400); //object(sub_roadright) (4)
	CreateDynamicObject(1215,-191.1894531,998.4589844,19.3326721,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (130)
	CreateDynamicObject(1215,-191.1670532,1002.6911011,19.3419895,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (131)
	CreateDynamicObject(1215,-191.1669922,1002.6904297,19.3419895,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (132)
	CreateDynamicObject(1215,-194.8184814,1002.6068726,19.3428783,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (132)
	CreateDynamicObject(1215,-194.8399200,998.4941406,19.3298206,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (132)
	CreateDynamicObject(1215,-193.1535645,984.2218628,18.8100491,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (130)
	CreateDynamicObject(6959,-110.1041183,1417.8253174,11.2321892,0.0000000,0.0000000,11.9915771, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(6959,-89.6298599,1417.1175537,-8.7594433,271.9940186,179.9945068,101.9924927, -1, -1, -1, 400, 400); //object(vegasnbball1) (39)
	CreateDynamicObject(970,-126.2962112,1408.1906738,11.7524204,0.0000000,0.0000000,103.9862366, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(1597,-128.4753113,1410.7451172,13.8583212,0.0000000,0.0000000,13.9989014, -1, -1, -1, 400, 400); //object(cntrlrsac1) (1)
	CreateDynamicObject(1215,-96.2817078,1413.3918457,11.7652626,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (138)
	CreateDynamicObject(1231,-128.8051605,1416.0032959,13.9313316,0.0000000,0.0000000,342.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (8)
	CreateDynamicObject(1280,-125.8729324,1409.9931641,11.6022949,0.0000000,0.0000000,193.9971771, -1, -1, -1, 400, 400); //object(parkbench1) (3)
	CreateDynamicObject(1533,-96.6037292,1412.8110352,11.8828669,0.0000000,0.0000000,191.9970551, -1, -1, -1, 400, 400); //object(gen_doorext12) (3)
	CreateDynamicObject(9241,-94.8338089,1382.3366699,31.3941994,0.0000000,0.0000000,191.9970703, -1, -1, -1, 400, 400); //object(copbits_sfn) (1)
	CreateDynamicObject(16096,-93.5377350,1402.8729248,30.9941330,0.0000000,0.0000000,12.0000000, -1, -1, -1, 400, 400); //object(des_a51guardbox04) (1)
	CreateDynamicObject(2946,-96.1055603,1402.4217529,29.8353004,0.0000000,0.0000000,12.0000000, -1, -1, -1, 400, 400); //object(cr_door_03) (1)
	CreateDynamicObject(2946,-96.2114410,1402.6477051,29.8920517,0.0000000,0.0000000,191.9970703, -1, -1, -1, 400, 400); //object(cr_door_03) (2)
	CreateDynamicObject(5725,21.2304649,1175.6240234,26.7197838,0.0000000,0.0000000,359.7253418, -1, -1, -1, 400, 400); //object(holpacific2_law) (1)
	CreateDynamicObject(10022,8.4414062,1077.1298828,37.9794617,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vicstuff_sfe04) (1)
	CreateDynamicObject(1345,-44.6253052,1062.2664795,19.5123234,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_dumpster) (1)
	CreateDynamicObject(1345,-34.9082184,1058.9575195,19.5123234,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_dumpster) (2)
	CreateDynamicObject(8841,71.9707031,1164.1025391,20.7403030,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(rsdncarprk01_lvs) (1)
	CreateDynamicObject(970,75.6835556,1183.5186768,18.3814144,0.0000000,0.0000000,51.9982910, -1, -1, -1, 400, 400); //object(fencesmallb) (11)
	CreateDynamicObject(970,78.3256760,1186.8831787,18.3814144,0.0000000,0.0000000,51.9982910, -1, -1, -1, 400, 400); //object(fencesmallb) (12)
	CreateDynamicObject(970,72.2015381,1181.7805176,18.4554710,0.0000000,0.0000000,1.9982910, -1, -1, -1, 400, 400); //object(fencesmallb) (13)
	CreateDynamicObject(970,67.9440308,1181.6253662,18.5000801,0.0000000,0.0000000,1.9940186, -1, -1, -1, 400, 400); //object(fencesmallb) (14)
	CreateDynamicObject(970,63.7062340,1181.4752197,18.5161877,0.0000000,0.0000000,1.9940186, -1, -1, -1, 400, 400); //object(fencesmallb) (15)
	CreateDynamicObject(970,59.4578056,1181.3521729,18.5161877,0.0000000,0.0000000,1.9940186, -1, -1, -1, 400, 400); //object(fencesmallb) (16)
	CreateDynamicObject(970,55.2075500,1181.2851562,18.5161877,0.0000000,0.0000000,1.9940186, -1, -1, -1, 400, 400); //object(fencesmallb) (18)
	CreateDynamicObject(970,50.9634972,1181.1568604,18.5161877,0.0000000,0.0000000,1.9940186, -1, -1, -1, 400, 400); //object(fencesmallb) (20)
	CreateDynamicObject(970,77.3973389,1188.4267578,18.2330303,0.0000000,0.0000000,359.9940186, -1, -1, -1, 400, 400); //object(fencesmallb) (21)
	CreateDynamicObject(970,73.1492844,1188.4227295,18.2724514,0.0000000,0.0000000,359.9890137, -1, -1, -1, 400, 400); //object(fencesmallb) (22)
	CreateDynamicObject(970,68.8989716,1188.4512939,18.3118935,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fencesmallb) (23)
	CreateDynamicObject(970,64.6799774,1188.5212402,18.3510437,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fencesmallb) (24)
	CreateDynamicObject(970,60.4148865,1188.5439453,18.3838158,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fencesmallb) (25)
	CreateDynamicObject(970,56.1731720,1188.5480957,18.4190331,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fencesmallb) (26)
	CreateDynamicObject(970,51.9541092,1188.5781250,18.4540634,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fencesmallb) (27)
	CreateDynamicObject(973,99.1435547,1188.1591797,18.5042820,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,108.5273590,1187.8454590,18.5042820,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (2)
	CreateDynamicObject(994,58.7819252,1166.4080811,16.6640625,0.0000000,0.0000000,62.0000000, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (1)
	CreateDynamicObject(994,60.7955284,1170.1508789,16.6640625,0.0000000,0.0000000,61.9958496, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (2)
	CreateDynamicObject(994,67.3008728,1169.7985840,16.6640625,0.0000000,0.0000000,61.9958496, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (3)
	CreateDynamicObject(994,65.0439682,1165.5876465,16.6640625,0.0000000,0.0000000,61.9958496, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (4)
	CreateDynamicObject(994,74.0277252,1169.7915039,16.6640625,0.0000000,0.0000000,61.9958496, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (5)
	CreateDynamicObject(994,71.2360077,1164.5064697,16.6640625,0.0000000,0.0000000,61.9958496, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (6)
	CreateDynamicObject(994,80.2724609,1169.5937500,16.6640625,0.0000000,0.0000000,61.9903564, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (7)
	CreateDynamicObject(994,77.5153122,1164.3919678,16.6640625,0.0000000,0.0000000,61.9958496, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (8)
	CreateDynamicObject(996,90.5035553,1179.8131104,18.4128170,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(lhouse_barrier1) (3)
	CreateDynamicObject(996,90.5263672,1171.4423828,18.4053020,0.0000000,0.0000000,269.9890137, -1, -1, -1, 400, 400); //object(lhouse_barrier1) (5)
	CreateDynamicObject(5725,21.3730469,1186.0146484,9.0497856,0.0000000,0.0000000,359.7308350, -1, -1, -1, 400, 400); //object(holpacific2_law) (1)
	CreateDynamicObject(1256,61.9434814,1165.0522461,18.3841343,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (10)
	CreateDynamicObject(1256,61.9487114,1162.6464844,18.3841343,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (11)
	CreateDynamicObject(1256,75.9958344,1165.2900391,18.3841343,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (12)
	CreateDynamicObject(8168,61.7750244,1156.6374512,19.6120358,0.0000000,0.0000000,195.9999542, -1, -1, -1, 400, 400); //object(vgs_guardhouse01) (1)
	CreateDynamicObject(8168,54.7170410,1156.8281250,19.6120358,0.0000000,0.0000000,193.9960938, -1, -1, -1, 400, 400); //object(vgs_guardhouse01) (3)
	CreateDynamicObject(8169,62.1754417,1161.1251221,17.6640625,0.0000000,0.0000000,16.0000000, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (3)
	CreateDynamicObject(8169,55.3945312,1161.0712891,17.6640625,0.0000000,0.0000000,15.9906006, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (4)
	CreateDynamicObject(8169,51.8779297,1162.2939453,17.6640625,0.0000000,0.0000000,285.9960938, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(8169,53.0341797,1163.1601562,17.6640625,0.0000000,0.0000000,285.9960938, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(800,55.1526489,1185.0356445,19.1067486,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(genveg_bush07) (1)
	CreateDynamicObject(800,60.1258240,1185.3110352,19.1067486,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(genveg_bush07) (2)
	CreateDynamicObject(800,64.5423813,1185.6435547,19.1067486,0.0000000,0.0000000,344.0000000, -1, -1, -1, 400, 400); //object(genveg_bush07) (3)
	CreateDynamicObject(800,69.9578705,1185.1174316,19.1067486,0.0000000,0.0000000,343.9984131, -1, -1, -1, 400, 400); //object(genveg_bush07) (4)
	CreateDynamicObject(800,73.6415634,1185.6042480,19.1067486,0.0000000,0.0000000,243.9984131, -1, -1, -1, 400, 400); //object(genveg_bush07) (5)
	CreateDynamicObject(800,66.6210632,1185.0656738,19.1067486,0.0000000,0.0000000,239.9953613, -1, -1, -1, 400, 400); //object(genveg_bush07) (6)
	CreateDynamicObject(800,59.7247124,1184.5498047,19.1067486,0.0000000,0.0000000,179.9908447, -1, -1, -1, 400, 400); //object(genveg_bush07) (7)
	CreateDynamicObject(800,52.8545532,1186.2250977,19.1067486,0.0000000,0.0000000,179.9890137, -1, -1, -1, 400, 400); //object(genveg_bush07) (8)
	CreateDynamicObject(800,52.8786201,1183.4746094,19.1067486,0.0000000,0.0000000,171.9890137, -1, -1, -1, 400, 400); //object(genveg_bush07) (9)
	CreateDynamicObject(800,56.9761353,1183.3531494,19.1067486,0.0000000,0.0000000,171.9854736, -1, -1, -1, 400, 400); //object(genveg_bush07) (10)
	CreateDynamicObject(872,74.8535461,1186.7720947,14.0291710,0.0000000,0.0000000,66.0000000, -1, -1, -1, 400, 400); //object(gen_tallgrsnew) (1)
	CreateDynamicObject(1360,61.9408531,1163.8497314,18.4360828,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (7)
	CreateDynamicObject(1361,89.5095520,1164.3552246,18.4680214,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop2) (3)
	CreateDynamicObject(1360,75.9750366,1164.1055908,18.4966984,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (8)
	CreateDynamicObject(1597,71.4072113,1187.2047119,20.1761665,0.0000000,2.0000000,90.0000000, -1, -1, -1, 400, 400); //object(cntrlrsac1) (2)
	CreateDynamicObject(2773,53.3849220,1160.4382324,18.1812916,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airprt_bar) (1)
	CreateDynamicObject(2773,51.8417511,1160.4873047,18.1812916,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airprt_bar) (2)
	CreateDynamicObject(2773,58.8443069,1160.2983398,18.1812916,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airprt_bar) (3)
	CreateDynamicObject(2773,60.3434296,1160.3286133,18.1812916,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airprt_bar) (4)
	CreateDynamicObject(2775,56.9156647,1159.4583740,21.0026875,0.0000000,0.0000000,178.0000000, -1, -1, -1, 400, 400); //object(cj_airprt_mon) (1)
	CreateDynamicObject(2775,62.3786507,1159.3223877,21.0026875,0.0000000,0.0000000,177.9949951, -1, -1, -1, 400, 400); //object(cj_airprt_mon) (2)
	CreateDynamicObject(2774,78.8269806,1165.3415527,9.9946232,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (1)
	CreateDynamicObject(2774,72.0732040,1165.1915283,9.9946232,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (2)
	CreateDynamicObject(2774,65.1833267,1165.3125000,9.9946232,0.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (3)
	CreateDynamicObject(2774,57.9336319,1165.4208984,9.9946232,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (4)
	CreateDynamicObject(2792,77.1458969,1166.1082764,20.8365917,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_air_d_1) (2)
	CreateDynamicObject(2792,78.3089600,1167.0544434,20.8365917,0.0000000,0.0000000,268.0000000, -1, -1, -1, 400, 400); //object(cj_air_d_1) (3)
	CreateDynamicObject(2793,70.4530945,1165.8620605,20.8286209,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_air_d_2) (1)
	CreateDynamicObject(2793,71.3679047,1166.9008789,20.8286209,0.0000000,0.0000000,268.0000000, -1, -1, -1, 400, 400); //object(cj_air_d_2) (2)
	CreateDynamicObject(2794,63.4886246,1166.1596680,20.8252354,0.0000000,0.0000000,356.0000000, -1, -1, -1, 400, 400); //object(cj_air_d_3) (1)
	CreateDynamicObject(2794,64.4703751,1167.1473389,20.8252354,0.0000000,0.0000000,273.9954834, -1, -1, -1, 400, 400); //object(cj_air_d_3) (2)
	CreateDynamicObject(2795,56.3447914,1166.2553711,20.8424644,0.0000000,0.0000000,356.0000000, -1, -1, -1, 400, 400); //object(cj_air_d_4) (1)
	CreateDynamicObject(2795,57.2041779,1167.1805420,20.8424644,0.0000000,0.0000000,269.9954834, -1, -1, -1, 400, 400); //object(cj_air_d_4) (3)
	CreateDynamicObject(7313,74.7384720,1165.9249268,21.6640625,0.0000000,0.0000000,181.9999695, -1, -1, -1, 400, 400); //object(vgsn_scrollsgn01) (1)
	CreateDynamicObject(7313,68.7504578,1165.6447754,21.6640625,0.0000000,0.0000000,181.9995270, -1, -1, -1, 400, 400); //object(vgsn_scrollsgn01) (2)
	CreateDynamicObject(7301,50.8515625,1181.6064453,28.0947933,0.0000000,0.0000000,223.9947510, -1, -1, -1, 400, 400); //object(vgsn_addboard03) (1)
	CreateDynamicObject(2697,57.7803993,1164.6000977,19.7158680,0.0000000,0.0000000,356.0000000, -1, -1, -1, 400, 400); //object(cj_banner14) (1)
	CreateDynamicObject(1231,79.4370193,1165.1445312,18.4550705,0.0000000,1.9995117,353.9959717, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(1231,72.6927032,1165.4345703,18.4550705,0.0000000,1.9995117,353.9959717, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(1231,65.6987915,1165.7353516,18.4550705,0.0000000,1.9995117,353.9959717, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(1231,58.5500336,1165.8397217,18.4550705,0.0000000,1.9995117,353.9959717, -1, -1, -1, 400, 400); //object(streetlamp2) (1)
	CreateDynamicObject(3460,91.0854950,1178.4881592,17.6271591,0.0000000,0.0000000,182.0000000, -1, -1, -1, 400, 400); //object(vegaslampost) (1)
	CreateDynamicObject(1226,94.5418320,1193.0396729,21.2144547,0.0000000,0.0000000,272.0000000, -1, -1, -1, 400, 400); //object(lamppost3) (1)
	CreateDynamicObject(1215,78.6696930,1187.9016113,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (139)
	CreateDynamicObject(1215,76.8052063,1185.5502930,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (140)
	CreateDynamicObject(1215,75.1895447,1183.3995361,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (141)
	CreateDynamicObject(1215,72.1143875,1182.2188721,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (142)
	CreateDynamicObject(1215,67.3677368,1182.0378418,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (143)
	CreateDynamicObject(1215,63.1203003,1181.8752441,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (144)
	CreateDynamicObject(1215,58.1237793,1181.6845703,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (145)
	CreateDynamicObject(1215,53.6263428,1181.5131836,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (146)
	CreateDynamicObject(1215,53.3193359,1165.9843750,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (147)
	CreateDynamicObject(1215,89.4140625,1166.1015625,18.2466354,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (148)
	CreateDynamicObject(1229,94.9875793,1191.8731689,18.8554535,0.0000000,0.0000000,92.0000000, -1, -1, -1, 400, 400); //object(bussign1) (1)
	CreateDynamicObject(1234,94.8278961,1192.2193604,18.8266773,0.0000000,0.0000000,176.0000000, -1, -1, -1, 400, 400); //object(phonesign) (2)
	CreateDynamicObject(1234,92.2426376,1162.4050293,19.2843590,0.0000000,0.0000000,175.9954834, -1, -1, -1, 400, 400); //object(phonesign) (3)
	CreateDynamicObject(1234,92.2421875,1162.4042969,19.2843590,0.0000000,0.0000000,277.9954834, -1, -1, -1, 400, 400); //object(phonesign) (4)
	CreateDynamicObject(1363,91.8243713,1160.2709961,18.4929104,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_phone_kiosk) (1)
	CreateDynamicObject(1363,91.8886261,1156.7705078,18.4929104,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_phone_kiosk) (2)
	CreateDynamicObject(982,93.8472977,1153.3795166,18.3401031,0.0000000,0.0000000,269.9969482, -1, -1, -1, 400, 400); //object(fenceshit) (8)
	CreateDynamicObject(982,68.3213196,1153.8015137,18.3401031,0.0000000,0.0000000,267.9945068, -1, -1, -1, 400, 400); //object(fenceshit) (9)
	CreateDynamicObject(984,49.1473656,1154.4782715,18.3007431,0.0000000,0.0000000,268.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (1)
	CreateDynamicObject(984,41.9112473,1161.0592041,18.3007431,0.0000000,0.0000000,187.9949951, -1, -1, -1, 400, 400); //object(fenceshit2) (2)
	CreateDynamicObject(1215,91.7625351,1160.2385254,19.1534500,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (149)
	CreateDynamicObject(1215,91.8923111,1156.7399902,19.1534500,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (150)
	CreateDynamicObject(983,107.3203125,1156.5009766,18.3476181,0.0000000,0.0000000,347.9974365, -1, -1, -1, 400, 400); //object(fenceshit3) (41)
	CreateDynamicObject(1775,99.2120667,1173.2546387,18.7610989,0.0000000,0.0000000,268.0000000, -1, -1, -1, 400, 400); //object(cj_sprunk1) (1)
	CreateDynamicObject(1775,99.1979294,1174.5006104,18.7610989,0.0000000,0.0000000,267.9949951, -1, -1, -1, 400, 400); //object(cj_sprunk1) (2)
	CreateDynamicObject(1775,99.2121048,1175.7500000,18.7610989,0.0000000,0.0000000,267.9949951, -1, -1, -1, 400, 400); //object(cj_sprunk1) (3)
	CreateDynamicObject(4848,105.7392578,1169.5097656,20.6057549,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(sanpedbeaut) (1)
	CreateDynamicObject(4848,105.7392578,1169.5097656,13.6457558,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(sanpedbeaut) (2)
	CreateDynamicObject(983,111.9199219,1184.4853516,18.3476181,0.0000000,0.0000000,347.9974365, -1, -1, -1, 400, 400); //object(fenceshit3) (41)
	CreateDynamicObject(7037,8.2176247,1132.0883789,23.6044388,0.0000000,0.0000000,269.9999695, -1, -1, -1, 400, 400); //object(vgnwalburger1) (1)
	CreateDynamicObject(2948,6.2588382,1139.8264160,18.8736038,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(cr_door_02) (1)
	CreateDynamicObject(2948,4.4434609,1139.8215332,18.8736038,0.0000000,0.0000000,89.9999695, -1, -1, -1, 400, 400); //object(cr_door_02) (2)
	CreateDynamicObject(1506,99.5888443,1179.5898438,19.9401550,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(gen_doorext08) (1)
	CreateDynamicObject(1506,99.5924377,1178.1019287,19.9401550,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(gen_doorext08) (2)
	CreateDynamicObject(2456,98.8028870,1169.7276611,22.6693859,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(cj_ff_stand02) (1)
	CreateDynamicObject(2456,99.1298065,1169.8944092,22.6693859,0.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(cj_ff_stand02) (2)
	CreateDynamicObject(2642,99.5544586,1171.1135254,21.2851982,0.0000000,0.0000000,269.9999695, -1, -1, -1, 400, 400); //object(cj_burger_poster2) (1)
	CreateDynamicObject(2641,99.5097504,1168.1420898,21.6242428,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(cj_burger_poster) (1)
	CreateDynamicObject(2948,99.5337830,1170.5933838,19.9401550,0.0000000,0.0000000,356.0000000, -1, -1, -1, 400, 400); //object(cr_door_02) (3)
	CreateDynamicObject(2948,99.5349121,1168.5927734,19.9401550,0.0000000,0.0000000,183.9954529, -1, -1, -1, 400, 400); //object(cr_door_02) (4)
	CreateDynamicObject(2948,99.5339661,1168.8427734,19.9401550,0.0000000,0.0000000,183.9935303, -1, -1, -1, 400, 400); //object(cr_door_02) (5)
	CreateDynamicObject(1215,98.8853989,1182.0854492,20.5044785,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (148)
	CreateDynamicObject(1215,98.8714600,1160.1010742,20.5044785,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (148)
	CreateDynamicObject(8260,-169.0039368,1065.5605469,22.2227306,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(vgswrehse18) (1)
	CreateDynamicObject(973,-322.7416992,1202.7850342,21.4005013,87.9950562,0.0000000,179.9895020, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-322.6823120,1201.2836914,21.4005013,87.9950562,0.0000000,359.9890137, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-313.9425659,1201.4237061,19.4005013,63.9284973,85.9072266,276.5375977, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-313.9694824,1202.9228516,19.4005013,63.9239502,85.9020996,276.5368652, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(2633,-325.0693359,1204.5223389,20.0668354,0.0000000,0.0000000,359.9890137, -1, -1, -1, 400, 400); //object(crack_walkway1) (2)
	CreateDynamicObject(2633,-320.8161011,1204.5346680,20.0668354,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(crack_walkway1) (2)
	CreateDynamicObject(3361,-314.6740723,1199.6384277,19.5160599,0.0000000,0.0000000,359.9949951, -1, -1, -1, 400, 400); //object(cxref_woodstair) (1)
	CreateDynamicObject(3361,-314.7641602,1204.6376953,19.5160599,0.0000000,0.0000000,359.9945068, -1, -1, -1, 400, 400); //object(cxref_woodstair) (1)
	CreateDynamicObject(2633,-320.9161377,1199.5341797,20.0668354,0.0000000,0.0000000,181.9835052, -1, -1, -1, 400, 400); //object(crack_walkway1) (2)
	CreateDynamicObject(6959,-306.2001343,1185.7788086,18.7715549,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(vegasnbball1) (25)
	CreateDynamicObject(973,-312.3475952,1185.7041016,18.9005013,87.9971008,0.1260376,89.8502808, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-314.0964661,1185.7357178,18.9005013,87.9950562,0.1208801,267.8463135, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-313.7546387,1194.9114990,17.6505013,73.8823242,276.9582520,350.7220459, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-312.1758728,1194.8730469,17.6505013,73.8775635,276.9543152,350.7165833, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-319.0897827,1186.0037842,18.9005013,87.9950562,0.1208496,89.8461914, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-320.8391113,1186.0286865,18.9005013,87.9949951,0.1208496,267.8411865, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-320.4973145,1195.2044678,17.6505013,73.8775635,276.9543152,350.7165527, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(973,-318.9191895,1195.1663818,17.6505013,73.8775635,276.9543152,350.7165833, -1, -1, -1, 400, 400); //object(sub_roadbarrier) (1)
	CreateDynamicObject(3463,-193.0717468,990.9396973,18.4230366,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegaslampost2) (1)
	CreateDynamicObject(14438,-310.8887024,1196.5506592,26.6470928,0.0000000,0.0000000,4.0000000, -1, -1, -1, 400, 400); //object(carter-light04) (1)
	CreateDynamicObject(8615,-1.3644816,1281.0554199,15.6674957,0.0000000,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(vgssstairs04_lvs) (1)
	CreateDynamicObject(8615,-4.2909956,1275.9613037,11.1674957,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgssstairs04_lvs) (2)
	CreateDynamicObject(11439,-63.4227791,1292.7045898,9.3131771,0.0000000,0.0000000,94.0000000, -1, -1, -1, 400, 400); //object(des_woodbr_) (1)
	CreateDynamicObject(8615,-24.9150391,1290.1357422,19.4174957,0.0000000,0.0000000,3.9990234, -1, -1, -1, 400, 400); //object(vgssstairs04_lvs) (4)
	CreateDynamicObject(3504,101.1105423,1185.1689453,19.0064259,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (1)
	CreateDynamicObject(3504,102.8260651,1185.1833496,19.0064259,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (2)
	CreateDynamicObject(3504,104.4878845,1185.1826172,19.0064259,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (3)
	CreateDynamicObject(3504,106.1127625,1185.1727295,19.0064259,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (4)
	CreateDynamicObject(3504,107.6763611,1185.1967773,19.0064259,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (5)
	CreateDynamicObject(6875,-100.5942764,1376.1101074,-1.7331591,0.0000000,0.0000000,282.0000000, -1, -1, -1, 400, 400); //object(vgn_corpbuild4) (1)
	CreateDynamicObject(7191,-78.7990112,1392.4630127,13.0939827,0.0000000,358.0000000,191.9975891, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (7)
	CreateDynamicObject(14409,-91.4947205,1439.9678955,8.0859280,0.0000000,0.0000000,279.9975586, -1, -1, -1, 400, 400); //object(carter-stairs02) (1)
	CreateDynamicObject(1533,-98.0670319,1412.4816895,11.8828669,0.0000000,0.0000000,191.9970551, -1, -1, -1, 400, 400); //object(gen_doorext12) (3)
	CreateDynamicObject(1533,-99.5299225,1412.1525879,11.8828669,0.0000000,0.0000000,191.9970551, -1, -1, -1, 400, 400); //object(gen_doorext12) (3)
	CreateDynamicObject(1533,-100.9928131,1411.8234863,11.8828669,0.0000000,0.0000000,191.9970703, -1, -1, -1, 400, 400); //object(gen_doorext12) (3)
	CreateDynamicObject(7191,-106.5314865,1410.5140381,12.3439827,0.0000000,0.0000000,281.9975586, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (8)
	CreateDynamicObject(1597,-126.9700699,1420.8894043,13.8583212,0.0000000,0.0000000,329.9965820, -1, -1, -1, 400, 400); //object(cntrlrsac1) (1)
	CreateDynamicObject(1597,-122.7393494,1430.5490723,13.8583212,0.0000000,0.0000000,345.9963379, -1, -1, -1, 400, 400); //object(cntrlrsac1) (1)
	CreateDynamicObject(6959,-109.9289856,1437.4642334,-8.7594433,271.9885254,179.9945068,191.9915771, -1, -1, -1, 400, 400); //object(vegasnbball1) (39)
	CreateDynamicObject(14409,-90.8920670,1436.5133057,8.0859280,0.0000000,0.0000000,279.9975586, -1, -1, -1, 400, 400); //object(carter-stairs02) (1)
	CreateDynamicObject(14409,-90.2699051,1432.8479004,8.0859280,0.0000000,0.0000000,279.9975586, -1, -1, -1, 400, 400); //object(carter-stairs02) (1)
	CreateDynamicObject(6959,-108.1218033,1426.3621826,-8.7594433,271.9829712,179.9945068,191.9860840, -1, -1, -1, 400, 400); //object(vegasnbball1) (39)
	CreateDynamicObject(970,-127.2933960,1412.2469482,11.7524204,0.0000000,0.0000000,103.9855957, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-127.2857361,1416.2279053,11.7524204,0.0000000,0.0000000,75.9855957, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-125.8082199,1420.0493164,11.7524204,0.0000000,0.0000000,61.9814758, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-123.8625259,1423.6936035,11.7605114,0.0000000,0.0000000,61.9793701, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-122.2393417,1427.4531250,11.7524204,0.0000000,0.0000000,71.9793701, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-121.0509644,1431.3803711,11.7524204,0.0000000,0.0000000,73.9769287, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-121.9041595,1435.6269531,11.7524204,0.0000000,0.0000000,189.9760132, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-120.3813400,1434.0202637,11.7524204,0.0000000,0.0000000,75.9755859, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(1231,-123.8817291,1425.3321533,13.9313316,0.0000000,0.0000000,327.9989014, -1, -1, -1, 400, 400); //object(streetlamp2) (8)
	CreateDynamicObject(1280,-126.9587479,1416.1951904,11.6022949,0.0000000,0.0000000,165.9965820, -1, -1, -1, 400, 400); //object(parkbench1) (3)
	CreateDynamicObject(1280,-124.0149841,1422.8325195,11.6022949,0.0000000,0.0000000,151.9924316, -1, -1, -1, 400, 400); //object(parkbench1) (3)
	CreateDynamicObject(1280,-121.3855286,1429.0969238,11.6022949,0.0000000,0.0000000,163.9903564, -1, -1, -1, 400, 400); //object(parkbench1) (3)
	CreateDynamicObject(1280,-119.8825073,1434.6724854,11.6022949,0.0000000,0.0000000,167.9874268, -1, -1, -1, 400, 400); //object(parkbench1) (3)
	CreateDynamicObject(14409,-99.1765213,1415.2932129,8.8359280,0.0000000,0.0000000,11.9975586, -1, -1, -1, 400, 400); //object(carter-stairs02) (1)
	CreateDynamicObject(14409,-101.1320267,1414.8924561,8.8359280,0.0000000,0.0000000,11.9970703, -1, -1, -1, 400, 400); //object(carter-stairs02) (1)
	CreateDynamicObject(1215,-102.8854065,1411.9941406,11.7652626,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (138)
	CreateDynamicObject(970,-117.8984375,1436.4421387,11.7524204,0.0000000,0.0000000,191.9755859, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-113.8562622,1437.3022461,11.7524204,0.0000000,0.0000000,191.9751129, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-109.8256302,1438.1616211,11.7524204,0.0000000,0.0000000,191.9751129, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-105.7964172,1439.0067139,11.7524204,0.0000000,0.0000000,191.9751129, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-101.7742004,1439.8585205,11.7524204,0.0000000,0.0000000,191.9751129, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-97.7422256,1440.7250977,11.7524204,0.0000000,0.0000000,191.9751129, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(970,-93.6165466,1441.5996094,11.8055124,0.0000000,0.0000000,191.9750977, -1, -1, -1, 400, 400); //object(fencesmallb) (5)
	CreateDynamicObject(6959,-131.0539398,1414.1330566,-8.7594433,271.9884949,179.9945068,101.9915771, -1, -1, -1, 400, 400); //object(vegasnbball1) (39)
	CreateDynamicObject(1231,-98.8250961,1426.7661133,13.9313316,0.0000000,0.0000000,283.9965820, -1, -1, -1, 400, 400); //object(streetlamp2) (8)
	CreateDynamicObject(1231,-110.4163361,1424.8436279,13.9313316,0.0000000,0.0000000,283.9965820, -1, -1, -1, 400, 400); //object(streetlamp2) (8)
	CreateDynamicObject(2614,-99.3659515,1412.1735840,15.4944277,0.0000000,0.0000000,192.0000000, -1, -1, -1, 400, 400); //object(cj_us_flag) (1)
	CreateDynamicObject(7091,-81.2650604,1401.2081299,27.3548584,0.0000000,0.0000000,10.0000000, -1, -1, -1, 400, 400); //object(vegasflag02) (1)
	CreateDynamicObject(7091,-80.3199463,1395.0312500,27.3548584,0.0000000,0.0000000,9.9975586, -1, -1, -1, 400, 400); //object(vegasflag02) (2)
	CreateDynamicObject(7091,-79.2614746,1388.1132812,27.3548584,0.0000000,0.0000000,9.9975586, -1, -1, -1, 400, 400); //object(vegasflag02) (3)
	CreateDynamicObject(7091,-78.2406616,1381.4423828,27.3548584,0.0000000,0.0000000,9.9975586, -1, -1, -1, 400, 400); //object(vegasflag02) (4)
	CreateDynamicObject(2796,99.1766205,1184.4420166,21.0127335,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_air_d_6) (1)
	CreateDynamicObject(2796,99.6409073,1185.2136230,21.0127335,0.0000000,0.0000000,269.9999695, -1, -1, -1, 400, 400); //object(cj_air_d_6) (2)
	CreateDynamicObject(1215,110.1817322,1186.4255371,18.2283859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (148)
	CreateDynamicObject(2662,89.5248795,1160.3737793,19.0243359,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(cj_banner08) (1)
	CreateDynamicObject(2643,97.9619293,1169.7260742,20.3614788,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(cj_burger_poster3) (1)
	CreateDynamicObject(2643,98.2117691,1169.7170410,20.3614788,0.0000000,0.0000000,92.0000000, -1, -1, -1, 400, 400); //object(cj_burger_poster3) (4)
	CreateDynamicObject(2643,92.5641556,1185.1713867,25.3686237,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(cj_burger_poster3) (6)
	CreateDynamicObject(2643,92.8178711,1185.1248779,25.3686237,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(cj_burger_poster3) (7)
	CreateDynamicObject(2685,99.7778320,1184.8504639,19.3850193,0.0000000,0.0000000,179.9999390, -1, -1, -1, 400, 400); //object(cj_food_post1) (1)
	CreateDynamicObject(1215,110.1816406,1186.4248047,18.2283859,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (148)
	CreateDynamicObject(13132,-147.7919922,1083.1923828,21.9994965,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(ce_bar01) (1)
	CreateDynamicObject(17558,-98.2255859,1344.1445312,12.8456898,0.0000000,0.0000000,95.9985352, -1, -1, -1, 400, 400); //object(mstorcp4_lae2) (1)
	CreateDynamicObject(3069,-82.2348633,1345.7800293,10.4172707,346.0000000,0.0000000,276.0000000, -1, -1, -1, 400, 400); //object(d9_ramp) (1)
	CreateDynamicObject(5737,-96.2028809,1372.9222412,11.9634457,0.0000000,0.0000000,184.5249023, -1, -1, -1, 400, 400); //object(archshop07_law02) (3)
	CreateDynamicObject(6959,-102.0338669,1347.2280273,18.2321892,0.0000000,0.0000000,5.9915771, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(6959,-104.7695312,1346.9589844,18.2321892,0.0000000,0.0000000,5.9875488, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(6959,-103.4873047,1327.5253906,-2.1178102,0.0000000,267.9949951,95.9820557, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(6959,-124.1571274,1344.7399902,-1.8678102,0.0000000,267.9949341,5.9820557, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(6959,-106.1999664,1359.7453613,-3.1178102,0.0000000,270.0000000,277.9767151, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(6959,-82.9527435,1369.3653564,-1.5778084,274.0000000,0.0000000,275.9875488, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(6959,-107.2836380,1367.2031250,-2.1178102,0.0000000,270.0000000,277.9760742, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(6959,-106.0755005,1398.5690918,-8.7594433,271.9884949,179.9943848,193.9915161, -1, -1, -1, 400, 400); //object(vegasnbball1) (39)
	CreateDynamicObject(1533,-91.4639587,1360.6673584,10.4238148,0.0000000,0.0000000,5.9971008, -1, -1, -1, 400, 400); //object(gen_doorext12) (3)
	CreateDynamicObject(1533,-89.9725800,1360.8216553,10.4238148,0.0000000,0.0000000,5.9930420, -1, -1, -1, 400, 400); //object(gen_doorext12) (3)
	CreateDynamicObject(1533,-91.4638672,1360.6669922,14.4238148,0.0000000,0.0000000,5.9930420, -1, -1, -1, 400, 400); //object(gen_doorext12) (3)
	CreateDynamicObject(1533,-89.9665222,1360.7563477,14.4238148,0.0000000,0.0000000,5.9930420, -1, -1, -1, 400, 400); //object(gen_doorext12) (3)
	CreateDynamicObject(1223,-85.1563339,1424.4250488,8.3989868,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(lampost_coast) (1)
	CreateDynamicObject(1290,-67.6786194,1412.7583008,14.6195383,0.0000000,0.0000000,106.0000000, -1, -1, -1, 400, 400); //object(lamppost2) (1)
	CreateDynamicObject(1290,-67.6777344,1412.7578125,14.6195383,0.0000000,0.0000000,105.9960938, -1, -1, -1, 400, 400); //object(lamppost2) (6)
	CreateDynamicObject(1290,-61.1600876,1378.3649902,14.6195383,0.0000000,0.0000000,105.9960938, -1, -1, -1, 400, 400); //object(lamppost2) (8)
	CreateDynamicObject(1290,-61.1591797,1378.3642578,14.6195383,0.0000000,0.0000000,105.9960938, -1, -1, -1, 400, 400); //object(lamppost2) (9)
	CreateDynamicObject(1290,-56.6748047,1345.8798828,14.6195383,0.0000000,0.0000000,95.9930420, -1, -1, -1, 400, 400); //object(lamppost2) (10)
	CreateDynamicObject(1290,-56.6748047,1345.8798828,14.6195383,0.0000000,0.0000000,95.9930420, -1, -1, -1, 400, 400); //object(lamppost2) (11)
	CreateDynamicObject(1290,-58.0732574,1306.8851318,14.6195383,0.0000000,0.0000000,95.9930420, -1, -1, -1, 400, 400); //object(lamppost2) (12)
	CreateDynamicObject(1290,-58.0732422,1306.8847656,14.6195383,0.0000000,0.0000000,95.9930420, -1, -1, -1, 400, 400); //object(lamppost2) (13)
	CreateDynamicObject(1290,-74.1562653,1307.3593750,14.6195383,0.0000000,0.0000000,95.9930420, -1, -1, -1, 400, 400); //object(lamppost2) (14)
	CreateDynamicObject(1290,-74.1562500,1307.3593750,14.6195383,0.0000000,0.0000000,95.9930420, -1, -1, -1, 400, 400); //object(lamppost2) (15)
	CreateDynamicObject(1290,-71.3158646,1327.3748779,14.6195383,0.0000000,0.0000000,95.9930420, -1, -1, -1, 400, 400); //object(lamppost2) (16)
	CreateDynamicObject(1290,-71.3154297,1327.3740234,14.6195383,0.0000000,0.0000000,95.9930420, -1, -1, -1, 400, 400); //object(lamppost2) (17)
	CreateDynamicObject(1290,-71.3154297,1327.3740234,14.6195383,0.0000000,0.0000000,95.9930420, -1, -1, -1, 400, 400); //object(lamppost2) (18)
	CreateDynamicObject(1215,-70.9096909,1335.4592285,10.6201725,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (152)
	CreateDynamicObject(1215,-70.8595200,1336.3580322,10.5817890,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (153)
	CreateDynamicObject(1215,-70.8321991,1337.1411133,10.5437374,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (154)
	CreateDynamicObject(1215,-70.8129807,1338.0179443,10.5092392,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (155)
	CreateDynamicObject(1215,-70.7195129,1339.0131836,10.2592392,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (156)
	CreateDynamicObject(1215,-70.6257629,1340.0083008,10.2592392,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (157)
	CreateDynamicObject(1215,-70.4702301,1340.8842773,10.3659000,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (158)
	CreateDynamicObject(1215,-70.5164108,1341.8872070,10.3290215,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (159)
	CreateDynamicObject(1215,-70.5437775,1342.8510742,10.2922192,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (160)
	CreateDynamicObject(1215,-71.2216415,1343.3286133,10.3270779,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (161)
	CreateDynamicObject(1215,-71.2322998,1351.3748779,10.0058136,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (166)
	CreateDynamicObject(1215,-71.3485184,1352.4547119,9.9719505,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (167)
	CreateDynamicObject(1215,-71.4262848,1353.4704590,9.9375763,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (168)
	CreateDynamicObject(1215,-71.5717316,1354.5286865,9.9069118,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (169)
	CreateDynamicObject(1215,-71.7587891,1355.6787109,9.8759537,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (170)
	CreateDynamicObject(1215,-71.8587341,1356.8624268,9.8343706,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (171)
	CreateDynamicObject(1215,-71.9026031,1350.6484375,10.0884132,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (172)
	CreateDynamicObject(1215,-72.9702530,1350.2918701,10.1879911,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (173)
	CreateDynamicObject(1215,-73.9503326,1350.0380859,10.2733765,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (174)
	CreateDynamicObject(1215,-74.8655701,1349.8913574,10.3506451,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (175)
	CreateDynamicObject(1215,-75.9561691,1349.6975098,10.4039860,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (176)
	CreateDynamicObject(1215,-77.1997375,1349.5686035,10.3695698,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (177)
	CreateDynamicObject(1215,-78.2995758,1349.4536133,10.3429985,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (178)
	CreateDynamicObject(1215,-79.3678055,1349.3826904,10.3126583,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (179)
	CreateDynamicObject(1215,-80.4055328,1349.3017578,10.2862186,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (180)
	CreateDynamicObject(1215,-81.4289551,1349.2220459,10.2601433,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (181)
	CreateDynamicObject(1215,-72.0162048,1343.6817627,10.3762960,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (182)
	CreateDynamicObject(1215,-72.9577637,1343.9649658,10.4400902,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (183)
	CreateDynamicObject(1215,-74.1572800,1343.9609375,10.5361214,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (184)
	CreateDynamicObject(1215,-75.5030899,1343.9062500,10.6082897,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (185)
	CreateDynamicObject(1215,-76.7458344,1343.7731934,10.6082897,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (186)
	CreateDynamicObject(1215,-77.9880219,1343.6394043,10.6082897,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (187)
	CreateDynamicObject(1215,-79.2302094,1343.5056152,10.6082897,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (188)
	CreateDynamicObject(1215,-80.2243500,1343.3991699,10.6082897,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (189)
	CreateDynamicObject(1215,-91.7499084,1360.2648926,14.9568882,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (190)
	CreateDynamicObject(1215,-88.2536163,1360.4423828,14.9568882,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (192)
	CreateDynamicObject(1215,-88.2911072,1360.9409180,10.9568882,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (193)
	CreateDynamicObject(1215,-91.7807617,1360.6738281,10.9568882,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (194)
	CreateDynamicObject(1215,-74.8555145,1376.5458984,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (195)
	CreateDynamicObject(1215,-75.2700043,1379.0104980,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (197)
	CreateDynamicObject(1215,-75.7274094,1381.7210693,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (199)
	CreateDynamicObject(1215,-76.1746292,1384.4332275,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (201)
	CreateDynamicObject(1215,-76.6789856,1387.1352539,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (202)
	CreateDynamicObject(1215,-77.1745377,1389.8399658,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (203)
	CreateDynamicObject(1215,-77.5208130,1391.8095703,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (204)
	CreateDynamicObject(1215,-77.9108658,1394.0255127,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (205)
	CreateDynamicObject(1215,-78.2571411,1395.9951172,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (206)
	CreateDynamicObject(1215,-78.6905670,1398.4572754,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (207)
	CreateDynamicObject(1215,-79.0807877,1400.6729736,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (208)
	CreateDynamicObject(1215,-79.5571823,1403.3812256,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (209)
	CreateDynamicObject(1215,-79.9903717,1405.8430176,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (210)
	CreateDynamicObject(1215,-80.4673386,1408.5511475,9.3966398,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (211)
	CreateDynamicObject(984,-302.3366699,1046.2214355,45.7546883,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (3)
	CreateDynamicObject(984,-302.3685303,1033.5366211,45.7546883,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (4)
	CreateDynamicObject(984,-308.6582336,1058.9121094,45.7546883,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (5)
	CreateDynamicObject(984,-327.2411499,1052.4908447,45.7546883,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (7)
	CreateDynamicObject(983,-318.1903992,1058.8974609,45.8015633,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (7)
	CreateDynamicObject(983,-324.0939636,1058.8231201,45.8015633,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (7)
	CreateDynamicObject(984,-327.1959229,1039.7250977,45.7546883,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (8)
	CreateDynamicObject(983,-327.2401428,1030.1940918,45.8015633,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (7)
	CreateDynamicObject(984,-308.6233521,1023.8257446,45.7546883,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (9)
	CreateDynamicObject(984,-320.6556702,1023.8056030,45.7546883,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (10)
	CreateDynamicObject(8613,-331.3165588,1028.7806396,41.6456795,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vgssstairs03_lvs) (1)
	CreateDynamicObject(3934,-314.8347778,1041.0892334,45.1180077,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(helipad01) (1)
	CreateDynamicObject(11489,-149.0068054,1124.2502441,18.7499866,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(dam_statues) (1)
	CreateDynamicObject(5844,-296.6132812,1182.7998047,18.9340668,0.0000000,0.0000000,71.9989014, -1, -1, -1, 400, 400); //object(lawnmart_alpha) (1)
	CreateDynamicObject(4004,-142.5871887,1217.3228760,30.7345181,0.0000000,0.0000000,0.7695312, -1, -1, -1, 400, 400); //object(lacityhall3_lan) (1)
	CreateDynamicObject(8555,-372.0064697,1103.1092529,39.5991516,0.0000000,0.0000000,89.9990234, -1, -1, -1, 400, 400); //object(vgsecrthse) (1)
	CreateDynamicObject(12941,-299.6406250,1123.8017578,18.3804207,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(sw_lastdrop) (1)
	CreateDynamicObject(12941,-320.8011475,1123.1416016,18.3804207,0.0000000,0.0000000,359.9945374, -1, -1, -1, 400, 400); //object(sw_lastdrop) (1)
	CreateDynamicObject(8169,-317.4654541,1136.4005127,18.7406635,0.0000000,0.0000000,17.9960938, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(8169,-324.3171692,1136.1875000,18.7406635,0.0000000,0.0000000,17.9956055, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(8169,-317.5324707,1135.1528320,18.7406635,0.0000000,0.0000000,17.9956055, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(8169,-332.2743530,1136.2116699,18.7406635,0.0000000,0.0000000,15.9956055, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(8169,-329.5443420,1136.1715088,18.7406635,0.0000000,0.0000000,15.9906006, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(6959,-357.8981628,1109.7785645,18.6231174,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (7)
	CreateDynamicObject(6959,-358.3466797,1149.4863281,18.6231174,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (7)
	CreateDynamicObject(5737,-144.2939606,1226.7677002,24.3990688,0.0000000,0.0000000,90.2196655, -1, -1, -1, 400, 400); //object(archshop07_law02) (3)
	CreateDynamicObject(5737,-144.2939453,1226.7675781,32.6490707,0.0000000,0.0000000,90.2142334, -1, -1, -1, 400, 400); //object(archshop07_law02) (3)
	CreateDynamicObject(5737,-190.4993286,1220.2292480,24.1490707,0.0000000,0.0000000,90.2142334, -1, -1, -1, 400, 400); //object(archshop07_law02) (3)
	CreateDynamicObject(947,-157.9379883,1229.1021729,20.9451103,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(bskballhub_lax01) (1)
	CreateDynamicObject(947,-173.5674896,1229.0383301,20.9451103,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(bskballhub_lax01) (2)
	CreateDynamicObject(1251,-157.5048828,1228.9316406,21.3468723,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(1251,-157.5423737,1225.6816406,17.8468723,90.0000000,180.4035187,179.5964966, -1, -1, -1, 400, 400); //object(smashbar) (4)
	CreateDynamicObject(1251,-157.4670105,1232.1816406,17.8468723,90.0000000,180.4010010,179.5935059, -1, -1, -1, 400, 400); //object(smashbar) (5)
	CreateDynamicObject(1251,-174.0029144,1229.0438232,21.3468723,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(smashbar) (6)
	CreateDynamicObject(1251,-174.0729675,1232.2929688,18.0968723,270.0000000,179.9560547,179.9560547, -1, -1, -1, 400, 400); //object(smashbar) (7)
	CreateDynamicObject(1251,-173.9302368,1225.7929688,18.0968723,270.0000000,179.9505615,179.9505615, -1, -1, -1, 400, 400); //object(smashbar) (8)
	CreateDynamicObject(1408,-159.6043243,1238.9710693,21.6788445,0.0000000,356.0000000,190.0000000, -1, -1, -1, 400, 400); //object(dyn_f_wood_2) (1)
	CreateDynamicObject(1408,-164.8951111,1238.0815430,21.9632626,0.0000000,355.9954834,189.9975586, -1, -1, -1, 400, 400); //object(dyn_f_wood_2) (4)
	CreateDynamicObject(1408,-170.0065918,1237.1619873,22.2412510,0.0000000,355.9954834,189.9975586, -1, -1, -1, 400, 400); //object(dyn_f_wood_2) (5)
	CreateDynamicObject(1408,-175.1726532,1236.1953125,22.5228977,0.0000000,355.9954834,189.9975586, -1, -1, -1, 400, 400); //object(dyn_f_wood_2) (6)
	CreateDynamicObject(1408,-180.3691406,1235.3775635,22.7886448,0.0000000,355.9954834,185.9975433, -1, -1, -1, 400, 400); //object(dyn_f_wood_2) (7)
	CreateDynamicObject(1408,-185.5063629,1234.7122803,23.0272865,0.0000000,355.9899902,185.9930420, -1, -1, -1, 400, 400); //object(dyn_f_wood_2) (8)
	CreateDynamicObject(1408,-190.6616821,1234.0747070,23.2570782,0.0000000,355.9899902,185.9930420, -1, -1, -1, 400, 400); //object(dyn_f_wood_2) (9)
	CreateDynamicObject(1408,-195.8659668,1233.3759766,23.4990101,0.0000000,355.9899902,185.9930420, -1, -1, -1, 400, 400); //object(dyn_f_wood_2) (10)
	CreateDynamicObject(1408,-200.2447052,1232.8601074,23.7327595,0.0000000,355.9844971,185.9930420, -1, -1, -1, 400, 400); //object(dyn_f_wood_2) (11)
	CreateDynamicObject(3749,101.4664154,1198.4602051,23.0511246,0.0000000,0.0000000,269.9999695, -1, -1, -1, 400, 400); //object(clubgate01_lax) (2)
	CreateDynamicObject(984,-22.7470703,1295.9355469,21.0307388,0.0000000,90.0000000,1.9939270, -1, -1, -1, 400, 400); //object(fenceshit2) (11)
	CreateDynamicObject(984,-21.7470703,1295.9501953,21.0307388,0.0000000,90.0000000,1.9830322, -1, -1, -1, 400, 400); //object(fenceshit2) (12)
	CreateDynamicObject(984,-8.7497520,1281.7340088,17.9593506,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(fenceshit2) (15)
	CreateDynamicObject(983,-21.2180996,1294.5023193,21.5776138,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (48)
	CreateDynamicObject(983,-21.3188610,1297.7540283,21.5776138,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (49)
	CreateDynamicObject(983,-23.3427734,1297.3837891,21.5776138,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (51)
	CreateDynamicObject(3935,-141.6930389,1132.8128662,21.0515842,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(statue) (1)
	CreateDynamicObject(1280,-137.5742493,1128.6005859,19.1513443,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(parkbench1) (6)
	CreateDynamicObject(1280,-137.6041565,1122.5001221,19.1513443,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(parkbench1) (7)
	CreateDynamicObject(1360,-136.5665283,1128.7224121,19.5220089,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (9)
	CreateDynamicObject(1360,-136.4503174,1122.3155518,19.5220089,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (10)
	CreateDynamicObject(1361,-136.5286865,1126.4947510,19.4933319,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop2) (4)
	CreateDynamicObject(1361,-136.5770721,1124.5090332,19.4933319,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop2) (5)
	CreateDynamicObject(1215,-136.8002930,1125.5444336,19.3143120,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (162)
	CreateDynamicObject(1215,-137.5722046,1126.6468506,19.3143120,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (163)
	CreateDynamicObject(1215,-137.5736694,1124.5314941,19.3143120,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (164)
	CreateDynamicObject(1215,-149.2240906,1138.0458984,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (165)
	CreateDynamicObject(1215,-147.1394348,1138.0300293,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (191)
	CreateDynamicObject(1215,-144.9268799,1137.9637451,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (196)
	CreateDynamicObject(1215,-142.5940857,1137.8937988,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (198)
	CreateDynamicObject(1215,-140.2060394,1137.9837646,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (200)
	CreateDynamicObject(1215,-137.9365082,1138.1363525,19.3143120,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (212)
	CreateDynamicObject(1215,-135.5931244,1138.1644287,19.3143120,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (213)
	CreateDynamicObject(1216,-149.8965759,1112.1679688,19.4341908,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(phonebooth1) (5)
	CreateDynamicObject(1216,-149.8672791,1113.6679688,19.4341908,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(phonebooth1) (7)
	CreateDynamicObject(1216,-149.8379822,1115.1679688,19.4341908,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(phonebooth1) (8)
	CreateDynamicObject(1216,-149.9638672,1110.6694336,19.4341908,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(phonebooth1) (10)
	CreateDynamicObject(1290,-143.6901245,1114.6315918,24.7734108,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(lamppost2) (4)
	CreateDynamicObject(3642,-100.4079819,1152.7312012,20.9432888,0.0000000,0.0000000,268.0000000, -1, -1, -1, 400, 400); //object(glenphouse03_lax) (1)
	CreateDynamicObject(5626,-82.1203003,1158.5173340,21.4723930,0.0000000,0.0000000,89.9999695, -1, -1, -1, 400, 400); //object(laecompmedhos518) (1)
	CreateDynamicObject(3587,-82.1848679,1143.3769531,21.1952209,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(nwsnpedhus1_las) (1)
	CreateDynamicObject(3583,-112.2151871,1115.8137207,21.7403622,0.0000000,0.0000000,177.9999390, -1, -1, -1, 400, 400); //object(compbigho3_lae) (1)
	CreateDynamicObject(3558,-98.8639908,1137.5604248,21.7045250,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(compmedhos5_lae) (1)
	CreateDynamicObject(3556,-156.8366241,1133.7286377,21.1185837,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(compmedhos3_lae) (1)
	CreateDynamicObject(1368,-159.2984619,1222.2618408,19.4319248,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (1)
	CreateDynamicObject(1368,-163.0955505,1222.1602783,19.4319248,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (2)
	CreateDynamicObject(1368,-166.8440399,1222.0832520,19.4319248,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (3)
	CreateDynamicObject(949,-157.3730011,1222.2111816,19.3784714,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(plant_pot_4) (1)
	CreateDynamicObject(949,-168.7194366,1221.8833008,19.3784714,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(plant_pot_4) (2)
	CreateDynamicObject(1215,-161.2402191,1222.1691895,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (214)
	CreateDynamicObject(1215,-165.0350494,1222.1280518,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (215)
	CreateDynamicObject(8555,-372.0546875,1167.9892578,39.5991516,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(vgsecrthse) (1)
	CreateDynamicObject(8555,-372.0546875,1167.9892578,-6.1408405,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(vgsecrthse) (1)
	CreateDynamicObject(8555,-372.0058594,1103.1083984,-6.3508396,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(vgsecrthse) (1)
	CreateDynamicObject(5848,-151.7114258,1164.1619873,24.1774559,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(mainblk_lawn) (3)
	CreateDynamicObject(5781,-305.0458984,1169.6396484,24.2380524,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(melblok11_lawn) (1)
	CreateDynamicObject(5781,-322.1455078,1169.6464844,24.2380524,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(melblok11_lawn) (2)
	CreateDynamicObject(10847,-318.9688416,1172.9193115,17.6094742,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(gen_whouse03_sfse01) (2)
	CreateDynamicObject(5769,17.7825527,1165.6740723,23.0578842,358.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(vineblock1_lawn) (1)
	CreateDynamicObject(8169,49.7167969,1157.7163086,17.6640625,0.0000000,0.0000000,285.9960938, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(8169,49.8408852,1163.2469482,17.6640625,0.0000000,0.0000000,281.9960938, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(8169,48.8029976,1164.9741211,17.6640625,0.0000000,0.0000000,281.9915771, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(8169,18.2812691,1159.4492188,18.7421875,0.0000000,0.0000000,13.9915771, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (5)
	CreateDynamicObject(5762,-248.3672638,1220.7441406,21.8742867,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(foodmartlawn) (1)
	CreateDynamicObject(7658,-224.3388672,994.0223389,18.6839867,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(vgnbuild1new) (1)
	CreateDynamicObject(7658,-224.3388672,994.0214844,13.1839867,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(vgnbuild1new) (2)
	CreateDynamicObject(5738,-236.3805847,981.1538696,32.7934418,0.0000000,0.0000000,180.5328369, -1, -1, -1, 400, 400); //object(hothol02_law01) (1)
	CreateDynamicObject(5737,-270.3544006,982.4888916,24.7295609,0.0000000,0.0000000,178.5278320, -1, -1, -1, 400, 400); //object(archshop07_law02) (3)
	CreateDynamicObject(5737,-270.3535156,982.4882812,33.1895599,0.0000000,0.0000000,178.5278320, -1, -1, -1, 400, 400); //object(archshop07_law02) (3)
	CreateDynamicObject(9302,-169.6998444,1113.5898438,26.0843658,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(sfn_town01) (1)
	CreateDynamicObject(9302,-169.3303680,1114.9206543,26.0843658,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(sfn_town01) (2)
	CreateDynamicObject(10391,-157.9136963,1183.5689697,26.9857979,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(mission_14_sfs) (1)
	CreateDynamicObject(10391,-157.8645630,1179.8183594,26.9857979,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(mission_14_sfs) (2)
	CreateDynamicObject(5848,-151.3945465,1166.9058838,24.1774559,0.0000000,0.0000000,171.9964600, -1, -1, -1, 400, 400); //object(mainblk_lawn) (4)
	CreateDynamicObject(10439,-97.3366699,1228.2871094,21.8991165,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(hashbury_08_sfs) (1)
	CreateDynamicObject(10439,-84.2192307,1226.3205566,21.8991165,0.0000000,0.0000000,269.9999390, -1, -1, -1, 400, 400); //object(hashbury_08_sfs) (5)
	CreateDynamicObject(10630,-472.7486572,884.8308105,-6.2500000,0.0000000,0.0000000,272.0000000, -1, -1, -1, 400, 400); //object(queens_10_sfs) (2)
	CreateDynamicObject(10630,-526.8125000,882.7294922,-6.2500000,0.0000000,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(queens_10_sfs) (4)
	CreateDynamicObject(10630,-546.3382568,917.4660645,-6.2500000,0.0000000,0.0000000,181.9940186, -1, -1, -1, 400, 400); //object(queens_10_sfs) (5)
	CreateDynamicObject(10630,-457.4384766,950.2412109,-6.2500000,0.0000000,0.0000000,271.9885254, -1, -1, -1, 400, 400); //object(queens_10_sfs) (6)
	CreateDynamicObject(3406,-474.6855164,897.3162842,-1.4761505,358.0000000,0.0000000,92.0000000, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (1)
	CreateDynamicObject(3406,-474.9904175,906.0636597,-1.4761505,357.9949951,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (2)
	CreateDynamicObject(3406,-475.2248535,913.8096924,-1.4761505,357.9949951,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (3)
	CreateDynamicObject(3406,-475.4819336,922.3054199,-1.4761505,357.9949951,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (4)
	CreateDynamicObject(3406,-481.0339355,911.9925537,-1.4761505,357.9949951,0.0000000,181.9995270, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (5)
	CreateDynamicObject(3406,-489.6275940,911.6829834,-1.4761505,357.9895020,0.0000000,181.9995270, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (7)
	CreateDynamicObject(3406,-498.3708496,911.3967896,-1.4761505,357.9895020,0.0000000,181.9995270, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (8)
	CreateDynamicObject(3406,-503.2059326,915.0354004,-1.4761505,357.9895020,0.0000000,91.9994812, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (9)
	CreateDynamicObject(3406,-503.4795227,923.6987915,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (10)
	CreateDynamicObject(3406,-503.7191162,932.2105713,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (11)
	CreateDynamicObject(3406,-503.9800720,940.9713745,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (12)
	CreateDynamicObject(3406,-504.2573242,949.3675537,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (13)
	CreateDynamicObject(3406,-509.7496338,932.4122925,-1.4761505,357.9895020,0.0000000,183.9940491, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (14)
	CreateDynamicObject(3406,-517.9532471,931.8333740,-1.4761505,357.9895020,0.0000000,183.9935150, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (15)
	CreateDynamicObject(3406,-526.6671753,931.2338867,-1.4761505,357.9895020,0.0000000,183.9935150, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (16)
	CreateDynamicObject(3406,-521.8364868,926.8259277,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (18)
	CreateDynamicObject(3406,-521.5335693,918.1255493,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (19)
	CreateDynamicObject(3406,-521.2187500,909.3905640,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (20)
	CreateDynamicObject(3406,-522.2233887,937.3112183,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (21)
	CreateDynamicObject(3406,-522.5228882,945.6550293,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (22)
	CreateDynamicObject(3406,-522.8342896,954.3186646,-1.4761505,357.9895020,0.0000000,91.9940186, -1, -1, -1, 400, 400); //object(cxref_woodjetty) (23)
	CreateDynamicObject(1215,-473.7265930,894.6792603,1.2725666,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (216)
	CreateDynamicObject(1215,-475.6775818,894.5783691,1.2043555,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (217)
	CreateDynamicObject(1215,-475.7511902,896.7623291,1.2044482,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (218)
	CreateDynamicObject(1215,-473.7380981,896.8154297,1.2747681,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (219)
	CreateDynamicObject(1215,-473.8423157,899.0370483,1.2738383,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (220)
	CreateDynamicObject(1215,-475.8413086,898.9877930,1.2738383,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (221)
	CreateDynamicObject(1215,-475.8650513,901.0632324,1.1236544,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (222)
	CreateDynamicObject(1215,-473.9547729,901.1862183,1.1905348,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (223)
	CreateDynamicObject(1215,-474.2373047,909.5664062,1.1908762,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-476.1185913,909.5385742,1.1250327,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (225)
	CreateDynamicObject(1215,-475.9757690,903.2324829,1.2738383,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (226)
	CreateDynamicObject(1215,-473.9765625,903.3056641,1.2738383,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-474.0595093,905.5540161,1.2738383,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (228)
	CreateDynamicObject(1215,-476.0571289,905.4799805,1.2738383,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (229)
	CreateDynamicObject(1215,-476.1303711,907.4780273,1.2738383,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (230)
	CreateDynamicObject(1215,-474.1313477,907.5512695,1.2738383,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (231)
	CreateDynamicObject(1216,-252.3085480,1210.4129639,19.4341908,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(phonebooth1) (3)
	CreateDynamicObject(1216,-250.5510254,1210.4866943,19.4341908,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(phonebooth1) (3)
	CreateDynamicObject(1215,-259.3889771,1206.1634521,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (4)
	CreateDynamicObject(1215,-259.3767090,1210.4932861,19.3065109,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (4)
	CreateDynamicObject(1256,-257.8200684,1208.6868896,19.4016438,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (1)
	CreateDynamicObject(6959,-358.0528870,1162.4776611,18.8731174,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (7)
	CreateDynamicObject(6959,-319.5812683,1162.6237793,8.6231174,0.0000000,30.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (7)
	CreateDynamicObject(6959,-357.4865417,1124.7492676,8.6231174,0.0000000,29.9981689,269.9999695, -1, -1, -1, 400, 400); //object(vegasnbball1) (7)
	CreateDynamicObject(1215,-474.2498779,911.1111450,1.2732282,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-474.3040161,913.2932739,1.2739937,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-474.3959961,915.4993896,1.2734628,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-474.5509033,917.5387573,1.1884568,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-474.5115662,919.5894775,1.2730389,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-474.5939636,921.8372192,1.2730389,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-474.6140137,923.9963989,1.2748268,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-474.8582458,926.0211182,1.1866698,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-476.4937439,925.9653931,1.1292248,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-476.5807190,923.9547119,1.2057796,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-476.5147095,921.7052002,1.2057796,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-476.4492798,919.4561768,1.2057796,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-476.3433838,917.4774780,1.1254969,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-476.3947754,915.4409180,1.2734628,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-476.3291626,913.1915283,1.2734628,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(1215,-476.1775818,911.0472412,1.2055213,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (224)
	CreateDynamicObject(3361,-437.9570007,952.0104370,2.2207594,0.0000000,0.0000000,178.0000000, -1, -1, -1, 400, 400); //object(cxref_woodstair) (3)
	CreateDynamicObject(3361,-429.9111023,951.7268066,6.2207594,0.0000000,0.0000000,177.9949951, -1, -1, -1, 400, 400); //object(cxref_woodstair) (4)
	CreateDynamicObject(984,-434.7496643,950.9241333,-1.1664343,90.0000000,179.5964966,268.4034119, -1, -1, -1, 400, 400); //object(fenceshit2) (6)
	CreateDynamicObject(984,-433.9992065,950.9091797,-1.1664343,90.0000000,179.5935059,268.4014893, -1, -1, -1, 400, 400); //object(fenceshit2) (13)
	CreateDynamicObject(984,-434.7078552,952.7793579,-1.1664343,90.0000000,180.4064941,267.5885010, -1, -1, -1, 400, 400); //object(fenceshit2) (18)
	CreateDynamicObject(984,-433.9571228,952.7705078,-1.1664343,90.0000000,179.5935059,268.4014893, -1, -1, -1, 400, 400); //object(fenceshit2) (19)
	CreateDynamicObject(3361,-451.9467773,887.7550659,0.9707594,0.0000000,0.0000000,193.9949951, -1, -1, -1, 400, 400); //object(cxref_woodstair) (5)
	CreateDynamicObject(8838,-384.1319885,946.7652588,8.4123745,0.0000000,0.0000000,34.0000000, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (1)
	CreateDynamicObject(8838,-381.2480469,942.6806641,8.4123745,0.0000000,0.0000000,213.9972076, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-392.0004578,924.1397705,8.4123745,0.0000000,0.0000000,123.9971924, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (3)
	CreateDynamicObject(8838,-396.1667480,921.3700562,8.4123745,0.0000000,0.0000000,123.9917297, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (4)
	CreateDynamicObject(8838,-400.2736816,918.5626831,8.4123745,0.0000000,0.0000000,123.9917297, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (6)
	CreateDynamicObject(8838,-404.5004883,915.8842773,8.4123745,0.0000000,0.0000000,123.9917297, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (7)
	CreateDynamicObject(8838,-408.5960693,913.0163574,8.4123745,0.0000000,0.0000000,123.9917297, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (8)
	CreateDynamicObject(8838,-412.6917725,910.1481934,8.4123745,0.0000000,0.0000000,123.9916992, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (9)
	CreateDynamicObject(8838,-394.0818481,882.4638672,8.4123745,0.0000000,0.0000000,123.9916992, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (10)
	CreateDynamicObject(8838,-389.9849854,885.3312988,8.4123745,0.0000000,0.0000000,123.9916992, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (11)
	CreateDynamicObject(8838,-385.8883057,888.1984863,8.4123745,0.0000000,0.0000000,123.9916992, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (12)
	CreateDynamicObject(8838,-381.7443848,890.9953003,8.4123745,0.0000000,0.0000000,123.9917297, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (13)
	CreateDynamicObject(8838,-377.5899658,893.7772827,8.4123745,0.0000000,0.0000000,123.9917297, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (14)
	CreateDynamicObject(8838,-373.4360352,896.5587158,8.4123745,0.0000000,0.0000000,123.9917297, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (15)
	CreateDynamicObject(3069,-358.5627136,958.8502808,5.3746681,16.0000000,0.0000000,126.0000000, -1, -1, -1, 400, 400); //object(d9_ramp) (3)
	CreateDynamicObject(3069,-361.0525513,962.2864990,5.3746681,15.9960938,0.0000000,125.9967041, -1, -1, -1, 400, 400); //object(d9_ramp) (4)
	CreateDynamicObject(6959,-389.3462830,886.4990234,7.0215549,0.0000000,0.0000000,35.9995117, -1, -1, -1, 400, 400); //object(vegasnbball1) (13)
	CreateDynamicObject(6959,-406.0742188,909.5703125,7.0215549,0.0000000,0.0000000,35.9967041, -1, -1, -1, 400, 400); //object(vegasnbball1) (13)
	CreateDynamicObject(6959,-422.2617493,896.9889526,-12.9784451,270.0000000,179.9699707,305.9666138, -1, -1, -1, 400, 400); //object(vegasnbball1) (13)
	CreateDynamicObject(6959,-407.5785828,876.3937988,-12.9784451,270.0000000,179.8891602,305.8857422, -1, -1, -1, 400, 400); //object(vegasnbball1) (13)
	CreateDynamicObject(6959,-417.6434021,925.9333496,-12.9784451,270.0000000,179.9685059,215.9652252, -1, -1, -1, 400, 400); //object(vegasnbball1) (13)
	CreateDynamicObject(982,-403.8682861,871.6691284,7.6738596,0.0000000,0.0000000,35.9962158, -1, -1, -1, 400, 400); //object(fenceshit) (10)
	CreateDynamicObject(982,-418.9102173,892.2979126,7.6738596,0.0000000,0.0000000,35.9912109, -1, -1, -1, 400, 400); //object(fenceshit) (11)
	CreateDynamicObject(982,-416.7820740,926.2671509,7.6738596,0.0000000,0.0000000,305.9912109, -1, -1, -1, 400, 400); //object(fenceshit) (12)
	CreateDynamicObject(982,-382.3612061,950.6893921,10.6265268,0.0000000,0.0000000,303.9912109, -1, -1, -1, 400, 400); //object(fenceshit) (13)
	CreateDynamicObject(982,-403.5902405,936.3596191,10.6265268,0.0000000,0.0000000,303.9862061, -1, -1, -1, 400, 400); //object(fenceshit) (14)
	CreateDynamicObject(982,-394.0125732,878.2234497,10.6265268,0.0000000,0.0000000,33.9862061, -1, -1, -1, 400, 400); //object(fenceshit) (15)
	CreateDynamicObject(982,-408.3012085,899.4467773,10.6265268,0.0000000,0.0000000,33.9807129, -1, -1, -1, 400, 400); //object(fenceshit) (16)
	CreateDynamicObject(982,-383.5751648,916.0625610,10.6265268,0.0000000,0.0000000,33.9807129, -1, -1, -1, 400, 400); //object(fenceshit) (17)
	CreateDynamicObject(982,-369.2976685,894.8210449,10.6265268,0.0000000,0.0000000,33.9807129, -1, -1, -1, 400, 400); //object(fenceshit) (18)
	CreateDynamicObject(982,-376.2025757,874.7469482,10.6265268,0.0000000,0.0000000,303.9862061, -1, -1, -1, 400, 400); //object(fenceshit) (19)
	CreateDynamicObject(983,-364.7913818,882.4350586,10.6265268,0.0000000,0.0000000,303.9971924, -1, -1, -1, 400, 400); //object(fenceshit3) (56)
	CreateDynamicObject(6959,-385.2930298,915.9790039,-12.9784451,270.0000000,179.9670410,305.9637451, -1, -1, -1, 400, 400); //object(vegasnbball1) (13)
	CreateDynamicObject(982,-383.1053467,938.5544434,10.6265268,0.0000000,0.0000000,303.9862061, -1, -1, -1, 400, 400); //object(fenceshit) (20)
	CreateDynamicObject(983,-369.8735352,947.4685669,10.6265268,0.0000000,0.0000000,304.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (57)
	CreateDynamicObject(8838,-378.4335022,938.5479126,8.4123745,0.0000000,0.0000000,213.9972534, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (16)
	CreateDynamicObject(982,-380.3823242,934.3593750,10.6265268,0.0000000,0.0000000,303.9862061, -1, -1, -1, 400, 400); //object(fenceshit) (21)
	CreateDynamicObject(983,-367.1308594,943.3273315,10.6265268,0.0000000,0.0000000,304.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (58)
	CreateDynamicObject(1215,-390.8510742,926.8817749,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-392.3126831,929.2871094,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-389.2304077,931.2626953,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-386.5436401,933.0924072,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-383.8571167,934.9215088,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-380.9639893,936.8913574,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-378.0714111,938.8610840,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-375.1788330,940.8308105,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-372.2810364,942.7925415,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-369.3878174,944.7624512,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-366.2886353,946.8729248,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(983,-416.8179016,927.4326782,10.6265268,0.0000000,0.0000000,303.9971924, -1, -1, -1, 400, 400); //object(fenceshit3) (59)
	CreateDynamicObject(983,-421.3479004,924.3146973,10.6265268,0.0000000,0.0000000,304.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (60)
	CreateDynamicObject(983,-428.2919006,905.2578125,7.6738596,0.0000000,2.0000000,35.9971924, -1, -1, -1, 400, 400); //object(fenceshit3) (61)
	CreateDynamicObject(983,-417.2165833,912.6926880,10.6265268,0.0000000,1.9995117,33.9967041, -1, -1, -1, 400, 400); //object(fenceshit3) (63)
	CreateDynamicObject(3069,-355.0279236,954.0093994,5.3746681,15.9960938,0.0000000,125.9967041, -1, -1, -1, 400, 400); //object(d9_ramp) (6)
	CreateDynamicObject(1215,-366.1533813,949.8377075,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-363.4065857,945.8205566,10.5208025,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(1215,-393.6719055,931.3685913,10.5072956,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (227)
	CreateDynamicObject(3361,-433.1887817,907.0975342,4.9056206,0.0000000,0.0000000,215.9910736, -1, -1, -1, 400, 400); //object(cxref_woodstair) (6)
	CreateDynamicObject(3361,-434.4856873,908.9352417,4.9056206,0.0000000,0.0000000,215.9857178, -1, -1, -1, 400, 400); //object(cxref_woodstair) (7)
	CreateDynamicObject(3361,-435.7825623,910.7731323,4.9056206,0.0000000,0.0000000,215.9857178, -1, -1, -1, 400, 400); //object(cxref_woodstair) (8)
	CreateDynamicObject(3361,-429.8886719,920.5846558,4.9056206,0.0000000,0.0000000,125.9857788, -1, -1, -1, 400, 400); //object(cxref_woodstair) (9)
	CreateDynamicObject(3361,-431.6430054,919.1757202,4.9056206,0.0000000,0.0000000,125.9857178, -1, -1, -1, 400, 400); //object(cxref_woodstair) (11)
	CreateDynamicObject(3361,-433.4591675,917.8471069,4.9056206,0.0000000,0.0000000,125.9857178, -1, -1, -1, 400, 400); //object(cxref_woodstair) (12)
	CreateDynamicObject(3361,-435.2755737,916.5189819,4.9056206,0.0000000,0.0000000,125.9857178, -1, -1, -1, 400, 400); //object(cxref_woodstair) (13)
	CreateDynamicObject(994,-440.4908142,918.4394531,4.5360518,0.0000000,352.0000000,50.0000000, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (9)
	CreateDynamicObject(994,-436.3291321,923.2476196,5.3419800,0.0000000,351.9964600,49.9987793, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (10)
	CreateDynamicObject(994,-449.3796997,889.4842529,3.1113501,0.0000000,0.0000000,104.0000000, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (11)
	CreateDynamicObject(994,-447.3496704,881.3233032,2.9975758,0.0000000,0.0000000,103.9965820, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (12)
	CreateDynamicObject(994,-424.5223694,944.3696289,8.1192465,0.0000000,0.0000000,96.0000000, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (13)
	CreateDynamicObject(994,-425.1197205,952.6626587,7.8977442,0.0000000,0.0000000,113.9985657, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (14)
	CreateDynamicObject(1368,-408.1791687,878.2575684,7.6800413,0.0000000,0.0000000,126.0000000, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (4)
	CreateDynamicObject(1368,-402.4740295,870.6268311,7.6800413,0.0000000,0.0000000,125.9967041, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (7)
	CreateDynamicObject(1368,-397.0824280,863.1986694,7.6800413,0.0000000,0.0000000,125.9967041, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (8)
	CreateDynamicObject(1368,-413.9290771,886.4049683,7.6800413,0.0000000,0.0000000,125.9967041, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (9)
	CreateDynamicObject(1368,-420.4767151,895.2070312,7.6800413,0.0000000,0.0000000,125.9967041, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (10)
	CreateDynamicObject(1368,-426.4641724,903.6918945,7.6800413,0.0000000,0.0000000,125.9967041, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (11)
	CreateDynamicObject(1368,-416.9354553,925.7263794,7.6800413,0.0000000,0.0000000,35.9912109, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (13)
	CreateDynamicObject(1368,-412.3899841,928.8331299,7.6800413,0.0000000,0.0000000,35.9912109, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (14)
	CreateDynamicObject(1368,-408.4090271,931.7927856,7.6800413,0.0000000,0.0000000,35.9912109, -1, -1, -1, 400, 400); //object(cj_blocker_bench) (15)
	CreateDynamicObject(3361,-424.8903809,918.8908081,7.6556206,0.0000000,0.0000000,215.9857178, -1, -1, -1, 400, 400); //object(cxref_woodstair) (14)
	CreateDynamicObject(3361,-423.3973389,916.8850098,7.6556206,0.0000000,0.0000000,215.9857178, -1, -1, -1, 400, 400); //object(cxref_woodstair) (15)
	CreateDynamicObject(3361,-421.9043579,914.8787842,7.6556206,0.0000000,0.0000000,215.9857178, -1, -1, -1, 400, 400); //object(cxref_woodstair) (16)
	CreateDynamicObject(1594,-391.7932434,888.8741455,7.4672966,0.0000000,0.0000000,347.9921875, -1, -1, -1, 400, 400); //object(chairsntable) (2)
	CreateDynamicObject(1594,-399.2762451,891.2279053,7.4672966,0.0000000,0.0000000,31.9921875, -1, -1, -1, 400, 400); //object(chairsntable) (3)
	CreateDynamicObject(1594,-390.3265686,896.7119141,7.4672966,0.0000000,0.0000000,31.9921875, -1, -1, -1, 400, 400); //object(chairsntable) (4)
	CreateDynamicObject(1649,-685.6784668,931.7168579,13.2985544,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(wglasssmash) (1)
	CreateDynamicObject(1649,-684.9277344,931.7096558,13.2985544,0.0000000,0.0000000,178.0000000, -1, -1, -1, 400, 400); //object(wglasssmash) (2)
	CreateDynamicObject(3461,-688.1052856,931.2653809,10.4578238,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(tikitorch01_lvs) (1)
	CreateDynamicObject(3515,-698.8984985,915.2058105,10.5629807,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsfountain) (1)
	CreateDynamicObject(3578,-698.6954956,920.5502319,11.6062241,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (1)
	CreateDynamicObject(3578,-698.6953125,920.5498047,11.1062241,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (2)
	CreateDynamicObject(3578,-693.5825806,915.7168579,11.5249519,0.0000000,0.0000000,268.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (3)
	CreateDynamicObject(3578,-703.6932983,915.6894531,11.6537809,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(dockbarr1_la) (6)
	CreateDynamicObject(3578,-698.4334717,910.8021851,11.6062241,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (7)
	CreateDynamicObject(3578,-698.4326172,910.8017578,11.1062241,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(dockbarr1_la) (8)
	CreateDynamicObject(2297,-692.6320801,934.9196167,12.3828125,0.0000000,0.0000000,44.0000000, -1, -1, -1, 400, 400); //object(tv_unit_2) (1)
	CreateDynamicObject(2332,-690.0026245,943.1657715,13.0956974,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(kev_safe) (1)
	CreateDynamicObject(1703,-688.7377319,934.6024780,12.6328125,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(kb_couch02) (1)
	CreateDynamicObject(1703,-689.1832275,937.3837280,12.6328125,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(kb_couch02) (2)
	CreateDynamicObject(1255,-618.2088623,931.9813843,10.0989752,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(lounger) (1)
	CreateDynamicObject(1255,-617.7018433,936.2685547,10.0989752,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(lounger) (3)
	CreateDynamicObject(1744,-683.4315186,936.2203979,14.2800417,0.0000000,0.0000000,272.0000000, -1, -1, -1, 400, 400); //object(med_shelf) (1)
	CreateDynamicObject(1486,-683.7961426,936.5346680,14.7654886,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(dyn_beer_1) (1)
	CreateDynamicObject(1487,-683.7940674,936.2976074,14.8179941,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(dyn_wine_1) (1)
	CreateDynamicObject(1509,-683.7848511,936.0592651,14.8179941,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(dyn_wine_3) (1)
	CreateDynamicObject(1512,-683.7894897,935.7977295,14.8179922,0.0000000,0.0000000,74.0000000, -1, -1, -1, 400, 400); //object(dyn_wine_03) (1)
	CreateDynamicObject(1517,-683.8087769,935.5558472,14.8202944,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(dyn_wine_break) (1)
	CreateDynamicObject(1520,-683.8264771,935.3427734,14.6205397,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(dyn_wine_bounce) (1)
	CreateDynamicObject(1544,-683.8255005,935.1458130,14.6205397,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_beer_b_1) (1)
	CreateDynamicObject(1664,-683.8082275,934.9096069,14.7872429,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(propwinebotl2) (1)
	CreateDynamicObject(1804,-690.1956787,924.1764526,11.4797220,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(med_bed_1) (1)
	CreateDynamicObject(1825,-692.1073608,928.3587036,12.6293173,0.0000000,0.0000000,338.0000000, -1, -1, -1, 400, 400); //object(kb_table_chairs1) (1)
	CreateDynamicObject(2293,-687.6915894,936.0689697,12.6328125,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(swk_1_fstool) (1)
	CreateDynamicObject(1668,-687.7748413,935.9557495,13.3045921,0.0000000,0.0000000,40.0000000, -1, -1, -1, 400, 400); //object(propvodkabotl1) (1)
	CreateDynamicObject(1667,-687.3535767,936.0693359,13.2264681,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(propwineglass1) (1)
	CreateDynamicObject(1667,-687.9188843,936.2581177,13.2264681,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(propwineglass1) (2)
	CreateDynamicObject(1725,-679.3828125,961.7318115,0.3046875,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(mrk_bed1) (1)
	CreateDynamicObject(1340,-408.0005188,921.1345825,8.1178913,0.0000000,0.0000000,310.0000000, -1, -1, -1, 400, 400); //object(chillidogcart) (1)
	CreateDynamicObject(1340,-411.7080383,918.1650391,8.1178913,0.0000000,0.0000000,309.9957275, -1, -1, -1, 400, 400); //object(chillidogcart) (2)
	CreateDynamicObject(1340,-415.8063660,914.8837891,8.1178913,0.0000000,0.0000000,309.9957275, -1, -1, -1, 400, 400); //object(chillidogcart) (3)
	CreateDynamicObject(1340,-403.6979370,924.5612183,8.1178913,0.0000000,0.0000000,309.9957275, -1, -1, -1, 400, 400); //object(chillidogcart) (4)
	CreateDynamicObject(1340,-399.5670166,927.3779297,8.1178913,0.0000000,0.0000000,309.9957275, -1, -1, -1, 400, 400); //object(chillidogcart) (5)
	CreateDynamicObject(1340,-394.7682495,926.1110840,8.1178913,0.0000000,0.0000000,211.9957428, -1, -1, -1, 400, 400); //object(chillidogcart) (6)
	CreateDynamicObject(1341,-391.1307678,920.2355957,7.9928913,0.0000000,0.0000000,213.9999695, -1, -1, -1, 400, 400); //object(icescart_prop) (1)
	CreateDynamicObject(1341,-387.4606934,914.2744141,7.9928913,0.0000000,0.0000000,213.9972076, -1, -1, -1, 400, 400); //object(icescart_prop) (2)
	CreateDynamicObject(1341,-384.1838989,908.9521484,7.9928913,0.0000000,0.0000000,213.9972076, -1, -1, -1, 400, 400); //object(icescart_prop) (3)
	CreateDynamicObject(1341,-381.1696167,904.0556641,7.9928913,0.0000000,0.0000000,213.9972076, -1, -1, -1, 400, 400); //object(icescart_prop) (4)
	CreateDynamicObject(1341,-377.2376709,897.6689453,7.9928913,0.0000000,0.0000000,213.9971924, -1, -1, -1, 400, 400); //object(icescart_prop) (5)
	CreateDynamicObject(1342,-405.2181396,899.9917603,8.0239983,0.0000000,0.0000000,302.0000000, -1, -1, -1, 400, 400); //object(noodlecart_prop) (1)
	CreateDynamicObject(1342,-400.3905029,902.6270752,8.0239983,0.0000000,0.0000000,301.9976807, -1, -1, -1, 400, 400); //object(noodlecart_prop) (2)
	CreateDynamicObject(1342,-396.3742981,905.1643066,8.0239983,0.0000000,0.0000000,301.9976807, -1, -1, -1, 400, 400); //object(noodlecart_prop) (3)
	CreateDynamicObject(1342,-392.1473389,907.8349609,8.0239983,0.0000000,0.0000000,301.9976807, -1, -1, -1, 400, 400); //object(noodlecart_prop) (4)
	CreateDynamicObject(1342,-388.3424683,910.2387695,8.0239983,0.0000000,0.0000000,301.9976807, -1, -1, -1, 400, 400); //object(noodlecart_prop) (5)
	CreateDynamicObject(1594,-383.5324097,894.5087891,7.4672966,0.0000000,0.0000000,347.9919434, -1, -1, -1, 400, 400); //object(chairsntable) (2)
	CreateDynamicObject(1594,-406.2790527,910.5118408,7.4672966,0.0000000,0.0000000,347.9919434, -1, -1, -1, 400, 400); //object(chairsntable) (2)
	CreateDynamicObject(1594,-396.5451660,917.9387207,7.4672966,0.0000000,0.0000000,31.9919434, -1, -1, -1, 400, 400); //object(chairsntable) (2)
	CreateDynamicObject(1594,-413.8272095,905.5173950,7.4672966,0.0000000,0.0000000,331.9866943, -1, -1, -1, 400, 400); //object(chairsntable) (2)
	CreateDynamicObject(1363,-420.2688599,905.2695312,7.8266678,0.0000000,0.0000000,34.0000000, -1, -1, -1, 400, 400); //object(cj_phone_kiosk) (3)
	CreateDynamicObject(1363,-413.7310791,896.4274902,7.8266678,0.0000000,0.0000000,33.9971924, -1, -1, -1, 400, 400); //object(cj_phone_kiosk) (4)
	CreateDynamicObject(1363,-407.2539673,887.5283813,7.8266678,0.0000000,0.0000000,33.9971924, -1, -1, -1, 400, 400); //object(cj_phone_kiosk) (5)
	CreateDynamicObject(955,-417.7086487,918.6226196,7.4903049,0.0000000,0.0000000,124.0000000, -1, -1, -1, 400, 400); //object(cj_ext_sprunk) (1)
	CreateDynamicObject(1775,-418.7007141,919.6059570,8.0873413,0.0000000,0.0000000,122.0000000, -1, -1, -1, 400, 400); //object(cj_sprunk1) (4)
	CreateDynamicObject(1776,-419.5651245,921.3306885,8.0896969,0.0000000,0.0000000,126.0000000, -1, -1, -1, 400, 400); //object(cj_candyvendor) (1)
	CreateDynamicObject(1440,-383.1181641,914.3187256,6.2116265,0.0000000,0.0000000,122.0000000, -1, -1, -1, 400, 400); //object(dyn_box_pile_3) (1)
	CreateDynamicObject(1415,-385.2082520,916.9435425,5.7541122,0.0000000,0.0000000,126.0000000, -1, -1, -1, 400, 400); //object(dyn_dumpster) (1)
	CreateDynamicObject(1359,-394.9104309,893.6865845,7.6888623,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bin1) (1)
	CreateDynamicObject(1359,-402.5906067,905.6894531,7.6888623,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_bin1) (2)
	CreateDynamicObject(1265,-384.3475037,915.8430176,6.1631665,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(blackbag2) (1)
	CreateDynamicObject(1264,-383.8085632,915.3356934,6.9421563,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(blackbag1) (1)
	CreateDynamicObject(11496,-618.0872803,936.0631714,9.3250790,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(des_wjetty) (1)
	CreateDynamicObject(11496,-622.8499146,936.7080078,9.3250790,0.0000000,0.0000000,171.9964600, -1, -1, -1, 400, 400); //object(des_wjetty) (2)
	CreateDynamicObject(11496,-618.0216064,936.1271362,-2.1749210,359.9999390,180.0000000,171.9964600, -1, -1, -1, 400, 400); //object(des_wjetty) (4)
	CreateDynamicObject(1255,-616.9968262,940.7521973,10.0989752,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(lounger) (1)
	CreateDynamicObject(2571,-623.5712280,930.9794312,9.5250778,0.0000000,0.0000000,84.0000000, -1, -1, -1, 400, 400); //object(hotel_single_1) (1)
	CreateDynamicObject(970,-616.8414917,927.9675903,10.0765591,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(fencesmallb) (32)
	CreateDynamicObject(970,-614.5090942,929.7167969,10.0765591,0.0000000,0.0000000,81.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (33)
	CreateDynamicObject(970,-620.9329834,928.5177002,10.0765591,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (34)
	CreateDynamicObject(970,-625.0222168,929.1134033,10.0765591,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (35)
	CreateDynamicObject(11496,-629.5825195,937.6790161,9.3250790,0.0000000,0.0000000,171.9964600, -1, -1, -1, 400, 400); //object(des_wjetty) (5)
	CreateDynamicObject(970,-629.1015625,929.6897583,10.0765591,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (37)
	CreateDynamicObject(970,-633.1524048,930.2566528,10.0765591,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (38)
	CreateDynamicObject(11496,-636.0928955,938.5543213,9.3250790,0.0000000,0.0000000,171.9964600, -1, -1, -1, 400, 400); //object(des_wjetty) (6)
	CreateDynamicObject(970,-637.2224121,930.8291016,10.0765591,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (39)
	CreateDynamicObject(970,-613.9358521,933.8020630,10.0765591,0.0000000,0.0000000,81.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (40)
	CreateDynamicObject(970,-613.3474121,937.8790283,10.0765591,0.0000000,0.0000000,81.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (41)
	CreateDynamicObject(970,-612.7812500,941.9690552,10.0765591,0.0000000,0.0000000,81.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (42)
	CreateDynamicObject(11496,-620.9164429,940.6983643,9.3250790,0.0000000,0.0000000,81.9964600, -1, -1, -1, 400, 400); //object(des_wjetty) (7)
	CreateDynamicObject(970,-614.5434570,944.3178101,10.0765591,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(fencesmallb) (43)
	CreateDynamicObject(970,-618.7933960,944.8788452,10.1644735,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(fencesmallb) (44)
	CreateDynamicObject(3749,-715.3441772,959.6979980,17.0727997,0.0000000,0.0000000,88.0000000, -1, -1, -1, 400, 400); //object(clubgate01_lax) (1)
	CreateDynamicObject(7191,-717.4321899,929.7674561,13.1844416,0.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (3)
	CreateDynamicObject(7191,-696.1714478,907.2477417,13.1844416,0.0000000,0.0000000,89.9949951, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (4)
	CreateDynamicObject(7191,-696.1708984,907.2470703,9.6844416,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (9)
	CreateDynamicObject(7191,-692.1938477,1009.9541626,13.1844416,0.0000000,0.0000000,267.9945068, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (10)
	CreateDynamicObject(7191,-715.2188721,988.7850342,13.1844416,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (11)
	CreateDynamicObject(7191,-648.3458252,1004.0491943,13.1844416,0.0000000,0.0000000,255.9895020, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (12)
	CreateDynamicObject(7191,-648.3457031,1004.0488281,9.6844416,0.0000000,0.0000000,255.9869385, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (13)
	CreateDynamicObject(7191,-614.3106079,979.7031860,9.6844416,0.0000000,0.0000000,213.9869385, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (14)
	CreateDynamicObject(7191,-614.3105469,979.7031250,12.9344416,0.0000000,0.0000000,213.9862061, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (15)
	CreateDynamicObject(7191,-613.4462891,941.9130859,5.4344416,0.0000000,0.0000000,149.9853516, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (16)
	CreateDynamicObject(7191,-646.8398438,926.9160156,5.4344416,0.0000000,0.0000000,79.9804688, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (17)
	CreateDynamicObject(7191,-614.3105469,979.7031250,5.9344416,0.0000000,0.0000000,213.9862061, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (18)
	CreateDynamicObject(14754,-684.6254883,964.3312988,4.2500000,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bigsanfranhoose) (1)
	CreateDynamicObject(1337,-678.6962891,955.2529297,2.1744325,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(binnt07_la) (3)
	CreateDynamicObject(7191,-613.4462891,941.9130859,1.9344416,0.0000000,0.0000000,149.9853516, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (16)
	CreateDynamicObject(7191,-646.8398438,926.9160156,1.6844416,0.0000000,0.0000000,79.9804688, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (17)
	CreateDynamicObject(983,-23.2365246,1294.1367188,21.5776138,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (51)
	CreateDynamicObject(6959,-20.5214195,1292.8916016,8.3873158,0.0000000,0.0000000,1.9875488, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(6959,-17.8536377,1267.7296143,-10.8626842,285.9999695,180.0000000,181.9830322, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(1337,759.0400391,1605.0664062,9.8954182,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(binnt07_la) (1)
	CreateDynamicObject(8172,5.0645227,2502.9753418,15.7825584,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vgssairportland07) (1)
	CreateDynamicObject(8171,154.9697266,2502.9116211,15.7669334,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(vgssairportland06) (1)
	CreateDynamicObject(8171,292.9130859,2502.9062500,15.7669334,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(vgssairportland06) (2)
	CreateDynamicObject(8172,371.0125427,2502.8554688,15.7825584,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(vgssairportland07) (2)
	CreateDynamicObject(4241,344.4833984,2472.8017578,15.7343750,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(sbsbed4law2) (1)
	CreateDynamicObject(4241,146.6318359,2472.9316406,15.7343750,0.0000000,0.0000000,269.9949951, -1, -1, -1, 400, 400); //object(sbsbed4law2) (2)
	CreateDynamicObject(4241,19.3691406,2486.1914062,15.7343750,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(sbsbed4law2) (3)
	CreateDynamicObject(4241,-65.8206329,2494.5642090,-82.3556137,82.0000000,180.0000000,89.9945068, -1, -1, -1, 400, 400); //object(sbsbed4law2) (5)
	CreateDynamicObject(13725,-16.6455078,2557.4570312,35.5389099,0.0000000,0.0000000,353.9959717, -1, -1, -1, 400, 400); //object(opmans01_cunte) (1)
	CreateDynamicObject(9949,84.0497589,2426.0029297,27.7497921,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(pier1_sfe) (1)
	CreateDynamicObject(1337,205.5908203,2390.2373047,30.7967377,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(binnt07_la) (2)
	CreateDynamicObject(8555,143.2393188,2411.9560547,36.6999969,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (5)
	CreateDynamicObject(8555,143.2392578,2451.0625000,36.6999969,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(8555,226.3223114,2450.9606934,36.6999969,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (7)
	CreateDynamicObject(8555,226.3192291,2411.8425293,36.6999969,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (8)
	CreateDynamicObject(8555,307.6356201,2411.6601562,36.6999969,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (9)
	CreateDynamicObject(8555,307.6546326,2450.7541504,36.6999969,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (10)
	CreateDynamicObject(8565,345.2033386,2440.8566895,21.6585121,0.0000000,0.0000000,181.9999695, -1, -1, -1, 400, 400); //object(vgsebuild03_lvs) (1)
	CreateDynamicObject(3491,0.2048681,2450.2016602,24.0973549,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(vegass_hanger2) (1)
	CreateDynamicObject(6959,14.0479870,2463.0234375,15.7704058,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (49)
	CreateDynamicObject(6959,13.7742138,2441.5458984,15.7704058,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (50)
	CreateDynamicObject(6959,-22.1357441,2441.4790039,15.7704058,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (51)
	CreateDynamicObject(6959,-23.7143192,2463.5388184,15.7704058,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (52)
	CreateDynamicObject(3268,-69.5795975,2433.3911133,15.7343750,0.0000000,0.0000000,179.9999390, -1, -1, -1, 400, 400); //object(mil_hangar1_) (1)
	CreateDynamicObject(3268,-69.5518417,2463.2143555,15.7343750,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(mil_hangar1_) (2)
	CreateDynamicObject(6959,-58.9101562,2462.9042969,15.7704058,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (53)
	CreateDynamicObject(6959,-58.9352989,2435.1762695,15.7704058,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (54)
	CreateDynamicObject(6959,-59.7691574,2551.6569824,16.3172607,2.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (53)
	CreateDynamicObject(6959,-38.7022362,2551.7268066,16.3172607,1.9995117,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (53)
	CreateDynamicObject(6959,-79.4576111,2547.5119629,-2.6627369,271.9993896,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (53)
	CreateDynamicObject(6959,-17.5322151,2556.5502930,-2.9127369,271.9940186,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (53)
	CreateDynamicObject(7191,-80.3178406,2547.0114746,17.0606480,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (21)
	CreateDynamicObject(7191,-80.2551117,2502.8369141,17.0606480,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (23)
	CreateDynamicObject(7191,-80.1909943,2458.4433594,17.0606480,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (24)
	CreateDynamicObject(7191,-80.1252518,2413.8698730,17.0606480,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (25)
	CreateDynamicObject(7191,-80.1250000,2413.8691406,13.5606480,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (26)
	CreateDynamicObject(7191,-80.1904297,2458.4433594,13.3106480,0.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (27)
	CreateDynamicObject(7191,-58.2419205,2392.0844727,19.3106480,354.0000000,0.0000000,92.0000000, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (28)
	CreateDynamicObject(7191,-14.9500198,2394.1279297,19.3106480,5.9959717,0.0000000,93.7495117, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (30)
	CreateDynamicObject(7191,-14.9492188,2394.1279297,15.8106480,5.9930420,0.0000000,93.7463379, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (33)
	CreateDynamicObject(7191,29.1504440,2396.9213867,17.0606480,359.9930420,0.0000000,93.7463379, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (34)
	CreateDynamicObject(7191,69.1766434,2386.3757324,17.0606480,359.9890137,0.0000000,55.7408447, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (35)
	CreateDynamicObject(7191,110.6840439,2373.4594727,17.0606480,359.9835205,0.0000000,89.7391357, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (36)
	CreateDynamicObject(7191,155.2980042,2373.9804688,17.0606480,359.9780273,0.0000000,91.7358398, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (37)
	CreateDynamicObject(7191,232.6108704,2375.1206055,17.0606480,359.9780273,0.0000000,269.7358704, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (39)
	CreateDynamicObject(7191,232.8758392,2374.9943848,17.0606480,359.9780273,0.0000000,89.7308350, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (40)
	CreateDynamicObject(7191,277.2343750,2374.7573242,17.0606480,359.9780273,0.0000000,89.7308350, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (41)
	CreateDynamicObject(7191,322.0241699,2374.5327148,17.0606480,359.9780273,0.0000000,89.7308350, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (42)
	CreateDynamicObject(7191,361.9322510,2387.0305176,17.0606480,359.9780273,0.0000000,125.7308350, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (43)
	CreateDynamicObject(7191,399.7468872,2409.6235352,17.0606480,359.9780273,0.0000000,115.7275391, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (44)
	CreateDynamicObject(7191,416.7725830,2417.7915039,17.0606480,359.9780273,0.0000000,115.7244873, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (46)
	CreateDynamicObject(7191,437.9771729,2449.5065918,17.0606480,359.9780273,0.0000000,177.7244873, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (47)
	CreateDynamicObject(7191,439.0392456,2494.0932617,17.0606480,359.9780273,0.0000000,179.7203369, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (48)
	CreateDynamicObject(7191,443.7097473,2537.8969727,17.0606480,359.9780273,0.0000000,167.7198486, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (51)
	CreateDynamicObject(7191,443.7089844,2537.8964844,14.8106480,359.9780273,0.0000000,167.7172852, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (52)
	CreateDynamicObject(7191,447.2388306,2553.7265625,14.8106480,359.9780273,0.0000000,167.7172852, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (53)
	CreateDynamicObject(7191,447.2382812,2553.7265625,17.0606480,359.9780273,0.0000000,167.7172852, -1, -1, -1, 400, 400); //object(vegasnnewfence2b) (54)
	CreateDynamicObject(9241,310.5259399,2648.1652832,25.8142757,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(copbits_sfn) (2)
	CreateDynamicObject(9241,152.6718445,2551.2792969,17.2932739,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(copbits_sfn) (4)
	CreateDynamicObject(10838,193.7274170,2375.0158691,32.0883942,0.0000000,0.0000000,269.9999695, -1, -1, -1, 400, 400); //object(airwelcomesign_sfse) (1)
	CreateDynamicObject(9314,221.0762329,2375.0612793,20.7445583,0.0000000,0.0000000,269.9999695, -1, -1, -1, 400, 400); //object(advert01_sfn) (1)
	CreateDynamicObject(3458,194.7244568,2370.8989258,14.0059052,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgncarshade1) (2)
	CreateDynamicObject(3458,194.8107300,2366.3886719,14.2559052,354.0000000,0.0000000,2.0000000, -1, -1, -1, 400, 400); //object(vgncarshade1) (4)
	CreateDynamicObject(3458,194.8693085,2361.5710449,14.5059052,359.9959717,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (5)
	CreateDynamicObject(3458,194.9940948,2356.8203125,14.5059052,359.9945068,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (6)
	CreateDynamicObject(3458,195.1246948,2351.8203125,14.5059052,359.9945068,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (7)
	CreateDynamicObject(3458,195.2555542,2346.8203125,14.5059052,359.9945068,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (8)
	CreateDynamicObject(3458,195.3798370,2342.0703125,14.5059052,359.9945068,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (9)
	CreateDynamicObject(3458,195.5644989,2337.0754395,15.0059052,347.9945068,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (14)
	CreateDynamicObject(3458,195.7500000,2332.3298340,16.0059052,347.9919434,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (15)
	CreateDynamicObject(3458,196.0395355,2328.5900879,16.7559052,347.9919434,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (16)
	CreateDynamicObject(3458,196.4251099,2323.6044922,17.7559052,347.9919434,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (17)
	CreateDynamicObject(3458,196.8108521,2318.6191406,18.7559052,347.9919434,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (18)
	CreateDynamicObject(3458,196.7540131,2313.8691406,19.7559052,347.9919434,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (19)
	CreateDynamicObject(3458,196.7579651,2309.1191406,20.7559052,347.9919434,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (21)
	CreateDynamicObject(3458,196.9270325,2304.3493652,21.3844032,357.9919434,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (23)
	CreateDynamicObject(3458,197.4511719,2299.4570312,21.3844032,359.9890137,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (24)
	CreateDynamicObject(3458,197.6015320,2295.7333984,21.3844032,359.9890137,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (25)
	CreateDynamicObject(3458,197.8886719,2291.0048828,20.8844032,11.9860840,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(vgncarshade1) (26)
	CreateDynamicObject(967,209.1192780,2374.0695801,15.7343750,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(bar_gatebox01) (1)
	CreateDynamicObject(967,210.6191406,2374.0649414,15.7343750,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(bar_gatebox01) (2)
	CreateDynamicObject(967,212.1191406,2374.0600586,15.7343750,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(bar_gatebox01) (3)
	CreateDynamicObject(16000,393.4905090,2550.6396484,8.2343750,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(drvin_screen) (1)
	CreateDynamicObject(16000,382.5609131,2539.7687988,8.2343750,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(drvin_screen) (2)
	CreateDynamicObject(16000,393.6861572,2529.1120605,8.2343750,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(drvin_screen) (3)
	CreateDynamicObject(16000,404.5532227,2539.8916016,8.2343750,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(drvin_screen) (4)
	CreateDynamicObject(16000,393.6855469,2529.1113281,18.9843750,90.0000000,180.4035187,359.5910339, -1, -1, -1, 400, 400); //object(drvin_screen) (5)
	CreateDynamicObject(16000,393.6887207,2550.1486816,18.9843750,90.0000000,179.5990601,180.3898926, -1, -1, -1, 400, 400); //object(drvin_screen) (6)
	CreateDynamicObject(3928,393.4524536,2539.9101562,18.9878559,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(helipad) (1)
	CreateDynamicObject(3361,403.2995605,2553.5139160,16.7582474,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(cxref_woodstair) (10)
	CreateDynamicObject(10757,187.9543457,2373.9587402,36.5618820,0.0000000,348.0000000,336.0000000, -1, -1, -1, 400, 400); //object(airport_04_sfse) (1)
	CreateDynamicObject(10757,413.2645874,2542.6748047,27.5282841,5.9414062,8.0409241,353.1571045, -1, -1, -1, 400, 400); //object(airport_04_sfse) (2)
	CreateDynamicObject(1681,53.0337830,2408.4892578,17.7124004,0.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(ap_learjet1_01) (1)
	CreateDynamicObject(1681,16.4234810,2408.3469238,16.9624004,1.9951172,355.9975891,272.1395874, -1, -1, -1, 400, 400); //object(ap_learjet1_01) (2)
	CreateDynamicObject(1683,20.2942085,2542.8852539,21.6370010,0.0000000,0.0000000,339.7500000, -1, -1, -1, 400, 400); //object(ap_jumbo_01) (1)
	CreateDynamicObject(1683,185.5383759,2413.7546387,18.9879990,0.0000000,0.0000000,271.7462158, -1, -1, -1, 400, 400); //object(ap_jumbo_01) (2)
	CreateDynamicObject(1683,267.8019409,2413.3500977,18.9879990,0.0000000,0.0000000,271.7413330, -1, -1, -1, 400, 400); //object(ap_jumbo_01) (4)
	CreateDynamicObject(2774,-14.9262924,2556.2770996,25.8149357,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (11)
	CreateDynamicObject(2774,-14.9436054,2557.7763672,25.8149357,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (12)
	CreateDynamicObject(2774,-15.1876059,2559.5158691,25.8149357,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (13)
	CreateDynamicObject(2774,-16.6757717,2556.2712402,25.8149357,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (14)
	CreateDynamicObject(2774,-18.1747932,2556.2661133,25.8149357,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (15)
	CreateDynamicObject(2774,-18.2084751,2558.0156250,25.8149357,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (16)
	CreateDynamicObject(2774,-18.2377052,2559.5156250,25.8149357,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (17)
	CreateDynamicObject(2774,-16.7378540,2559.4746094,25.8149357,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_airp_pillars) (18)
	CreateDynamicObject(8555,312.4785767,2589.3530273,0.9100032,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(8555,312.4829407,2628.3718262,0.9100032,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(8555,232.8808746,2628.1857910,0.9100032,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(8555,232.9002075,2590.0532227,0.9100032,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(8555,148.2759399,2590.1062012,0.9100032,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(8555,148.2509308,2629.1362305,0.9100032,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(8555,148.2269897,2668.3803711,0.9100032,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(8555,232.8960876,2665.3742676,0.9100032,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(8555,312.8403015,2665.4462891,0.9100032,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsecrthse) (6)
	CreateDynamicObject(9241,311.3803406,2594.7443848,25.8142757,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(copbits_sfn) (2)
	CreateDynamicObject(9241,229.8329926,2592.2919922,25.8142757,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(copbits_sfn) (2)
	CreateDynamicObject(9241,229.6687164,2650.6345215,25.8142757,0.0000000,0.0000000,88.0000000, -1, -1, -1, 400, 400); //object(copbits_sfn) (2)
	CreateDynamicObject(4828,148.1994781,2604.8239746,34.5296021,0.0000000,0.0000000,88.0000000, -1, -1, -1, 400, 400); //object(lasairprt5) (1)
	CreateDynamicObject(3361,280.8175049,2566.6533203,22.0082474,0.0000000,0.0000000,272.0000000, -1, -1, -1, 400, 400); //object(cxref_woodstair) (17)
	CreateDynamicObject(3361,284.8312988,2562.1730957,17.7582474,0.0000000,0.0000000,359.9995117, -1, -1, -1, 400, 400); //object(cxref_woodstair) (18)
	CreateDynamicObject(3361,276.8339844,2562.2329102,17.7582474,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(cxref_woodstair) (19)
	CreateDynamicObject(983,280.2132568,2561.1835938,17.6921120,90.0000000,179.3060303,90.4414368, -1, -1, -1, 400, 400); //object(fenceshit3) (41)
	CreateDynamicObject(983,281.4624329,2561.1506348,17.6921120,90.0000000,179.3023682,90.4394531, -1, -1, -1, 400, 400); //object(fenceshit3) (41)
	CreateDynamicObject(1251,-32.4755783,1290.9844971,17.1926250,0.0000000,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(1251,-33.0628738,1299.7476807,17.1893597,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(14410,-3.7981839,1271.4244385,4.8818359,0.0000000,0.0000000,2.0000000, -1, -1, -1, 400, 400); //object(carter-stairs03) (1)
	CreateDynamicObject(14410,-7.5368505,1271.2509766,4.8818359,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(carter-stairs03) (2)
	CreateDynamicObject(14410,-11.3033018,1271.0977783,4.8818359,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(carter-stairs03) (3)
	CreateDynamicObject(14410,-15.3013954,1270.9622803,4.8818359,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(carter-stairs03) (4)
	CreateDynamicObject(14410,-19.2919617,1270.8111572,4.8818359,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(carter-stairs03) (5)
	CreateDynamicObject(14410,-23.2734509,1270.7597656,4.8818359,0.0000000,0.0000000,359.9995117, -1, -1, -1, 400, 400); //object(carter-stairs03) (6)
	CreateDynamicObject(14410,-27.0489120,1270.7508545,4.8818359,0.0000000,0.0000000,359.9945068, -1, -1, -1, 400, 400); //object(carter-stairs03) (7)
	CreateDynamicObject(14410,-31.0488281,1270.7480469,4.8818359,0.0000000,0.0000000,359.9995117, -1, -1, -1, 400, 400); //object(carter-stairs03) (8)
	CreateDynamicObject(983,-35.2582703,1274.7802734,9.0396204,0.0000000,0.0000000,291.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,-29.3115616,1277.1550293,9.0458307,0.0000000,0.0000000,291.9946289, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,-23.2934895,1279.2387695,9.0396204,0.0000000,0.0000000,285.9946289, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,-17.1063290,1280.7949219,9.0396204,0.0000000,0.0000000,281.9906006, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,-10.7851562,1282.0136719,9.0396204,0.0000000,0.0000000,279.9810791, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,-4.4878674,1282.1127930,9.0396204,0.0000000,0.0000000,261.9810791, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,0.7364559,1276.1911621,9.0396204,0.0000000,0.0000000,181.9799805, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,0.2725397,1279.8177490,6.5396204,270.0000000,180.4035187,42.3811340, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,-0.5675362,1280.7432861,6.5396204,270.0000000,180.1094055,42.0881653, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,-0.9033816,1281.1135254,6.5396204,270.0000000,179.9714966,41.9502869, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(983,-0.0633231,1280.1873779,6.5396204,270.0000000,179.9670410,41.9458008, -1, -1, -1, 400, 400); //object(fenceshit3) (53)
	CreateDynamicObject(3069,-80.1171875,1340.4599609,19.6672707,278.0000000,180.0000000,95.9985352, -1, -1, -1, 400, 400); //object(d9_ramp) (2)
	CreateDynamicObject(3069,-79.9070740,1337.9685059,19.6672707,277.9980469,179.9945068,95.9930420, -1, -1, -1, 400, 400); //object(d9_ramp) (2)
	CreateDynamicObject(8169,-76.0214157,1346.7883301,9.9467354,0.0000000,358.0000000,285.9960938, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(6959,-92.1791916,1349.4898682,10.4821892,358.0012207,2.0012207,6.0573730, -1, -1, -1, 400, 400); //object(vegasnbball1) (37)
	CreateDynamicObject(8169,-69.3782806,1347.0056152,8.6759205,326.3753052,9.6214905,295.3589478, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(8169,-69.9538879,1353.6508789,8.4259205,326.3708496,9.6185303,295.3564453, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(8169,-72.5145798,1360.1295166,7.1759205,284.1370239,97.9863892,16.2268372, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(8169,-73.4944229,1366.5723877,6.9259205,284.1339111,97.9815674,16.2268066, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(8169,-70.3427200,1339.9595947,7.9259205,286.1114502,96.9488525,9.2230225, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(8169,-69.9383240,1334.7103271,8.1759205,284.1295471,97.9798279,12.2184448, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(8169,-73.0129395,1331.2369385,8.4259205,284.1284180,97.9760742,284.2164307, -1, -1, -1, 400, 400); //object(vgs_guardhseflr) (6)
	CreateDynamicObject(1215,-36.3459702,1299.8673096,17.8869953,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (170)
	CreateDynamicObject(1215,-3.3300095,1301.1137695,17.8869953,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (170)
	CreateDynamicObject(1290,-18.6461830,1287.0314941,23.1477051,0.0000000,0.0000000,181.9875641, -1, -1, -1, 400, 400); //object(lamppost2) (10)
	CreateDynamicObject(1215,-38.0783806,1272.8692627,8.9203892,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (170)
	CreateDynamicObject(1215,0.5341988,1273.3947754,8.8196411,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (170)
	CreateDynamicObject(5170,746.8470459,1805.8475342,7.4235373,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(imnrmpy2_las2) (1)
	CreateDynamicObject(5170,733.9060669,1806.5684814,7.4235373,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(imnrmpy2_las2) (2)
	CreateDynamicObject(8838,747.7891846,1817.2978516,3.3552055,0.0000000,0.0000000,269.9971924, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,747.7667847,1784.8322754,3.3552055,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,747.7666016,1784.8320312,3.3552055,0.0000000,0.0000000,269.9890137, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,733.2698364,1784.5961914,3.3552055,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,733.2274170,1817.1625977,3.3552055,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(3578,745.3088989,1828.7637939,4.3561583,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (4)
	CreateDynamicObject(3578,745.2898560,1818.5972900,4.3561583,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (5)
	CreateDynamicObject(3578,745.2725830,1808.3587646,4.3561583,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (9)
	CreateDynamicObject(3578,745.2658691,1798.0958252,4.3561583,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (10)
	CreateDynamicObject(3578,745.2550659,1787.9598389,4.3561583,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (11)
	CreateDynamicObject(3578,745.2440186,1777.8864746,4.3561583,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (12)
	CreateDynamicObject(3578,745.2329102,1773.1319580,4.3561583,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (13)
	CreateDynamicObject(3578,735.7324219,1773.2524414,4.3561583,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (14)
	CreateDynamicObject(3578,735.7493286,1783.5102539,4.3561583,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (15)
	CreateDynamicObject(3578,735.7624512,1793.5129395,4.3561583,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (16)
	CreateDynamicObject(3578,735.7835693,1803.7613525,4.3561583,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (17)
	CreateDynamicObject(3578,735.7907104,1814.0173340,4.3561583,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (18)
	CreateDynamicObject(3578,735.7974243,1824.2745361,4.3561583,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (19)
	CreateDynamicObject(3578,735.8192749,1828.7293701,4.3561583,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(dockbarr1_la) (20)
	CreateDynamicObject(1256,749.9308472,1827.9481201,5.5452604,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (7)
	CreateDynamicObject(1256,749.8476562,1822.9472656,5.5452604,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (8)
	CreateDynamicObject(1256,749.8281250,1817.9472656,5.5452604,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (9)
	CreateDynamicObject(1256,749.7529297,1798.6972656,5.5452604,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (13)
	CreateDynamicObject(1256,749.7314453,1793.1972656,5.5452604,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (14)
	CreateDynamicObject(1256,749.7797852,1787.6972656,5.5452604,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (15)
	CreateDynamicObject(1256,731.3928833,1788.1517334,5.5452604,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (17)
	CreateDynamicObject(1256,731.2464600,1793.0203857,5.5452604,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (18)
	CreateDynamicObject(1256,731.1905518,1797.9213867,5.5452604,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (19)
	CreateDynamicObject(1256,731.1928711,1826.6523438,5.5452604,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (20)
	CreateDynamicObject(1256,731.1462402,1821.4023438,5.5452604,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (21)
	CreateDynamicObject(1256,731.1000977,1816.1523438,5.5452604,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (22)
	CreateDynamicObject(982,750.3538818,1821.0727539,5.5693583,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (7)
	CreateDynamicObject(982,750.3306885,1795.5528564,5.5693583,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (22)
	CreateDynamicObject(982,730.8516846,1795.3205566,5.5693583,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (23)
	CreateDynamicObject(982,730.8315430,1820.8177490,5.5693583,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (24)
	CreateDynamicObject(984,730.8557739,1776.0983887,5.5224833,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (20)
	CreateDynamicObject(984,750.3323364,1776.3847656,5.5224833,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (21)
	CreateDynamicObject(984,750.2911377,1769.3962402,-0.2275167,90.0000000,180.0000000,180.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (22)
	CreateDynamicObject(984,730.8378906,1768.9992676,-0.2275167,90.0000000,179.9945068,179.9945068, -1, -1, -1, 400, 400); //object(fenceshit2) (23)
	CreateDynamicObject(994,735.8115234,1840.3349609,4.1873703,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (15)
	CreateDynamicObject(994,745.3115234,1840.2282715,4.1873703,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (16)
	CreateDynamicObject(1215,749.8641357,1825.5407715,5.4501266,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (270)
	CreateDynamicObject(1215,749.9506836,1820.4033203,5.4501266,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (271)
	CreateDynamicObject(1215,749.9514160,1795.9007568,5.4501266,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (272)
	CreateDynamicObject(1215,749.9364014,1790.4003906,5.4501266,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (273)
	CreateDynamicObject(1215,731.1210938,1790.4384766,5.4501266,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (274)
	CreateDynamicObject(1215,731.2211914,1795.4384766,5.4501266,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (275)
	CreateDynamicObject(1215,730.9097900,1818.7548828,5.4501266,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (276)
	CreateDynamicObject(1215,731.0142822,1824.0048828,5.4501266,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (277)
	CreateDynamicObject(1231,733.1000977,1833.5161133,7.6161966,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (16)
	CreateDynamicObject(1231,747.5960693,1833.8625488,7.6161966,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (17)
	CreateDynamicObject(8572,731.7753906,1777.6318359,7.1990390,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vgssstairs02_lvs) (1)
	CreateDynamicObject(8572,749.4458008,1773.9605713,7.1990390,0.0000000,0.0000000,90.0000000, -1, -1, -1, 400, 400); //object(vgssstairs02_lvs) (2)
	CreateDynamicObject(984,738.9672241,1776.3272705,8.4240456,0.0000000,270.0000000,89.9998779, -1, -1, -1, 400, 400); //object(fenceshit2) (24)
	CreateDynamicObject(984,742.2150269,1776.2702637,8.4240456,0.0000000,270.0000000,89.9945068, -1, -1, -1, 400, 400); //object(fenceshit2) (25)
	CreateDynamicObject(984,738.9404297,1775.3276367,8.4240456,0.0000000,270.0000000,269.9931641, -1, -1, -1, 400, 400); //object(fenceshit2) (26)
	CreateDynamicObject(984,742.1907349,1775.3111572,8.4240456,0.0000000,270.0000000,269.9889832, -1, -1, -1, 400, 400); //object(fenceshit2) (27)
	CreateDynamicObject(984,738.9401855,1774.8017578,8.9240456,0.0000000,359.9999390,269.9890137, -1, -1, -1, 400, 400); //object(fenceshit2) (29)
	CreateDynamicObject(984,738.9963989,1777.0505371,8.9240456,0.0000000,359.9945068,269.9890137, -1, -1, -1, 400, 400); //object(fenceshit2) (30)
	CreateDynamicObject(983,745.5554810,1774.8054199,8.8669691,0.0000000,180.0000000,90.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (75)
	CreateDynamicObject(983,745.1006470,1776.9874268,8.8669691,0.0000000,179.9945068,90.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (78)
	CreateDynamicObject(8648,695.0779419,1835.7535400,5.2350912,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(shbbyhswall04_lvs) (1)
	CreateDynamicObject(8648,695.0779419,1835.7528076,5.9850912,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(shbbyhswall04_lvs) (2)
	CreateDynamicObject(8648,678.2626953,1824.1083984,5.2350912,0.0000000,0.0000000,259.9914551, -1, -1, -1, 400, 400); //object(shbbyhswall04_lvs) (4)
	CreateDynamicObject(8648,678.2626953,1824.1083984,6.2350912,0.0000000,0.0000000,259.9859619, -1, -1, -1, 400, 400); //object(shbbyhswall04_lvs) (12)
	CreateDynamicObject(8648,678.2626953,1824.1083984,7.2350912,0.0000000,0.0000000,259.9914551, -1, -1, -1, 400, 400); //object(shbbyhswall04_lvs) (13)
	CreateDynamicObject(8648,665.9492188,1841.0468750,5.2350912,0.0000000,0.0000000,171.9964600, -1, -1, -1, 400, 400); //object(shbbyhswall04_lvs) (14)
	CreateDynamicObject(8648,665.9492188,1841.0468750,6.2350912,0.0000000,0.0000000,171.9964600, -1, -1, -1, 400, 400); //object(shbbyhswall04_lvs) (15)
	CreateDynamicObject(8648,665.9492188,1841.0468750,7.2350912,0.0000000,0.0000000,171.9964600, -1, -1, -1, 400, 400); //object(shbbyhswall04_lvs) (16)
	CreateDynamicObject(9361,681.9341431,1850.4287109,7.2448573,0.0000000,0.0000000,308.0000000, -1, -1, -1, 400, 400); //object(boatoffice_sfn) (2)
	CreateDynamicObject(8648,695.0771484,1835.7519531,6.9850912,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(shbbyhswall04_lvs) (18)
	CreateDynamicObject(10832,673.0259399,1852.2647705,6.4107695,0.0000000,0.0000000,82.0000000, -1, -1, -1, 400, 400); //object(gatehouse2_sfse) (1)
	CreateDynamicObject(2254,679.6828003,1848.9106445,6.4962215,0.0000000,0.0000000,354.0000000, -1, -1, -1, 400, 400); //object(frame_clip_1) (2)
	CreateDynamicObject(2811,685.8905640,1852.5156250,4.9109278,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(gb_romanpot01) (1)
	CreateDynamicObject(3660,725.2767334,1846.2683105,5.7758818,0.0000000,0.0000000,348.0000000, -1, -1, -1, 400, 400); //object(lasairfbed_las) (6)
	CreateDynamicObject(2164,681.9977417,1853.5500488,4.8698573,0.0000000,0.0000000,354.0000000, -1, -1, -1, 400, 400); //object(med_office_unit_5) (1)
	CreateDynamicObject(2197,683.5278320,1851.9854736,4.8698573,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(filling_cabinet) (1)
	CreateDynamicObject(2197,684.2760620,1851.9173584,4.8698573,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(filling_cabinet) (2)
	CreateDynamicObject(2197,685.0166016,1851.8027344,4.8698573,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(filling_cabinet) (3)
	CreateDynamicObject(2290,685.7145996,1850.9025879,4.9112229,0.0000000,0.0000000,262.0000000, -1, -1, -1, 400, 400); //object(swk_couch_1) (1)
	CreateDynamicObject(1998,679.5491333,1852.0922852,4.8698573,0.0000000,0.0000000,262.0000000, -1, -1, -1, 400, 400); //object(officedesk1l) (1)
	CreateDynamicObject(1663,681.6658936,1852.2258301,5.3300714,0.0000000,0.0000000,282.0000000, -1, -1, -1, 400, 400); //object(swivelchair_b) (1)
	CreateDynamicObject(1663,681.5061035,1850.7343750,5.3300714,0.0000000,0.0000000,247.9970703, -1, -1, -1, 400, 400); //object(swivelchair_b) (2)
	CreateDynamicObject(1671,679.6691895,1851.2446289,5.3300714,0.0000000,0.0000000,80.0000000, -1, -1, -1, 400, 400); //object(swivelchair_a) (2)
	CreateDynamicObject(1523,680.6463623,1848.9483643,4.6122704,0.0000000,0.0000000,354.0000000, -1, -1, -1, 400, 400); //object(gen_doorext10) (1)
	CreateDynamicObject(1523,683.6267700,1848.6231689,4.6122704,0.0000000,0.0000000,171.9959717, -1, -1, -1, 400, 400); //object(gen_doorext10) (2)
	CreateDynamicObject(1215,677.7087402,1848.6732178,5.0180025,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (278)
	CreateDynamicObject(1215,681.2723999,1853.3411865,5.4341803,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (279)
	CreateDynamicObject(1231,676.2810059,1837.5633545,6.8950076,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (18)
	CreateDynamicObject(1231,676.2802734,1837.5625000,6.8950076,0.0000000,0.0000000,280.0000000, -1, -1, -1, 400, 400); //object(streetlamp2) (19)
	CreateDynamicObject(1231,685.4015503,1836.0178223,6.8950076,0.0000000,0.0000000,231.9975586, -1, -1, -1, 400, 400); //object(streetlamp2) (20)
	CreateDynamicObject(1231,685.4013672,1836.0175781,6.8950076,0.0000000,0.0000000,145.9927979, -1, -1, -1, 400, 400); //object(streetlamp2) (21)
	CreateDynamicObject(1231,697.1906128,1850.2463379,6.8950076,0.0000000,0.0000000,171.9918213, -1, -1, -1, 400, 400); //object(streetlamp2) (22)
	CreateDynamicObject(3241,698.8810425,1905.2711182,4.7434492,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(conhoos2) (1)
	CreateDynamicObject(3242,676.5679932,1905.6826172,6.6797419,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(conhoos1) (1)
	CreateDynamicObject(3555,701.5140381,1895.8963623,7.4714036,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(compmedhos2_lae) (1)
	CreateDynamicObject(3556,702.8066406,1869.9025879,7.0610542,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(compmedhos3_lae) (2)
	CreateDynamicObject(3557,686.2348633,1872.4555664,6.8416872,0.0000000,0.0000000,171.9949951, -1, -1, -1, 400, 400); //object(compmedhos4_lae) (1)
	CreateDynamicObject(3558,673.7639160,1889.2882080,7.6980019,0.0000000,0.0000000,83.9959717, -1, -1, -1, 400, 400); //object(compmedhos5_lae) (2)
	CreateDynamicObject(3582,670.2440186,1875.0416260,6.6878405,0.0000000,0.0000000,84.0000000, -1, -1, -1, 400, 400); //object(compmedhos1_lae) (1)
	CreateDynamicObject(3583,724.1926880,1903.3021240,7.5615644,0.0000000,0.0000000,87.9949951, -1, -1, -1, 400, 400); //object(compbigho3_lae) (2)
	CreateDynamicObject(3587,725.7331543,1891.2763672,6.9797606,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(nwsnpedhus1_las) (2)
	CreateDynamicObject(3590,701.2578735,1883.1088867,7.2668128,0.0000000,0.0000000,269.9949951, -1, -1, -1, 400, 400); //object(compfukhouse2) (1)
	CreateDynamicObject(3634,779.2199707,1940.5346680,7.3069754,0.0000000,0.0000000,261.9974365, -1, -1, -1, 400, 400); //object(nwccumphus1_las) (1)
	CreateDynamicObject(3642,758.1341553,1974.7814941,6.7870383,0.0000000,0.0000000,79.9914551, -1, -1, -1, 400, 400); //object(glenphouse03_lax) (3)
	CreateDynamicObject(3640,752.8199463,1943.8005371,8.6458778,0.0000000,0.0000000,79.9964600, -1, -1, -1, 400, 400); //object(glenphouse02_lax) (1)
	CreateDynamicObject(17699,783.1616821,1956.3114014,8.7248163,0.0000000,0.0000000,172.0000000, -1, -1, -1, 400, 400); //object(mcstraps_lae2) (1)
	CreateDynamicObject(17697,791.1473389,1698.9219971,8.8951025,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(carlshou1_lae2) (1)
	CreateDynamicObject(17697,791.1908569,1696.3620605,8.8951025,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(carlshou1_lae2) (2)
	CreateDynamicObject(9931,704.7095337,1973.9335938,21.0856266,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(church_sfe) (1)
	CreateDynamicObject(8132,727.6191406,1922.9949951,7.1422815,0.0000000,0.0000000,284.0000000, -1, -1, -1, 400, 400); //object(vgschurch03_lvs) (1)
	CreateDynamicObject(8132,674.9896240,1922.9876709,7.1422815,0.0000000,0.0000000,283.9965820, -1, -1, -1, 400, 400); //object(vgschurch03_lvs) (3)
	CreateDynamicObject(8292,649.9158936,1933.7150879,14.1196795,0.0000000,0.0000000,326.0000000, -1, -1, -1, 400, 400); //object(vgsbboardsigns01) (1)
	CreateDynamicObject(8131,704.6206055,1955.4819336,21.2324600,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgschurch02_lvs) (1)
	CreateDynamicObject(8131,671.7744751,1922.1516113,0.2024612,358.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgschurch02_lvs) (2)
	CreateDynamicObject(11008,769.5898438,1875.0742188,10.2368927,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(firehouse_sfs) (1)
	CreateDynamicObject(3504,731.4525757,1770.1875000,6.2281675,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (6)
	CreateDynamicObject(3504,731.4821777,1771.6875000,6.2281675,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (7)
	CreateDynamicObject(3504,731.5114746,1773.1875000,6.2281675,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (8)
	CreateDynamicObject(3504,731.5217285,1774.6875000,6.2281675,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (9)
	CreateDynamicObject(3504,731.5324707,1776.1875000,6.2281675,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(vgsn_portaloo) (10)
	CreateDynamicObject(16000,650.0559082,1933.7437744,8.0173941,2.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(drvin_screen) (7)
	CreateDynamicObject(16000,650.0556641,1933.7431641,-4.4826059,1.9995117,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(drvin_screen) (8)
	CreateDynamicObject(6959,772.1500244,1948.9851074,4.6660600,0.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(vegasnbball1) (60)
	CreateDynamicObject(6959,766.6494141,1948.9494629,4.6660600,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(vegasnbball1) (61)
	CreateDynamicObject(6959,768.0148315,1988.9061279,4.6660600,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(vegasnbball1) (62)
	CreateDynamicObject(6959,773.4809570,1987.6158447,4.6660600,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(vegasnbball1) (63)
	CreateDynamicObject(6959,791.0431519,1949.6079102,-15.3339405,274.0000000,180.0000000,87.9949341, -1, -1, -1, 400, 400); //object(vegasnbball1) (64)
	CreateDynamicObject(6959,792.1678467,1983.7304688,-15.3339405,273.9990234,179.9945068,87.9895020, -1, -1, -1, 400, 400); //object(vegasnbball1) (65)
	CreateDynamicObject(6959,746.8338623,1950.5684814,-15.3339405,271.9999695,0.0000000,267.9949951, -1, -1, -1, 400, 400); //object(vegasnbball1) (66)
	CreateDynamicObject(6959,747.9728394,1983.8939209,-15.3339405,271.9995117,0.0000000,267.9949951, -1, -1, -1, 400, 400); //object(vegasnbball1) (67)
	CreateDynamicObject(3642,753.7216797,1975.6645508,6.7870383,0.0000000,0.0000000,79.9914551, -1, -1, -1, 400, 400); //object(glenphouse03_lax) (3)
	CreateDynamicObject(17573,785.6203003,1975.0211182,6.1735139,0.0000000,0.0000000,348.0000000, -1, -1, -1, 400, 400); //object(rydhou01_lae2) (3)
	CreateDynamicObject(17934,755.1201172,1960.8339844,7.1335392,0.0000000,0.0000000,167.9974365, -1, -1, -1, 400, 400); //object(coochieghous) (1)
	CreateDynamicObject(3582,763.1642456,1992.7127686,7.3646502,0.0000000,0.0000000,346.0000000, -1, -1, -1, 400, 400); //object(compmedhos1_lae) (3)
	CreateDynamicObject(3582,762.3733521,1989.5415039,7.3646502,0.0000000,0.0000000,345.9979248, -1, -1, -1, 400, 400); //object(compmedhos1_lae) (4)
	CreateDynamicObject(3599,726.5743408,1872.6318359,7.3730249,0.0000000,0.0000000,268.0000000, -1, -1, -1, 400, 400); //object(hillhouse02_la) (1)
	CreateDynamicObject(7504,744.5434570,1971.6223145,5.9234705,0.0000000,0.0000000,270.0000000, -1, -1, -1, 400, 400); //object(glfcrsgate2_vgn) (1)
	CreateDynamicObject(7504,733.5478516,1972.0368652,5.9234705,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(glfcrsgate2_vgn) (2)
	CreateDynamicObject(7504,731.9702148,2064.1064453,5.9234705,0.0000000,0.0000000,91.9945068, -1, -1, -1, 400, 400); //object(glfcrsgate2_vgn) (3)
	CreateDynamicObject(7504,744.5573730,2064.0874023,5.9234705,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(glfcrsgate2_vgn) (4)
	CreateDynamicObject(982,745.6598511,1867.2536621,5.0225163,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (25)
	CreateDynamicObject(982,745.6229248,1892.8256836,5.0352440,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (26)
	CreateDynamicObject(982,734.4702148,1869.7980957,5.0352440,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (27)
	CreateDynamicObject(982,734.4662476,1895.3647461,5.0116796,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (28)
	CreateDynamicObject(982,734.4658203,1895.3642578,6.2616796,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (29)
	CreateDynamicObject(982,734.4658203,1895.3642578,7.5116796,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (30)
	CreateDynamicObject(982,734.4697266,1869.7978516,6.2852440,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (31)
	CreateDynamicObject(982,734.4697266,1869.7978516,7.5352440,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (32)
	CreateDynamicObject(982,745.6220703,1892.8251953,6.2852440,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (33)
	CreateDynamicObject(982,745.6220703,1892.8251953,7.5352440,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (34)
	CreateDynamicObject(982,745.6591797,1867.2529297,6.2725163,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (36)
	CreateDynamicObject(982,745.6591797,1867.2529297,7.5225163,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (37)
	CreateDynamicObject(983,745.6382446,1906.2441406,4.9256115,90.0000000,179.3079834,180.6864777, -1, -1, -1, 400, 400); //object(fenceshit3) (77)
	CreateDynamicObject(983,745.6145020,1907.4934082,4.9256115,90.0000000,179.3078613,180.6811523, -1, -1, -1, 400, 400); //object(fenceshit3) (79)
	CreateDynamicObject(996,727.0601196,1858.8680420,4.9560575,0.0000000,0.0000000,348.0000000, -1, -1, -1, 400, 400); //object(lhouse_barrier1) (1)
	CreateDynamicObject(3463,693.1894531,1924.7714844,4.6875000,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vegaslampost2) (2)
	CreateDynamicObject(3463,693.1894531,1924.7714844,4.6875000,0.0000000,0.0000000,92.0000000, -1, -1, -1, 400, 400); //object(vegaslampost2) (3)
	CreateDynamicObject(3463,801.0478516,1872.1635742,3.8038149,0.0000000,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(vegaslampost2) (5)
	CreateDynamicObject(3463,800.5557861,1886.6560059,3.8038149,0.0000000,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(vegaslampost2) (6)
	CreateDynamicObject(3460,707.7639771,1909.3681641,8.7596741,0.0000000,0.0000000,308.0000000, -1, -1, -1, 400, 400); //object(vegaslampost) (2)
	CreateDynamicObject(3460,709.3342896,1887.9855957,8.7596741,0.0000000,0.0000000,271.9962158, -1, -1, -1, 400, 400); //object(vegaslampost) (3)
	CreateDynamicObject(3460,709.2663574,1870.4420166,8.7596741,0.0000000,0.0000000,271.9940186, -1, -1, -1, 400, 400); //object(vegaslampost) (4)
	CreateDynamicObject(3460,699.5097046,1862.5411377,8.7596741,0.0000000,0.0000000,175.9940186, -1, -1, -1, 400, 400); //object(vegaslampost) (5)
	CreateDynamicObject(3460,671.3953247,1866.6815186,8.7596741,0.0000000,0.0000000,175.9899902, -1, -1, -1, 400, 400); //object(vegaslampost) (6)
	CreateDynamicObject(3460,663.9131470,1881.4659424,8.7596741,0.0000000,0.0000000,85.9899902, -1, -1, -1, 400, 400); //object(vegaslampost) (7)
	CreateDynamicObject(3460,665.2101440,1897.9603271,8.7596741,0.0000000,0.0000000,85.9899902, -1, -1, -1, 400, 400); //object(vegaslampost) (8)
	CreateDynamicObject(1568,692.3884888,1899.0465088,4.7434492,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (1)
	CreateDynamicObject(1568,680.3443604,1899.2781982,4.7434492,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (2)
	CreateDynamicObject(1568,687.0772095,1904.7763672,4.7434492,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (3)
	CreateDynamicObject(1568,671.1730957,1899.7365723,4.5720978,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (4)
	CreateDynamicObject(1568,687.3876953,1879.5996094,4.7434492,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (5)
	CreateDynamicObject(1568,694.0537109,1879.0535889,4.7434492,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (6)
	CreateDynamicObject(1568,680.2164307,1880.9421387,4.7434492,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (7)
	CreateDynamicObject(1568,718.8300781,1897.0761719,4.6875000,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (8)
	CreateDynamicObject(1568,719.0429688,1885.6533203,4.6875000,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (9)
	CreateDynamicObject(1297,661.6904907,1848.7115479,7.8670998,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(lamppost1) (1)
	CreateDynamicObject(1297,658.7075195,1828.8354492,7.8670998,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(lamppost1) (2)
	CreateDynamicObject(1297,665.9130859,1811.1503906,7.8670998,0.0000000,0.0000000,261.9909668, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,683.7944336,1807.8950195,7.8670998,0.0000000,0.0000000,261.9964600, -1, -1, -1, 400, 400); //object(lamppost1) (4)
	CreateDynamicObject(1297,706.9755859,1811.3867188,7.8670998,0.0000000,0.0000000,327.9913330, -1, -1, -1, 400, 400); //object(lamppost1) (5)
	CreateDynamicObject(1297,711.9339600,1828.2678223,7.8670998,0.0000000,0.0000000,349.9913330, -1, -1, -1, 400, 400); //object(lamppost1) (6)
	CreateDynamicObject(1297,714.7984619,1847.3347168,7.8670998,0.0000000,0.0000000,349.9859619, -1, -1, -1, 400, 400); //object(lamppost1) (7)
	CreateDynamicObject(1295,732.6191406,1844.6748047,9.8636742,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(doublestreetlght1) (1)
	CreateDynamicObject(6053,660.1347656,1713.0808105,11.0855055,0.0000000,0.0000000,42.0000000, -1, -1, -1, 400, 400); //object(stepshop_law) (1)
	CreateDynamicObject(8567,56.6638870,1124.4395752,23.3316803,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsebuild04_lvs) (1)
	CreateDynamicObject(8567,56.6630859,1124.4394531,19.0816803,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(vgsebuild04_lvs) (2)
	CreateDynamicObject(8838,-19.1253376,1288.8656006,15.7920742,0.0000000,0.0000000,181.9890137, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-19.0088806,1283.8676758,15.7920742,0.0000000,0.0000000,181.9885254, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(983,-2.5846033,1288.4179688,18.0062256,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (47)
	CreateDynamicObject(984,-21.5395184,1281.3508301,17.9593506,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(fenceshit2) (15)
	CreateDynamicObject(984,-29.1155739,1281.0146484,17.9593506,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(fenceshit2) (15)
	CreateDynamicObject(983,-35.6515732,1283.9802246,18.0062256,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (47)
	CreateDynamicObject(983,-35.7481613,1287.1627197,18.0062256,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (47)
	CreateDynamicObject(1251,-25.6499176,1291.2137451,17.1583920,0.0000000,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(1251,-18.8239212,1291.4268799,17.1264076,0.0000000,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(1251,-11.9814072,1291.6542969,17.1239033,0.0000000,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(1251,-5.8291550,1291.8747559,17.1180038,0.0000000,0.0000000,91.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(8838,-19.8181477,1302.8376465,15.7920742,0.0000000,0.0000000,1.9885254, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-20.0038795,1307.8184814,15.7920742,0.0000000,0.0000000,1.9830322, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-20.0399818,1308.9366455,14.7920742,270.0000000,180.4035034,182.3865967, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-20.0390625,1308.9365234,9.7920742,270.0000000,180.1093750,182.0924072, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-4.6699495,1308.3452148,0.5420742,0.1286926,271.9958496,183.9807129, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-35.7283401,1307.3100586,0.5420742,0.1264038,271.9940186,1.9770508, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-35.5679893,1302.3050537,0.5420742,0.1263428,271.9885254,1.9720459, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-4.2060490,1303.1101074,0.5420742,0.1263428,271.9940186,183.9770508, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(1251,-26.2087936,1300.0314941,17.1554184,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(1251,-19.3952332,1300.3297119,17.1186810,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(1251,-12.5593262,1300.5589600,17.1170101,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(1251,-6.4730377,1300.7581787,17.1233387,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(smashbar) (1)
	CreateDynamicObject(8838,-19.0087891,1283.8671875,18.7920742,0.0000000,0.0000000,181.9885254, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-20.0029297,1307.8183594,18.7920742,0.0000000,0.0000000,1.9830322, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(983,-36.5824203,1306.5325928,18.0062256,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (47)
	CreateDynamicObject(983,-36.4243736,1303.2862549,18.0062256,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (47)
	CreateDynamicObject(984,-30.3204613,1309.9482422,17.9593506,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(fenceshit2) (15)
	CreateDynamicObject(984,-17.5580673,1310.3977051,17.9593506,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(fenceshit2) (15)
	CreateDynamicObject(984,-9.8719130,1310.6921387,17.9593506,0.0000000,0.0000000,271.9995117, -1, -1, -1, 400, 400); //object(fenceshit2) (15)
	CreateDynamicObject(983,-3.4733543,1307.7620850,18.0062256,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (47)
	CreateDynamicObject(983,-3.3799591,1304.5986328,18.0062256,0.0000000,0.0000000,1.9995117, -1, -1, -1, 400, 400); //object(fenceshit3) (47)
	CreateDynamicObject(8838,-18.9936943,1283.1171875,14.5420742,270.0000000,180.0000000,1.9884644, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-18.9931641,1283.1171875,9.7920742,270.0000000,180.0014954,1.9900208, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-34.1896706,1283.6903076,0.5420742,0.0000000,270.0000000,1.9885559, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-34.3311768,1288.1882324,0.5420742,0.0000000,270.0000000,1.9884644, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-3.8978016,1284.5878906,0.5420742,0.0000000,270.0000000,181.9869080, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(8838,-4.0819149,1288.1188965,0.5420742,0.0000000,270.0000000,181.9829865, -1, -1, -1, 400, 400); //object(vgehshade01_lvs) (2)
	CreateDynamicObject(1215,-19.8514862,1300.6259766,17.8869953,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (170)
	CreateDynamicObject(1215,-35.7569237,1290.5881348,17.8869953,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (170)
	CreateDynamicObject(1215,-2.6544819,1291.7501221,17.8869953,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (170)
	CreateDynamicObject(1215,-19.5008011,1291.1306152,17.8869953,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (170)
	CreateDynamicObject(1256,-4.1753531,1307.5531006,17.9821281,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (16)
	CreateDynamicObject(1256,-35.0807495,1283.1120605,17.9821281,0.0000000,0.0000000,182.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (23)
	CreateDynamicObject(1256,-35.9893341,1307.0745850,17.9821281,0.0000000,0.0000000,181.9995270, -1, -1, -1, 400, 400); //object(stonebench1) (24)
	CreateDynamicObject(1256,-30.3652267,1309.3874512,17.9821281,0.0000000,0.0000000,89.9995117, -1, -1, -1, 400, 400); //object(stonebench1) (25)
	CreateDynamicObject(1256,-23.1217308,1309.7128906,17.9821281,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (26)
	CreateDynamicObject(1256,-16.6275902,1310.0048828,17.9821281,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (27)
	CreateDynamicObject(1256,-9.3841991,1310.3305664,17.9821281,0.0000000,0.0000000,89.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (28)
	CreateDynamicObject(1256,-30.2393475,1281.7224121,17.9821281,0.0000000,0.0000000,269.9945679, -1, -1, -1, 400, 400); //object(stonebench1) (29)
	CreateDynamicObject(1256,-22.4892578,1281.7368164,17.9821281,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (30)
	CreateDynamicObject(1256,-15.2401161,1282.2504883,17.9821281,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (31)
	CreateDynamicObject(1256,-7.7392588,1282.2646484,17.9821281,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(stonebench1) (32)
	CreateDynamicObject(1290,-19.3004837,1305.0161133,23.1477051,0.0000000,0.0000000,181.9830322, -1, -1, -1, 400, 400); //object(lamppost2) (10)
	CreateDynamicObject(8615,-19.4452629,1301.8498535,19.4174957,0.0000000,0.0000000,181.9990387, -1, -1, -1, 400, 400); //object(vgssstairs04_lvs) (4)
	CreateDynamicObject(7301,-26.5202332,1281.8746338,13.5936289,0.0000000,0.0000000,135.9947815, -1, -1, -1, 400, 400); //object(vgsn_addboard03) (1)
	CreateDynamicObject(8293,-9.3006477,1283.8395996,12.8183165,0.0000000,0.0000000,233.9999695, -1, -1, -1, 400, 400); //object(vgsbboardsigns02) (1)
	CreateDynamicObject(8310,-13.5394764,1308.7904053,13.0761833,0.0000000,0.0000000,306.0000000, -1, -1, -1, 400, 400); //object(vgsbboardsigns06) (1)
	CreateDynamicObject(8329,-26.9863892,1308.3085938,13.2536945,0.0000000,0.0000000,308.0000000, -1, -1, -1, 400, 400); //object(vgsbboardsigns16) (2)
	CreateDynamicObject(1327,-207.9955292,1227.0682373,19.2101612,38.9599609,26.0942383,254.8834229, -1, -1, -1, 400, 400); //object(junk_tyre) (2)
	CreateDynamicObject(12954,-213.7248383,1231.9854736,19.3277512,0.0000000,0.0000000,237.9999847, -1, -1, -1, 400, 400); //object(sw_furnipile01) (1)
	CreateDynamicObject(12954,-218.9625549,1229.0382080,17.5777512,0.0000000,0.0000000,237.9968262, -1, -1, -1, 400, 400); //object(sw_furnipile01) (2)
	CreateDynamicObject(2674,-221.9877930,1228.8223877,18.7639275,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(proc_rubbish_2) (1)
	CreateDynamicObject(2676,-216.6059570,1229.0384521,18.8455105,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(proc_rubbish_8) (1)
	CreateDynamicObject(1362,-205.1928864,1228.8540039,19.3406715,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_firebin) (1)
	CreateDynamicObject(3461,-204.9272919,1228.7661133,18.7710724,0.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(tikitorch01_lvs) (2)
	CreateDynamicObject(17969,-207.7213745,1231.1170654,20.9981003,0.0000000,12.0000000,94.0000000, -1, -1, -1, 400, 400); //object(hub_graffitti) (1)
	CreateDynamicObject(4227,-221.7002411,1230.7825928,21.6385498,346.0000000,0.0000000,2.0000000, -1, -1, -1, 400, 400); //object(graffiti_lan01) (1)
	CreateDynamicObject(8947,674.1591797,1798.0122070,3.1032333,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(vgelkup) (2)
	CreateDynamicObject(8947,681.5328979,1796.7381592,3.1032333,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(vgelkup) (3)
	CreateDynamicObject(8947,651.4321899,1802.0446777,-0.1467667,16.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(vgelkup) (5)
	CreateDynamicObject(8947,667.9113770,1799.0500488,2.1032333,15.9960938,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(vgelkup) (7)
	CreateDynamicObject(8947,671.7011108,1784.0877686,3.1032333,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(vgelkup) (9)
	CreateDynamicObject(8947,679.0703125,1782.7470703,3.1032333,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(vgelkup) (11)
	CreateDynamicObject(8947,690.6173706,1795.0029297,3.1032333,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(vgelkup) (12)
	CreateDynamicObject(8947,690.6171875,1795.0029297,5.3532333,0.0000000,0.0000000,260.0000000, -1, -1, -1, 400, 400); //object(vgelkup) (13)
	CreateDynamicObject(8947,690.6171875,1795.0029297,11.3532333,0.0000000,0.0000000,260.0000000, -1, -1, -1, 400, 400); //object(vgelkup) (14)
	CreateDynamicObject(970,687.6903076,1773.8798828,6.7082586,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(fencesmallb) (36)
	CreateDynamicObject(970,683.5050049,1774.6114502,6.7082586,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (45)
	CreateDynamicObject(970,679.3345947,1775.3463135,6.7082586,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (46)
	CreateDynamicObject(970,675.1447754,1776.0684814,6.7082586,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (47)
	CreateDynamicObject(970,670.9301147,1776.8218994,6.7082586,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (48)
	CreateDynamicObject(970,666.7268066,1777.5606689,6.7082586,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (50)
	CreateDynamicObject(970,662.5593872,1778.2893066,6.7082586,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (51)
	CreateDynamicObject(970,660.4897461,1778.6483154,6.7082586,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (52)
	CreateDynamicObject(970,658.8092651,1781.0566406,6.7082586,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (53)
	CreateDynamicObject(970,659.5302734,1785.2520752,6.7082586,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (54)
	CreateDynamicObject(970,660.2706909,1789.4145508,6.7082586,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (55)
	CreateDynamicObject(970,660.4804688,1790.6463623,6.7082586,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (57)
	CreateDynamicObject(970,690.1054077,1775.5733643,6.7082586,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (58)
	CreateDynamicObject(970,690.8547363,1779.7231445,6.7082586,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (59)
	CreateDynamicObject(970,691.6055908,1783.8914795,6.7082586,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (60)
	CreateDynamicObject(970,692.3486938,1788.0599365,6.7082586,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(fencesmallb) (61)
	CreateDynamicObject(994,663.0020142,1804.5411377,6.1567774,1.9224854,16.0092468,169.4484863, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (15)
	CreateDynamicObject(994,669.5484619,1791.3111572,6.1567774,1.9940186,359.9945068,79.9969177, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (15)
	CreateDynamicObject(994,676.4257812,1790.3269043,8.1178751,1.9210205,16.0055847,169.4484863, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (15)
	CreateDynamicObject(994,678.8993530,1804.3604736,8.1178751,1.9171143,16.0015869,169.4476318, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (15)
	CreateDynamicObject(994,670.8175659,1805.9217529,6.1567774,1.9940186,359.9945068,169.9969482, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (15)
	CreateDynamicObject(994,670.3742676,1803.2071533,6.1567774,1.9940186,359.9945068,169.9969482, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (15)
	CreateDynamicObject(994,663.5484619,1807.2359619,6.1567774,1.9171143,16.0070801,169.4476318, -1, -1, -1, 400, 400); //object(lhouse_barrier2) (15)
	CreateDynamicObject(1886,703.2532959,1799.4184570,14.2247791,15.9899902,2.0805359,301.4266357, -1, -1, -1, 400, 400); //object(shop_sec_cam) (1)
	CreateDynamicObject(1886,678.4331055,1790.3143311,14.2247791,15.9851074,2.0764160,113.4264221, -1, -1, -1, 400, 400); //object(shop_sec_cam) (2)
	CreateDynamicObject(1884,696.3896484,1791.3991699,8.4067774,0.0000000,0.0000000,348.0000000, -1, -1, -1, 400, 400); //object(shop_dblshlf) (1)
	CreateDynamicObject(1883,693.1240234,1792.1284180,8.4067774,0.0000000,0.0000000,348.0000000, -1, -1, -1, 400, 400); //object(shop_shelf01) (1)
	CreateDynamicObject(1983,695.7507324,1787.6406250,8.4067774,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(shlf4_cab_mid) (2)
	CreateDynamicObject(1983,696.7337646,1787.4669189,8.4067774,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(shlf4_cab_mid) (3)
	CreateDynamicObject(1983,697.7202148,1787.3057861,8.4067774,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(shlf4_cab_mid) (4)
	CreateDynamicObject(1983,694.7646484,1787.8110352,8.4067774,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(shlf4_cab_mid) (5)
	CreateDynamicObject(1984,681.8144531,1792.8974609,8.1567774,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(shlf5_till) (1)
	CreateDynamicObject(1984,682.9335938,1799.0458984,8.1567774,0.0000000,0.0000000,349.9914551, -1, -1, -1, 400, 400); //object(shlf5_till) (3)
	CreateDynamicObject(1984,682.3515625,1795.8486328,8.1567774,0.0000000,0.0000000,349.9914551, -1, -1, -1, 400, 400); //object(shlf5_till) (4)
	CreateDynamicObject(2012,692.6290283,1788.2513428,8.4067774,0.0000000,0.0000000,170.0000000, -1, -1, -1, 400, 400); //object(shop_shelf13) (1)
	CreateDynamicObject(1847,701.3480835,1790.4720459,8.4067774,0.0000000,0.0000000,260.0000000, -1, -1, -1, 400, 400); //object(shop_shelf06) (1)
	CreateDynamicObject(1844,689.5304565,1788.7421875,8.4067774,0.0000000,0.0000000,170.0000000, -1, -1, -1, 400, 400); //object(shop_shelf03) (1)
	CreateDynamicObject(2579,685.5009766,1798.5341797,8.1542969,0.0000000,0.0000000,79.9969482, -1, -1, -1, 400, 400); //object(cj_sex_shelf_2) (1)
	CreateDynamicObject(2579,684.9189453,1795.3359375,8.1542969,0.0000000,0.0000000,79.9914551, -1, -1, -1, 400, 400); //object(cj_sex_shelf_2) (2)
	CreateDynamicObject(2579,684.3935547,1792.3837891,8.1542969,0.0000000,0.0000000,79.9914551, -1, -1, -1, 400, 400); //object(cj_sex_shelf_2) (3)
	CreateDynamicObject(2624,700.4251099,1797.9289551,10.0826206,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_shoe_corner01) (1)
	CreateDynamicObject(2652,698.8151855,1799.2686768,9.0360775,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_skate_cubes) (1)
	CreateDynamicObject(2543,698.8239136,1787.2303467,8.1567774,0.0000000,0.0000000,170.0000000, -1, -1, -1, 400, 400); //object(cj_ss_4_m) (1)
	CreateDynamicObject(2543,699.8035278,1787.0665283,8.1567774,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(cj_ss_4_m) (2)
	CreateDynamicObject(2542,687.3138428,1789.0147705,8.4067774,0.0000000,0.0000000,170.0000000, -1, -1, -1, 400, 400); //object(cj_ss_3_l) (1)
	CreateDynamicObject(2542,686.3270264,1789.1821289,8.4067774,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(cj_ss_3_l) (2)
	CreateDynamicObject(2541,690.7055054,1791.8666992,8.4067774,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_ss_3_m) (1)
	CreateDynamicObject(2541,689.7194824,1792.0351562,8.4067774,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(cj_ss_3_m) (2)
	CreateDynamicObject(2541,688.7331543,1792.2041016,8.4067774,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(cj_ss_3_m) (3)
	CreateDynamicObject(2541,688.8753052,1793.1937256,8.4067774,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(cj_ss_3_m) (4)
	CreateDynamicObject(2541,689.8652954,1793.0283203,8.4067774,0.0000000,0.0000000,169.9914551, -1, -1, -1, 400, 400); //object(cj_ss_3_m) (5)
	CreateDynamicObject(2541,690.8522949,1792.8671875,8.4067774,0.0000000,0.0000000,169.9914551, -1, -1, -1, 400, 400); //object(cj_ss_3_m) (6)
	CreateDynamicObject(2540,689.4206543,1796.1884766,8.4067774,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_ss_2_l) (1)
	CreateDynamicObject(2539,690.3587646,1796.0184326,8.4067774,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_ss_2_m) (1)
	CreateDynamicObject(2538,691.2602539,1795.8676758,8.4067774,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_ss_2_r) (1)
	CreateDynamicObject(2375,695.2161255,1801.1629639,8.4067774,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(shop_set_2_unit1) (1)
	CreateDynamicObject(2362,684.1250000,1795.2675781,9.1028919,0.0000000,0.0000000,257.9974365, -1, -1, -1, 400, 400); //object(cj_sweetie_tray_1) (1)
	CreateDynamicObject(1987,693.0887451,1795.5192871,8.4067774,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(shlf4_cablft) (1)
	CreateDynamicObject(1988,694.0672607,1795.3466797,8.4067774,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(shlf4_cab_rt) (1)
	CreateDynamicObject(1983,695.0317993,1795.1738281,8.4067774,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(shlf4_cab_mid) (6)
	CreateDynamicObject(1885,678.7963867,1790.6044922,8.4067774,0.0000000,0.0000000,348.0000000, -1, -1, -1, 400, 400); //object(shop_baskets) (1)
	CreateDynamicObject(1885,678.7958984,1790.6044922,8.6567774,0.0000000,0.0000000,347.9974365, -1, -1, -1, 400, 400); //object(shop_baskets) (2)
	CreateDynamicObject(1885,678.7958984,1790.6044922,8.9067774,0.0000000,0.0000000,347.9974365, -1, -1, -1, 400, 400); //object(shop_baskets) (3)
	CreateDynamicObject(14684,692.6167603,1803.4323730,10.6081324,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(int_tatooa12) (1)
	CreateDynamicObject(14687,684.7248535,1793.9465332,12.4067774,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(int_tat_lights02) (1)
	CreateDynamicObject(14687,691.1420898,1792.9147949,12.4067774,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(int_tat_lights02) (2)
	CreateDynamicObject(14687,697.8059082,1791.8428955,12.4067774,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(int_tat_lights02) (3)
	CreateDynamicObject(1775,686.0682983,1802.4567871,9.5038137,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_sprunk1) (5)
	CreateDynamicObject(1775,687.2972412,1802.2331543,9.5038137,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(cj_sprunk1) (8)
	CreateDynamicObject(1776,684.6917114,1802.6199951,9.5061693,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_candyvendor) (2)
	CreateDynamicObject(1776,683.4669800,1802.8731689,9.5061693,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(cj_candyvendor) (3)
	CreateDynamicObject(1209,688.7678223,1802.0437012,8.4067774,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(vendmach) (1)
	CreateDynamicObject(1209,689.9977417,1801.8201904,8.4067774,0.0000000,0.0000000,349.9969482, -1, -1, -1, 400, 400); //object(vendmach) (2)
	CreateDynamicObject(3463,676.1582031,1782.2500000,6.1567774,0.0000000,0.0000000,351.9964600, -1, -1, -1, 400, 400); //object(vegaslampost2) (4)
	CreateDynamicObject(1215,695.6696167,1795.1134033,8.9711008,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (274)
	CreateDynamicObject(1215,700.7459717,1786.7592773,8.9711008,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (274)
	CreateDynamicObject(1215,691.5058594,1792.3699951,8.9711008,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (274)
	CreateDynamicObject(1215,688.2807617,1792.7486572,8.9711008,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (274)
	CreateDynamicObject(1215,688.8348389,1796.2036133,8.9711008,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (274)
	CreateDynamicObject(1215,692.9631348,1801.4691162,8.9711008,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (274)
	CreateDynamicObject(1215,703.0844727,1799.3648682,8.9711008,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (274)
	CreateDynamicObject(2705,702.6135864,1796.7365723,9.8392820,0.0000000,0.0000000,258.0000000, -1, -1, -1, 400, 400); //object(cj_hoodie_04) (1)
	CreateDynamicObject(2705,702.5466309,1796.2407227,9.8392820,0.0000000,0.0000000,83.9974365, -1, -1, -1, 400, 400); //object(cj_hoodie_04) (2)
	CreateDynamicObject(2706,700.6963501,1799.7363281,9.8702164,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_hoodie_05) (1)
	CreateDynamicObject(2706,701.1862183,1799.6815186,9.8702164,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(cj_hoodie_05) (2)
	CreateDynamicObject(2704,703.0452271,1798.1401367,10.8351698,0.0000000,0.0000000,258.0000000, -1, -1, -1, 400, 400); //object(cj_hoodie_3) (1)
	CreateDynamicObject(2704,703.2116089,1799.0202637,10.8209648,0.0000000,0.0000000,79.9974670, -1, -1, -1, 400, 400); //object(cj_hoodie_3) (3)
	CreateDynamicObject(2689,702.3919067,1799.2348633,10.4174747,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_hoodie_2) (1)
	CreateDynamicObject(2689,702.3916016,1799.2343750,9.6674747,0.0000000,0.0000000,165.9969482, -1, -1, -1, 400, 400); //object(cj_hoodie_2) (2)
	CreateDynamicObject(2399,699.9810181,1800.1015625,10.0253668,0.0000000,0.0000000,350.0000000, -1, -1, -1, 400, 400); //object(cj_4_s_sweater_2) (1)
	CreateDynamicObject(2389,699.1691284,1800.0384521,9.9180508,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(cj_4_sweaters) (1)
	CreateDynamicObject(1275,701.0030518,1799.9213867,10.6797953,0.0000000,0.0000000,354.0000000, -1, -1, -1, 400, 400); //object(clothesp) (1)
	CreateDynamicObject(1274,682.1691284,1803.5087891,10.6630974,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(bigdollar) (1)
	CreateDynamicObject(2754,682.3143921,1803.1291504,9.3089218,0.0000000,0.0000000,80.0000000, -1, -1, -1, 400, 400); //object(otb_machine) (1)
	CreateDynamicObject(2754,681.0775146,1803.3162842,9.3089218,0.0000000,0.0000000,79.9969482, -1, -1, -1, 400, 400); //object(otb_machine) (2)
	CreateDynamicObject(1274,681.9222412,1803.5494385,10.6630974,0.0000000,0.0000000,354.0000000, -1, -1, -1, 400, 400); //object(bigdollar) (2)
	CreateDynamicObject(1274,681.6751709,1803.5894775,10.6630974,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bigdollar) (3)
	CreateDynamicObject(2332,682.5772705,1789.4073486,8.8696623,0.0000000,0.0000000,170.0000000, -1, -1, -1, 400, 400); //object(kev_safe) (2)
	CreateDynamicObject(2332,681.7723999,1789.6206055,9.8041620,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(kev_safe) (3)
	CreateDynamicObject(2003,681.7639160,1789.5476074,8.8696623,0.0000000,0.0000000,170.0000000, -1, -1, -1, 400, 400); //object(cr_safe_body) (1)
	CreateDynamicObject(2003,682.5977783,1789.4084473,9.8041620,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(cr_safe_body) (2)
	CreateDynamicObject(2332,680.9540405,1789.7459717,8.8696623,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(kev_safe) (4)
	CreateDynamicObject(2332,680.9446411,1789.7462158,9.8041620,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(kev_safe) (6)
	CreateDynamicObject(2003,682.6019897,1789.4665527,10.7386618,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(cr_safe_body) (4)
	CreateDynamicObject(2003,681.7764893,1789.6309814,10.7386618,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(cr_safe_body) (5)
	CreateDynamicObject(2003,680.9638672,1789.7893066,10.7386618,0.0000000,0.0000000,169.9969482, -1, -1, -1, 400, 400); //object(cr_safe_body) (7)
	CreateDynamicObject(2004,682.1749268,1789.8068848,8.9054203,0.0000000,0.0000000,34.0000000, -1, -1, -1, 400, 400); //object(cr_safe_door) (1)
	CreateDynamicObject(2004,683.0283203,1789.6643066,9.8229208,0.0000000,0.0000000,1.9971924, -1, -1, -1, 400, 400); //object(cr_safe_door) (2)
	CreateDynamicObject(2004,681.3969116,1790.0446777,10.7393532,0.0000000,0.0000000,97.9882812, -1, -1, -1, 400, 400); //object(cr_safe_door) (6)
	CreateDynamicObject(2004,682.2145386,1789.8854980,10.7157412,0.0000000,0.0000000,151.9870911, -1, -1, -1, 400, 400); //object(cr_safe_door) (7)
	CreateDynamicObject(2004,683.0027466,1789.7276611,10.7553024,0.0000000,0.0000000,75.9848633, -1, -1, -1, 400, 400); //object(cr_safe_door) (8)
	CreateDynamicObject(1649,679.1774902,1800.7550049,10.1212835,0.0000000,0.0000000,260.0000000, -1, -1, -1, 400, 400); //object(wglasssmash) (3)
	CreateDynamicObject(1649,677.8652344,1793.1192627,10.1212835,0.0000000,0.0000000,259.9969482, -1, -1, -1, 400, 400); //object(wglasssmash) (4)
	CreateDynamicObject(1649,678.5971069,1792.9422607,10.1212835,0.0000000,0.0000000,79.9969482, -1, -1, -1, 400, 400); //object(wglasssmash) (5)
	CreateDynamicObject(1649,679.9119263,1800.6065674,10.1212835,0.0000000,0.0000000,79.9969482, -1, -1, -1, 400, 400); //object(wglasssmash) (6)
	CreateDynamicObject(1663,684.8162231,1797.7153320,8.8669920,0.0000000,0.0000000,200.0000000, -1, -1, -1, 400, 400); //object(swivelchair_b) (3)
	CreateDynamicObject(1663,684.2615967,1794.5124512,8.8669920,0.0000000,0.0000000,151.9951172, -1, -1, -1, 400, 400); //object(swivelchair_b) (4)
	CreateDynamicObject(1663,683.7495117,1791.5556641,8.8669920,0.0000000,0.0000000,221.9903717, -1, -1, -1, 400, 400); //object(swivelchair_b) (5)
	CreateDynamicObject(3463,676.1582031,1782.2500000,6.1567774,0.0000000,0.0000000,81.9964600, -1, -1, -1, 400, 400); //object(vegaslampost2) (4)
	CreateDynamicObject(1297,652.8148193,1785.2055664,7.3670998,0.0000000,0.0000000,341.9909668, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,650.5353394,1769.7432861,7.3670998,0.0000000,0.0000000,341.9879150, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,645.7158203,1756.8148193,6.8670998,0.0000000,0.0000000,343.9879150, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,635.3384399,1760.4487305,6.8670998,0.0000000,0.0000000,153.9874268, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,638.4216919,1770.3837891,7.1170998,0.0000000,0.0000000,177.9843750, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,640.8130493,1786.4658203,7.1170998,0.0000000,0.0000000,177.9840088, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,642.9222412,1801.1042480,7.1170998,0.0000000,0.0000000,169.9840088, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,645.1164551,1814.2235107,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,647.1638184,1828.2945557,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,648.6363525,1841.7148438,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,650.5242310,1854.3356934,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,651.8602905,1866.5131836,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,653.1962280,1878.6909180,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,654.3411865,1889.1289062,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,654.8614502,1899.6165771,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,655.7187500,1910.5708008,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(1297,656.4995728,1921.5430908,7.1170998,0.0000000,0.0000000,169.9804688, -1, -1, -1, 400, 400); //object(lamppost1) (3)
	CreateDynamicObject(8947,539.2530518,2355.9899902,27.5334206,0.0000000,0.0000000,327.9969482, -1, -1, -1, 400, 400); //object(vgelkup) (11)
	CreateDynamicObject(8947,527.0884399,2363.6093750,27.5334206,0.0000000,0.0000000,327.9968262, -1, -1, -1, 400, 400); //object(vgelkup) (11)
	CreateDynamicObject(8947,514.6883545,2371.3356934,27.5334206,0.0000000,0.0000000,327.9968262, -1, -1, -1, 400, 400); //object(vgelkup) (11)
	CreateDynamicObject(8947,502.2890930,2379.0739746,27.5334206,0.0000000,0.0000000,327.9969482, -1, -1, -1, 400, 400); //object(vgelkup) (11)
	CreateDynamicObject(8947,490.5382996,2386.5356445,25.7834206,0.0000000,345.9998779,327.9968262, -1, -1, -1, 400, 400); //object(vgelkup) (11)
	CreateDynamicObject(8947,539.2529297,2355.9892578,30.0334206,0.0000000,0.0000000,327.9968262, -1, -1, -1, 400, 400); //object(vgelkup) (11)
	CreateDynamicObject(8947,527.8665771,2363.1335449,27.7834206,0.0000000,342.0000000,327.9968262, -1, -1, -1, 400, 400); //object(vgelkup) (11)
	CreateDynamicObject(982,500.6231995,2365.8039551,31.2705193,0.0000000,0.0000000,58.0000000, -1, -1, -1, 400, 400); //object(fenceshit) (35)
	CreateDynamicObject(982,513.4764404,2386.3051758,31.2705193,0.0000000,0.0000000,57.9968262, -1, -1, -1, 400, 400); //object(fenceshit) (38)
	CreateDynamicObject(984,529.7664795,2376.1362305,31.2236443,0.0000000,0.0000000,58.0000000, -1, -1, -1, 400, 400); //object(fenceshit2) (32)
	CreateDynamicObject(984,516.8887329,2355.6242676,31.2236443,0.0000000,0.0000000,57.9968262, -1, -1, -1, 400, 400); //object(fenceshit2) (33)
	CreateDynamicObject(984,533.4031982,2345.3037109,33.7236443,0.0000000,0.0000000,57.9968262, -1, -1, -1, 400, 400); //object(fenceshit2) (34)
	CreateDynamicObject(984,546.1655273,2365.8740234,33.7236443,0.0000000,0.0000000,57.9968262, -1, -1, -1, 400, 400); //object(fenceshit2) (35)
	CreateDynamicObject(984,548.2486572,2357.0793457,33.7236443,0.0000000,0.0000000,327.9968262, -1, -1, -1, 400, 400); //object(fenceshit2) (36)
	CreateDynamicObject(984,542.2026367,2347.3730469,33.7236443,0.0000000,0.0000000,327.9968262, -1, -1, -1, 400, 400); //object(fenceshit2) (37)
	CreateDynamicObject(984,527.2919312,2349.1250000,27.9736443,90.0000000,180.0439453,235.9531250, -1, -1, -1, 400, 400); //object(fenceshit2) (38)
	CreateDynamicObject(983,523.9066772,2351.2724609,32.6289597,342.0000000,0.0000000,58.0000000, -1, -1, -1, 400, 400); //object(fenceshit3) (80)
	CreateDynamicObject(983,520.3653564,2353.5100098,31.2705193,341.9989014,0.0000000,57.9968262, -1, -1, -1, 400, 400); //object(fenceshit3) (81)
	CreateDynamicObject(984,540.1814575,2369.6542969,27.9736443,90.0000000,180.0384521,235.9478760, -1, -1, -1, 400, 400); //object(fenceshit2) (45)
	CreateDynamicObject(983,536.8610229,2371.7185059,32.6289597,341.9989014,0.0000000,57.9968262, -1, -1, -1, 400, 400); //object(fenceshit3) (82)
	CreateDynamicObject(983,533.1542358,2374.0551758,31.2705193,341.9989014,0.0000000,57.9968262, -1, -1, -1, 400, 400); //object(fenceshit3) (83)
	CreateDynamicObject(8168,542.6638794,2360.5451660,35.0349350,0.0000000,0.0000000,344.0000000, -1, -1, -1, 400, 400); //object(vgs_guardhouse01) (2)
	CreateDynamicObject(8168,542.6630859,2360.5449219,31.5349350,0.0000000,0.0000000,343.9984131, -1, -1, -1, 400, 400); //object(vgs_guardhouse01) (4)
	CreateDynamicObject(1256,536.5037231,2348.2736816,33.7464218,0.0000000,0.0000000,328.0000000, -1, -1, -1, 400, 400); //object(stonebench1) (6)
	CreateDynamicObject(1256,537.1644287,2347.8637695,33.7464218,0.0000000,0.0000000,147.9968262, -1, -1, -1, 400, 400); //object(stonebench1) (33)
	CreateDynamicObject(1256,532.4683838,2350.7260742,33.7464218,0.0000000,0.0000000,147.9968262, -1, -1, -1, 400, 400); //object(stonebench1) (34)
	CreateDynamicObject(1256,531.7783203,2351.1496582,33.7464218,0.0000000,0.0000000,327.9968262, -1, -1, -1, 400, 400); //object(stonebench1) (35)
	CreateDynamicObject(1256,535.3444824,2356.8776855,33.7464218,0.0000000,0.0000000,327.9968262, -1, -1, -1, 400, 400); //object(stonebench1) (36)
	CreateDynamicObject(1256,536.0266724,2356.4848633,33.7464218,0.0000000,0.0000000,147.9968262, -1, -1, -1, 400, 400); //object(stonebench1) (37)
	CreateDynamicObject(1256,539.8684082,2354.1052246,33.7464218,0.0000000,0.0000000,327.9968262, -1, -1, -1, 400, 400); //object(stonebench1) (39)
	CreateDynamicObject(1256,540.5357056,2353.6958008,33.7464218,0.0000000,0.0000000,147.9968262, -1, -1, -1, 400, 400); //object(stonebench1) (40)
	CreateDynamicObject(1360,536.3393555,2352.4851074,32.8589859,0.0000000,0.0000000,328.0000000, -1, -1, -1, 400, 400); //object(cj_bush_prop3) (11)
	CreateDynamicObject(1215,536.2368774,2352.4787598,33.2417068,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (287)
	CreateDynamicObject(1215,493.6882324,2398.6337891,28.7426510,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (288)
	CreateDynamicObject(1215,492.8190002,2399.2468262,28.6932907,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (289)
	CreateDynamicObject(1215,492.4046936,2399.9262695,28.6221695,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (290)
	CreateDynamicObject(1215,492.2340088,2400.6855469,28.5783081,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (291)
	CreateDynamicObject(1215,492.1976318,2401.5886230,28.5454426,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (292)
	CreateDynamicObject(1215,492.1979065,2402.5783691,28.5140724,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (293)
	CreateDynamicObject(1215,492.3493958,2403.4533691,28.5089455,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (294)
	CreateDynamicObject(1215,482.9083557,2376.7263184,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (295)
	CreateDynamicObject(1215,483.4510803,2376.3669434,28.9774170,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (296)
	CreateDynamicObject(1215,484.1387634,2376.0688477,28.9774170,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (297)
	CreateDynamicObject(1215,476.6904907,2381.5175781,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (298)
	CreateDynamicObject(1215,477.5244141,2383.0556641,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (299)
	CreateDynamicObject(1215,478.2562866,2384.6440430,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (300)
	CreateDynamicObject(1215,479.0567322,2386.2004395,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (301)
	CreateDynamicObject(1215,479.7431030,2387.5346680,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (302)
	CreateDynamicObject(1215,480.5430603,2389.0910645,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (303)
	CreateDynamicObject(1215,481.4582520,2390.8701172,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (304)
	CreateDynamicObject(1215,482.1988525,2392.4560547,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (305)
	CreateDynamicObject(1215,482.9390869,2394.0419922,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (306)
	CreateDynamicObject(1215,483.7851562,2395.8544922,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (307)
	CreateDynamicObject(1215,484.6318359,2397.6669922,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (308)
	CreateDynamicObject(1215,485.3726807,2399.2529297,28.9488964,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (309)
	CreateDynamicObject(1215,486.4229736,2400.7390137,28.5089455,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (310)
	CreateDynamicObject(1215,486.9788513,2402.5429688,28.5018234,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (311)
	CreateDynamicObject(1215,487.4764404,2404.6005859,28.5018234,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (312)
	CreateDynamicObject(1215,487.9035645,2406.5537109,28.5018234,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (313)
	CreateDynamicObject(1223,518.2703857,2336.4699707,29.3115349,0.0000000,0.0000000,50.0000000, -1, -1, -1, 400, 400); //object(lampost_coast) (2)
	CreateDynamicObject(1257,516.3671265,2338.2895508,30.7693253,0.0000000,0.0000000,233.9999390, -1, -1, -1, 400, 400); //object(bustopm) (3)
	CreateDynamicObject(1223,513.7680054,2339.1477051,29.3115349,0.0000000,0.0000000,53.9987793, -1, -1, -1, 400, 400); //object(lampost_coast) (4)
	CreateDynamicObject(3458,211.5975494,2273.9189453,21.3844032,5.9853516,2.0109558,177.7897339, -1, -1, -1, 400, 400); //object(vgncarshade1) (24)
	CreateDynamicObject(3458,211.5966797,2273.9189453,24.6344032,359.9857178,359.9995728,353.9959717, -1, -1, -1, 400, 400); //object(vgncarshade1) (24)
	CreateDynamicObject(3458,211.2973633,2269.9350586,21.6344032,359.9835205,359.9945068,353.9959717, -1, -1, -1, 400, 400); //object(vgncarshade1) (24)
	CreateDynamicObject(3458,211.6127319,2273.6699219,20.6344032,335.9834900,359.9939880,353.9935303, -1, -1, -1, 400, 400); //object(vgncarshade1) (24)
	CreateDynamicObject(1215,231.4265594,2276.2951660,23.7869186,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (315)
	CreateDynamicObject(1215,211.5357971,2276.9794922,23.0143318,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (316)
	CreateDynamicObject(1215,191.6217957,2277.3862305,22.3286400,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (317)
	CreateDynamicObject(1215,191.6656799,2270.4248047,23.7257652,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (318)
	CreateDynamicObject(1215,193.6545410,2270.6298828,23.7257652,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (319)
	CreateDynamicObject(1215,195.6319580,2270.9287109,23.7257652,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (320)
	CreateDynamicObject(1215,197.6264648,2271.0751953,23.7257652,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (321)
	CreateDynamicObject(1215,199.6206055,2271.2216797,23.7257652,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (322)
	CreateDynamicObject(1215,201.6147461,2271.3681641,23.7257652,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (323)
	CreateDynamicObject(1215,203.3595581,2271.4963379,23.7257652,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (324)
	CreateDynamicObject(1215,205.1477966,2271.5561523,23.7263126,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (325)
	CreateDynamicObject(1215,206.8027039,2271.5063477,23.7264366,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (326)
	CreateDynamicObject(1215,208.5883484,2271.4274902,23.7265759,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (327)
	CreateDynamicObject(1215,210.1534576,2271.3095703,23.7267132,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (328)
	CreateDynamicObject(1215,212.1519775,2271.2373047,23.7267132,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (329)
	CreateDynamicObject(1215,213.9001923,2271.1740723,23.7267132,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (330)
	CreateDynamicObject(1229,191.7074738,2277.3833008,23.3269043,0.0000000,0.0000000,264.0000000, -1, -1, -1, 400, 400); //object(bussign1) (2)
	CreateDynamicObject(1229,516.4321289,2342.2683105,30.9475021,0.0000000,0.0000000,233.9959717, -1, -1, -1, 400, 400); //object(bussign1) (3)
	CreateDynamicObject(1257,564.7640381,2301.9753418,34.4382935,0.0000000,0.0000000,9.9978333, -1, -1, -1, 400, 400); //object(bustopm) (5)
	CreateDynamicObject(1223,564.3572998,2298.9624023,32.0957031,0.0000000,0.0000000,187.9987793, -1, -1, -1, 400, 400); //object(lampost_coast) (5)
	CreateDynamicObject(1223,563.3485107,2304.6220703,31.8457031,0.0000000,0.0000000,187.9980469, -1, -1, -1, 400, 400); //object(lampost_coast) (6)
	CreateDynamicObject(1229,563.9719238,2298.9599609,34.6040878,0.0000000,0.0000000,7.9923401, -1, -1, -1, 400, 400); //object(bussign1) (4)
	CreateDynamicObject(3095,671.4118652,1906.2691650,4.1880836,0.0000000,0.0000000,356.0000000, -1, -1, -1, 400, 400); //object(a51_jetdoor) (1)
	CreateDynamicObject(3095,670.8125000,1897.5286865,4.1880836,0.0000000,0.0000000,355.9954834, -1, -1, -1, 400, 400); //object(a51_jetdoor) (2)
	CreateDynamicObject(3095,670.2103271,1888.7983398,4.1880836,0.0000000,0.0000000,355.9954834, -1, -1, -1, 400, 400); //object(a51_jetdoor) (3)
	CreateDynamicObject(3095,669.5919800,1880.0679932,4.1880836,0.0000000,0.0000000,355.9954834, -1, -1, -1, 400, 400); //object(a51_jetdoor) (4)
	CreateDynamicObject(3095,668.9273071,1872.3596191,4.1880836,0.0000000,0.0000000,353.9954834, -1, -1, -1, 400, 400); //object(a51_jetdoor) (5)
	CreateDynamicObject(3095,677.6118774,1871.4428711,4.1880836,0.0000000,0.0000000,353.9904785, -1, -1, -1, 400, 400); //object(a51_jetdoor) (6)
	CreateDynamicObject(3095,686.0461426,1870.4149170,4.1880836,0.0000000,0.0000000,351.9904785, -1, -1, -1, 400, 400); //object(a51_jetdoor) (7)
	CreateDynamicObject(3095,694.4541016,1869.2034912,4.1880836,0.0000000,0.0000000,351.9854736, -1, -1, -1, 400, 400); //object(a51_jetdoor) (8)
	CreateDynamicObject(3095,702.3992310,1867.8952637,4.1880836,0.0000000,0.0000000,349.9854736, -1, -1, -1, 400, 400); //object(a51_jetdoor) (9)
	CreateDynamicObject(3095,703.7009888,1868.9576416,4.1880836,0.0000000,0.0000000,359.9854736, -1, -1, -1, 400, 400); //object(a51_jetdoor) (10)
	CreateDynamicObject(3095,703.6766968,1877.7070312,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (11)
	CreateDynamicObject(3095,703.6522827,1886.4570312,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (12)
	CreateDynamicObject(3095,703.6278687,1895.2070312,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (13)
	CreateDynamicObject(3095,703.6027832,1904.2070312,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (14)
	CreateDynamicObject(3095,703.5978394,1905.9570312,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (15)
	CreateDynamicObject(3095,695.3513184,1905.9754639,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (16)
	CreateDynamicObject(3095,686.3505859,1905.9877930,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (17)
	CreateDynamicObject(3095,678.8505859,1905.9982910,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (18)
	CreateDynamicObject(3280,707.1431885,1863.4046631,4.5359287,0.0000000,0.0000000,356.0000000, -1, -1, -1, 400, 400); //object(a51_panel) (1)
	CreateDynamicObject(3280,707.1425781,1863.4042969,4.5359287,2.0000000,0.0000000,354.0000000, -1, -1, -1, 400, 400); //object(a51_panel) (2)
	CreateDynamicObject(3095,694.9279175,1877.4891357,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (21)
	CreateDynamicObject(3095,686.1840210,1877.4639893,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (22)
	CreateDynamicObject(3095,677.9378052,1877.4488525,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (23)
	CreateDynamicObject(3095,694.9013672,1886.4613037,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (24)
	CreateDynamicObject(3095,685.9015503,1886.4558105,4.1880836,0.0000000,0.0000000,359.9854736, -1, -1, -1, 400, 400); //object(a51_jetdoor) (25)
	CreateDynamicObject(3095,677.7087402,1886.4676514,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (26)
	CreateDynamicObject(3095,677.7475586,1895.4667969,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (27)
	CreateDynamicObject(3095,685.9729004,1895.4481201,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (28)
	CreateDynamicObject(3095,694.9688110,1895.4232178,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (29)
	CreateDynamicObject(3095,694.7147827,1900.8920898,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (30)
	CreateDynamicObject(3095,685.7138672,1900.9091797,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (31)
	CreateDynamicObject(3095,676.7138672,1900.8696289,4.1880836,0.0000000,0.0000000,359.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (32)
	CreateDynamicObject(3935,687.9201050,1888.4588623,7.2950459,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(statue) (2)
	CreateDynamicObject(1215,687.9689941,1889.6186523,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (314)
	CreateDynamicObject(1215,687.4078979,1889.5760498,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (331)
	CreateDynamicObject(1215,688.4686279,1889.6064453,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (332)
	CreateDynamicObject(1215,688.9672852,1889.5839844,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (333)
	CreateDynamicObject(1215,688.9284058,1889.0847168,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (334)
	CreateDynamicObject(1215,688.9403076,1888.5841064,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (335)
	CreateDynamicObject(1215,688.9615479,1888.0844727,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (336)
	CreateDynamicObject(1215,688.9830933,1887.5844727,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (337)
	CreateDynamicObject(1215,688.4831543,1887.6108398,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (338)
	CreateDynamicObject(1215,687.9827881,1887.5925293,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (339)
	CreateDynamicObject(1215,687.4825439,1887.5805664,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (340)
	CreateDynamicObject(1215,686.9825439,1887.5688477,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (341)
	CreateDynamicObject(1215,686.9824219,1887.5683594,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (342)
	CreateDynamicObject(1215,686.9754639,1888.0683594,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (343)
	CreateDynamicObject(1215,686.9803467,1888.5683594,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (344)
	CreateDynamicObject(1215,686.9756470,1889.0687256,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (345)
	CreateDynamicObject(1215,686.9813232,1889.5683594,5.3077726,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (346)
	CreateDynamicObject(1315,710.1491089,1862.5725098,8.0125294,0.0000000,0.0000000,168.0000000, -1, -1, -1, 400, 400); //object(trafficlight1) (5)
	CreateDynamicObject(1315,706.8426514,1859.9798584,8.0125294,0.0000000,0.0000000,81.9974365, -1, -1, -1, 400, 400); //object(trafficlight1) (6)
	CreateDynamicObject(1287,680.3953857,1885.4371338,5.3225198,0.0000000,0.0000000,266.0000000, -1, -1, -1, 400, 400); //object(newstandnew3) (1)
	CreateDynamicObject(1289,680.4566040,1886.1197510,5.3225198,0.0000000,0.0000000,266.0000000, -1, -1, -1, 400, 400); //object(newstandnew1) (1)
	CreateDynamicObject(1286,680.5120850,1886.7856445,5.3225198,0.0000000,0.0000000,266.0000000, -1, -1, -1, 400, 400); //object(newstandnew4) (2)
	CreateDynamicObject(1285,680.5845337,1887.4642334,5.3225198,0.0000000,0.0000000,266.0000000, -1, -1, -1, 400, 400); //object(newstandnew5) (1)
	CreateDynamicObject(1280,687.5682983,1894.2302246,5.1448045,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(parkbench1) (8)
	CreateDynamicObject(1280,688.3171387,1894.2475586,5.1448045,0.0000000,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(parkbench1) (9)
	CreateDynamicObject(1280,687.7358398,1899.7397461,5.1448045,0.0000000,0.0000000,269.9945068, -1, -1, -1, 400, 400); //object(parkbench1) (10)
	CreateDynamicObject(1280,687.7402344,1898.9892578,5.1448045,0.0000000,0.0000000,89.9890442, -1, -1, -1, 400, 400); //object(parkbench1) (11)
	CreateDynamicObject(1594,691.4169922,1876.6870117,5.2204409,0.0000000,0.0000000,44.0000000, -1, -1, -1, 400, 400); //object(chairsntable) (8)
	CreateDynamicObject(1594,691.0140991,1872.8526611,5.2204409,0.0000000,0.0000000,353.9947510, -1, -1, -1, 400, 400); //object(chairsntable) (9)
	CreateDynamicObject(970,691.8046265,1878.6004639,5.2949305,0.0000000,0.0000000,352.0000000, -1, -1, -1, 400, 400); //object(fencesmallb) (49)
	CreateDynamicObject(2395,686.5788574,1887.2435303,4.9934492,270.0000000,180.0300293,180.0300293, -1, -1, -1, 400, 400); //object(cj_sports_wall) (1)
	CreateDynamicObject(2395,686.5783691,1887.1469727,2.2434492,358.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(cj_sports_wall) (2)
	CreateDynamicObject(2395,689.2998657,1890.1677246,2.2434492,357.9949951,0.0000000,180.0000000, -1, -1, -1, 400, 400); //object(cj_sports_wall) (3)
	CreateDynamicObject(2395,686.0869751,1887.2730713,1.7434492,1.9955750,270.1327515,267.9975586, -1, -1, -1, 400, 400); //object(cj_sports_wall) (5)
	CreateDynamicObject(2395,689.7516479,1890.0412598,1.7434492,1.9940796,270.0604248,89.9940796, -1, -1, -1, 400, 400); //object(cj_sports_wall) (6)
	CreateDynamicObject(1280,683.9291382,1905.6009521,5.1448045,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(parkbench1) (12)
	CreateDynamicObject(1280,684.6647949,1905.5899658,5.1448045,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(parkbench1) (13)
	CreateDynamicObject(1280,690.4126587,1905.4803467,5.1448045,0.0000000,0.0000000,179.9945068, -1, -1, -1, 400, 400); //object(parkbench1) (14)
	CreateDynamicObject(1280,689.7194824,1905.4776611,5.1448045,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(parkbench1) (15)
	CreateDynamicObject(1215,734.2220459,1857.8336182,5.0433216,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (350)
	CreateDynamicObject(1215,733.4037476,1857.9989014,5.0401831,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (351)
	CreateDynamicObject(1215,732.5094604,1858.1839600,5.0365877,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (352)
	CreateDynamicObject(1215,731.6002197,1858.3616943,5.0333204,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (353)
	CreateDynamicObject(1215,730.5620117,1858.5119629,5.0527878,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (354)
	CreateDynamicObject(1215,729.5564575,1858.6772461,5.1001406,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(bollardlight) (355)
	CreateDynamicObject(1568,718.8300781,1897.0761719,4.6875000,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (8)
	CreateDynamicObject(1568,719.0429688,1885.6533203,4.6875000,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(chinalamp_sf) (9)
	CreateDynamicObject(1295,750.4581299,1839.3892822,9.8636742,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(doublestreetlght1) (1)
	CreateDynamicObject(1295,757.1097412,1836.5035400,9.8636742,0.0000000,0.0000000,0.0000000, -1, -1, -1, 400, 400); //object(doublestreetlght1) (1)
	CreateDynamicObject(1295,763.3770752,1850.9532471,9.8636742,0.0000000,0.0000000,246.0000000, -1, -1, -1, 400, 400); //object(doublestreetlght1) (1)
	CreateDynamicObject(1295,756.5953369,1854.1671143,9.8636742,0.0000000,0.0000000,245.9948730, -1, -1, -1, 400, 400); //object(doublestreetlght1) (1)
	CreateDynamicObject(1295,749.3156738,1856.2341309,9.8636742,0.0000000,0.0000000,245.9948730, -1, -1, -1, 400, 400); //object(doublestreetlght1) (1)
	CreateDynamicObject(3095,782.2031860,2006.4350586,4.1348100,0.0000000,0.0000000,353.9835205, -1, -1, -1, 400, 400); //object(a51_jetdoor) (33)
	CreateDynamicObject(3095,780.7484131,1998.9105225,4.1348100,0.0000000,0.0000000,343.9794922, -1, -1, -1, 400, 400); //object(a51_jetdoor) (34)
	CreateDynamicObject(3095,778.1984863,1990.2796631,4.1348100,0.0000000,0.0000000,343.9764404, -1, -1, -1, 400, 400); //object(a51_jetdoor) (37)
	CreateDynamicObject(3095,775.7431030,1981.8826904,4.1348100,0.0000000,0.0000000,343.9764404, -1, -1, -1, 400, 400); //object(a51_jetdoor) (38)
	CreateDynamicObject(3095,773.1933594,1974.2402344,4.1348100,0.0000000,0.0000000,337.9764404, -1, -1, -1, 400, 400); //object(a51_jetdoor) (39)
	CreateDynamicObject(3095,769.7897949,1965.9082031,4.1348100,0.0000000,0.0000000,337.9724121, -1, -1, -1, 400, 400); //object(a51_jetdoor) (41)
	CreateDynamicObject(3095,767.6463623,1958.1868896,4.1348100,0.0000000,0.0000000,349.9724121, -1, -1, -1, 400, 400); //object(a51_jetdoor) (42)
	CreateDynamicObject(3095,765.9971313,1949.3386230,4.1348100,0.0000000,0.0000000,349.9694824, -1, -1, -1, 400, 400); //object(a51_jetdoor) (43)
	CreateDynamicObject(3095,764.4919434,1940.7219238,4.1348100,0.0000000,0.0000000,349.9694824, -1, -1, -1, 400, 400); //object(a51_jetdoor) (44)
	CreateDynamicObject(3095,763.3643799,1932.2963867,4.1348100,0.0000000,0.0000000,353.9694824, -1, -1, -1, 400, 400); //object(a51_jetdoor) (45)
	CreateDynamicObject(3095,762.9511719,1924.8256836,4.1348100,0.0000000,0.0000000,359.9685059, -1, -1, -1, 400, 400); //object(a51_jetdoor) (46)
	CreateDynamicObject(1446,747.3704834,1929.9250488,5.4415212,0.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(dyn_f_r_wood_4) (1)
	CreateDynamicObject(1446,752.0035400,1929.7514648,5.4415212,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(dyn_f_r_wood_4) (2)
	CreateDynamicObject(1446,756.1195679,1929.5985107,5.4415212,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(dyn_f_r_wood_4) (3)
	CreateDynamicObject(1446,747.3701172,1929.9248047,3.9415212,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(dyn_f_r_wood_4) (5)
	CreateDynamicObject(1446,747.3060913,1953.8572998,5.4415212,0.0000000,0.0000000,169.9949951, -1, -1, -1, 400, 400); //object(dyn_f_r_wood_4) (6)
	CreateDynamicObject(1446,747.3056641,1953.8564453,3.9415212,0.0000000,0.0000000,169.9914551, -1, -1, -1, 400, 400); //object(dyn_f_r_wood_4) (7)
	CreateDynamicObject(1446,751.9126587,1953.0328369,5.4415212,0.0000000,0.0000000,169.9914551, -1, -1, -1, 400, 400); //object(dyn_f_r_wood_4) (8)
	CreateDynamicObject(1446,756.5129395,1952.2202148,5.4415212,0.0000000,0.0000000,169.9914551, -1, -1, -1, 400, 400); //object(dyn_f_r_wood_4) (9)
	CreateDynamicObject(1446,759.4923096,1951.6881104,5.4415212,0.0000000,0.0000000,169.9914551, -1, -1, -1, 400, 400); //object(dyn_f_r_wood_4) (10)
	CreateDynamicObject(1418,774.3745117,1928.9727783,5.4106932,0.0000000,0.0000000,358.0000000, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (1)
	CreateDynamicObject(1418,777.8455811,1928.8771973,5.4114537,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (2)
	CreateDynamicObject(1418,781.2944946,1928.8103027,5.4125156,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (3)
	CreateDynamicObject(1418,784.7528076,1928.7360840,5.4106932,0.0000000,0.0000000,357.9949951, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (4)
	CreateDynamicObject(1418,788.2340698,1928.7226562,5.4120154,0.0000000,0.0000000,359.9949951, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (5)
	CreateDynamicObject(1418,789.9830322,1928.7225342,5.4120154,0.0000000,0.0000000,359.9945068, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (7)
	CreateDynamicObject(1418,791.7955933,1930.4580078,5.4106932,0.0000000,0.0000000,87.9945068, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (8)
	CreateDynamicObject(1418,791.9006348,1933.9045410,5.4106932,0.0000000,0.0000000,87.9895020, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (9)
	CreateDynamicObject(1418,791.9956055,1937.3403320,5.4106932,0.0000000,0.0000000,87.9895020, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (10)
	CreateDynamicObject(1418,792.1067505,1940.7805176,5.4106932,0.0000000,0.0000000,87.9895020, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (11)
	CreateDynamicObject(1418,792.2286987,1944.2687988,5.4106932,0.0000000,0.0000000,87.9895020, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (12)
	CreateDynamicObject(1418,790.6336670,1946.4658203,5.4106932,0.0000000,0.0000000,165.9895020, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (13)
	CreateDynamicObject(3634,778.4730225,1940.6044922,7.3069754,0.0000000,0.0000000,261.9964600, -1, -1, -1, 400, 400); //object(nwccumphus1_las) (1)
	CreateDynamicObject(1418,787.1751709,1947.1236572,5.4106932,0.0000000,0.0000000,171.9869385, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (15)
	CreateDynamicObject(1418,783.7456665,1947.5837402,5.4106932,0.0000000,0.0000000,171.9854736, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (17)
	CreateDynamicObject(1418,780.2932739,1948.0458984,5.4106932,0.0000000,0.0000000,171.9854736, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (18)
	CreateDynamicObject(1418,776.8724976,1948.4956055,5.4106932,0.0000000,0.0000000,171.9854736, -1, -1, -1, 400, 400); //object(dyn_f_wood_3) (19)
	return 1;
}


public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SendSystemMessage(playerid, "Bem vindo ao Santa Faria Roleplay! O sistema está carregando seus dados...");
	SetSpawnInfo(playerid, 0, 183, -146.1487,1124.4265,19.7422, 0, 0, 0, 0, 0, 0, 0);
	SpawnPlayer(playerid);
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid, 0xFFFFFF00);
	TextDrawHideForPlayer(playerid, BlankScreen);
	new string[128], pIP[16], strx[1280];
	SetPVarFloat(playerid, "Health", 100);
	format(string, 128, "SELECT `playerID`, `playerCreated` FROM `playerdata` WHERE `playerName` = '%s';", ReturnPlayerNameEx(playerid));
	mysql_function_query(db, string, true, "CheckAccount", "i", playerid);
	mysql_format(db, string, 128, "INSERT INTO playerconnections (conName, conIP) VALUES('%e', '%e');", ReturnPlayerNameEx(playerid), pIP);
	mysql_function_query(db, string, false, "", "");
	strcat(strx, "{FFFFFF}Bem vindo!\n\n{FFAA00}ESTAMOS EM FASE DE TESTES!\nAjude a comunidade e o servidor reportando os bugs que você encontrar!\nSugestões também são bem vindas!\n\n\n\tATENÇÃO: ESTE SERVIDOR POSSUI UM TERMO DE USO!");
	strcat(strx, "\n{FFAA00}CRÉDITOS:\n{A9C4E4}LeLeTe:\n\t {C2A2DA}Regras, GUI, GM, Sistemas;\n{A9C4E4}Nick:\n\t {C2A2DA}Mapa de Santa Faria;\n{A9C4E4}Gonça, Horyk:\n\t {C2A2DA}Testes e Sugestões;\n");
	strcat(strx, "\n\n{A9C4E4}Este servidor não possui comandos. Para ajuda e mais informações, aperte a tecla N;");
	strcat(strx, "\n\t{FFAA00}Ao entrar no servidor, automaticamente você aceita e concorda com os termos a seguir:\n\n{FFFFFF}1. Este servidor é exclusivamente RP. Qualquer violação das regras comuns de RP estará sujeita a banimento.");
	strcat(strx, "\n2. Este servidor está em testes, portanto não há garantia de permanência de nenhum dos dados atualmente carregados no servidor;");
	strcat(strx, "\n3. Este servidor é para maiores de 18 anos. Caso você não tenha a mínima idade, deslogue imediatamente. \n4. Os responsáveis e ligados ao servidor não se responsabilizam por nenhum dos jogadores e/ou ações in-game ou fora;");
	ShowPlayerDialog(playerid, DIALOG_TERMS, DIALOG_STYLE_MSGBOX,  "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", strx, "Continuar", "Sair");
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	new Float:XYZ[3];
	GetPlayerPos(playerid, XYZ[0], XYZ[1], XYZ[2]);
	SetPVarFloat(playerid, "PosX", XYZ[0]);
	SetPVarFloat(playerid, "PosY", XYZ[1]);
	SetPVarFloat(playerid, "PosZ", XYZ[2]);
	SetPVarInt(playerid, "Int", GetPlayerInterior(playerid));
	SetPVarInt(playerid, "VW", GetPlayerVirtualWorld(playerid));
	SavePlayerData(playerid);
	new string[128];
	format(string, 128, "%s ((OFF))", ReturnRPName(playerid));
	DestroyDynamic3DTextLabel(NameText[playerid]);
	new actid = CreateActor(GetPVarInt(playerid, "Skin"), XYZ[0], XYZ[1], XYZ[2], 0);
	ActorText[playerid] = CreateDynamic3DTextLabel(string, COLOR_PURPLE, XYZ[0], XYZ[1], XYZ[2]+0.8, 30, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);
	SetTimerEx("RemoveOfflinePlayer", 60000, 0, "i", actid);
	if(IsValidActor(GetPVarInt(playerid, "TutorialActor"))) DestroyActor(GetPVarInt(playerid, "TutorialActor"));
	if(IsValidDynamic3DTextLabel(TutorialActorText[playerid])) DestroyDynamic3DTextLabel(TutorialActorText[playerid]);
	mysql_format(db, string, 128, "DELETE FROM playerdata WHERE playerID = '%d';", GetPVarInt(playerid, "InternalID"));
	if(!GetPVarInt(playerid, "Created")) mysql_function_query(db, string, false, "", "");
	return 1;
}

public OnPlayerSpawn(playerid)
{	
	SetCameraBehindPlayer(playerid);
	if(!GetPVarInt(playerid, "Logged"))
	{	
		SetPlayerPos(playerid, -147.1928,1124.2349,10.7422);
		SetPlayerCameraPos(playerid, -130.1519,1110.5338,28.9699);
		SetPlayerCameraLookAt(playerid, -147.1928,1124.2349,19.7422);
		TogglePlayerControllable(playerid, 0);
		if(!GetPVarInt(playerid, "AccountExists"))
			return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "Bem vindo!\nPor favor, registre uma senha abaixo para continuar.\nATENÇÃO! A senha tem um limite de 24 caracteres.", "Registrar", "Sair");
		else
			return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "Bem vindo!\nPor favor, digite sua senha abaixo para continuar.", "Continuar", "Sair");
	}
	if(!GetPVarInt(playerid, "Registered")) return 1;
	new string[128];
	format(string, 128, "%s [%i]", ReturnRPName(playerid), playerid);
	DestroyDynamic3DTextLabel(NameText[playerid]);
	NameText[playerid] = CreateDynamic3DTextLabel(string, COLOR_WHITE, GetPVarFloat(playerid, "PosX"), GetPVarFloat(playerid, "PosY"), GetPVarFloat(playerid, "PosZ")+0.8, 30, playerid, INVALID_VEHICLE_ID, 1);
	TextDrawSetString(ChatIndicator[playerid], "~w~Chat: IC");
	SetPVarInt(playerid, "ChatSelected", 0);
	SetPVarInt(playerid, "LastSelected", 1);
	TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new Float:pos[3];
	GetPlayerPos(playerid, pos[0], pos[1], pos[2]);
	SetPVarFloat(playerid, "PosX", pos[0]);
	SetPVarFloat(playerid, "PosY", pos[1]);
	SetPVarFloat(playerid, "PosZ", pos[2]);
	SetPVarInt(playerid, "Int", GetPlayerInterior(playerid));
	SetPVarInt(playerid, "VW", GetPlayerVirtualWorld(playerid));
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new x[256], string[180];
	if(GetPVarInt(playerid, "Logged"))
	{
		switch(GetPVarInt(playerid, "ChatSelected"))
		{
			case 0:
			{
				format(string, 180, "%s diz: %s", ReturnRPName(playerid), text);
				BroadcastChat(string, playerid, DEFAULT_MESSAGE_RADIUS);
				mysql_format(db, x, 256, "INSERT INTO chatlog (logText, playerID) VALUES('%e', '%d');", string, GetPVarInt(playerid, "InternalID"));
				mysql_function_query(db, x, false, "", "");
				if(GetPVarInt(playerid, "Tutorial") > 0)
				{
					switch(GetPVarInt(playerid, "Tutorial"))
					{
						case 1:
						{
							if(IsPlayerInRangeOfPoint(playerid, 5, 732.0733,1787.5806,5.8858))
							{
								if(!strcmp(text, "oi", true, 2))
								{
									BroadcastChat("Mano diz: Salve.", playerid, DEFAULT_MESSAGE_RADIUS);
									SetPVarInt(playerid, "Tutorial", 2);
									TutorialSteps(playerid);
								}
							}
						}
					}
				}	
			}
			case 1:
			{
				format(string, 180, "(( %s [%i]: %s ))", ReturnRPName(playerid), playerid, text);
				BroadcastMessage(string, 0xAFAFAFFF, playerid, DEFAULT_MESSAGE_RADIUS);
				mysql_format(db, x, 256, "INSERT INTO chatlog (logText, playerID) VALUES('%e', '%d');", string, GetPVarInt(playerid, "InternalID"));
				mysql_function_query(db, x, false, "", "");
			}
			case 2:
			{
				format(string, 180, "** %s %s", ReturnRPName(playerid), text);
				BroadcastMessage(string, 0xC2A2DAFF, playerid, DEFAULT_MESSAGE_RADIUS);
				mysql_format(db, x, 256, "INSERT INTO chatlog (logText, playerID) VALUES('%e', '%d');", string, GetPVarInt(playerid, "InternalID"));
				mysql_function_query(db, x, false, "", "");
				if(GetPVarInt(playerid, "Tutorial") > 0)
				{
					switch(GetPVarInt(playerid, "Tutorial"))
					{
						case 2:
						{
							if(IsPlayerInRangeOfPoint(playerid, 5, 732.0733,1787.5806,5.8858))
							{
								if(!strcmp(text, "senta na cadeira ao lado do mano", true, 32))
								{
									SetPlayerPos(playerid, 732.0333,1789.0806,5.8858);
									SetPlayerFacingAngle(playerid, 271.5175);
									ApplyAnimation(playerid,"PED","SEAT_idle", 4.0, 1, 0, 0, 0, 0);	
									BroadcastMessage("** Mano nota alguém sentando, e volta a olhar pra frente.", 0xC2A2DAFF, playerid, DEFAULT_MESSAGE_RADIUS);
									SetPVarInt(playerid, "Tutorial", 3);
									TutorialSteps(playerid);
								}
							}
						}
						case 3:
						{
							if(IsPlayerInRangeOfPoint(playerid, 5, 732.0733,1787.5806,5.8858))
							{
								if(!strcmp(text, "olha para o Mano", true, 16))
								{
									BroadcastMessage("** Mano nota alguém olhando pra ele.", 0xC2A2DAFF, playerid, DEFAULT_MESSAGE_RADIUS);
									BroadcastMessage("(( Mano [1337]: Fala memo. ))", 0xAFAFAFFF, playerid, DEFAULT_MESSAGE_RADIUS);
									SetPVarInt(playerid, "Tutorial", 4);
									TutorialSteps(playerid);
								}
							}
						}
						
					}
				}
			}
			case 3:
			{
				format(string, 180, "** %s (( %s ))", text, ReturnRPName(playerid));
				BroadcastMessage(string, 0xC2A2DAFF, playerid, DEFAULT_MESSAGE_RADIUS);
				mysql_format(db, x, 256, "INSERT INTO chatlog (logText, playerID) VALUES('%e', '%d');", string, GetPVarInt(playerid, "InternalID"));
				mysql_function_query(db, x, false, "", "");
			}
			case 4:
			{
				if(GetPVarInt(playerid, "Tutorial") == 4)
				{
					format(string, 128, "(( PM para Mano [1337]: %s ))", text);
					SendClientMessage(playerid, COLOR_YELLOW, string);
					if(!strcmp(text, "salve", true, 5))
					{
						SetPVarInt(playerid, "Tutorial", 5);
						format(string, 128, "(( PM de Mano [1337]: Salve. ))", text);
						SendClientMessage(playerid, COLOR_YELLOW, string);
						TutorialSteps(playerid);
					}
				}
				else SendPrivateMessage(playerid, GetPVarInt(playerid, "PMT"), text);
				TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
				TextDrawSetString(ChatIndicator[playerid], "~w~Chat: IC");
				TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
				SetPVarInt(playerid, "ChatSelected", 0);
				SetPVarInt(playerid, "PMT", INVALID_PLAYER_ID);
			}
			case 5:
			{
				format(string, 180, "%s [%i]: %s", GetPVarStringEx(playerid, "AdminName"), playerid, text);
				SendAdminMessage(string);
			}
			case 6:
			{
				format(string, 180, "((!)) %s [%i]: %s", GetPVarStringEx(playerid, "AdminName"), playerid, text);
				SendColoredServerBroadcast(0xA9C4E4FF, string);
			}
			case 7:
			{
				format(string, 180, "%s [%i]: %s", GetPVarStringEx(playerid, "Username"), playerid, text);
				SendNewbieMessage(string);
			}
			case 8:
			{
				format(string, 180, "%s [%i]: %s", GetPVarStringEx(playerid, "Username"), playerid, text);
				SendServerChat(string);
			}
		}
		TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
		TextDrawSetString(ChatIndicator[playerid], "~w~Chat: IC");
		TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
		SetPVarInt(playerid, "ChatSelected", 0);
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid, bodypart)
{
   return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	new string[128];
	format(string, 128, "Um administrador logado na rcon digitou: %s", cmd);
	SendAdminBroadcast(string);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(!GetPVarInt(playerid, "Logged"))
	{	
		SetPlayerPos(playerid, -146.1487,1124.4265,19.7422);
		SetPlayerCameraPos(playerid, -111.5967,1094.6294,45.4640);
		SetPlayerCameraLookAt(playerid, -196.7935,1161.2151,21.3809);
		if(!GetPVarInt(playerid, "AccountExists"))
			return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "Bem vindo!\nPor favor, registre uma senha abaixo para continuar.\nATENÇÃO! A senha tem um limite de 24 caracteres.", "Registrar", "Sair");
		else
			return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "Bem vindo!\nPor favor, digite sua senha abaixo para continuar.", "Continuar", "Sair");
	}
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_CROUCH)
	{
		if(GetPVarInt(playerid, "Admin") > 0)
		{
			if(!HelpStackEmpty())
			{
				SetPVarInt(playerid, "HelpPlayer", HelpStackTopPlayer());
				SetPVarString(playerid, "HelpMessage", HelpStackTopMessage());
				HelpStackPop();
				new string[128];
				format(string, 128, "Sua mensagem de ajuda foi vista por %s [%i], aguarde uma resposta...", GetPVarStringEx(playerid, "AdminName"), playerid);
				SendWarningMessage(GetPVarInt(playerid, "HelpPlayer"), string);
				format(string, 128, "[!] Você está visualizando o pedido de ajuda do usuário %s no personagem %s [%d]:", GetPVarStringEx(GetPVarInt(playerid, "HelpPlayer"), "Username"), ReturnRPName(GetPVarInt(playerid, "HelpPlayer")), GetPVarInt(playerid, "HelpPlayer"));
				SendClientMessage(playerid, COLOR_GREY, string);
				format(string, 128, "%s", GetPVarStringEx(playerid, "HelpMessage"));
				SendClientMessage(playerid, COLOR_LIGHT, string);
				SendClientMessage(playerid, COLOR_GREY, "Envie uma MP para o jogador assim que possível;");
			}
		}
	}
	if (newkeys & KEY_YES) 
	{
		if(GetPVarInt(playerid, "LastSelected") == GetPVarInt(playerid, "ChatSelected")) SetPVarInt(playerid, "LastSelected", GetPVarInt(playerid, "ChatSelected")+1);
		switch(GetPVarInt(playerid, "LastSelected"))
		{
			case 1:
			{
				TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
				TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~b~OOC Local");
				GameTextForPlayer(playerid, "~w~Chat: ~b~OOC Local", 3000, 4);
				TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
			}
			case 2:
			{
				TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
				new string[24];
				format(string, 24, "~w~Chat: ~p~Ação");
				convert_encoding(string);
				TextDrawSetString(ChatIndicator[playerid], string);
				GameTextForPlayer(playerid, string, 3000, 4);
				TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
			}
			case 3:
			{
				TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
				new string[30];
				format(string, 30, "~w~Chat: ~p~Descrição");
				convert_encoding(string);
				TextDrawSetString(ChatIndicator[playerid], string);
				GameTextForPlayer(playerid, string, 3000, 4);
				TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
			}
			case 4:
			{
				if(GetPVarInt(playerid, "PMT") == INVALID_PLAYER_ID) ShowPlayerDialog(playerid, DIALOG_PM, DIALOG_STYLE_INPUT, "Mensagens Privadas", "Digite abaixo o ID ou nome de quem vai receber a mensagem;", "Selecionar", "Sair");
				TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
				new string[30];
				format(string, 30, "~w~Chat: ~y~%s", ReturnRPName(GetPVarInt(playerid, "PMT")));
				convert_encoding(string);
				TextDrawSetString(ChatIndicator[playerid], string);
				GameTextForPlayer(playerid, string, 3000, 4);
				TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
			}		
			case 5:
			{
				if(GetPVarInt(playerid, "Admin") > 0 && GetPVarInt(playerid, "ReadAdminMessage") > 0)
				{
					TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
					GameTextForPlayer(playerid, "~w~Chat: ~y~Administrativo", 3000, 4);
					TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~y~Administrativo");
					TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
				}
				else 
				{
					if(GetPVarInt(playerid, "ReadNewbieChat") < 1)
					{
						if(!OOCChat || GetPVarInt(playerid, "ReadGlobalChat") < 1)
						{
							SetPVarInt(playerid, "LastSelected", 1);
							TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
							TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~b~OOC Local");
							GameTextForPlayer(playerid, "~w~Chat: ~b~OOC Local", 3000, 4);
							TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
						}
						else
						{
							SetPVarInt(playerid, "LastSelected", 8);
							TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
							TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~r~OOC Global");
							GameTextForPlayer(playerid, "~w~Chat: ~r~OOC Global", 3000, 4);
							TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
						}
					}
					else
					{
						SetPVarInt(playerid, "LastSelected", 7);
						TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
						TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~h~~b~Novato");
						GameTextForPlayer(playerid, "~w~Chat: ~h~~b~Novato", 3000, 4);
						TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
					}
				}
			}	
			case 6:
			{
				if(GetPVarInt(playerid, "Admin") > 0)
				{
					TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
					new string[30];
					format(string, 30, "~w~Chat: ~g~Anúncio");
					convert_encoding(string);
					GameTextForPlayer(playerid, string, 3000, 4);
					TextDrawSetString(ChatIndicator[playerid], string);
					TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
				}	
				else
				{
					if(GetPVarInt(playerid, "TogglePrivateMessage") < 1)
					{
						if(GetPVarInt(playerid, "ReadNewbieChat") < 1)
						{
							if(!OOCChat || GetPVarInt(playerid, "ReadGlobalChat") < 1)
							{
								SetPVarInt(playerid, "LastSelected", 1);
								TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
								TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~b~OOC Local");
								GameTextForPlayer(playerid, "~w~Chat: ~b~OOC Local", 3000, 4);
								TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
							}
							else
							{
								SetPVarInt(playerid, "LastSelected", 8);
								TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
								TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~r~OOC Global");
								GameTextForPlayer(playerid, "~w~Chat: ~r~OOC Global", 3000, 4);
								TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
							}
						}
						else
						{
							SetPVarInt(playerid, "LastSelected", 7);
							TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
							TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~h~~b~Novato");
							GameTextForPlayer(playerid, "~w~Chat: ~h~~b~Novato", 3000, 4);
							TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
						}
					}
					else
					{
						SetPVarInt(playerid, "LastSelected", 4);
						if(GetPVarInt(playerid, "PMT") == INVALID_PLAYER_ID) ShowPlayerDialog(playerid, DIALOG_PM, DIALOG_STYLE_INPUT, "Mensagens Privadas", "Digite abaixo o ID ou nome de quem vai receber a mensagem;", "Selecionar", "Sair");
						TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
						new string[30];
						if(GetPVarInt(playerid, "PMT") == INVALID_PLAYER_ID) format(string, 30, "~w~Chat: ~y~Mensagem Privada", ReturnRPName(GetPVarInt(playerid, "PMT")));
						else format(string, 30, "~w~Chat: ~y~%s", ReturnRPName(GetPVarInt(playerid, "PMT")));
						convert_encoding(string);
						TextDrawSetString(ChatIndicator[playerid], string);
						GameTextForPlayer(playerid, string, 3000, 4);
						TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
					}
				}	
			}
			case 7:
			{
				if(GetPVarInt(playerid, "ReadNewbieChat") < 1)
				{
					if(!OOCChat || GetPVarInt(playerid, "ReadGlobalChat") < 1)
					{
						SetPVarInt(playerid, "LastSelected", 1);
						TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
						TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~b~OOC Local");
						GameTextForPlayer(playerid, "~w~Chat: ~b~OOC Local", 3000, 4);
						TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
					}
					else
					{
						SetPVarInt(playerid, "LastSelected", 8);
						TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
						TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~r~OOC Global");
						GameTextForPlayer(playerid, "~w~Chat: ~r~OOC Global", 3000, 4);
						TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
					}
				}
				else
				{
					TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
					TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~h~~b~Novato");
					GameTextForPlayer(playerid, "~w~Chat: ~h~~b~Novato", 3000, 4);
					TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
				}
			}
			case 8:
			{
				if(!OOCChat || GetPVarInt(playerid, "ReadGlobalChat") < 1)
				{
					SetPVarInt(playerid, "LastSelected", 1);
					TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
					TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~b~OOC Local");
					GameTextForPlayer(playerid, "~w~Chat: ~b~OOC Local", 3000, 4);
					TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
				}
				else
				{
					TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
					TextDrawSetString(ChatIndicator[playerid], "~w~Chat: ~r~OOC Global");
					GameTextForPlayer(playerid, "~w~Chat: ~r~OOC Global", 3000, 4);
					TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
				}
			}
			default:
			{
				TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
				TextDrawSetString(ChatIndicator[playerid], "~w~Chat: IC");
				TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
				SetPVarInt(playerid, "ChatSelected", 0);
			}
		}
		SetPVarInt(playerid, "ChatSelected", GetPVarInt(playerid, "LastSelected"));
	}
	if(newkeys & KEY_NO)
	{
		if(GetPVarInt(playerid, "MenuOpen") != 1337)
		{
			new string[128];
			format(string, 128, "INVENTÁRIO");
			convert_encoding(string);
			TextDrawShowForPlayer(playerid, MenuInventory[playerid]);
			TextDrawShowForPlayer(playerid, MenuStats[playerid]);
			TextDrawShowForPlayer(playerid, MenuPanel[playerid]);
			TextDrawShowForPlayer(playerid, MenuCharacters[playerid]);
			TextDrawSetString(MenuDisc[4], string);
			TextDrawShowForPlayer(playerid, MenuDisc[0]);
			TextDrawShowForPlayer(playerid, MenuDisc[1]);
			TextDrawShowForPlayer(playerid, MenuDisc[2]);
			TextDrawShowForPlayer(playerid, MenuDisc[3]);
			TextDrawShowForPlayer(playerid, MenuDisc[4]);
			TextDrawShowForPlayer(playerid, MenuDisc[5]);
			TextDrawShowForPlayer(playerid, MenuDisc[6]);
			TextDrawShowForPlayer(playerid, MenuDisc[7]);
			if(GetPVarInt(playerid, "Admin") > 0)
			{
				TextDrawShowForPlayer(playerid, MenuDisc[8]);
				TextDrawShowForPlayer(playerid, MenuAdmin[playerid]);	
			}
			SelectTextDraw(playerid, COLOR_PURPLE);
			SetPVarInt(playerid, "MenuOpen", 1337);
		}
	}
	if(newkeys & KEY_CTRL_BACK)
	{
		if(!IsPlayerInAnyVehicle(playerid))
		{
			foreach(new i : ItemsPlaced)
			{
				if(IsPlayerInRangeOfPoint(playerid, 2, PlacedItems[i][pPosX], PlacedItems[i][pPosY], PlacedItems[i][pPosZ]) && GetPlayerInterior(playerid) == PlacedItems[i][pInt] && GetPlayerVirtualWorld(playerid) == PlacedItems[i][pVW]) 
				{
					ShowItemForPlayer(playerid, i);
					break;
				}
			}
		}
		
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	new string[128], xip[24], playerid;
	foreach(Player, i)
	{
		GetPlayerIp(i, xip, 24);
		if(!strcmp(ip, xip, true, 24)) playerid = i;
	}
	format(string, 128, "%s - IP: %s - Logou na RCON", ReturnPlayerNameEx(playerid), ip);
	if(success) PlayerLog(playerid, string);
	else
	{
		format(string, 128, "%s - IP: %s - Tentou logar na RCON", ReturnPlayerNameEx(playerid), ip);
		PlayerLog(playerid, string);
		format(string, 128, "%s - IP: %s - Errou a senha da RCON e foi kickado.", ReturnPlayerNameEx(playerid), ip);
		SendAdminBroadcast(string);
		Kick(playerid);
		return 1;
	}
	return ShowPlayerDialog(playerid, DIALOG_RCONLOGIN, DIALOG_STYLE_PASSWORD, "[{C2A2DA}#{A9C4E4}] Autenticação do Servidor", "Por favor, digite abaixo a senha do script", "Continuar", "Sair do Servidor");
}

public OnIncomingConnection(playerid, ip_address[], port)
{
    printf("Conexão detectada. ID %i [IP-porta: %s:%i]", playerid, ip_address, port);
    return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}
public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid)
	{
		case DIALOG_NULL: return 1;
		case DIALOG_LOGIN: 
		{
			if(!response) return SendSystemMessage(playerid, "Você será kickado pois decidiu não logar no servidor."), Kick(playerid);
			if(!GetPVarInt(playerid, "AccountExists") || GetPVarInt(playerid, "Created") != 1337)
			{
				new string[128], passx[24];
				mysql_format(db, string, 128, "INSERT INTO playerdata (playerName, playerPass) VALUES('%e', '%e');", ReturnPlayerNameEx(playerid), inputtext);
    			mysql_real_escape_string(inputtext, passx, db);
				SetPVarString(playerid, "InputPass", passx);
    			mysql_function_query(db, string, true, "OnPlayerRegister", "i", playerid);
			}
			else
			{
				new string[180];
				format(string, 180, "SELECT * FROM playerdata WHERE playerName = '%s' AND playerPass = '%s';", ReturnPlayerNameEx(playerid), inputtext);
    			mysql_function_query(db, string, true, "OnPlayerLogin", "i", playerid);
			}
		}
		case DIALOG_ADMINLOGIN: 
		{
			if(!response) return SendSystemMessage(playerid, "Você será kickado pois decidiu não logar no servidor."), Kick(playerid);
			new safepass[24];
			mysql_real_escape_string(inputtext, safepass, db);
			if(!strcmp(inputtext, GetPVarStringEx(playerid, "AdminPass"), true, 24)) 
			{
				new string[128];
				format(string, 128, "%s [%d] (%s) acabou de logar.", GetPVarStringEx(playerid, "AdminName"), playerid, ReturnPlayerNameEx(playerid));
				SendAdminBroadcast(string);
				SetPVarInt(playerid, "ReadAdminBroadcast", 1);
				SetPVarInt(playerid, "ReadAdminMessage", 1);
				return SendSystemMessage(playerid, "[SISTEMA] Você logou com sucesso!");
			}	
			else
			{	
				new la = GetPVarInt(playerid, "LoginAttempts");
				SetPVarInt(playerid, "LoginAttempts", la+1);
				if(la == 4)
				{
					SendSystemMessage(playerid, "Seu IP será banido imediatamente por errar quatro vezes sua senha.");
					BanEx(playerid, "[SISTEMA] Errou quatro vezes a senha.");
					return 1;
				}
				return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "ERRO: Senha inválida\nPor favor, digite a senha administrativa desta conta", "Continuar", "Sair do Servidor");
			}
		}
		case DIALOG_RCONLOGIN: 
		{
			if(!response) 
			{
				new string[128], xip[16];
				GetPlayerIp(playerid, xip, 16);
				format(string, 128, "%s - IP: %s - Logou na RCON mas não logou no script.", ReturnPlayerNameEx(playerid), xip);
				SendAdminBroadcast(string);
				SendSystemMessage(playerid, "Você será kickado pois decidiu não logar no script."); 
				Kick(playerid);
				return 1;
			}
			new safepass[24];
			mysql_real_escape_string(inputtext, safepass, db);
			if(!strcmp(inputtext, INTERNAL_SERVER_PASSWORD, true)) SendSystemMessage(playerid, "[SISTEMA] Você logou com sucesso na administração!");
			else
			{
				new string[128], xip[16];
				GetPlayerIp(playerid, xip, 16);
				format(string, 128, "%s - IP: %s - Logou na RCON mas errou a senha do script.", ReturnPlayerNameEx(playerid), xip);
				SendAdminBroadcast(string);
				SendSystemMessage(playerid, "Você será kickado pois errou a senha do script."); 
				Kick(playerid);
				return 1;
			}
			SetPVarInt(playerid, "SpecialAuth", 1337);
			SetPVarInt(playerid, "Admin", 1337);
			new string[128], xip[16];
			GetPlayerIp(playerid, xip, 16);
			format(string, 128, "%s - IP: %s - Logou na RCON e no script.", ReturnPlayerNameEx(playerid), xip);
			SendAdminBroadcast(string);
			return 1;
		}
		case DIALOG_ADMINREGISTER: 
		{
			if(!response)
			{
				if(!GetPVarInt(playerid, "AdminReg")) return SendSystemMessage(playerid, "Você será kickado pois decidiu não logar no servidor."), Kick(playerid);
				else 
				{
					SetPVarInt(playerid, "AdminReg", 0);
					return ShowPlayerDialog(playerid, DIALOG_ADMINREGISTER, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "Registre uma senha administrativa abaixo.\nATENÇÃO: Máximo de 24 caracteres.", "Registrar", "Sair");
				}
			}
			if(!GetPVarInt(playerid, "AdminReg")) SetPVarString(playerid, "TempAdminCheck", inputtext);
			else
			{
				if(strcmp(inputtext, GetPVarStringEx(playerid, "TempAdminCheck"), true))
				{
					new la = GetPVarInt(playerid, "LoginAttempts");
					SetPVarInt(playerid, "LoginAttempts", la+1);
					if(la == 4)
					{
						SendSystemMessage(playerid, "Seu IP será banido imediatamente por errar quatro vezes sua senha.");
						BanEx(playerid, "[SISTEMA] Errou quatro vezes a senha na hora de registrar a senha administrativa.");
						return 1;
					}
					return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "ERRO: Senha inválida\nPor favor, digite a senha administrativa desta conta\nCaso queira, clique em VOLTAR para registrar uma nova.", "Continuar", "Voltar");
				}
				DeletePVar(playerid, "AdminReg");
				DeletePVar(playerid, "TempAdminCheck");	
				SendSystemMessage(playerid, "Senha registrada. Lembre-se dela, pois será necessária cada vez que você entrar no servidor.");
				SetPVarString(playerid, "AdminPass", inputtext);
				SavePlayerData(playerid);
				return 1;
			}
			SetPVarInt(playerid, "AdminReg", 1);
			return ShowPlayerDialog(playerid, DIALOG_ADMINREGISTER, DIALOG_STYLE_PASSWORD, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "Digite novamente sua senha para confirmar.", "Digitar", "Voltar");
		}
		case DIALOG_TERMS: if(!response) return Kick(playerid);
		case DIALOG_REGISTEREX: 
		{
			if(!response) return SendSystemMessage(playerid, "Você será kickado pois decidiu não se registrar no servidor."), Kick(playerid);
			SetPVarString(playerid, "Email", inputtext);
			ShowPlayerDialog(playerid, DIALOG_NAMEREGISTER, DIALOG_STYLE_INPUT, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "Email registrado!\nPor favor, informe abaixo seu nome de usuário;\nSeu nome de Usuário é diferente do Nome do Personagem;\nSeu nome de personagem é o nome da conta: Caso ele seja inválido, você poderá ser banido!\nNomes de Personagem válidos usam o formato Nome_Sobrenome (ex. Ripton_Hylton);", "Continuar", "Sair");
			return 1;
		}
		case DIALOG_NAMEREGISTER:
		{	
			if(!strlen(inputtext) || strlen(inputtext) > 24) ShowPlayerDialog(playerid, DIALOG_NAMEREGISTER, DIALOG_STYLE_INPUT, "{C2A2DA}#{A9C4E4} Santa Faria Roleplay", "ERRO: Limite de 24 caracteres para o nome;\nPor favor, informe abaixo o nome do seu personagem;\nAtenção: Os nomes devem ter um formato Nome_Sobrenome;\nNomes fora do formato ou inválidos terão a conta banida!", "Continuar", "Sair");
			SetPVarString(playerid, "Username", inputtext);
			SendSystemMessage(playerid, "[Criação de Pergonsagens]");
			SendSystemMessage(playerid, "Para mudar as características de seu personagem, clique nas setas.");
			SendSystemMessage(playerid, "Para finalizar, clique no balão com o ícone azul. Clicando no botão vermelho reiniciará o processo.");
			SpawnPlayer(playerid);
			return StartRegister(playerid);
		}
		case DIALOG_PM:
		{
			if(!response)
			{
				TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
				TextDrawSetString(ChatIndicator[playerid], "~w~Chat: IC");
				TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
				SetPVarInt(playerid, "ChatSelected", 0);
				SetPVarInt(playerid, "PMT", INVALID_PLAYER_ID);
			}
			else
			{
				new ID, string[50];
				if(GetPVarInt(playerid, "Tutorial") == 4) 
				{
					if(strval(inputtext) != 1337) return ShowPlayerDialog(playerid, DIALOG_PM, DIALOG_STYLE_INPUT, "Mensagens Privadas", "{FF0000}ERRO: Jogador diferente de Mano;\n{A9C4E4}Digite abaixo o ID ou nome de quem vai receber a mensagem;", "Selecionar", "Sair");
					TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
					format(string, 50, "~w~Chat: ~y~Mano", ReturnRPName(GetPVarInt(playerid, "PMT")));
					convert_encoding(string);
					TextDrawSetString(ChatIndicator[playerid], string);
					GameTextForPlayer(playerid, string, 3000, 4);
					TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
					return 1;
				}
				if(sscanf(inputtext, "u", ID) || !IsPlayerConnected(ID)) return ShowPlayerDialog(playerid, DIALOG_PM, DIALOG_STYLE_INPUT, "Mensagens Privadas", "{FF0000}ERRO: Jogador inválido;\n{A9C4E4}Digite abaixo o ID ou nome de quem vai receber a mensagem;", "Selecionar", "Sair");
				SetPVarInt(playerid, "PMT", ID);
				TextDrawHideForPlayer(playerid, ChatIndicator[playerid]);
				format(string, 50, "~w~Chat: ~y~%s", ReturnRPName(GetPVarInt(playerid, "PMT")));
				convert_encoding(string);
				TextDrawSetString(ChatIndicator[playerid], string);
				GameTextForPlayer(playerid, string, 3000, 4);
				TextDrawShowForPlayer(playerid, ChatIndicator[playerid]);
			}
		}
		case DIALOG_REPORT:
		{
			switch(GetPVarInt(playerid, "Reporting"))
			{
				case 1337:
				{
					if(!response) return 1;
					new ID;
					if(sscanf(inputtext, "u", ID)) 
					{
						new str[128];
						mysql_format(db, str, 128, "SELECT * FROM playerdata WHERE playerName = '%e';", inputtext);
						mysql_function_query(db, str, true, "CheckExist", "is", playerid, inputtext);
						return 1;
					}
					if(!IsPlayerConnected(ID)) return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", "{FF0000}ERRO: Jogador inválido;\n{A9C4E4}Digite abaixo o ID ou nome de quem você deseja reportar;", "Reportar", "Sair");
					DeletePVar(playerid, "OfflineReport");
					SetPVarInt(playerid, "ReportedPlayer", ID);
					new str[256];
					format(str, 256, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n{a9c4e4}Digite o motivo que você deseja reportar esse jogador.\nAtenção: Limite de 128 caracteres;", ReturnRPName(GetPVarInt(playerid, "ReportedPlayer")));
					SetPVarInt(playerid, "Reporting", 1338);
					return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", str, "Reportar", "Voltar");
				}
				case 1338:
				{
					if(!response) 
					{
						SetPVarInt(playerid, "Reporting", 1337);
						return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", "Digite abaixo o nome ou ID do jogador que deseja reportar;", "Reportar", "Cancelar");
					}
					if(!strlen(inputtext) || strlen(inputtext) > 128)
					{
						new str[256];
						if(GetPVarInt(playerid, "OfflineReport") != 1337) format(str, 256, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n\n{FF0000}ERRO: Motivo inválido ou excedendo o limite de caracteres;\n{a9c4e4}Digite o motivo que você deseja reportar esse jogador.\nAtenção: Limite de 128 caracteres;", ReturnRPName(GetPVarInt(playerid, "ReportedPlayer")));
						else format(str, 256, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n\n{FF0000}ERRO: Motivo inválido ou excedendo o limite de caracteres;\n{a9c4e4}Digite o motivo que você deseja reportar esse jogador.\nAtenção: Limite de 128 caracteres;", GetPVarStringEx(playerid, "ReportedPlayer"));
						SetPVarInt(playerid, "Reporting", 1338);
						return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", str, "Reportar", "Voltar");
					}
					SetPVarString(playerid, "ReportReason", inputtext);
					SetPVarInt(playerid, "Reporting", 1339);
					new str[384];
					if(GetPVarInt(playerid, "OfflineReport") != 1337) format(str, 384, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n{A9C4E4}Motivo: \n\t{C2A2DA}%s;\n{a9c4e4}Digite abaixo informações extras (link de fotos, testemunhas, etc).\nAtenção: Limite de 128 caracteres;", ReturnRPName(GetPVarInt(playerid, "ReportedPlayer")), GetPVarStringEx(playerid, "ReportReason"));
					else format(str, 384, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n{A9C4E4}Motivo: \n\t{C2A2DA}%s;\n{a9c4e4}Digite abaixo informações extras (link de fotos, testemunhas, etc).\nAtenção: Limite de 128 caracteres;", GetPVarStringEx(playerid, "ReportedPlayer"), GetPVarStringEx(playerid, "ReportReason"));
					return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", str, "Reportar", "Voltar");
				}
				case 1339:
				{
					if(!response) 
					{
						new str[256];
						if(GetPVarInt(playerid, "OfflineReport") != 1337) format(str, 256, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n\n{FF0000}ERRO: Motivo inválido ou excedendo o limite de caracteres;\n{a9c4e4}Digite o motivo que você deseja reportar esse jogador.\nAtenção: Limite de 128 caracteres;", ReturnRPName(GetPVarInt(playerid, "ReportedPlayer")));
						else format(str, 256, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n\n{FF0000}ERRO: Motivo inválido ou excedendo o limite de caracteres;\n{a9c4e4}Digite o motivo que você deseja reportar esse jogador.\nAtenção: Limite de 128 caracteres;", GetPVarStringEx(playerid, "ReportedPlayer"));
						SetPVarInt(playerid, "Reporting", 1338);
						return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", str, "Reportar", "Voltar");
					}
					if(!strlen(inputtext) || strlen(inputtext) > 128)
					{
						SetPVarInt(playerid, "Reporting", 1339);
						new str[384];
						if(GetPVarInt(playerid, "OfflineReport") != 1337) format(str, 384, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n{A9C4E4}Motivo: \n\t{C2A2DA}%s;\n{a9c4e4}Digite abaixo informações extras (link de fotos, testemunhas, etc).\nAtenção: Limite de 128 caracteres;", ReturnRPName(GetPVarInt(playerid, "ReportedPlayer")), GetPVarStringEx(playerid, "ReportReason"));
						else format(str, 384, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n{A9C4E4}Motivo: \n\t{C2A2DA}%s;\n{a9c4e4}Digite abaixo informações extras (link de fotos, testemunhas, etc).\nAtenção: Limite de 128 caracteres;", GetPVarStringEx(playerid, "ReportedPlayer"), GetPVarStringEx(playerid, "ReportReason"));
						return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_INPUT, "Reporte um Jogador", str, "Reportar", "Voltar");
					}
					SetPVarString(playerid, "ReportingExtra", inputtext);
					new str[512];
					if(GetPVarInt(playerid, "OfflineReport") != 1337) format(str, 512, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n{A9C4E4}Motivo: \n\t{C2A2DA}%s;\n{A9C4E4}Informações Extras: \n\t{C2A2DA}%s;\n{a9c4e4}Para enviar este relatório, aperte SIM; Apertar NÃO irá apagar o relatório;", ReturnRPName(GetPVarInt(playerid, "ReportedPlayer")), GetPVarStringEx(playerid, "ReportReason"), GetPVarStringEx(playerid, "ReportingExtra"));
					else format(str, 512, "{A9C4E4}Reportando: \n\t{C2A2DA}%s\n\n{A9C4E4}Motivo: \n\t{C2A2DA}%s;\n{A9C4E4}Informações Extras: \n\t{C2A2DA}%s;\n{a9c4e4}Para enviar este relatório, aperte SIM; Apertar NÃO irá apagar o relatório;", GetPVarStringEx(playerid, "ReportReason"), GetPVarStringEx(playerid, "ReportReason"), GetPVarStringEx(playerid, "ReportingExtra"));
					SetPVarInt(playerid, "Reporting", 1340);
					return ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_MSGBOX, "Reporte um Jogador", str, "Sim", "Não");
				}
				case 1340:
				{
					if(!response) return SendWarningMessage(playerid, "Relatório cancelado;");
					SendActionMessage(playerid, "Seu relatório foi enviado com sucesso; Para vê-lo, acesse seu painel;");
					new str[384];
					if(GetPVarInt(playerid, "OfflineReport") != 1337) mysql_format(db, str, 384, "INSERT INTO playerreports (reportee, reported, reportReason, reportExtra) VALUES('%i', '%i', '%e', '%e')", GetPVarInt(playerid, "InternalID"), GetPVarInt(GetPVarInt(playerid, "ReportedPlayer"), "InternalID"), GetPVarStringEx(playerid, "ReportReason"), GetPVarStringEx(playerid, "ReportingExtra"));
					else mysql_format(db, str, 384, "INSERT INTO playerreports (reportee, reported, reportReason, reportExtra) VALUES('%i', '%i', '%e', '%e')", GetPVarInt(playerid, "InternalID"), GetPVarInt(playerid, "ReportedPlayerID"), GetPVarStringEx(playerid, "ReportReason"), GetPVarStringEx(playerid, "ReportingExtra"));
					mysql_function_query(db, str, false, "", "");
				}
			}
		}
		case DIALOG_SUGGESTION:
		{
			if(!response) return SendWarningMessage(playerid, "Sugestão cancelada;");
			switch(GetPVarInt(playerid, "Suggesting"))
			{
				case 1337:
				{
					new str[256];
					format(str, 128, "%s", inputtext);
					SetPVarString(playerid, "Suggestion", str);
					SetPVarInt(playerid, "Suggesting", 1338);
					format(str, 256, "{a9C4e4}Sugestão:\n\t{c2A2DA}%s\n{A9c4e4}Digite abaixo mais informações sobre sua sugestão;", GetPVarStringEx(playerid, "Suggestion"));
					return ShowPlayerDialog(playerid, DIALOG_SUGGESTION, DIALOG_STYLE_INPUT, "Faça uma Sugestão", str, "Prosseguir", "Cancelar");
				}
				case 1338:
				{
					new str[384];
					format(str, 128, "%s", inputtext);
					SetPVarString(playerid, "SuggestionExtra", str);
					SetPVarInt(playerid, "Suggesting", 1339);
					format(str, 384, "{a9C4e4}Sugestão:\n\t{c2A2DA}%s\n{a9C4e4}Extras:\n\t{c2A2DA}%s\n{A9c4e4}Aperte SIM para enviar a sugestão;\nAperte NÃO para cancelar;", GetPVarStringEx(playerid, "Suggestion"), GetPVarStringEx(playerid, "SuggestionExtra"));
					return ShowPlayerDialog(playerid, DIALOG_SUGGESTION, DIALOG_STYLE_MSGBOX, "Faça uma Sugestão", str, "Prosseguir", "Cancelar");
				}
				case 1339:
				{
					new str[384];
					SendActionMessage(playerid, "Sua sugestão foi enviada com sucesso; Para vê-lo, acesse seu painel;");
					mysql_format(db, str, 384, "INSERT INTO playersuggestions (sugPlayer, sugMain, sugExtra) VALUES('%i', '%e', '%e')", GetPVarInt(playerid, "InternalID"), GetPVarStringEx(playerid, "Suggestion"), GetPVarStringEx(playerid, "SuggestionExtra"));
					mysql_function_query(db, str, false, "", "");
				}
			}
		}
		case DIALOG_BUGTRACKER:
		{
			if(!response) return SendWarningMessage(playerid, "Relatório de erro cancelado;");
			switch(GetPVarInt(playerid, "BugTracking"))
			{
				case 1337:
				{
					new str[128];
					format(str, 24, "%s", inputtext);
					SetPVarString(playerid, "BugTitle", str);
					SetPVarInt(playerid, "BugTracking", 1338);
					format(str, 128, "{a9C4e4}Título/Nome do Bug:\n\t{c2A2DA}%s\n{A9c4e4}Digite abaixo mais informações sobre este bug;", GetPVarStringEx(playerid, "BugTitle"));
					return ShowPlayerDialog(playerid, DIALOG_BUGTRACKER, DIALOG_STYLE_INPUT, "Reporte um Bug", str, "Prosseguir", "Cancelar");
				}
				case 1338:
				{
					new str[256];
					format(str, 128, "%s", inputtext);
					SetPVarString(playerid, "BugDetail", str);
					SetPVarInt(playerid, "BugTracking", 1339);
					format(str, 256, "{a9C4e4}Título/Nome do Bug:\n\t{c2A2DA}%s\n{a9C4e4}Detalhes:\n\t{c2A2DA}%s\n{A9c4e4}Digite abaixo mais informações sobre o bug;", GetPVarStringEx(playerid, "BugTitle"), GetPVarStringEx(playerid, "BugDetail"));
					return ShowPlayerDialog(playerid, DIALOG_BUGTRACKER, DIALOG_STYLE_INPUT, "Reporte um Bug", str, "Prosseguir", "Cancelar");
				}
				case 1339:
				{
					new str[384];
					format(str, 128, "%s", inputtext);
					SetPVarString(playerid, "BugExtra", str);
					SetPVarInt(playerid, "BugTracking", 1340);
					format(str, 384, "{a9C4e4}Título/Nome do Bug:\n\t{c2A2DA}%s\n{a9C4e4}Detalhes:\n\t{c2A2DA}%s\n{a9C4e4}Extra:\n\t{c2A2DA}%s\n{A9c4e4}Aperte SIM para enviar o relatório;\nAperte NÃO para cancelar;", GetPVarStringEx(playerid, "BugTitle"), GetPVarStringEx(playerid, "BugDetail"), GetPVarStringEx(playerid, "BugExtra"));
					return ShowPlayerDialog(playerid, DIALOG_BUGTRACKER, DIALOG_STYLE_MSGBOX, "Reporte um Bug", str, "Prosseguir", "Cancelar");
				}
				case 1340:
				{
					new str[384];
					SendActionMessage(playerid, "Seu relatório de erros foi enviado com sucesso; Para vê-lo, acesse seu painel;");
					mysql_format(db, str, 384, "INSERT INTO bugtracker (bugReporter, bugTitle, bugDetail, bugExtra) VALUES('%i', '%e', '%e', '%e')", GetPVarInt(playerid, "InternalID"), GetPVarStringEx(playerid, "BugTitle"), GetPVarStringEx(playerid, "BugDetail"), GetPVarStringEx(playerid, "BugExtra"));
					mysql_function_query(db, str, false, "", "");
				}
			}
		}
		case DIALOG_TUTORIAL: if(response) return StartTutorial(playerid);
		
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(_:clickedid != INVALID_TEXT_DRAW)
    {
		if(clickedid == MenuInventory[playerid])
		{	
			SetPVarInt(playerid, "InventoryOpen", -1);
			TextDrawHideForPlayer(playerid, MenuDisc[0]);
			TextDrawHideForPlayer(playerid, MenuDisc[1]);
			TextDrawHideForPlayer(playerid, MenuDisc[2]);
			TextDrawHideForPlayer(playerid, MenuDisc[3]);
			TextDrawHideForPlayer(playerid, MenuDisc[4]);
			TextDrawHideForPlayer(playerid, MenuDisc[5]);
			TextDrawHideForPlayer(playerid, MenuDisc[6]);
			TextDrawHideForPlayer(playerid, MenuDisc[7]);
			TextDrawHideForPlayer(playerid, MenuInventory[playerid]);
			TextDrawHideForPlayer(playerid, MenuStats[playerid]);
			TextDrawHideForPlayer(playerid, MenuPanel[playerid]);
			TextDrawHideForPlayer(playerid, MenuCharacters[playerid]);	
			if(GetPVarInt(playerid, "Admin") > 0)
			{
				TextDrawHideForPlayer(playerid, MenuDisc[8]);
				TextDrawHideForPlayer(playerid, MenuAdmin[playerid]);	
			}
			DeletePVar(playerid, "MenuOpen");
			ShowPlayerPanel(playerid, PANEL_PLAYER_INVENTORY);
		}
		else if(clickedid == MenuStats[playerid])
		{
			SendSystemMessage(playerid, "Estatísticas em construção!");
			TextDrawHideForPlayer(playerid, MenuDisc[0]);
			TextDrawHideForPlayer(playerid, MenuDisc[1]);
			TextDrawHideForPlayer(playerid, MenuDisc[2]);
			TextDrawHideForPlayer(playerid, MenuDisc[3]);
			TextDrawHideForPlayer(playerid, MenuDisc[4]);
			TextDrawHideForPlayer(playerid, MenuDisc[5]);
			TextDrawHideForPlayer(playerid, MenuDisc[6]);
			TextDrawHideForPlayer(playerid, MenuDisc[7]);
			TextDrawHideForPlayer(playerid, MenuInventory[playerid]);
			TextDrawHideForPlayer(playerid, MenuStats[playerid]);
			TextDrawHideForPlayer(playerid, MenuPanel[playerid]);
			TextDrawHideForPlayer(playerid, MenuCharacters[playerid]);	
			if(GetPVarInt(playerid, "Admin") > 0)
			{
				TextDrawHideForPlayer(playerid, MenuDisc[8]);
				TextDrawHideForPlayer(playerid, MenuAdmin[playerid]);	
			}
			CancelSelectTextDraw(playerid);
			DeletePVar(playerid, "MenuOpen");
		}
		else if(clickedid == MenuPanel[playerid])
		{
			SetPVarInt(playerid, "PanelOpen", -1);
			TextDrawHideForPlayer(playerid, MenuDisc[0]);
			TextDrawHideForPlayer(playerid, MenuDisc[1]);
			TextDrawHideForPlayer(playerid, MenuDisc[2]);
			TextDrawHideForPlayer(playerid, MenuDisc[3]);
			TextDrawHideForPlayer(playerid, MenuDisc[4]);
			TextDrawHideForPlayer(playerid, MenuDisc[5]);
			TextDrawHideForPlayer(playerid, MenuDisc[6]);
			TextDrawHideForPlayer(playerid, MenuDisc[7]);
			TextDrawHideForPlayer(playerid, MenuInventory[playerid]);
			TextDrawHideForPlayer(playerid, MenuStats[playerid]);
			TextDrawHideForPlayer(playerid, MenuPanel[playerid]);
			TextDrawHideForPlayer(playerid, MenuCharacters[playerid]);	
			if(GetPVarInt(playerid, "Admin") > 0)
			{
				TextDrawHideForPlayer(playerid, MenuDisc[8]);
				TextDrawHideForPlayer(playerid, MenuAdmin[playerid]);	
			}
			DeletePVar(playerid, "MenuOpen");
			ShowPlayerPanel(playerid, PANEL_PLAYER_HELP);
		}
		else if(clickedid == MenuCharacters[playerid])
		{
			SendSystemMessage(playerid, "Sistema de personagens em construção!");
			TextDrawHideForPlayer(playerid, MenuDisc[0]);
			TextDrawHideForPlayer(playerid, MenuDisc[1]);
			TextDrawHideForPlayer(playerid, MenuDisc[2]);
			TextDrawHideForPlayer(playerid, MenuDisc[3]);
			TextDrawHideForPlayer(playerid, MenuDisc[4]);
			TextDrawHideForPlayer(playerid, MenuDisc[5]);
			TextDrawHideForPlayer(playerid, MenuDisc[6]);
			TextDrawHideForPlayer(playerid, MenuDisc[7]);
			TextDrawHideForPlayer(playerid, MenuInventory[playerid]);
			TextDrawHideForPlayer(playerid, MenuStats[playerid]);
			TextDrawHideForPlayer(playerid, MenuPanel[playerid]);
			TextDrawHideForPlayer(playerid, MenuCharacters[playerid]);	
			if(GetPVarInt(playerid, "Admin") > 0)
			{
				TextDrawHideForPlayer(playerid, MenuDisc[8]);
				TextDrawHideForPlayer(playerid, MenuAdmin[playerid]);	
			}
			CancelSelectTextDraw(playerid);
			DeletePVar(playerid, "MenuOpen");
		}
		else if(clickedid == MenuAdmin[playerid])
		{
			CancelSelectTextDraw(playerid);
			TextDrawHideForPlayer(playerid, MenuDisc[0]);
			TextDrawHideForPlayer(playerid, MenuDisc[1]);
			TextDrawHideForPlayer(playerid, MenuDisc[2]);
			TextDrawHideForPlayer(playerid, MenuDisc[3]);
			TextDrawHideForPlayer(playerid, MenuDisc[4]);
			TextDrawHideForPlayer(playerid, MenuDisc[5]);
			TextDrawHideForPlayer(playerid, MenuDisc[6]);
			TextDrawHideForPlayer(playerid, MenuDisc[7]);
			TextDrawHideForPlayer(playerid, MenuInventory[playerid]);
			TextDrawHideForPlayer(playerid, MenuStats[playerid]);
			TextDrawHideForPlayer(playerid, MenuPanel[playerid]);
			TextDrawHideForPlayer(playerid, MenuCharacters[playerid]);	
			if(GetPVarInt(playerid, "Admin") > 0)
			{
				TextDrawHideForPlayer(playerid, MenuDisc[8]);
				TextDrawHideForPlayer(playerid, MenuAdmin[playerid]);	
			}
			DeletePVar(playerid, "MenuOpen");
			ShowPlayerPanel(playerid, PANEL_PLAYER_ADMIN);
		}
		else if(clickedid == Panel[playerid][5]) PanelTabForward(playerid);
		else if(clickedid == Panel[playerid][6]) PanelTabBackward(playerid);
		else if(clickedid == Panel[playerid][7]) PanelListUp(playerid);
		else if(clickedid == Panel[playerid][8]) PanelListDown(playerid);
		else if(clickedid == Panel[playerid][9]) HidePlayerPanel(playerid);
		else if(clickedid == Panel[playerid][10]) PanelItemClicked(playerid, 1);
		else if(clickedid == Panel[playerid][11]) PanelItemClicked(playerid, 2);
		else if(clickedid == Panel[playerid][12]) PanelItemClicked(playerid, 3);
		else if(clickedid == Panel[playerid][13]) PanelItemClicked(playerid, 4);
		else if(clickedid == Panel[playerid][14]) PanelItemClicked(playerid, 5);
		else if(clickedid == Panel[playerid][15]) PanelItemClicked(playerid, 6);
		else if(clickedid == Panel[playerid][16]) PanelItemClicked(playerid, 7);
		else if(clickedid == Panel[playerid][17]) PanelItemClicked(playerid, 8);
		else if(clickedid == Panel[playerid][18]) PanelItemClicked(playerid, 9);
		else if(clickedid == Panel[playerid][19]) PanelItemClicked(playerid, 10);
		else if(clickedid == Panel[playerid][20]) PanelItemClicked(playerid, 11);
		else if(clickedid == Panel[playerid][22]) PanelItemClicked(playerid, 12);
		else if(clickedid == Panel[playerid][22]) PanelItemClicked(playerid, 13);
		else if(clickedid == Panel[playerid][23]) PanelItemClicked(playerid, 14);
		else if(clickedid == Panel[playerid][24]) PanelItemClicked(playerid, 15);
		else if(clickedid == Panel[playerid][25]) PanelItemClicked(playerid, 16);
		else if(clickedid == Panel[playerid][26]) PanelItemClicked(playerid, 17);
		else if(clickedid == Panel[playerid][27]) PanelItemClicked(playerid, 18);
		else if(clickedid == Panel[playerid][28]) PanelItemClicked(playerid, 19);
		else if(clickedid == Panel[playerid][29]) PanelItemClicked(playerid, 20);
		else if(clickedid == Panel[playerid][30]) PanelItemClicked(playerid, 21);
		else if(clickedid == ItemBox[playerid][6]) CloseItemBox(playerid);
		else if(clickedid == ItemBox[playerid][30]) ItemBoxPickup(playerid);
		for(new i = 1; i < 13; i++)
		{
			if(clickedid == RegisterText[playerid][2+(i*4)]) RegisterMenuBackward(playerid, i);
			else if(clickedid == RegisterText[playerid][3+(i*4)]) RegisterMenuForward(playerid, i);
		}
		if(clickedid == RegisterText[playerid][52]) FinishCreation(playerid);
		else if(clickedid == RegisterText[playerid][53]) ResetRegistrationValues(playerid);
		else if(clickedid == InfoBox[playerid][13]) CloseInfoBox(playerid);
    }
	else
	{
		if(GetPVarInt(playerid, "PanelOpen") > -1) HidePlayerPanel(playerid);
		if(GetPVarInt(playerid, "InfoBox") > 0) CloseInfoBox(playerid);
		if(GetPVarInt(playerid, "ItemBox") > 0) CloseItemBox(playerid);
		if(GetPVarInt(playerid, "MenuOpen") > 0)
		{
			TextDrawHideForPlayer(playerid, MenuDisc[0]);
			TextDrawHideForPlayer(playerid, MenuDisc[1]);
			TextDrawHideForPlayer(playerid, MenuDisc[2]);
			TextDrawHideForPlayer(playerid, MenuDisc[3]);
			TextDrawHideForPlayer(playerid, MenuDisc[4]);
			TextDrawHideForPlayer(playerid, MenuDisc[5]);
			TextDrawHideForPlayer(playerid, MenuDisc[6]);
			TextDrawHideForPlayer(playerid, MenuDisc[7]);
			TextDrawHideForPlayer(playerid, MenuInventory[playerid]);
			TextDrawHideForPlayer(playerid, MenuStats[playerid]);
			TextDrawHideForPlayer(playerid, MenuPanel[playerid]);
			TextDrawHideForPlayer(playerid, MenuCharacters[playerid]);	
			if(GetPVarInt(playerid, "Admin") > 0)
			{
				TextDrawHideForPlayer(playerid, MenuDisc[8]);
				TextDrawHideForPlayer(playerid, MenuAdmin[playerid]);	
			}
			CancelSelectTextDraw(playerid);
			DeletePVar(playerid, "MenuOpen");
			
		}
	}
	return 1;
}


public OnPlayerCommandText(playerid, cmdtext[])
{
	SendErrorMessage(playerid, "Este servidor não possui comandos. Para mais informações, aperte N.");
	return 1;
}

